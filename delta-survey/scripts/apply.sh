#!/bin/bash

echo "xdelta3-fast" >> apply-times
{ time xdelta3 -d -s $1 xdelta3-fast.patch xdelta3-fast.applied ; } 2>> apply-times

echo "xdelta3-best" >> apply-times
{ time xdelta3 -d -s $1 xdelta3-best.patch xdelta3-best.applied ; } 2>> apply-times

echo "bspatch" >> apply-times
{ time bspatch $1 bspatch.applied bsdiff.patch ; } 2>> apply-times

echo "zucchini" >> apply-times
{ time zucchini -apply $1 zucchini.patch zucchini.applied ; } 2>> apply-times

echo "courgette" >> apply-times
{ time courgette -apply $1 courgette.patch courgette.applied ; } 2>> apply-times

rm -f courgette.log