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

function[ optometer_protocol_CA ] = Photometer_Setup_Util( obj )

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
