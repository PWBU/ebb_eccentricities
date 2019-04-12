%% Countdown ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% run('countdown_sounds.m')
  Screen('Flip', window)
countdownX = {'5', '4', '3', '2', '1'};
for sui = 1:6
    if sui ~= 6
        Screen('DrawText', window, countdownX{sui}, xCenter-50,...
            yCenter, grey);
    else
        Screen('DrawText', window, 'ONLINE', xCenter-50,...
            yCenter, grey);
    end
% sound(Fivea, FiveX);
%         case 2; sound(Foura, FourX);
%         case 3; sound(Threea, ThreeX);
%         case 4; sound(Twoa, TwoX);
%         case 5; sound(Onea, OneX);
%         case 6; sound(Onlinea, OnlineX);
%     end
    Screen('Flip', window); WaitSecs(1);
end
% clear sound
