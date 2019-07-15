#!/bin/bash

for filename in ./test/*.dimacs; do
  python src/python/test/test.py --input $filename
done

