#!/bin/sh
COMMONS=$(sed -e 's/:[^:\/\/]/="/g;s/$/"/g;s/ *=/=/g' commons.yml)

sed -ie "s/^##\./$COMMONS/g" prep.sh
