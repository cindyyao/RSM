function[ gamma_channel_S ] = Find_Monitor_LUT_Chan( optometer_raw_data, color_chan )
%lut_fit, lut_interp

Model = @BrainardModel;

gamma_channel_S.color_chan = color_chan;
%gamma_channel_S.background_radpow; % Due to the averaging algorithm this returned value will be the same for all channels

%gamma_channel_S.avgraw_radpow_data; 
%gamma_channel_S.adjusted_radpow_data

%gamma_channel_S.raw_gunvals;


%gamma_channel_S.finegrain_gunvals; 
%gamma_channel_S.interp_radpow_data;

%gamma_channel_S.fit_gamma;
%gamma_channel_S.fit_thresh;
%gamma_channel_S.fit_stat_final;
%gamma_channel_S.fit_radpow_data;

gamma_channel_S.avgraw_radpow_data = Average_RadPow_Data( optometer_raw_data, color_chan );


% Next pre-processing step
% Subtract background level
gamma_channel_S.background_radpow = gamma_channel_S.avgraw_radpow_data( gun_vals == 0 );    % There should be only one entry

gamma_channel_S.adjusted_radpow_data = gamma_channel_S.avgraw_radpow_data - gamma_channel_S.background_radpow;


% Next step
% Scale so that top of curve is 1 
max_lum = max( gamma_channel_S.adjusted_radpow_data );

gamma_channel_S.adjusted_radpow_data = gamma_channel_S.adjusted_radpow_data ./ max_lum;


gamma_channel_S.raw_gunvals = gun_vals;


% First we use matlab's interp1 function to fill out an empirical LUT
[ gamma_channel_S.finegrain_gunvals, gamma_channel_S.interp_radpow_data ] = Interpolate_RadPow_Data( gun_vals, gamma_channel_S.adjusted_radpow_data );

[ gamma_channel_S.interp_lut ] = Make_Empiric_LUT( gamma_channel_S.finegrain_gunvals, gamma_channel_S.interp_radpow_data );


% Now we use our fit utils to fit a gamma function to the data.
% Note that this fitting assumes we have background subtracted the zero
% level luminance, and normalized each max gun value to 1.
% The reference is: 
% Display Characterization
%   David H Brainard
%   Denis G Pelli
%   Tom Robson
[gamma_channel_S.fit_gamma, gamma_channel_S.fit_thresh, gamma_channel_S.fit_stat_final] = Fit_PreProcced_RadPow_Curve( gun_vals, gamma_channel_S.adjusted_radpow_data );


[gamma_channel_S.fit_radpow_data] = Model( [gamma_channel_S.fit_gamma, gamma_channel_S.fit_thresh], gamma_channel_S.finegrain_gunvals);

[ gamma_channel_S.fit_lut ] = Make_Empiric_LUT( gamma_channel_S.finegrain_gunvals, gamma_channel_S.fit_radpow_data );