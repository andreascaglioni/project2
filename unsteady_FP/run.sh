#! /bin/bash

echo '# 0'
FreeFem++ unsteady_FP.freefem 0
echo '# 0.12'
FreeFem++ unsteady_FP.freefem 0.12
echo '# 0.14'
FreeFem++ unsteady_FP.freefem 0.14
echo '# 8'
FreeFem++ unsteady_FP.freefem 8
echo '# 12'
FreeFem++ unsteady_FP.freefem 12
echo '# 20'
FreeFem++ unsteady_FP.freefem 20
