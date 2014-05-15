function[ gamma_channel_S ] = Find_Monitor_LUT( optometer_raw_data, color_chan )
%lut_fit, lut_interp

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



% PART 1: Extract the data from the relevant gun
switch color_chan
    case 'r',
        test_col = 1;
    case 'g',
        test_col = 2;
    case 'b',
        test_col = 3;
end

i = 1;

for row = 1:size(optometer_raw_data,1),

    if ( sum( optometer_raw_data(row,(1:3)) ) == optometer_raw_data(row,test_col) ),
        % Then the sum across all gun columns equals the test column
        % This implies that only the test column has any value
        % NOTE each data set gets all three 0,0,0 entries, slick huh!
        
        raw_gun_vals(i) = optometer_raw_data(row, test_col);    % The gun value
        raw_radpow_data(i) = optometer_raw_data(row, 4);   % The luminance data
        i = i + 1;
    end % if then test
     
    
end % for loop


% PART 2: Preprocessing: basically just average redundant data points
% Strategy? Brute force
% Loop through list, make a table of gun values
% each entry, check whether it is already in the table, if so average 

% Seed the process
gun_vals(1) = raw_gun_vals(1);
radpow_data_CA{1} = [raw_radpow_data(1), 1];      % each entry in CA is a vector, first element of vect is a sum of lum values
                                    % second element is a count of the number of entries

for index = 2:(i-1),
    
    current_gun_val = raw_gun_vals(index);
    current_radpow_data = raw_radpow_data(index);
    
    keep_checking = 1;
    check_index = 1;
  
    while (keep_checking)
        
        if ( current_gun_val == gun_vals(check_index) )
            % This means that we already have an entry for this gun value
            % Thus average current_lum_data with the other data points from this gun value
            % and stop checking through Gun_Vals
            
            temp_vect = radpow_data_CA{check_index};
            temp_vect(1) = temp_vect(1) + raw_radpow_data(index);
            temp_vect(2) = temp_vect(2) + 1;
            
            radpow_data_CA{check_index} = temp_vect;
            
            keep_checking = 0;
            
        
        elseif (check_index < length(gun_vals))  
            % THen we aren't done yet, increase the check_index
            check_index = check_index + 1;
            
        else
            % THen we need to add a new entry and it is then time to stop checking
            
            check_index = check_index + 1;
            gun_vals(check_index) = current_gun_val;
            radpow_data_CA{check_index} = [current_radpow_data, 1];
            
            keep_checking = 0;
        end     % if then
        
                
    end     % while loop through Gun_Vals
    
    
end     % for loop


for j = 1:length(gun_vals),
    
    temp_vect = radpow_data_CA{j};
    gamma_channel_S.avgraw_radpow_data(j) = temp_vect(1) / temp_vect(2);
    
end 


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