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
	
	end			% properties block
	
	
	
	methods
		
        % Constructor method
        function[obj] = Moving_Bar( stimuli )
            
            
            if (isfield(stimuli,'x_start'))
                if (isfield(stimuli,'x_end'))
                
                    % flip around if needed for proper ordering
                    if (stimuli.x_start > stimuli.x_end)
                        temp = stimuli.x_start;
                        stimuli.x_end = temp;
                        stimuli.x_start = stimuli.x_end;
                        clear temp
                    end
            
                    obj.x_start = stimuli.x_start;
                    obj.x_end = stimuli.x_end;
 
                
                    obj.bar_width = stimuli.x_end - stimuli.x_start;   
                    
                else
                    fprintf('\t RSM ERROR: x-end not recognized. Please define x_end value and try again. \n');
                    return
                end  
            else
                fprintf('\t RSM ERROR: x-start not recognized. Please define x_start value and try again. \n');
                return
            end  
        
        
        
            if (isfield(stimuli,'y_start'))
                if (isfield(stimuli,'y_end'))
                
                    % flip around if needed for proper ordering
                    if (stimuli.y_start > stimuli.y_end)
                        temp = stimuli.y_start;
                        stimuli.y_end = temp;
                        stimuli.y_start = stimuli.y_end;
                        clear temp
                    end
            
                    obj.y_start = stimuli.y_start;
                    obj.y_end = stimuli.y_end;
                
                    obj.bar_height = stimuli.y_end - stimuli.y_start;
            
                else
                    fprintf('\t RSM ERROR: y-end not recognized. Please define y_end value and try again. \n');
                    return
                end  
            else
                fprintf('\t RSM ERROR: y-start recognized. Please define y_start value and try again. \n');
                return
            end  

        
            if (isfield(stimuli,'x_delta'))
                if (isfield(stimuli,'y_delta'))

                    obj.x_delta = stimuli.x_delta;
                    obj.y_delta = stimuli.y_delta;
            
                else
                    fprintf('\t RSM ERROR: y-delta not recognized. Please define y_delta value and try again. \n');
                    return
                end  
            else
                fprintf('\t RSM ERROR: x-delta recognized. Please define x_delta value and try again. \n');
                return
            end  
   
        
            if (isfield(stimuli,'frames'))
                obj.frames = stimuli.frames;                       
            else
                fprintf('\t RSM ERROR: frames not recognized. Please define frames value and try again. \n');
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
            
            x_lead_new = obj.x_end;
            y_lead_new = obj.y_end;

            % OK: Time to tell DAQ we are starting
            Pulse_DigOut_Channel;
   
            for frame_num = 1:obj.frames,
                
                % Set up x
                if (obj.x_delta > 0)
                    % Then case is Left 2 right motion
                    
                    % update x_vertices
                    x_lead_new = x_lead_new + obj.x_delta;
                    x_lag_new = x_lead_new - obj.bar_width;
    
                else
                    x_lead_new = x_lead_new + obj.x_delta;
                    x_lag_new = x_lead_new - obj.bar_width;
    
                end  % x step
                
                
               if (obj.y_delta > 0)
                    % Then case is up to down
                    
                    % update x_vertices
                    y_lead_new = y_lead_new + obj.y_delta;
                    y_lag_new = y_lead_new - obj.bar_height;
    
               else
                    y_lead_new = y_lead_new + obj.y_delta;
                    y_lag_new = y_lead_new - obj.bar_height;
    
               end  % y step
                
    
                
                x_vertices = [x_lag_new; x_lead_new; x_lead_new; x_lag_new];
                
                y_vertices = [y_lag_new; y_lag_new; y_lead_new; y_lead_new];
                

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