#!/usr/bin/env bash

find . -name '*.png' -execdir mogrify -resize 16x16! {} \;
