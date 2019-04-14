try
    %   __ ___________  _____ ____   __
    %  (( \| || |||||\\//|||| ||||   ||
    %   \\   ||  |||| \/ |||| ||||   ||
    %  \_))  ||  ||||    ||\\_//||__|||
    %
    
    
    %% Ok fellas, let's get this bread
    EyelinkUtility(1, IsEL);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%       Fx      %%%%%%%%%%%%%%%%%%%%%%%%%%%
    Screen('Flip', window);  % Begin with fixation
    fixationCross(window, grey, pen, xCenter, yCenter);
    
    %%%%%%%%%%%%%%%%%%%%%%       Pre-cue      %%%%%%%%%%%%%%%%%%%%%%%%%
    if ThisFactor(2) ~= 0 && eccsThis > 0
        Screen('DrawTexture', window, cueTex, [], cueRectNow);
    end
    
    Then = Screen('Flip', window); % Stamp b4 context display
    fixationCross(window, grey, pen, xCenter, yCenter);
    WaitSecs(preTrialwait);
    Then = Screen('Flip', window);
    
    % Begin displaying stimuli
    blankTrial = 0;
    for whichInterval = 1:2 %two intervals
        
        %%%%%%%%%%%%%%%%%%%%%%%%%       Fixation      %%%%%%%%%%%%%%%%%%%%%%%%%
        if eccsThis > 0 || ThisFactor(2)
        fixationCross(window, grey, pen, xCenter, yCenter);    
        end
        
        if IsEL == 1
            EyelinkFixationControl(waitB4Stim, el, Then, 1);
        else
            Now = GetSecs(); while (Now-Then)< waitB4Stim; Now = GetSecs(); end
        end
        Then = Screen('Flip', window); % Stamp b4 context display
        
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%       Test      %%%%%%%%%%%%%%%%%%%%%%%%%
        % Inducers
%         if ThisFactor(1) ~= max(FactorList(:, 1)) && whichInterval == interval
%             for ini = 1:numberOfInducers
%                 distanceNow = (rcircleSize/2)+...
%                     edgeDis + (inducerSize(3)/2);
%                 [xi, yi] = pol2cart((pi/180)*(ini*(360/numberOfInducers)),...
%                     distanceNow);
%                 xi = xi + xCenter+randOffset(whichInterval);
%                 yi = yi + yCenterNow;
%                 inducerThis = CenterRectOnPoint(inducerSize, xi, yi);
%                 Screen('FrameOval', window, grey, inducerThis, pen+2, pen+2);
%             end
%         end
        % Center target
        if interval ~= whichInterval
            Screen('FillOval', window, grey, CenterRectOnPoint(tcircleRect, xCenter+randOffset(whichInterval), yCenterNow)); else
            Screen('FillOval', window, grey, CenterRectOnPoint(rcircleRect, xCenter+randOffset(whichInterval), yCenterNow));
        end
        
        
%          if interval == whichInterval
%             Screen('FillOval', window, white, CenterRectOnPoint(tcircleRect, xCenter+randOffset(whichInterval), yCenter)); else
%             Screen('FillOval', window, white, CenterRectOnPoint(rcircleRect, xCenter+randOffset(whichInterval), yCenter));
%         end
%         
        
        % Fixation
%         fixationCross(window, grey, pen, xCenter, yCenter);     
        Then = Screen('Flip', window, [], 1); % Stamp b4 stimuli display
        
        % Eye check
        if IsEL == 1
            cancel = EyelinkFixationControl(displayTime, el, Then, 2);
        else
            Now = GetSecs(); while (Now-Then)< displayTime; Now = GetSecs(); WaitSecs(.0001); end
        end
         if cancel == 1; %sound(Incorrecta, IncorrectX); 
            cancel = 0; blankTrial = 1; break; end
        Then = Screen('Flip', window);
        
        
        %% Make sure fixation is on centre before displaying
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%       Fin      %%%%%%%%%%%%%%%%%%%%%%%%%%%
        fixationCross(window, grey, pen, xCenter, yCenter);     
        if whichInterval == 1
            waitBetweenTrials = waitBetween(1);
        end
         Then = Screen('Flip', window);
%         Now = GetSecs(); while (Now - Then) <  waitBetweenTrials; Now = GetSecs(); end
        
        
    end
%     sound(respondNow, respondNowX);
    
catch ERROR
    sca; ShowCursor; commandwindow; ListenChar(0); ERROR.message
    save(strcat('data\','ERROR_', Name, '.', date, '_',...
        num2str(c(4)), '.', num2str(c(5)), '.', num2str(c(5))...
        , '.mat'));
end

EyelinkUtility(4, IsEL); 



