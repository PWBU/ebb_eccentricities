%% Poutasi W. B. Urale Ebbinghaus pupil size =/= brightness test
%
%  _____ ______  _____  ___   _       _____  _____  ___  ______  _____
% |_   _|| ___ \|_   _|/ _ \ | |     /  ___||_   _|/ _ \ | ___ \|_   _|
%   | |  | |_/ /  | | / /_\ \| |     \ `--.   | | / /_\ \| |_/ /  | |
%   | |  |    /   | | |  _  || |      `--. \  | | |  _  ||    /   | |
%   | |  | |\ \  _| |_| | | || |____ /\__/ /  | | | | | || |\ \   | |
%   \_/  \_| \_| \___/\_| |_/\_____/ \____/   \_/ \_| |_/\_| \_|  \_/
%

%% Makes sure no shit still on screen
Screen('Flip', window);

%% Define trial
conditionGo = randi(vars);
while ismember(conditionGo, Graveyard) == 1
    conditionGo = randi(vars);
end
ThisFactor = FactorList(conditionGo, :);

% Temporal location
interval = randi(2); % 1 = test in second interval. 2 = test in first interval.
if randi(2) == 1; eccsDir = -1; else; eccsDir = 1; end %Which hemifield will the stimulus appear in?

% Large ( . Y . ) or small (.)(.) inducers
switch ThisFactor(1)
    case 1
        inducerSize = inducerLarge;
        edgeDis = inducerLargeSize(2);
        numberOfInducers = 6;
    case 2
        inducerSize = inducerSmall;  % 2 = small inducers
        edgeDis = inducerSmallSize(2);
        numberOfInducers = 8;
    case 3
        inducerSize = [];
end

%  (??_??) < - - - - - - - - - - - - > (�?�) eccentricity for this trial
eccsThis = eccs(ThisFactor(2));

%Staircase stuff
thisTestSize = S.Starts(ThisFactor(3));
StepsThisTime = S.Steps(ThisFactor(3));
rcircleRect = [0 0 rcircleSize rcircleSize];
testSize = rcircleRect(3)*(toTheBase^thisTestSize);
tcircleRect = [0 0 testSize testSize];

% Which stim is objectively bigger?
if tcircleRect(3)>rcircleRect(3); testIs = 2; %smaller
elseif tcircleRect(3)<rcircleRect(3); testIs = 1; %bigger
end

% What response indicates the percieved "bigger" stimulus?
if (interval == 1 && florp == 1) || (interval == 2 && florp == 2)
    answerNow = 2; % pointing to right side (second interval) means t circle is bigger
elseif (interval == 2 && florp == 1) || (interval == 1 && florp == 2)
    answerNow = 1; % pointing to the left side (first interval) means t circle is bigger
end


% Rects for center circles
yCenterNow = yCenter + (eccsDir*eccsThis);
rcircleRectNow = CenterRectOnPoint(rcircleRect, xCenter, yCenterNow);
tcircleRect = CenterRectOnPoint(tcircleRect, xCenter, yCenterNow);
cueRectNow = CenterRectOnPoint([0 0 cueSize cueSize], xCenter, yCenterNow);

%% Display stimuli
run('pstimuli.m');

%% Response
run('response.m');


Screen('Flip', window);

S = staircaseGo(ThisFactor(3), S, correct);
[S, Reversal] = staircaseUpdate(ThisFactor(3), S,...
    StepSwitch, StepAdjust);