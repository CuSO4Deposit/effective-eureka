#!/bin/bash

set -e

OUTPUT_DIR="build"
mkdir -p $OUTPUT_DIR

echo "<html><head><title>D2 Diagrams</title></head><body>" > $OUTPUT_DIR/index.html

for d2_file in $(find . -name "*.d2"); do
  output_svg="$OUTPUT_DIR/$(basename "$d2_file" .d2).svg"
  d2 --sketch --layout=ELK "$d2_file" "$output_svg"
  echo "<h1>$(basename "$d2_file")</h1>" >> $OUTPUT_DIR/index.html
    echo "<a href=\"$(basename "$output_svg")\" target=\"_blank\"><img src=\"$(basename "$output_svg")\"></a>" >> $OUTPUT_DIR/index.html
done

echo "</body></html>" >> $OUTPUT_DIR/index.html

