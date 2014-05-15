function[gamma, thresh, alpha, final_fit_stat] = Fit_Gun_Luminance_Curve(raw_data, rgb)



% Now set up for fitting
Auxillary_Info = Gun_Vals;



% PART 3: Fit the sucka 

%params = [gamma, offset, alpha]

In_Params = [2.5, 30, max(Data)];
Min_Step_Sizes = [0.01, 1, 0.1];
Max_Step_Sizes = [0.2, 5, 1];

% TO set the tolerance I will find the TS score generated by the initial parameters
[model_out] = Model(In_Params, Auxillary_Info);
Initial_TS = FitStat(model_out, Data, Auxillary_Info);

Tol = 0.001 * Initial_TS;
Mode = 'Fixed';
%Mode = 'Adapt';                 % Use adaptive change of step sizes
V = 1;                          % Verbose flag


[final_params, final_fit_stat, num] = FitUtil(In_Params, Min_Step_Sizes, Max_Step_Sizes, Tol, Mode, Auxillary_Info, Data, V);

gamma = final_params(1);
thresh = final_params(2);
alpha = final_params(3);