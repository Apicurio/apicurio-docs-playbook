#!/bin/sh

OUTPUT_DIR=/apicurio-docs-playbook/target

mkdir -p $OUTPUT_DIR

echo "Cleaning output directory."
rm -rf $OUTPUT_DIR/*

echo "Running : antora $PLAYBOOK"
cd /apicurio-docs-playbook
antora $PLAYBOOK
echo "Antora build completed successfully."

echo "Customizing output."
find $OUTPUT_DIR/dist -name '*.html' -exec sed -i 's/_images/assets-images/g' {} \;
find $OUTPUT_DIR/dist -name '_images' -execdir mv _images assets-images \;

echo "Done."
