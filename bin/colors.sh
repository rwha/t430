#!/bin/bash

echo normal
for i in {0..255}; do
  echo -en "$(tput setf $i) X "
  [[ $i == 0 ]] && continue
  [ $((i % 32)) -eq 0 ] && echo
done

echo
echo "$(tput bold) bold"

for i in {0..255}; do
  echo -en "$(tput setf $i) X "
  [[ $i == 0 ]] && continue
  [ $((i % 32)) -eq 0 ] && echo
done

echo "$(tput sgr0)"
