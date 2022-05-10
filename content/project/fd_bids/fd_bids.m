function output = fd_bids(bids_dir, sav)
% Edited script for calculating framewise displacement from fMRIPrep
% confounds (updated for v20.2.1). Rewritten into function format to use
% for any BIDS compliant folder.
%
% BIDS_DIR is a string variable which contains the top level of the BIDS
% project (folder which contains all the subjects) which this script needs
% to access to run framewise displacement calculations on.
%
% SAV is a boolean variable which contains the response to export/ save
% the data variables into a .csv file. This argument is optional thus
% specifying True OR 1 in this argument is the only way to save data as a
% part of the function else the data will only be loaded into the
% workspace.
%
% Developed by Darren Liang
% Last updated: 09 MAY 2022

cwd = pwd;

% generate subject list from BIDS_dir
listdir = dir(bids_dir);
listnames = {listdir.name};
dirFlags = [listdir.isdir];
subjects = {};

for idx=1:length(listnames)
    if dirFlags(idx) == 1 && contains(listnames(idx), 'sub-')
        subjects = [subjects; listnames(idx)];
    else
        continue
    end
end

% subjects={'002' '003' '005' '006' '007' '008' '009' '010' '011' '012'...
% '013' '015' '016' '017' '018' '019' '020' '021' '022' '023' '024'...
% '025' '101' '102' '103' '104' '105' '106' '107' '108' '109' '110' ...
% '111' '112' '113'}';

for a=1:length(subjects)
    s=subjects(a);
    folder = strcat(bids_dir, filesep, s, '/ses-001/func');
    cd(folder{1,:});
    
    % generate run types from subject directory using file of interest
    rundir = dir([folder{1}, filesep, '*confounds_timeseries.tsv']);
    runs = {rundir.name};
    
    % run={'intact' 'scrambled'};
    
    for b=1:length(runs)
        filee = runs(b);
        %filee = strcat(s,'*',r,'*confounds_timeseries.tsv');
        fileee=dir(filee{1,:});
        file=fileee.name;
        M=tdfread(file);
        FD=M.framewise_displacement;
        for c=1:length(FD)
            FD_array(c,1)=str2double(FD(c,:));
        end
        FD_over_1=FD_array>1;
        FD_over_11=FD_array>1.1;
        FD_over_12=FD_array>1.2;
        FD_over_15=FD_array>1.5;
        FD_over_2=FD_array>2;
        FD_max=max(FD_array);
        
        if sum(FD_over_1,1)>0
            Bad_run_1(a,b)=cellstr(file);
        end
        if sum(FD_over_11,1)>0
            Bad_run_11(a,b)=cellstr(file);
        end
        if sum(FD_over_12,1)>0
            Bad_run_12(a,b)=cellstr(file);
        end       
        if sum(FD_over_15,1)>0
            Bad_run_15(a,b)=cellstr(file);
        end
         if sum(FD_over_2,1)>0
            Bad_run_2(a,b)=cellstr(file);
         end
         bad_FD(a,b)= FD_max;
    end
    
end

cd(cwd)
output = Bad_run_1;

if exist('sav', 'var') && sav == 1
    fprintf('Saving data to .mat\n')
    save(strcat(bids_dir, filesep, 'FD_bad_runs.mat'));
else
    fprintf('Run which exceeded 1mm loaded into workspace but not saved.\n')
end
