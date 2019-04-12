[RGB1, ~, ALPHA1] = imread('2x20p_line.png');
confettiTexture = Screen('MakeTexture', window, cat(3, RGB1, ALPHA1));
confettiRect = [0 0 2, 10];
Screen('DrawTexture', window, confettiTexture,[], confettiRect, 90);

numOfRings = 3;
numberThisRing = [25 15 10];
jitter =30;


pen = 2;

%%Hemifield location
hemi = randi(2);

%%Ebbinghaus stimuli ++++++++++++++++++++++++++++++++++++++++++
% Large ( . Y . ) or small (.)(.) inducers


% reference left or right

if hemi == 1
    hemifieldLocation = [-1 1]; % rcircle left, tcircle right
    inducey = -1;
elseif hemi == 2
    hemifieldLocation = [1 -1]; % tcircle left, rcircle right
    inducey = 1;
end


if (hemi == 1 && florp == 1) || (hemi == 2 && florp == 2)
    answerNow = 2; % pointing to right side means t circle is bigger
elseif (hemi == 2 && florp == 1) || (hemi == 1 && florp == 2)
    answerNow = 1; % pointing to the left side means t circle is bigger
end

inducerSize = .1;
distey = .1;


rcircleRect = [0 0 rcircleSize rcircleSize];

[keyIsDown, secs, keyCode] = KbCheck;
while ~keyCode(KbName('q'))
    
    if inducerSize <= 0
        inducerSize = .1;
    elseif inducerSize >= 6
        inducerSize = 5.9;
    end
    
    if distey <= 0
        distey = .1;
    elseif distey >= 6
        distey = 5.9;
    end
    
    if numberOfInducers <= 0
        numberOfInducers = 1;
    elseif numberOfInducers >= 20
        numberOfInducers = 20;
    end
    
    
    inducerSize2 = angle2pix(distance, width, resolution, inducerSize);
    distey2 = angle2pix(distance, width, resolution, distey);
    
    
    rcircleRectNow = CenterRectOnPoint(rcircleRect, xCenter, yCenter);
    
    Screen('FillOval', window, white, rcircleRectNow);
    
    
    indoooz = [0 0 39 39]; %inducerSize2 inducerSize2];
    indoo0z = pix2angle(indoooz(3),...
        distance, width, resolution);
    if 2 < 1
        for ini = 1:numberOfInducers
            distanceNow = (rcircleSize/2)+...
                distey2 + (inducerSize2/2); %+(inducerSize(3)/2));
            [xi, yi] = pol2cart((pi/180)*(ini*(360/numberOfInducers)),...
                distanceNow);
            xi = xi + (xCenter + (inducey));
            yi = yi + yCenter;
            inducerThis = CenterRectOnPoint(indoooz, xi, yi);
            Screen('FrameOval', window, white, inducerThis, pen, pen);
        end
    else
        sizeThisRing = [(distey2/2), (distey2/2)-15, (distey2/2)-30];
        
        for ivi = 1:numOfRings
            for ipi = 1:numberThisRing(ivi)
                [xi, yi] = pol2cart((pi/180)*(ipi*(360/numberThisRing(ivi))),...
                    sizeThisRing(ivi));
                xi = xi + xCenter; yi = yi + yCenter;
                confettiThis = CenterRectOnPoint(confettiRect, ...
                    (xi+((rand()-1/2)*randi(jitter)))...
                    , (yi+((rand()-1/2)*randi(jitter))));
                Screen('DrawTexture', window, confettiTexture,[], confettiThis, randi(360));
            end
        end
        
    end
    
    Screen('DrawText', window, strcat('aD=',num2str(distey), '_', 'aS=',...
        num2str(indoo0z)), xCenter-700,...
        yCenter, white);
    
    Screen('Flip', window);
    
    [keyIsDown, secs, keyCode] = KbCheck;
    while ~keyCode(KbName('LeftArrow')) && ~keyCode(KbName('RightArrow'))...
            && ~keyCode(KbName('DownArrow')) && ~keyCode(KbName('UpArrow'))...
            && ~keyCode(KbName('q')) && ...
            ~keyCode(KbName('.>')) && ...
            ~keyCode(KbName(',<'))
        [keyIsDown, secs, keyCode] = KbCheck;
        WaitSecs(.001);
    end
    
    if keyCode(KbName('LeftArrow')); inducerSize = inducerSize - .05;
    elseif keyCode(KbName('RightArrow')); inducerSize = inducerSize + .05;
    elseif keyCode(KbName('UpArrow'));  distey = distey + .05;
    elseif keyCode(KbName('DownArrow'));  distey = distey - .05;
    elseif keyCode(KbName('.>'));  numberOfInducers = numberOfInducers + 1;
    elseif keyCode(KbName(',<'));  numberOfInducers = numberOfInducers - 1;
    end
    
    WaitSecs(.001);
    
end
screenshot = Screen('GetImage', window, screenRect);
sca;
imwrite(screenshot, strcat('data\stimuli_images\', Name, '.jpeg'), 'JPEG');



