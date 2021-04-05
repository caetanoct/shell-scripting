#!/bin/sh
for file in ./*; do du -sh --apparent-size $file; done