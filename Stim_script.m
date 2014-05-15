%% Initialization

Start_RSM;
mglSetGammaTable( RSM_GLOBAL.monitor.red_table, RSM_GLOBAL.monitor.green_table, RSM_GLOBAL.monitor.blue_table );


%% Stimulus
%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Focus Squares
%------------------------------------------------------------------------------
%
fprintf('\n\n<strong> Focus squares. </strong>\n');
%
%-----------------------------------------------------------------------------

stimulus = [];
stimulus.type = 'FS';
stimulus.stim_width = 200;
stimulus.stim_height = 200;
stimulus.back_rgb = [0.5, 0.5, 0.5];

run_stimulus(display, stimulus);
clear stimulus;


%% Solid full-screen color
%------------------------------------------------------------------------------
%
fprintf('?\n\n<strong> Solid full-screen color. </strong>\n');
%
%------------------------------------------------------------------------------
stimulus.type = 'SC';
stimulus.rgb = [1.0, 0.0, 0.0];    
stimulus.back_rgb = [0.5, 0.5, 0.5];
stimulus.wait_trigger = 0;
stimulus.wait_key = 1;
stimulus.x_start = 160;  stimulus.x_end = 480;
stimulus.y_start = 80;   stimulus.y_end = 400;

run_stimulus(display, stimulus);
clear stimulus;

%% Flashing full-screen color
%------------------------------------------------------------------------------
%
fprintf('\n\n<strong> Flashing full-screen color. </strong>\n');
%
%------------------------------------------------------------------------------
stimulus = [];
stimulus.type = 'FC';  
stimulus.rgb = [1, 0, 0];
stimulus.back_rgb = [0.5, 0.5, 0.5];
stimulus.frames = 60;
stimulus.num_reps = 3;
stimulus.wait_trigger = 0;
stimulus.wait_key = 1;

run_stimulus(display, stimulus);
clear stimulus;



%% Moving bar
%------------------------------------------------------------------------------
%
fprintf('\n\n<strong> Moving bar. </strong>\n');
%
%------------------------------------------------------------------------------
stimulus = [];
stimulus.type = 'MB';
stimulus.rgb = 0.48 * [1.0, -1.0, -1.0];
stimulus.back_rgb = [0.5, 0.5, 0.5];
stimulus.x_start = 50;      stimulus.x_end = 100;
stimulus.y_start = 0;      stimulus.y_end = 480;
stimulus.x_delta = 0.5;      stimulus.y_delta = 0;
stimulus.ISI = 120; %frame
stimulus.frames = (640 - stimulus.x_start)/stimulus.x_delta + stimulus.ISI;
stimulus.num_reps = 2;
stimulus.wait_trigger = 0;
stimulus.wait_key = 0;


run_stimulus(display, stimulus);
clear stimulus;

%% Moving Grating
%------------------------------------------------------------------------------
%
fprintf('\n\n<strong> Moving Grating. </strong>\n');
%
%------------------------------------------------------------------------------

stimulus = [];
stimulus.type = 'MG';  
stimulus.rgb = [1.0, 1.0, 1.0];
stimulus.back_rgb = [0.0, 0.0, 0.0];
stimulus.phase0 = 0; 
stimulus.temporal_period = 1;  % sec
stimulus.spatial_period = 60;  % frame
stimulus.direction = 90;       % Convention 0 deg is 3 oclock
stimulus.frames = 640;        
stimulus.wait_trigger = 0;
stimulus.wait_key = 0;


run_stimulus(display, stimulus);
clear stimulus;


%% Counterphase Grating
%------------------------------------------------------------------------------
%
fprintf('\n\n<strong> Counterphase Grating. </strong>\n');
%
%------------------------------------------------------------------------------

stimulus = [];
stimulus.type = 'CG';  
stimulus.rgb = [1.0, 1.0, 1.0];
stimulus.back_rgb = [0.0, 0.0, 0.0];
stimulus.phase0 = 0; 
stimulus.temporal_period = 1;  
stimulus.spatial_period = 60;
stimulus.direction = 30;

