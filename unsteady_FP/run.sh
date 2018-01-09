#! /bin/bash

echo '# 0'
FreeFem++ unsteady_FP.freefem 0
echo '# 10'
FreeFem++ unsteady_FP.freefem 10
echo '# 50'
FreeFem++ unsteady_FP.freefem 50
echo '# 80'
FreeFem++ unsteady_FP.freefem 80

