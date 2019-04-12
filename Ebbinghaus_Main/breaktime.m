
Screen('Flip', window);

if vars > numGraves(2) %BREAKTIME
    if i ~= 1
%         [ElevA, ElevB] = audioread('Sounds\Elev.mp3');
%         sound(ElevA, ElevB)
        Progress = Trial; Progress = sprintf('%.0f', Progress);
        gProgress = numGraves(2); gProgress = sprintf('%.0f', gProgress);
        
        Screen('DrawText', window, ['You have completed ', Progress...
            , ' trials.'], xCenter-100, yCenter, grey);
        Screen('Flip', window);
        WaitSecs(.1);
        [keyIsDown,secs, keyCode] = KbCheck;
        while ~keyCode; [keyIsDown,secs, keyCode] = KbCheck;
            WaitSecs(.001); end
        WaitSecs(.5);
        
%         run('dad_jokes.m');
        WaitSecs(.1);
        KbPass();
        Screen('DrawText', window,...
            'Press any key when you want to continue',...
            xCenter, yCenter, grey);
        Screen('Flip', window);
        WaitSecs(.2);
        KbWait();
        clear sound
    else
       
        Screen('DrawText', window, 'The experimenter will now tell you about the task'...
            , xCenter-100, yCenter, grey);
        Screen('Flip', window);
                 disp('fart'); 

        WaitSecs(.5);
        KbPass();
        
    end
    
    %% NANI???
    Screen('DrawText', window, 'Press any key when you are ready to calibrate'...
        , xCenter-100, yCenter, grey);
    Screen('Flip', window);
    WaitSecs(.5);
    KbPass();
    
    %% Calibrate
    if exist('IsEL', 'var') && IsEL == 1
        EyelinkDoTrackerSetup(el); EyelinkDoDriftCorrection(el);
        Eyelink('message', 'DISPLAY_COORDS'); % not sure if this is the right place to put this
    end
    
    %% Remind viewer of the task
    Screen('Flip', window);
    if florp == 1
        Screen('DrawText', window, 'indicate the BIGGER circle', xCenter-100,...
            yCenter, grey);
    elseif florp == 2
        Screen('DrawText', window, 'indicate the SMALLER circle', xCenter-100,...
            yCenter, grey);
    end
    Screen('Flip', window);
    WaitSecs(.5);
    KbPass();
    
    %% Countdown ----
    run('countdown.m');
    
    
end

% clear sound

ElevA = 0;





