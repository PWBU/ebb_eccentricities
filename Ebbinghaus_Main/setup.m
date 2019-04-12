

%% Background colour
background_colour = [round(255/2) round(255/2) round(255/2)]; %[146 146 146]
white = [0 0 0];
grey = [0 0 0]; %[round(255/2) round(255/2)  round(255/2) ];
TestRect = [0 0 1000 1000];

%% Initiate DS --------------------------------------------------------
PsychDefaultSetup(2); screens = Screen('Screens');

switch size(screens,2)
    case 3
        screenNumber = 2; 
    case 2
        screenNumber = max(screens);
    case 1
        screenNumber = 0;
    otherwise
        screenNumber = 0;
end



%% RNG stuff ---------------------------------------------------------
tau = clock; rand('state', sum(100*tau)); state = rand('state');
if Synch == 2; Screen('Preference', 'SkipSyncTests', 1); end



%% Open window
global window 
if Test == 2; [window, windowRect] = ...
        Screen('OpenWindow', screenNumber, ...
        background_colour, [], [], [], [], 4);
elseif Test == 1;
    [window, windowRect] = ...
        Screen('OpenWindow', screenNumber, ...
        background_colour, TestRect, [], [], [], 4);
end



%% Dimensions of opened screen
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

%% Blending options
Screen('BlendFunction', window, 'GL_SRC_ALPHA',...
    'GL_ONE_MINUS_SRC_ALPHA');
Slack = Screen('GetFlipInterval', window)/2; %Screen interval

%% Font
Screen('TextFont', window, 'Microsoft JhenHei Light');

%% Text options
Screen('TextSize', window, 50);


%% Stimuli dimensions
screenRect = Screen(0, 'Rect');
[xCenter, yCenter] = RectCenter(windowRect);

%% Run countdown sounds
% run('countdown_sounds.m');


HideCursor(window, 0); 

