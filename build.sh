#!/bin/sh

#BASE_DIR=
#PLAYBOOK=
OUTPUT_DIR=$BASE_DIR/target

mkdir -p $OUTPUT_DIR

echo "Cleaning output directory: $OUTPUT_DIR"
rm -rf $OUTPUT_DIR/*

echo "Running : antora $PLAYBOOK from $BASE_DIR"
cd $BASE_DIR
antora $PLAYBOOK
echo "Antora build completed successfully."

echo "Customizing output."
find $OUTPUT_DIR/dist -name '*.html' -exec sed -i 's/_images/assets-images/g' {} \;
find $OUTPUT_DIR/dist -name '_images' -execdir mv _images assets-images \;

echo "Done."
