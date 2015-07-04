#!/bin/sh

python get_businesses.py -i > inactive.sa.csv &
python get_businesses.py -n > new.sa.csv &
python get_businesses.py -c > current.sa.csv &
python get_businesses.py -o > old.sa.csv &
python get_businesses.py -a > businesses.sa.csv &

