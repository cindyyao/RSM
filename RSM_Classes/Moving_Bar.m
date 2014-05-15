classdef	Moving_Bar < handle
    % Moving_Bar: Presents simple hard-edged rectangle as a moving bar.
%
%        $Id: Moving_Bar VER_ID DATA-TIME vinje $
%      usage: NAME(Args)
%         by: william vinje
%       date: Date
%  copyright: (c) Date William Vinje, Eduardo Jose Chichilnisky (GPL see RSM/COPYING)
% NB: when using mglQuad my convention is to start in upper left as 0, 0
% then always work in clockwise manner for sub-quads
% within each quad or sub-quad vertices are also described in a clockwise
% manner.

    properties
        
        stim_name

        run_date_time
        run_time_total
        
        main_trigger
        tmain0
        
        rep_trigger
        trep0

        run_duration
        stim_update_freq               
        
        run_script
        
        color
        backgrndcolor
       
        bar_width
        bar_height
        
        x_start
        x_end
        y_start
        y_end
        
        num_reps    % this controls how many reps we want to run
        
        reps_run    % this records how many bar passes have already occured
        
        x_delta
        y_delta
        frames

        wait_trigger
        wait_key
        repeat_num
        
        direction
        interval
	
	end			% properties block
	
	
	
	methods
		
        % Constructor method
        function[obj] = Moving_Bar( stimuli )
            global display
            
            if (isfield(stimuli,'bar_width'))
                obj.bar_width = stimuli.bar_width;
            else
                fprintf('\t RSM ERROR: bar_width not recognized. Please define bar_width value and try again. \n');
                return
            end  
            
            
            if (isfield(stimuli,'delta'))

                    obj.x_delta = stimuli.delta*cos(stimuli.direction*pi/180);
                    obj.y_delta = stimuli.delta*sin(stimuli.direction*pi/180);
            
            else
                fprintf('\t RSM ERROR: delta recognized. Please define delta value and try again. \n');
                return
            end  
   
        
            if (isfield(stimuli,'rgb'))
               obj.color = [stimuli.rgb(1); stimuli.rgb(2); stimuli.rgb(3)];
               obj.color = Color_Test( obj.color );
            else
                fprintf('\t RSM ERROR: rgb not recognized. Please define rg value and try again. \n');
                return
            end
        
        
            if (isfield(stimuli,'num_reps'))
                obj.num_reps = stimuli.num_reps;
            else
                fprintf('\t RSM ERROR: number of repetitions not recognized. Please define num_reps value and try again. \n');
                return
            end
            
            if (isfield(stimuli,'interval'))
                obj.interval = stimuli.interval;
            else
                fprintf('\t RSM ERROR: interval not recognized. Please define interval value and try again. \n');
                return
            end
            
            if (isfield(stimuli,'direction'))
                obj.direction = stimuli.direction;
                L = 2000;
                switch stimuli.direction
                    case 0
                        obj.x_start = [0; 0; stimuli.bar_width; stimuli.bar_width];
                        obj.y_start = [0; display.height; display.height; 0];
                        obj.frames = display.width/stimuli.delta;
                    case 180
                        obj.x_start = [display.width-stimuli.bar_width; display.width-stimuli.bar_width; display.width; display.width];
                        obj.y_start = [0; display.height; display.height; 0];
                        obj.frames = display.width/stimuli.delta;
                    case 90
                        obj.x_start = [0; 0; display.width; display.width];
                        obj.y_start = [display.height-stimuli.bar_width; display.height; display.height; display.height-stimuli.bar_width];
                        obj.frames = display.height/stimuli.delta;
                    case 270
                        obj.x_start = [0; 0; display.width; display.width];
                        obj.y_start = [0; stimuli.bar_width; stimuli.bar_width; 0];
                        obj.frames = display.height/stimuli.delta;
                    case 45
                        obj.x_start = [-L; L; L; -L];
                        obj.y_start = [display.height-L; display.height+L; display.height-stimuli.bar_width*sqrt(2)+L; display.height-stimuli.bar_width*sqrt(2)-L];
                        obj.frames = display.width*sqrt(2)/stimuli.delta;
                    case 225
                        obj.x_start = [0; L; L; 0];
                        obj.y_start = [-display.width+stimuli.bar_width*sqrt(2); L-display.width+stimuli.bar_width*sqrt(2); L-display.width; -display.width];
                        obj.frames = display.width*sqrt(2)/stimuli.delta;
                    case 135
                        obj.x_start = [L; 0; 0; L];
                        obj.y_start = [display.height+display.width-stimuli.bar_width*sqrt(2)-L; display.height+display.width-stimuli.bar_width*sqrt(2); display.height+display.width; display.height+display.width-L];
                        obj.frames = display.width*sqrt(2)/stimuli.delta;
                    case 315
                        obj.x_start = [L; -L; -L; L];
                        obj.y_start = [-L; L; stimuli.bar_width*sqrt(2)+L; stimuli.bar_width*sqrt(2)-L];
                        obj.frames = display.width*sqrt(2)/stimuli.delta;
                    otherwise
                        fprintf('\t RSM ERROR: invalid direction. Please define valid direction value and try again. \n');
                        return
                end
                obj.frames = obj.frames + stimuli.interval;
                
            else
                fprintf('\t RSM ERROR: direction not recognized. Please define direction value and try again. \n');
                return
            end

            % Note: color is rgb vector in [0-1] format, vertical vect for mglQuad  
            obj.backgrndcolor = [stimuli.back_rgb(1); stimuli.back_rgb(2); stimuli.back_rgb(3)];
            obj.backgrndcolor = Color_Test( obj.backgrndcolor );
            
            obj.wait_trigger = stimuli.wait_trigger;                            
            obj.wait_key = stimuli.wait_key;
 
          
            % The following setup values are not under direct user control
            % via the setup script

            obj.stim_name = 'Moving_Bar';

            obj.run_date_time = [];
            obj.run_time_total = [];
            
            obj.run_duration = [];      % By setting this to empty we indicate we switch to end condition being a fixed number of reps 
            obj.stim_update_freq = []; % By setting this to empty we remove artificial delay in main execution while loop
            
            obj.main_trigger = 0;        
            obj.tmain0 = [];
            
            obj.rep_trigger = 0;        
            obj.trep0 = [];
            
            obj.run_script = 'Run_Bar_Rep( exp_obj.stimulus );';
            
            obj.reps_run = 0;
            obj.repeat_num = 0;
            

		end		% constructor 
		

        
        function Run_Bar_Rep( obj )
            
            x_new = obj.x_start;
            y_new = obj.y_start;

            % OK: Time to tell DAQ we are starting
            Pulse_DigOut_Channel;
   
            for frame_num = 1:obj.frames,
                
                % Set up x
                % Then case is Left 2 right motion

                % update x_vertices
                x_new = x_new + obj.x_delta;
                y_new = y_new - obj.y_delta;
                
                x_vertices = x_new;
                
                y_vertices = y_new;
                

                % Draw the quad
                mglClearScreen( obj.backgrndcolor ); 
                
                new_color = obj.color + obj.backgrndcolor;
                [ new_color ] = Color_Test( new_color );
                        
                mglQuad(x_vertices, y_vertices, new_color, 0);
                                                                
                mglFlush();
            
    
            end % loop through frames
  
        end     % Run bar rep
		
        
	end			% methods block
    
    
end             % Moving Bar class