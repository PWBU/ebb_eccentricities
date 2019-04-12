
%
%
%                                                                   ,,           ,,
% `7MM"""YMM                                        mm              db           db   mm
%   MM    `7                                        MM                                MM
%   MM   d     ,p6"bo   ,p6"bo   .gP"Ya `7MMpMMMb.mmMMmm `7Mb,od8 `7MM  ,p6"bo `7MM mmMMmm `7M'   `MF'
%   MMmmMM    6M'  OO  6M'  OO  ,M'   Yb  MM    MM  MM     MM' "'   MM 6M'  OO   MM   MM     VA   ,V
%   MM   Y  , 8M       8M       8M""""""  MM    MM  MM     MM       MM 8M        MM   MM      VA ,V
%   MM     ,M YM.    , YM.    , YM.    ,  MM    MM  MM     MM       MM YM.    ,  MM   MM       VVV
% .JMMmmmmMMM  YMbmd'   YMbmd'   `Mbmmd'.JMML  JMML.`Mbmo.JMML.   .JMML.YMbmd' .JMML. `Mbmo    ,V
%                                                                                             ,V
%                                                                                          OOb"
%
%             ,,        ,,        ,,                        ,,
% `7MM"""YMM *M1M       *MM        db                      `7MM
%   MM    `7  MM        MM                                  MM
%   MM   d    MM,dMMb.  MM,dMMb.`7MM  `7MMpMMMb.  .P"Ybmmm  MMpMMMb.   ,6"Yb.`7MM  `7MM  ,pP"Ybd
%   MMmmMM    MM    `Mb MM    `Mb MM    MM    MM :MI  I8    MM    MM  8)   MM  MM    MM  8I   `"
%   MM   Y  , MM     M8 MM     M8 MM    MM    MM  WmmmP"    MM    MM   ,pm9MM  MM    MM  `YMMMa.
%   MM     ,M MM.   ,M9 MM.   ,M9 MM    MM    MM 8M         MM    MM  8M   MM  MM    MM  L.   I8
% .JMMmmmmMMM P^YbmdP'  P^YbmdP'.JMML..JMML  JMML.YMMMMMb .JMML  JMML.`Moo9^Yo.`Mbod"YML.M9mmmP'
%                                                6'     dP
%                                                Ybmmmd'
%
%
% ___________________________________________________________________
%
%An experiment that measures the relationship between
%eccentricty and the Ebbinghaus illusion. To be used with an Eyelink
%eye-tracking device.
%
% ___________________________________________________________________

% HISTORY
% mm/dd/yy
%
% 18/12/18 created
%
%
%
%
% DEBUG/ToDo
% Decide on timings, and then pilot


%% Begin
close all
clear all




try
    testOn = 3;
    if testOn == 2
        Code = 1;% input('Name?', 's');
        Name = input('Name?', 's');
        NameNumber = input('Number?');
        Test = 2; %input('Test? (1) or no (2)?');
        Synch = input('Sync(1) or Skip sync(2)');
        IsEL = input('EyeLink(1) or no(2)?');
        sim = 2;%input('Simulation(1) or no (2)?');
    elseif testOn == 1
        Code = 999;% input('Name?', 's');
        Name = 'Test';
        NameNumber = 999;
        Test = 2; %input('Test? (1) or no (2)?');
        Synch = 2;
        IsEL = 1;
        sim = 2;%input('Simulation(1) or no (2)?');
    end
        Code = randi(9999); 
        Name = input('Name?', 's');
        NoFull = input('All toolboxes(1) or no(2)?'); 
        NameNumber = 999;
        Test = 2; %input('Test? (1) or no (2)?');
        Synch = input('Synch(1) or no(2)?'); %2;
        IsEL = input('Eyelink(1) or no(2)?'); %2;
        sim = 2;%input('Si
        ListenChar(2); 

    
    %% Screen setup ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    addpath(genpath('EL_Functionality'));
    addpath(genpath('Ebbinghaus_Main'));
    addpath(genpath('instructions'));
    run('setup.m');
    run('pcontrolpanel.m');
    
    %% Unify key names
    KbName('UnifyKeyNames');
    

    %% Initiate storage and terminate arrays
    MainStorage = NaN((vars*numberOfTrials), NumberOfVariables);
    numGraves = size(Graveyard);
    run('instructionsSetup.m');
    instructions(instruct); 
    
    %% Initiate EL and record start time
    c = clock; run('initiate_EL.m');  
    
    %% Start the experiment
    
    i = 0; 
    while numGraves < vars
        
        i = i+1; ii = 0;
        florp = mod(florpGo, 2)+1;
        florpGo = florpGo + 1;
        numGraves = size(Graveyard);
        WaitSecs(.001);
        
        %% Breaktime
        run('breaktime.m');
        
        
        % Trials start here
        for ii = 1:numberOfTrials
            Trial = Trial + 1;
            
            %run('parametertest.m'); throw;
            
            run('ptrial.m');
            if S.Reversals(ThisFactor(2)) == StepSwitch(4)
                Graveyard = [Graveyard ThisFactor(2)];
            end
            numGraves = size(Graveyard);
            
            %% Storage procedure
            run('storage.m');
            
        end
        
    end
    
    %% CLEAN UP
catch ERROR
    sca; ShowCursor; commandwindow; ListenChar(0); ERROR.message
    save(strcat('ERROR_', num2str(randi(10000)), '.', date, '_',...
        num2str(c(4)), '.', num2str(c(5)), '.', num2str(c(5))...
        , '.mat'));
end

if  ~exist('ERROR', 'var')
    %% Naming an saving the current workspace
    table = array2table(MainStorage, 'VariableNames', colNames);
    save(strcat(num2str(randi(10000)), '.', date, '_',...
        num2str(c(4)), '.', num2str(c(5)), '.', num2str(c(5))...
        , '.mat'));
    
    endTime = clock;
    toa = endTime - c; toaStr =(toa(4) * 60) + toa(5);
    
    %% Last message to viewer
    Screen('DrawText', window, [...
        'That took ' num2str(toaStr), ' minutes!'], xCenter, yCenter, white);
    Screen('Flip', window);
    WaitSecs(1);
    KbPass;
    Screen('DrawText', window, [...
        'Thank you for participating, ', Name, '!'], xCenter, yCenter, white);
    Screen('Flip', window);
    WaitSecs(1);
    KbPass;
end

%% Shut down screen boiiii
sca; ShowCursor; commandwindow; ListenChar(0);
thresh_areas








