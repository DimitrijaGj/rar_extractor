#!/usr/bin/env bash

if [ $# -ne 2 ]; then
  echo "Usage: $0 <source_folder> <destination_folder>"
  exit 1
fi

SOURCE_FOLDER="$1"
DEST_FOLDER="$2"

if ! command -v unar >/dev/null 2>&1; then
  echo "❌ 'unar' is not installed. Install it via Homebrew: brew install unar"
  exit 1
fi

find "$SOURCE_FOLDER" -type f -iname '*.rar' | while read -r rar_file; do
    relative_path="${rar_file#$SOURCE_FOLDER/}"
    relative_dir="$(dirname "$relative_path")"
    output_dir="$DEST_FOLDER/$relative_dir"

    mkdir -p "$output_dir"
    echo "📦 Extracting: $rar_file → $output_dir"
    unar -quiet -force-overwrite -output-directory "$output_dir" "$rar_file"
done

echo "✅ All done!"

