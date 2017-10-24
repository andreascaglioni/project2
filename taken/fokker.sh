#! /bin/bash
#
/usr/local/bin/FreeFem++ fokker.edp > fokker_output.txt
echo "Output written to fokker_output.txt"
#
convert fokker_velocity.ps fokker_velocity.png
convert fokker_p_initial_mesh.ps fokker_p_initial_mesh.png
convert fokker_p_initial.ps fokker_p_initial.png
convert fokker_p_final_mesh.ps fokker_p_final_mesh.png
convert fokker_p_final.ps fokker_p_final.png
rm *.ps
echo "Graphics files converted to PNG format."
