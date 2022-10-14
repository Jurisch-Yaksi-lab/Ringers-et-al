%% Master-file loop

sourceP = 'Z:\Mert\Ciliascope\Christas Manuscript\aligned-files\';
targetP = 'Z:\Mert\Ciliascope\Christas Manuscript\analysed-files_test\';


% TODO: 
% 1) write a GUI frame to select the folder of where to get the aligned
% files. 
% 2) write a check that the files actually have the right name. 
stk_files = full(dir([sourceP,'*aligned.mat']));

progress()
for i = 1:length(stk_files)
    progress(i,length(stk_files),1)
    
    % Clear all except ref
    clearvars -except ref sourceP targetP stk_files i
    
    CBF.name = stk_files(i).name(1:end-4); % Give a names
    load([sourceP,CBF.name])
    
    % Retrieve the frame rate of acquisition
    [~,value]=import_json([sourceP, stk_files(i).name(1:end-12), '.json']);
    Fs= value(8);
    
    CBF.Fs = Fs; % Frequency of acquisition
    
    try 
        data = double(aligned);
    catch
        try 
        data = double(data);
        catch 
            print('Could not read data')
        end
    end 
        % Define the target path
    CBF.targetP = [targetP, stk_files(i).name(1:end-12),'_aligned', filesep];
    
    Master_analysisV2_3
    
end