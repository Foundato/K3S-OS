#!/bin/bash

echo "xdelta3-fast" >> times
{ time xdelta3 -e -1 -s $1 $2 xdelta3-fast.patch ; } 2>> times

echo "xdelta3-best" >> times
{ time xdelta3 -e -9 -s $1 $2 xdelta3-best.patch ; } 2>> times

echo "bsdiff" >> times
{ time bsdiff $1 $2 bsdiff.patch ; } 2>> times

echo "zucchini" >> times
{ time zucchini -gen $1 $2 zucchini.patch ; } 2>> times

echo "courgette" >> times
{ time courgette -gen $1 $2 courgette.patch ; } 2>> times

rm courgette.log