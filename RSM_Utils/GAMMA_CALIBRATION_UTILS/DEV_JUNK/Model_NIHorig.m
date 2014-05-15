function[Luminance_Predictions] = Model(Params, Gun_Values)

gamma = Params(1);
thresh = Params(2);
%alpha = Params(3);

N_bits = 8;

gun_rez = 2^N_bits;

Luminance_Predictions = (Gun_Values - thresh) ./ (gun_rez - thresh);

% Now wipe out any negative luminances lest I get weird imaginary data after the power
mask_vect = Luminance_Predictions > 0;
Luminance_Predictions = Luminance_Predictions .* mask_vect;


% This equation failed miserably. This comes from Chris Taylor's EE696 paper.
% Chris only gets an A- since his equation clearly needs a conversion factor!
%Luminance_Predictions = gun_rez * ( Luminance_Predictions .^ gamma );

%Luminance_Predictions = alpha * ( Luminance_Predictions .^ gamma );


Luminance_Predictions = ( Luminance_Predictions .^ gamma );
