#!/bin/bash

echo "verify xdelta3-fast"
cmp --silent $1 xdelta3-fast.applied || echo "xdelta3-fast.applied is different"
echo "verify xdelta3-best"
cmp --silent $1 xdelta3-best.applied || echo "xdelta3-best.applied is different"
echo "verify bspatch"
cmp --silent $1 bspatch.applied || echo "bspatch.applied is different"
echo "verify zucchini"
cmp --silent $1 zucchini.applied || echo "zucchini.applied is different"
echo "verify courgette"
cmp --silent $1 courgette.applied || echo "courgette.applied is different"