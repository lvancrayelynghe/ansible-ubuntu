#!/bin/bash

cat \
  <(echo -e "---\n") \
  <(cat roles/*/defaults/main.yml | grep -v '^---$' | grep -v '^[[:space:]]*$') \
  > group_vars/_compiled_defaults.yml
