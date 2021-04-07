#!/bin/sh

#BASE_DIR=
#PLAYBOOK=

if [ "x$BASE_DIR" = "x" ]
then
  BASE_DIR=`pwd`
fi

if [ "x$PLAYBOOK" = "x" ]
then
  PLAYBOOK=registry-docs-playbook.yml
fi

OUTPUT_DIR=$BASE_DIR/target

mkdir -p $OUTPUT_DIR

echo "Cleaning output directory: $OUTPUT_DIR"
rm -rf $OUTPUT_DIR/*

echo "Running : antora $PLAYBOOK from $BASE_DIR"
cd $BASE_DIR

# Set some Lunr env variables.
export DOCSEARCH_ENABLED=true
export DOCSEARCH_ENGINE=lunr
export NODE_PATH="$(npm -g root)"

antora --generator antora-site-generator-lunr $PLAYBOOK
echo "Antora build completed successfully."

echo "Customizing output."
find $OUTPUT_DIR/dist -name '*.html' -exec sed -i 's/_images/assets-images/g' {} \;
find $OUTPUT_DIR/dist -name '*.html' -exec sed -i 's/_attachments/assets-attachments/g' {} \;
find $OUTPUT_DIR/dist -name '_images' -execdir mv _images assets-images \;
find $OUTPUT_DIR/dist -name '_attachments' -execdir mv _attachments assets-attachments \;

echo "Done."
