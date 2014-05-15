function[ monitor_description ] = Build_Monitor_Description( data_filename, width, height, screen_refresh_freq )

def_path = '/Volumes/wvinje/WorkCore/SUPER_STIM/RetStimMGL_beta_0p1/RSM_Monitors/';

fn = cat(2, def_path, data_filename);

raw_data_S = load(fn);

if (length( fieldnames(raw_data_S) ) == 1 )
    data_field_name = fieldnames(raw_data_S);
else
    disp('ERROR: More than one field in monitor data!');
    keyboard
end

extractor_call = strcat('[ optometer_raw_data ] = raw_data_S.',data_field_name{1},';');
eval(extractor_call);


[ monitor_description.red_channel ] = Analyze_Monitor_Chan( optometer_raw_data, 'r' );
[ monitor_description.green_channel ] = Analyze_Monitor_Chan( optometer_raw_data, 'g' );
[ monitor_description.blue_channel ] = Analyze_Monitor_Chan( optometer_raw_data, 'b' );


monitor_description.stimwindow.width = width;
monitor_description.stimwindow.height = height;
monitor_description.stimwindow.screen_refresh_freq = screen_refresh_freq;

monitor_description.run_date = date;
