function[ gunval_interp, lum_interp ] = Interpolate_Lum_Data( Gun_Vals, Data )

Nbits = 8;

gunval_interp = linspace(0,((2^Nbits)-1),(2^Nbits));

lum_interp = interp1(Gun_Vals, Data, gunval_interp);
