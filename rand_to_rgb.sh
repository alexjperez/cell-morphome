#! /bin/bash

# Define IMOD R,G,B lookup table
declare -A rgb
rgb[plasmamembrane]=1,1,1
rgb[primarycilium]=1,1,1
rgb[nucleus]=1,1,0
rgb[nucleolus]=0,0,1
rgb[mitochondrion]=0,1,0
rgb[lysosome]=1,0,0
rgb[stigmoidbody]=0,1,1
rgb[multivesicularbody]=0.2,0,0.8
rgb[autophagosome]=1,0.5,1
rgb[autolysosome]=1,0,1

# Define IMOD name lookup table
declare -A name
name[plasmamembrane]="Plasma Membrane"
name[primarycilium]="Primary Cilium"
name[nucleus]="Nucleus"
name[nucleolus]="Nucleolus"
name[mitochondrion]="Mitochondrion"
name[lysosome]="Lysosome"
name[stigmoidbody]="Stigmoid Body"
name[multivesicularbody]="Multivesicular Body"
name[autophagosome]="Autophagosome"
name[autolysosome]="Autolysosome"

# Run edmod for each file
for file in *rand*.mod; do
    base=$( echo $file | cut -d "_" -f1-5 )
    structure=$( echo $file | cut -d "_" -f7 | cut -d "." -f1 )
    file_name=${name[$structure]}
    file_color=${rgb[$structure]}
    if [ -z "$file_color" ]; then
        echo "ERROR: No entry for structure named $structure"
    else
        echo -e "edmod.py --nameout \"$file_name\" --colorout $file_color --linewidth 3 $file ${base}_rgb_${structure}.mod"
        edmod.py --nameout "$file_name" --colorout $file_color --linewidth 3 $file ${base}_rgb_${structure}.mod
    fi 
done

