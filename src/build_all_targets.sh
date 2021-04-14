#!/usr/bin/env bash

set -e
cd "$(dirname "$0")"

cur_dir=$(pwd)
v8_dir=/work/v8

for conf_path in config/*; do
  conf_name=$(basename $conf_path)
  echo "building for" $conf_name
  mkdir -p $v8_dir/out/$conf_name
  cp -f $conf_path $v8_dir/out/$conf_name/args.gn
  cd $v8_dir
  gn gen out/$conf_name
  ninja -C out/$conf_name v8_monolith
  cd $cur_dir
done