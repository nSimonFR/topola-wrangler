#!/bin/sh
if [ $# -ne 4 ] ; then
  echo "USAGE: $0 input.ged index.html path url"
  exit 1
fi

sed "s#$3#$4#g" $1 > $1~gen

export NODE_OPTIONS=--openssl-legacy-provider
npm install && \
  node_modules/.bin/parse-gedcom "$1~gen" > src/entries.json && \
  node_modules/.bin/webpack && \
  mv dist/index.html "$2" && \
  rm -r dist $1~gen