stimulus.frames = 640;        
stimulus.wait_trigger = 0;
stimulus.wait_key = 1;

run_stimulus(display, stimulus);
clear stimulus;


%% Random Noise : Binary
%------------------------------------------------------------------------------
%
fprintf('\n\n<strong> Random Noise : Binary. </strong>\n');
%
%------------------------------------------------------------------------------

stimulus = [];
stimulus.type = 'RN';

stimulus.rgb = 0.48 * [1.0, 1.0, 1.0];
stimulus.back_rgb = [0.5, 0.5, 0.5];
stimulus.independent = 1;
stimulus.interval = 1; % frame
stimulus.seed = 11111;
stimulus.x_start = 160;  stimulus.x_end = 480;
stimulus.y_start = 80;   stimulus.y_end = 400;
stimulus.stixel_width = 10;      stimulus.stixel_height = 10;       stimulus.field_width = 32;        stimulus.field_height = 32;        
stimulus.duration = 5;  % sec    
stimulus.wait_trigger = 0;
stimulus.wait_key = 0;
stimulus.interval_sync = 0;
stimulus.stop_frame = [];


run_stimulus(display, stimulus);
clear stimulus;

%% Random Noise : Binary. Demo 2- sync pulse
%------------------------------------------------------------------------------
%
fprintf('\n\n<strong> Random Noise : Binary. Demo 2- sync pulse. </strong>\n');
%
%------------------------------------------------------------------------------

stimulus = [];
stimulus.type = 'RN';
stimulus.rgb = 0.48 * [1.0, 1.0, 1.0];
stimulus.back_rgb = [0.5, 0.5, 0.5];
stimulus.independent = 1;
stimulus.interval = 1;
stimulus.seed = 11111;
stimulus.x_start = 160;  stimulus.x_end = 480;
stimulus.y_start = 80;   stimulus.y_end = 400;
stimulus.stixel_width = 10;      stimulus.stixel_height = 10;       stimulus.field_width = 32;        stimulus.field_height = 32;        
stimulus.duration = 12;     
stimulus.wait_trigger = 0;
stimulus.wait_key = 0;
stimulus.interval_sync = 0;
stimulus.stop_frame = [];
stimulus.interval_sync = 1;
stimulus.interval_sync_xstart = 100;
stimulus.interval_sync_xend = 200;
stimulus.interval_sync_ystart = 100;
stimulus.interval_sync_yend = 200;


run_stimulus(display, stimulus);
clear stimulus;


%% Random Noise: Gaussian
%------------------------------------------------------------------------------
%
fprintf('\n\n<strong> Random Noise: Gaussian. </strong>\n');
%
%------------------------------------------------------------------------------

stimulus = [];
stimulus.type = 'RG';

stimulus.rgb = 0.48 * [1.0, 1.0, 1.0];
stimulus.back_rgb = [0.5, 0.5, 0.5];
stimulus.interval = 3;
stimulus.seed = 11111;

stimulus.x_start = 160;  stimulus.x_end = 480;
stimulus.y_start = 80;   stimulus.y_end = 400;

stimulus.stixel_width = 10;      stimulus.stixel_height = 10;       stimulus.field_width = 32;        stimulus.field_height = 32;        
stimulus.duration = 5;     
stimulus.wait_trigger = 0;
stimulus.wait_key = 0;
stimulus.interval_sync = 0;
stimulus.stop_frame = [];
stimulus.sigma = 0.16;


run_stimulus(display, stimulus);
clear stimulus;

