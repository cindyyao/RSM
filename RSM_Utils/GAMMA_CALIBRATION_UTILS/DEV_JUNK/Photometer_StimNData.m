function[ data_out ] = Photometer_StimNData( )

fprintf('****************************************\n');
fprintf('Photometer Stimulus Presentation Utility\n');
fprintf('****************************************\n');
fprintf('\n\n');

linear_mode = Tested_Input_Logical( 'Enter (1) to use linear gamma lut tables (0) to load monitor description:' );

if (linear_mode)

    gamma_table.red = linspace(0, 1, 256);    % red gun table
    gamma_table.green = linspace(0, 1, 256);    % green gun table
    gamma_table.blue = linspace(0, 1, 256);   % blue gun table

    % Give choice to use defaults or put in new values
    fprintf('Default monitor settings: \n');
   
    stimwindow.width = 800;
    stimwindow.height = 600;
    stimwindow.screen_refresh_freq = 99.6%100;

    def_mode = Tested_Input_Logical( 'Enter (1) to use defaults or (0) to update:' );
    
    if (~def_mode)
        stimwindow.width = input('Enter monitor width in pixels:');
        stimwindow.height = input('Enter monitor height in pixels:');
        stimwindow.screen_refresh_freq = input('Enter screen refresh rate:');
    end
    
    
else
    def_path = '/Volumes/wvinje/WorkCore/SUPER_STIM/RetStimMGL_beta_0p1/RSM_Monitors/';
    
    monitor_description_filename = input('Enter filename of monitor description file using single quotes and including .mat');

    fn = cat(2, def_path, monitor_description_filename);

    load(fn); % I assume monitor_description is the variable saved within the filename
   
    gamma_table.red = monitor_description.red_channel.interp_lut;
    gamma_table.green = monitor_description.green_channel.interp_lut;
    gamma_table.blue = monitor_description.blue_channel.interp_lut;

    stimwindow.width = monitor_description.stimwindow.width;
    stimwindow.height = monitor_description.stimwindow.height;
    stimwindow.screen_refresh_freq = monitor_description.stimwindow.screen_refresh_freq;
    
end
    

% Setup mgl window
stimwindow.monitor = 2;
stimwindow.backgrndcolor = [0, 0, 0];


mglOpen( stimwindow.monitor, stimwindow.width, stimwindow.height, stimwindow.screen_refresh_freq );             
             
mglScreenCoordinates;      % set screen coord system to pixels with 0,0 in up-left corner

mglSetGammaTable( gamma_table.red, gamma_table.green, gamma_table.blue );

mglClearScreen( obj.stimwindow.backgrndcolor );
            
mglFlush;

w = stimwindow.width;
h = stimwindow.height;
                        
x_vertices = [0; w; w; 0];
y_vertices = [0; 0; h; h];


not_done = 1;
data_out = [];
data_index = 0;

while( not_done )
    
    fprintf('-----------------------------------\n');
    
    gun_color = input('Enter gun color ["r", "g" or "b"]:');
   
    % Input max, min and steps
    [ min_gun_val ] = Tested_Input_NumRange( 'Enter min gun value [0-255]: ', 0, 255 );
    [ max_gun_val ] = Tested_Input_NumRange( 'Enter max gun value [0-255]: ', 0, 255 );
    [ num_steps ] = Tested_Input_NumRange( 'Enter number of steps [2-255]: ', 2, 255 );
    
    fprintf('-----------------------------------\n\n');
    
    levels = round( linspace( min_gun_val, max_gun_val, num_steps) );
    
    
    % Loop through the various gun levels
    for i = 1:length(levels),
        
        % Set the colors
        switch gun_color, 
        
            case 'r'
                color = [levels(i); 0; 0];

            case 'g'
                color = [ 0; levels(i); 0];

            case 'b'
                color = [0; 0; levels(i)];

        end % switch
        
        % Color the screen         
        mglQuad(x_vertices, y_vertices, color/255, 0); 
        mglFlush();
        
        
        % Collect the data
        fprintf('Gun level: %d \t//\t', levels(i) );
        power = input('Enter power reading: ');
        
        % Fill out the data_out
        data_index = data_index + 1;
        data_out(data_index,:) = [color', power];
        
    end % loop through levels
    
    %Run more?
    not_done = Tested_Input_Logical('Enter (1) to re-run or (0) to exit: ');
    
end     % main while

mglClose;


Display_Monitor_Data( data_out );

%plot(data_out(1:length(levels),1), data_out(1:length(levels),4), 'r');
%hold
%plot(data_out(length(levels)+1:2*length(levels),2), data_out(length(levels)+1:2*length(levels),4), 'g');
%plot(data_out((2*length(levels))+1:3*length(levels),3), data_out((2*length(levels))+1:3*length(levels),4), 'b');
%hold