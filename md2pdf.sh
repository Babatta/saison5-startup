#!/bin/bash

DIRECTORY="${1:-.}"

for md_file in "$DIRECTORY"/*.md; do
    if [ -f "$md_file" ]; then
        filename=$(basename "$md_file".md)

        docker run --rm -v "${PWD}:/app" yjpictures/mdpdfinator "$filename.md"

        echo "Conversion de '$md_file' terminée avec succès"
    else
        echo "Aucun fichier Markdown trouvé dans le dossier $DIRECTORY"
    fi
done
