#!/usr/bin/env bash

if [ $# -ne 2 ]; then
  echo "Usage: $0 <source_folder> <destination_folder>"
  exit 1
fi

SOURCE_FOLDER="$1"
DEST_FOLDER="$2"

# Normalize paths
SOURCE_FOLDER="$(cd "$SOURCE_FOLDER" && pwd)"
DEST_FOLDER="$(cd "$DEST_FOLDER" && pwd)"

# Find all .rar files and extract them
find "$SOURCE_FOLDER" -type f -iname '*.rar' | while read rar_file; do
    # Get relative path
    relative_path="${rar_file#$SOURCE_FOLDER/}"
    relative_dir=$(dirname "$relative_path")
    
    # Build output path
    output_dir="$DEST_FOLDER/$relative_dir"
    mkdir -p "$output_dir"

    echo "Extracting: $rar_file → $output_dir"
    unrar x -o+ "$rar_file" "$output_dir/"
done

echo "✅ All done!"

