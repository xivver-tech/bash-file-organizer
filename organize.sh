#!/bin/bash
# Simple file organizer: moves files into folders by extension

TARGET_DIR="${1:-.}"

if [ ! -d "$TARGET_DIR" ]; then
  echo "Error: Directory '$TARGET_DIR' does not exist."
  exit 1
fi

echo "Organizing files in: $TARGET_DIR"

cd "$TARGET_DIR" || exit 1

for file in *; do
  # Skip directories and the script itself
  if [ -d "$file" ] || [ "$file" = "organize.sh" ]; then
    continue
  fi

  # Get extension (lowercase)
  ext="${file##*.}"
  ext=$(echo "$ext" | tr '[:upper:]' '[:lower:]')

  # If no extension, put in "other"
  if [ "$ext" = "$file" ]; then
    ext="other"
  fi

  mkdir -p "$ext"
  mv "$file" "$ext/"
  echo "Moved: $file -> $ext/"
done

echo "Done!"
