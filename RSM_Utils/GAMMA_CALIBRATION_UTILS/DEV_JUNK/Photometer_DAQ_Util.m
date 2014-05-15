% NAME: Role
%
%        $Id: NAME VER_ID DATA-TIME vinje $
%      usage: NAME(Args)
%         by: william vinje
%       date: Date
%  copyright: (c) Date William Vinje, Eduardo Jose Chichilnisky (GPL see RSM/COPYING)
%    purpose: Role
%      usage: Examples
%
%

function[ data_out ] = Photometer_DAQ_Util( obj )

fprintf('****************************************\n');
fprintf('Photometer Stimulus Presentation Utility\n');
fprintf('****************************************\n');
fprintf('\n');
fprintf('Pre-supported Optometer protocols:\n');
fprintf('\t (1)Graseby 350 Linear/Log Optometer \n\n');

not_done = 1;
while (not_done),
    selection = input('Enter optometer selection: ');
    not_done = 0;
                 
    switch selection
                     
        case 1,
            optometer_protocol_CA{1} = 'Is Auto-Zero mode set?          (1) to confirm: ';
            optometer_protocol_CA{2} = 'Is Slow Integration Mode set?   (1) to confirm: ';
            optometer_protocol_CA{3} = 'Is Power mult set to 10^0?      (1) to confirm: ';
                         
        otherwise,
            disp('Please configure your optometer properly.');
            optometer_protocol_CA = [];
                     
    end % switch on stim choice
                 
end % while loop to select valid optometer

% Review protocol

if (~isempty( optometer_protocol_CA ))
    for op = 1:length( optometer_protocol_CA ),

        fprintf('\t');
        [ val ] = Tested_Input_Logical( optometer_protocol_CA{op} );
    
    end % loop through protocol review
end

w = obj.width;
h = obj.height;
                        
x_vertices = [0; w; w; 0];
y_vertices = [0; 0; h; h];

min_gun_val = 0;
max_gun_val = 1;
num_steps = 17;  % Enough?

not_done = 1;
data_out = [];
data_index = 0;

fprintf('\n');
fprintf('** Commencing Monitor Data Collection **\n');


while( not_done ),

    for gun_color = 1:3,
        
        levels = linspace( min_gun_val, max_gun_val, num_steps) ;
    
        % Loop through the various gun levels
        for i = 1:length(levels),
        
            % Set the colors
            switch gun_color, 
        
                case 1 % red
                    color = [levels(i); 0; 0];

                case 2 % green
                    color = [ 0; levels(i); 0];

                case 3 % blue
                    color = [0; 0; levels(i)];

            end % switch
        
            % Color the screen         
            mglQuad(x_vertices, y_vertices, color, 0); 
            mglFlush();
         
            % Collect the data
            fprintf('Gun level: %d \t//\t', levels(i) );
            power = input('Enter power reading: ');
        
            % Fill out the data_out
            data_index = data_index + 1;
            data_out(data_index,:) = [color', power];
        
        end % loop through levels
    
    end     % loop through guns

    %Collect another repetition?
    not_done = Tested_Input_Logical('Enter (1) to collect another repetition or (0) to exit data acquisition: ');
    
end     % rep loop

mglClose;

fprintf('**  Monitor Data Collection Completed **\n');

%Display_Monitor_Data( data_out );
