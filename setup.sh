#!/bin/bash

# Function to prompt the user for an array input
function prompt_for_array {
  local prompt_message=$1
  local -n array_ref=$2  # Use nameref to pass the array by reference

  echo "$prompt_message (Separate elements with spaces):"
  read -a array_ref  # Read input into the array
}

# Function to prompt the user for a single variable input
function prompt_for_input {
  local prompt_message=$1
  local -n var_ref=$2  # Use nameref to pass the variable by reference

  echo "$prompt_message:"
  read var_ref  # Read input into the variable
}

PROJECT_NAME=defaultProject
STD_VERSION=20
APPS=(app)
FORCE=true

prompt_for_input "Enter the Name for your project (no spaces!)" PROJECT_NAME
prompt_for_array "Enter the list of apps to generate" APPS
prompt_for_input "Enter the standard version (e.g. 17 for c++17)" STD_VERSION

if [ -d generated ]; then
  echo ./generated/ already exists
  if $FORCE; then
    echo removing existing ./generated folder
    # remove the generated directory if it exists:
    rm -rf generated/
  else
    exit 1
  fi

fi

# create the generated directory
mkdir generated

# copy all the files over to the generated directory:
# Copy all files from the source directory to the generated directory
find . -maxdepth 1 -mindepth 1 ! -name generated -exec cp -r {} generated \;

cd generated

# remove the unwanted files:
rm -Rf setup.sh README.md .git/

# rename to tocopy.github .github
mv tocopy.github/ .github/

# replace the vars with the ones provided by the user:

function create_and_replace {
  declare -n replace_map=$1  # Reference to the replacement map

  for SEARCH_STRING in "${!replace_map[@]}"; do
    REPLACE_STRING="${replace_map[$SEARCH_STRING]}"
    echo Replacing ${SEARCH_STRING} with ${REPLACE_STRING}
    # text replace:
    grep "${SEARCH_STRING}" . -lr | xargs sed -i "s/${SEARCH_STRING}/${REPLACE_STRING}/g"

    # file and folder renames:
    # Define the string to replace and the replacement string

    # Rename directories first to avoid issues with files inside renamed directories
    find . -depth -name "*$SEARCH_STRING*" | while IFS= read -r file; do
      # Determine the new name
      new_name="$(dirname "$file")/$(basename "$file" | sed "s/$SEARCH_STRING/$REPLACE_STRING/g")"
      # Rename the file or directory
      mv "$file" "$new_name"
    done
  done
}

declare -A REPLACE_MAP=(
  [{{REPLACE_ME_PROJECT_NAME}}]=${PROJECT_NAME}
  # [{{REPLACE_ME_APP_NAME}}]=${PROJECT_NAME}app
  [{{REPLACE_ME_LIB_NAME}}]=lib${PROJECT_NAME}
  [{{REPLACE_ME_STD_VERSION}}]=${STD_VERSION}
)

create_and_replace REPLACE_MAP

for app in "${APPS[@]}"; do
  echo Creating app $app
  # Create the target directory if it doesn't exist
  mkdir -p "$PROJECT_NAME/apps/$app"

  # Copy the contents of the template directory into the target directory
  cp -r "$PROJECT_NAME/apps/template"/* "$PROJECT_NAME/apps/$app/"
  cd "$PROJECT_NAME/apps/$app/"
  declare -A REPMAP=([{{REPLACE_ME_APP_NAME}}]=$app)
  create_and_replace REPMAP
  cd ../../../
done
rm -Rf "$PROJECT_NAME/apps/template"
