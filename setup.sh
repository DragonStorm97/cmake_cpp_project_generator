#!/bin/bash

# TODO: vars! (arguments/prompt user!)
PROJECT_NAME=coolProject
STD_VERSION=20

# remove the generated directory if it exists:
rm -rf generated/
# create the generated directory
mkdir generated

# copy all the files over to the generated directory:
# Copy all files from the source directory to the generated directory
find . -maxdepth 1 -mindepth 1 ! -name generated -exec cp -r {} generated \;

cd generated

# remove the unwanted files:
rm -rf setup.sh README.md .git

# replace the vars with the ones provided by the user:

# TODO: improve with a loop, etc.
declare -A REPLACE_MAP=(
  [{{REPLACE_ME_PROJECT_NAME}}]=${PROJECT_NAME}
  [{{REPLACE_ME_APP_NAME}}]=${PROJECT_NAME}app
  [{{REPLACE_ME_LIB_NAME}}]=lib${PROJECT_NAME}
  [{{REPLACE_ME_STD_VERSION}}]=${STD_VERSION}
)

for SEARCH_STRING in "${!REPLACE_MAP[@]}"; do
  REPLACE_STRING="${REPLACE_MAP[$SEARCH_STRING]}"
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
