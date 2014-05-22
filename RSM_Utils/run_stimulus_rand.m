function [] = run_stimulus_rand( monitor_description, stim_in )

if (strcmp(stim_in.type, 'MG') || strcmp(stim_in.type, 'CG') || strcmp(stim_in.type, 'MB'))    
    [stimulus, seq, trial_num_total] = rand_stim(stim_in);
    stim_out = stim_in;
    stim_out.trial_list = seq;
    uisave('stim_out')

    for i = 1:trial_num_total
        run_stimulus( monitor_description, stimulus(i) )
    end
else
    fprintf('\t RSM ERROR: For stimulus other than Moving_Bar, Moving_Grating, Counterphase_Grating, please use run_stimulus instead of run_stimulus_rand  \n');
    return
end
end
