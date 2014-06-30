%% Initialization

Start_RSM;
mglSetGammaTable( RSM_GLOBAL.monitor.red_table, RSM_GLOBAL.monitor.green_table, RSM_GLOBAL.monitor.blue_table );

% mglMoveWindow(5, 1055);

%% Stimulus
%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Focus Squares
%------------------------------------------------------------------------------
%
fprintf('\n\n<strong> Focus squares. </strong>\n');
%
%-----------------------------------------------------------------------------
clear_pending_stim

stimulus = [];
stimulus.type = 'FS';
stimulus.stim_width = 900;
stimulus.stim_height = 900;
stimulus.back_rgb = [0.5, 0.5, 0.5];

run_stimulus(display, stimulus);
clear stimulus;


%% Solid full-screen color
%------------------------------------------------------------------------------
%
fprintf('?\n\n<strong> Solid full-screen color. </strong>\n');
%
%------------------------------------------------------------------------------
clear_pending_stim

stimulus.type = 'SC';
stimulus.back_rgb = [0.5, 0.5, 0.5];
stimulus.rgb = [1, 0, 0];
stimulus.rgb = stimulus.rgb - stimulus.back_rgb;   
stimulus.wait_trigger = 0;
stimulus.wait_key = 0;
stimulus.x_start = 320;  stimulus.x_end = 1120;
stimulus.y_start = 50;   stimulus.y_end = 850;

run_stimulus(display, stimulus);
clear stimulus;

%% Flashing full-screen color
%------------------------------------------------------------------------------
%
fprintf('\n\n<strong> Flashing full-screen color. </strong>\n');
%
%------------------------------------------------------------------------------
clear_pending_stim

stimulus = [];
stimulus.type = 'FC';  
stimulus.rgb = [1, 0, 0];
stimulus.back_rgb = [0.5, 0.5, 0.5];
stimulus.frames = 60;
stimulus.num_reps = 3;
stimulus.wait_trigger = 0;
stimulus.wait_key = 0;

run_stimulus(display, stimulus);
clear stimulus;

%% Full Field Pulses (w-g-b-g)
%------------------------------------------------------------------------------
%
fprintf('\n\n<strong> Full Field Pulses. </strong>\n');
%
%------------------------------------------------------------------------------
clear_pending_stim

stimulus = [];
stimulus.type = 'FP';  
stimulus.rgb_white = [1, 1, 1];
stimulus.rgb_black = [0, 0, 0];
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
clear_pending_stim

stimulus = [];
stimulus.type = 'MB';
stimulus.back_rgb = [0, 0, 0];
stimulus.rgb = [1, 1, 1];
stimulus.rgb = stimulus.rgb - stimulus.back_rgb;
stimulus.bar_width = [60 120 240];
stimulus.direction = [0 45 90];
stimulus.delta = 5;      
stimulus.interval = 60; %frame
stimulus.num_reps = 1;
stimulus.wait_trigger = 0;
stimulus.wait_key = 0;
stimulus.repeats = 2;

run_stimulus(display, stimulus);
clear stimulus;

%% Moving Grating
%------------------------------------------------------------------------------
%
fprintf('\n\n<strong> Moving Grating. </strong>\n');
%
%------------------------------------------------------------------------------
clear_pending_stim
stimulus = [];
stimulus.type = 'MG';
stimulus.subtype = 'square';
stimulus.back_rgb = [0.0, 0.0, 0.0];
stimulus.rgb = [1.0, 1.0, 1.0];
stimulus.rgb = stimulus.rgb - stimulus.back_rgb;
stimulus.phase0 = 45; 
stimulus.temporal_period = [1 0.5];  % sec
stimulus.spatial_period = [120 60 240];  % frame
stimulus.direction = [315 0];       % Convention 0 deg is 3 oclock
stimulus.frames = 300;        
stimulus.wait_trigger = 0;
stimulus.wait_key = 0;
stimulus.repeats = 2;


run_stimulus(display, stimulus);
clear stimulus;


%% Counterphase Grating
%------------------------------------------------------------------------------
%
fprintf('\n\n<strong> Counterphase Grating. </strong>\n');
%
%------------------------------------------------------------------------------
clear_pending_stim

stimulus = [];
stimulus.type = 'CG';  
stimulus.back_rgb = [0.0, 0.0, 0.0];
stimulus.rgb = [1.0, 1.0, 1.0];
stimulus.rgb = stimulus.rgb - stimulus.back_rgb;
stimulus.phase0 = 0; 
stimulus.temporal_period = 1;  
stimulus.spatial_period = 60;
stimulus.direction = [0 45];

stimulus.frames = 300;        
stimulus.wait_trigger = 0;
stimulus.wait_key = 0;
stimulus.repeats = 1;

run_stimulus(display, stimulus);
clear stimulus;


%% Random Noise : Binary
%------------------------------------------------------------------------------
%
fprintf('\n\n<strong> Random Noise : Binary. </strong>\n');
%
%------------------------------------------------------------------------------
clear_pending_stim

stimulus = [];
stimulus.type = 'RN';

stimulus.back_rgb = [0.5, 0.5, 0.5];
stimulus.rgb = [1.0, 1.0, 1.0];
stimulus.rgb = stimulus.rgb - stimulus.back_rgb;
stimulus.independent = 0;
stimulus.interval = 2; % frame
stimulus.seed = 11111;
stimulus.x_start = 420;  stimulus.x_end = 1020;
stimulus.y_start = 150;   stimulus.y_end = 750;
stimulus.stixel_width = 15;      stimulus.stixel_height = 15;       stimulus.field_width = 40;        stimulus.field_height = 40;        
stimulus.duration = 20;  % sec    
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
clear_pending_stim

stimulus = [];
stimulus.type = 'RN';
stimulus.back_rgb = [0.5, 0.5, 0.5];
stimulus.rgb = [1.0, 1.0, 1.0];
stimulus.rgb = stimulus.rgb - stimulus.back_rgb;
stimulus.independent = 1;
stimulus.interval = 2;
stimulus.seed = 11111;
stimulus.x_start = 420;  stimulus.x_end = 1020;
stimulus.y_start = 150;   stimulus.y_end = 750;
stimulus.stixel_width = 15;      stimulus.stixel_height = 15;       stimulus.field_width = 40;        stimulus.field_height = 40;        
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
clear_pending_stim

stimulus = [];
stimulus.type = 'RG';

stimulus.back_rgb = [0.5, 0.5, 0.5];
stimulus.rgb = [1.0, 1.0, 1.0];
stimulus.rgb = stimulus.rgb - stimulus.back_rgb;
stimulus.interval = 3;
stimulus.seed = 11111;

stimulus.x_start = 420;  stimulus.x_end = 1020;
stimulus.y_start = 150;   stimulus.y_end = 750;
stimulus.stixel_width = 15;      stimulus.stixel_height = 15;       stimulus.field_width = 40;        stimulus.field_height = 40;        
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
clear_pending_stim

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
clear_pending_stim

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
clear_pending_stim

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
clear_pending_stim

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
clear_pending_stim

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