%% Raw Movie, Demo 1- forward
%------------------------------------------------------------------------------
%
fprintf('\n\n<strong> Raw Movie, Demo 1- forward. </strong>\n');
%
%------------------------------------------------------------------------------
%
stimulus = [];
stimulus.type = 'RM';
stimulus.fn = 'catcam_forest.rawMovie';
stimulus.back_rgb = [0.5, 0.5, 0.5];
stimulus.x_cen_offset = 0;   stimulus.y_cen_offset = 0;
stimulus.interval = 1;   
stimulus.preload = 0;
stimulus.wait_trigger = 0;
stimulus.wait_key = 1;
stimulus.interval_sync = 0;
stimulus.stop_frame = [];
stimulus.flip_flag = 1;          % 1 = normal; 2 = vertical flip; 3 = horizontal flip; 4 = vertical + horizontal flip
stimulus.reverse_flag = 0;       
stimulus.first_frame = 1;
stimulus.last_frame = [];        

run_stimulus(display, stimulus);
clear stimulus;

%% Raw Movie, Demo 2- reverse
%------------------------------------------------------------------------------
%
fprintf('\n\n<strong> Raw Movie, Demo 2- reverse. </strong>\n');
%
%------------------------------------------------------------------------------


stimulus = [];
stimulus.type = 'RM';
stimulus.fn = 'catcam_forest.rawMovie';
stimulus.back_rgb = [0.5, 0.5, 0.5];
stimulus.x_cen_offset = 0;   stimulus.y_cen_offset = 0;
stimulus.interval = 1;   
stimulus.preload = 0;
stimulus.wait_trigger = 0;
stimulus.wait_key = 1;
stimulus.interval_sync = 0;
stimulus.stop_frame = [];
stimulus.flip_flag = 1;          
stimulus.reverse_flag = 1;       
stimulus.first_frame = 1;
stimulus.last_frame = [];        

run_stimulus(display, stimulus);
clear stimulus;

%% Raw Movie, Demo 3- reverse & upside down
%------------------------------------------------------------------------------
%
fprintf('\n\n<strong> Raw Movie, Demo 3- reverse & upside down; frames 2000 down to 1000. </strong>\n');
%
%------------------------------------------------------------------------------


stimulus = [];
stimulus.type = 'RM';
stimulus.fn = 'catcam_forest.rawMovie';
stimulus.back_rgb = [0.5, 0.5, 0.5];
stimulus.x_cen_offset = 0;   stimulus.y_cen_offset = 0;
stimulus.interval = 1;   
stimulus.preload = 0;
stimulus.wait_trigger = 0;
stimulus.wait_key = 1;
stimulus.interval_sync = 0;
stimulus.stop_frame = [];
stimulus.flip_flag = 2;          % 1 = normal; 2 = vertical flip; 3 = horizontal flip; 4 = vertical + horizontal flip
stimulus.reverse_flag = 1;       % should default to 0
stimulus.first_frame = 1000;
stimulus.last_frame = 2000;        % should default to auto-detect

run_stimulus(display, stimulus);
clear stimulus;

%% Cone-Isolating Pulse
%------------------------------------------------------------------------------
%
fprintf('\n\n<strong> Cone-Isolating Pulse </strong>\n');
%
%------------------------------------------------------------------------------
stimulus = [];
stimulus.type = 'PL'; 
stimulus.control_flag = 1;
stimulus.map_file_name = '1234d01/map-0000.txt';
stimulus.lut_file_name = '1234d01/lut.mat';
stimulus.back_rgb = [0.5, 0.5, 0.5];
stimulus.frames = 120;
stimulus.num_reps = 3;
stimulus.wait_trigger = 0;
stimulus.wait_key = 0;

run_stimulus(display, stimulus);
clear stimulus;

%% Cone-Isolating Pulse; As setup by S-file
%------------------------------------------------------------------------------
%
fprintf('\n\n<strong> Cone-Isolating Pulse; As setup by S-file. </strong>\n');
%
%-----------------------------------------------------------------------------
fprintf('Test takes a long time to complete.\n');

run_test = Tested_Input_Logical('Enter [1] to run demo, or [0] to skip.');

if (run_test)

stimulus = [];
stimulus.type = 'PL';
stimulus.control_flag = 2;
stimulus.sfile_name = 's03';
stimulus.mapfile = '/1234d01/map-0000.txt';

run_stimulus(display, stimulus);

end

Stop_RSM




