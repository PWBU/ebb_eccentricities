%% %% Control panel% Ver.P for the PUPIL experiment

%% What variables?
colNames = {'Code', 'Block', 'WTrial', 'TTrial', 'InducerSize', ...
    'Distance', 'Condition', 'Hemifield', 'Correct', 'Starts', ...
    'Reversals', 'StepSize', 'NumGraves', 'IsRev', 'Rsize'};
NumberOfVariables = length(colNames);

%% Experimental setup
distance = 82; % distance from screen in cm
width = 62; % width of screen in cm
resolution = screenYpixels; % horizontal res of screen in pixels


%% Storage variables
bloks = 4;

%% Stimuli options/dimensions. Sizes are in deg of vis angle
spaceBetweenStim =13;
rcircleSize = 1.5;
inducerLargeSize = [rcircleSize * 2 rcircleSize*.62];
inducerSmallSize = [rcircleSize * .5 rcircleSize*.1];
cueSize = 2; %to be adjusted
fixSize = .2;
eccs = [0 3 10];
initialStartLim = .2;
numberOfInducers = 8;
howManyInducerSizes = 2;
changeValues = linspace(-.4, .4, 33);
randOffset = [-.5, .5]; 


%% EYELINK stuff
FixationThreshold = 4; % in DOVA
stopkey=KbName('space'); eye_used = -1;


%% Staircase variables
numberOfTrials = 50;
upDownRule = [1 1];
toTheBase = 2;
InitialStepSize = .1;
StepSwitch = [2 4 8 17];
StepAdjust = [.075 .05 .05];

%% Formatting
pen = 2;

%% Timing
preTrialwait = .0;
waitB4Stim = .1;
displayTime = .1;
waitBetween = [.5 0];
cueTime = .25;


waitB4Stim = .500;
displayTime = .100; % specified in milliseconds how long to display test stimuli
waitB4interval = .25; 
betweenInterval = .5; 


%% Conversion of angles above to pixels

spaceBetweenStim = angle2pix(distance, width, resolution, spaceBetweenStim);
rcircleSize = angle2pix(distance, width, resolution, rcircleSize);
inducerLargeSize = angle2pix(distance, width, resolution, inducerLargeSize);
inducerSmallSize = angle2pix(distance, width, resolution, inducerSmallSize);
fixSize = angle2pix(distance, width, resolution, fixSize);
eccs = angle2pix(distance, width, resolution, eccs);
cueSize = angle2pix(distance, width, resolution, cueSize);
FixationThreshold = angle2pix(distance, width, resolution, FixationThreshold);
randOffset = angle2pix(distance, width, resolution, randOffset);


%% Misc initialisations
distNum = length(eccs);
hemifieldLocation = [NaN NaN];
sizeNum = length(changeValues);
rcircleRect = [0 0 rcircleSize rcircleSize];
inducerLarge = [0 0 inducerLargeSize(1) inducerLargeSize(1)];
inducerSmall = [0 0 inducerSmallSize(1) inducerSmallSize(1)];
fixRect = [0 0 fixSize fixSize];
correct = NaN;
answerNow = NaN;
Trial = 0;
factorTemp = [];
Graveyard = [];
testIs = [];
florpGo = randi(2);
cancel = 0;
eccsNum = length(eccs);
sure = 0; skip = 0

%% Load some misc resources

% [respondNow, respondNowX] = audioread('Sounds\respondNow.wav');
% [fixLost, fixLostX] = audioread('Sounds\fixLost.wav');
[RGB1, ~, ALPHA1] = imread('cue.png');
RGB1(RGB1 ~= 0) = grey(1); 
cueTex = Screen('MakeTexture', window, cat(3, RGB1, ALPHA1));



%% Condition array setup
if NoFull == 1
    FactorList = fullfact([howManyInducerSizes+1 eccsNum]);
    FactorListSize = size(FactorList);
    FactorList = [FactorList; FactorList];
    FactorListSize = length(FactorList);
    vars = FactorListSize;
    FactorList = [FactorList (1:vars)'];
    FactorSize = size(FactorList);
else
    
    load('data\T1.mat', 'FactorList')
    FactorSize = size(FactorList);
    vars = FactorSize(1); 
    
end


%% Staircase setup
addpath(genpath('staircase'))
starterArray = [];



for oof = 1:FactorSize(1)/2
    starterGo = initialStartLim;
    starterArray = [starterArray; starterGo];
end
for boof = (FactorSize(1)/2+1):FactorSize(1)
    starterGo = -initialStartLim;
    starterArray = [starterArray; starterGo];
end

Levels = [changeValues(1) changeValues(length(changeValues))];
S = thisStaircaseSetup(vars, starterArray, upDownRule, Levels, InitialStepSize);






