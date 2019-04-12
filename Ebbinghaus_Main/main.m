%% Poutasi W. B.  Ebbinghaus pupil size =/= brightness test
% v.3

%% Begin
close all
clear all

try
    Code = 1;% input('Name?', 's');
    Name = input('Name?', 's');
    NameNumber = input('Number?');
    Test = 2; %input('Test? (1) or no (2)?');
    Synch = input('Sync(1) or Skip sync(2)');
    sim = 2;%input('Simulation(1) or no (2)?');
    
    %% Screen setup ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    run('setup.m');
    run('controlpanel.m');
    run('countdown_sounds.m');
    
    %% Condition array setup
    FactorList = fullfact([howManyInducerSizes distNum]); %two incuder sizes x distances x right/left hemifield
    FactorListSize = size(FactorList);
    vars = FactorListSize(1);
    control = [];
    for skrt = 1:FactorListSize(2)
        control = [control (max(FactorList(:, skrt))+1)];
    end
    FactorList = [FactorList; control];
    FactorList = [FactorList; FactorList];
    FactorListSize = length(FactorList);
    vars = FactorListSize;
    FactorList = [FactorList (1:vars)'];
    
    
    %% Initiate EL
    EyelinkUtility(6, IsEL);
    
    
    %% Staircase setup
    addpath(genpath('staircase'))
    starterArray = initialStartLim;
    for oof = 1:((howManyInducerSizes*distNum)+ 1)
        starterGo = initialStartLim;
        starterArray = [starterArray; starterGo];
    end
    for boof = ((howManyInducerSizes*distNum)+ 1) +...
            1:(((howManyInducerSizes*distNum)+ 1)+((howManyInducerSizes*distNum)+ 1))
        starterGo = -initialStartLim;
        starterArray = [starterArray; starterGo];
    end
    
    Levels = [changeValues(1) changeValues(length(changeValues))];
    S = thisStaircaseSetup(vars, starterArray, upDownRule, Levels, InitialStepSize);
    
    
    
    
    %% Initiate storage arrays
    MainStorage = NaN((vars*numberOfTrials), NumberOfVariables);
    i = 0;
    numGraves = size(Graveyard);
    c = clock;
    
    
    %% Start the experiment
    
    while vars > numGraves(2)
        i = i + 1;
        florp = mod(florpGo, 2)+1;
        florpGo = florpGo + 1; %1 = choose bigger, 2 = choose smaller 
        ii = 0;
        numGraves = size(Graveyard);
        WaitSecs(.001);
        
        %% Breaktime
        run('breaktime.m');
           
        
        % Trials start here
        while ii < numberOfTrials && vars > numGraves(2)
            ii = ii + 1;
            Trial = Trial + 1;
            %             run('parametertest.m'); throw; %unquote this to look at sizes instead
            %of running the 'speriment
            
            run('trial.m');
            if S.Reversals(ThisFactor(3)) == StepSwitch(4)
                Graveyard = [Graveyard ThisFactor(3)];
            end
            numGraves = size(Graveyard);
            
            %% Storage procedure
            run('storage.m');
            
        end
           
    end
    %% CLEAN UP
catch ERROR
    save(strcat('data\', Name, '.', date, '_',...
        num2str(c(4)), '.', num2str(c(5)), '.', num2str(c(5))...
        , '.mat'));
    sca; ShowCursor; commandwindow; ListenChar(0); ERROR.message
end

%% Naming an saving the current workspace
table = array2table(MainStorage, 'VariableNames', colNames);
save(strcat('data\', Name, '.', date, '_',...
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

%% Shut down screen boiiii
sca; ShowCursor; commandwindow; ListenChar(0);


%% Finalize and download edf file + shutdown EL






