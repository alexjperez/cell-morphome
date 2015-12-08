# cell-morphome

Compatible IMOD model files have the following naming convention:

ZT##_??_res_cell_$$_col_struct.mod

Where:
   ZT##  : Zeitgeber time, ranging from 00-24
   ??    : Dataset number, for replicate datasets
   res   : Resolution (i.e. 2Dbin4, isotropic)
   cell  : Cell type (i.e. neuron)
   $$    : Cell number of the given type for this given dataset
   col   : Color scheme, defined as
             rand --> assigned random colors
             rgb  --> assigned defined colors for the given structure
   struct: Structure, or organelle, type (i.e. mitochondrion, lysosome)

