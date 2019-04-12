

%% Begin eye tracking ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Eyelink('Message', 'TRIALID %d', puupCount);
Eyelink('StartRecording');
WaitSecs(0.1);
Eyelink('Message', 'SYNCTIME'); %Mark zero point on EyeLink file





eye_used = -1;
Screen('FillRect', el.window, el.backgroundcolour);
Screen('TextFont', el.window, el.msgfont);
Screen('TextSize', el.window, el.msgfontsize);
[width, height]=Screen('WindowSize', el.window);
message='Press space to stop.';
Screen('DrawText', el.window, message, 200, height-el.msgfontsize-20, el.msgfontcolour);
Screen('Flip',  el.window, [], 1);