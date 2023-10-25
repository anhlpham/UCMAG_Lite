 function setup = mag0_initialize_run
%----------------------------------------------------------------------
% Initialization of model parameters 
% Here, set up variables and parameters that control the run setup
%----------------------------------------------------------------------

 % Run setup
 setup.year_start = 2005;
 setup.year_end = 2005;
 setup.isave_envt = 1; % [1] Keeps structure with environmental forcing;

 % ROMS/Environment input file specifications
 % Input folder:
 %% Please change the directory here
 setup.in_dir = '/Users/anhpham/Desktop/Work/Kelp/MAG_0_ucla/MAG_0_ucla/datasets/ROMS_BEC_MAG_input'
 % Input file (as matlab structure)
 setup.in_file = 'z_ROMSdata_2005.mat';
 % File structure format:
 % ADD HERE SPECIFICATION FOR INPUT FILE FROM ROMS
 
 

