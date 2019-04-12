%% Initiate EyeLink ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if IsEL == 1
    try
        el=EyelinkInitDefaults(window);
        [el.screenXpixels, el.screenYpixels] = Screen('WindowSize', window);
        [el.xCenter, el.yCenter] = RectCenter(windowRect);
        el.eye_used = -1;
        
        disp('nor there');
        
        if ~EyelinkInit(0, 1)
            fprintf('Eyelink Init aborted.\n');
            cleanup;  % cleanup function
            return;
        end
        [v, vs]=Eyelink('GetTrackerVersion');
        Eyelink('Command', 'link_sample_data = LEFT,RIGHT,GAZE,AREA');
        edfFile = strcat(Name, num2str(Code)); %'.edf');
        % Same name as Matlab storage variable
        Eyelink('Openfile', edfFile);
        
        el.backgroundcolour = background_colour;
        el.calibrationtargetcolour = white;
        el.fixation_threshold = FixationThreshold; 
        el.msgfontcolour = grey; 
%         el.fixLost = fixLost; el.fixLostX = fixLostX; 
        EyelinkUpdateDefaults(el);
        
        
        
        
        
        Screen('Flip', window);
        
        KbPass();
        
    catch
        throw;
    end
else
    Screen('Flip', window);
     KbPass();
end
