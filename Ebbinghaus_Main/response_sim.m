% if blankTrial ~= 1;
%     %% Response        
%     [keyIsDown, secs, keyCode] = KbPass({'LeftArrow', 'RightArrow', 'p', 'F3', '6', '4', 'n'});
%     if keyCode(KbName('F3')); throw;
%     elseif keyCode(KbName('p')); Input = 99;
%         if florp == 1
%             Screen('DrawText', window, 'indicate the BIGGER circle', xCenter-100,...
%                 yCenter, white);
%         elseif florp == 2
%             Screen('DrawText', window, 'indicate the SMALLER circle', xCenter-100,...
%                 yCenter, white);
%         end
%         Screen('Flip', window); WaitSecs(.25);
%         KbPass;
%           %% Calibrate
%     if exist('IsEL', 'var') && IsEL == 1
%         EyelinkDoTrackerSetup(el); EyelinkDoDriftCorrection(el);
%         Eyelink('message', 'DISPLAY_COORDS'); % not sure if this is the right place to put this
%     end
%         run('countdown.m');
%     elseif keyCode(KbName('n')); Input = 99;
%         Screen('DrawText', window, num2str(S.Reversals), xCenter-100,...
%                 yCenter, white);
%         Screen('Flip', window); WaitSecs(.25);
%         KbPass;    
%     elseif keyCode(KbName('LeftArrow')) || keyCode(KbName('4')); Input = 1; % left response
%     elseif keyCode(KbName('RightArrow')) || keyCode(KbName('6')); Input = 2; % right response
%     end
%     
% elseif blankTrial == 1
%     Input = 99; 
% end
% if Input == answerNow; correct = 1; %not that "correct" simply means that the test circle is perceived as BIGGER
% elseif Input == 99; correct = 3;
% elseif Input == 3; correct = 3;
% else correct = 2;
% end

correct = randi(2); 

