#!/bin/bash
#
# Parses the current directory for model files with the 'rand' color ID in
# their filename. Converts each file to the 'rgb' color ID format, with the
# assigned names and colors corresponding to the desired values for the
# given biological structure or organelle.
#
# Written by: Alex Perez - alexjperez@gmail.com on 2015-12-07

# Define IMOD R,G,B values for each structure
declare -A rgb=([plasmamembrane]="1,1,1"
    [primarycilium]="1,1,1"
    [nucleus]="1,1,0"
    [nucleolus]="0,0,1"
    [mitochondrion]="0,1,0"
    [lysosome]="1,0,0"
    [stigmoidbody]="0,1,1"
    [multivesicularbody]="0.2,0,0.8"
    [autophagosome]="1,0.5,1"
    [autolysosome]="1,0,1")

# Define IMOD object names for each structure
declare -A name=([plasmamembrane]="Plasma Membrane"
    [primarycilium]="Primary Cilium"
    [nucleus]="Nucleus"
    [nucleolus]="Nucleolus"
    [mitochondrion]="Mitochondrion"
    [lysosome]="Lysosome"
    [stigmoidbody]="Stigmoid Body"
    [multivesicularbody]="Multivesicular Body"
    [autophagosome]="Autophagosome"
    [autolysosome]="Autolysosome")

# Loop over all files with the 'rand' color identifier
for file in *rand*.mod; do

    # Extract base and structure strings from the file name
    base="$(echo "${file}" | cut -d "_" -f1-5)"
    structure="$(echo "${file}" | cut -d "_" -f7 | cut -d "." -f1)"

    # Get the correct name and color values from the associative arrays
    file_name="${name[$structure]}"
    file_color="${rgb[$structure]}"

    # If entries do not exist, print error and continue. If they do, run 
    # edmod, changing the color, name, and line width. The 'col' identifier
    # will be changed from rand to rgb.
    if [[ -z "$file_color" ]]; then
        printf "ERROR: No entry for structure named %s\n" "${structure}"
    else
        set -x
        edmod.py --nameout "${file_name}" --colorout "${file_color}" \
            --linewidth 3 "${file}" "${base}"_rgb_"${structure}".mod
        { set +x; } 2> /dev/null
    fi 
done
