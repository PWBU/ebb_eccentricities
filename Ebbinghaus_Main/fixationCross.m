

function fixationCross(window, color, penWidth, xCenter, yCenter)
    Screen('DrawLine', window, color, xCenter-1, yCenter, xCenter+4,...
        yCenter, penWidth); 
    Screen('DrawLine', window, color, xCenter, yCenter-1, xCenter,...
        yCenter+4, penWidth); 
end

%     fixationCross(window, white, pen, xCenter, yCenter); 
