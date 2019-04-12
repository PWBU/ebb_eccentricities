

%%Hemifield location
hemi = randi(2);

%%Ebbinghaus stimuli ++++++++++++++++++++++++++++++++++++++++++
% Large ( . Y . ) or small (.)(.) inducers
if ThisFactor(1) == 1 % 1 = large inducers
    inducerSize = inducerLarge;
elseif ThisFactor(1) == 2
    inducerSize = inducerSmall;  % 2 = small inducers
end


% reference left or right

if hemi == 1
    hemifieldLocation = [-1 1]; % rcircle left, tcircle right
    inducey = -1;
elseif hemi == 2
    hemifieldLocation = [1 -1]; % tcircle left, rcircle right
    inducey = 1;
end


% tcircle size

thisTestSize = S.Starts(ThisFactor(3));
StepsThisTime = S.Steps(ThisFactor(3));
rcircleRect = [0 0 rcircleSize rcircleSize];
testSize = rcircleRect(3)*(toTheBase^thisTestSize);
tcircleRect = [0 0 testSize testSize];

if tcircleRect(3)>rcircleRect(3)
    testIs = 2; %smaller
elseif tcircleRect(3)<rcircleRect(3)
    testIs = 1; %bigger
end


if (hemi == 1 && florp == 1) || (hemi == 2 && florp == 2)
    answerNow = 2; % pointing to right side means t circle is bigger
elseif (hemi == 2 && florp == 1) || (hemi == 1 && florp == 2)
    answerNow = 1; % pointing to the left side means t circle is bigger
end

% if florp == 1
%     if (tcircleRect(3) > rcircleRect(3) && hemi == 1) || ...
%             (rcircleRect(3) > tcircleRect(3) && hemi == 2)
%         answerNow = 2; % right
%     elseif (tcircleRect(3) < rcircleRect(3) && hemi == 1) || ...
%             (rcircleRect(3) < tcircleRect(3) && hemi == 2)
%         answerNow = 1; % left
%     end
% elseif florp == 2
%     if (tcircleRect(3) > rcircleRect(3) && hemi == 1) || ...
%             (rcircleRect(3) > tcircleRect(3) && hemi == 2)
%         answerNow = 1; % left
%     elseif (tcircleRect(3) < rcircleRect(3) && hemi == 1) || ...
%             (rcircleRect(3) < tcircleRect(3) && hemi == 2)
%         answerNow = 2; % right
%     end
% end


%center circles drawn
rcircleRectNow = CenterRectOnPoint(rcircleRect, (xCenter +...
    (hemifieldLocation(1)*(.5*spaceBetweenStim))), yCenter);
tcircleRect = CenterRectOnPoint(tcircleRect, (xCenter +...
    (hemifieldLocation(2)*(.5*spaceBetweenStim))), yCenter);


if sim == 2
    fixRect = CenterRectOnPoint(fixRect, xCenter, yCenter);
%     Screen('Flip', window);
%     Screen('FillOval', window, white, fixRect);
    fixationCross(window, white, pen, xCenter, yCenter); 
    Screen('Flip', window, [], 1)
    WaitSecs((round(waitB4Stim/Slack)*Slack));
    Screen('FillOval', window, white, rcircleRectNow);
    Screen('FillOval', window, white, tcircleRect); % pen, pen);
    fixationCross(window, white, pen, xCenter, yCenter); 
    
    
    
    % define and draw inducers
    
    
    if ThisFactor(1) ~= max(FactorList(:, 1))
        for ini = 1:numberOfInducers
            distanceNow = (rcircleSize/2)+...
                (distances(ThisFactor(2))) + (testSize/2); %+(inducerSize(3)/2));
            [xi, yi] = pol2cart((pi/180)*(ini*(360/numberOfInducers)),...
                distanceNow);
            xi = xi + (xCenter + (inducey*...
                (.5* spaceBetweenStim)));
            yi = yi + yCenter;
            inducerThis = CenterRectOnPoint(inducerSize, xi, yi);
            Screen('FrameOval', window, white, inducerThis, pen, pen);
        end
    end
    
end
