
% Screen('Flip', window);

conditionGo = randi(vars);
while ismember(conditionGo, Graveyard) == 1
    conditionGo = randi(vars);
end
ThisFactor = FactorList(conditionGo, :);

% Draw stimuli
run('stimuli.m');
StimAt = Screen('Flip', window, []);
Then = GetSecs; Now = GetSecs();
    while (Now - Then) <  displayTime; Now = GetSecs(); end
    fixationCross(window, white, pen, xCenter, yCenter); 
Screen('Flip', window);

%%Response
if sim == 2
    [keyIsDown, secs, keyCode] = KbCheck;
    while ~keyCode(KbName('LeftArrow')) && ~keyCode(KbName('RightArrow'))...
            && ~keyCode(KbName('F3')) && ~keyCode(KbName('p'))
        [keyIsDown, secs, keyCode] = KbCheck;
        RT = secs - StimAt;
    end
end


% Screen('Flip', window);


%% Input and Stahp
if sim == 2
    if keyCode(KbName('F3')); throw;
    elseif keyCode(KbName('p')); Input = 99;
         if florp == 1
            Screen('DrawText', window, 'point to BIGGER circle', xCenter-100,...
                yCenter, white);
        elseif florp == 2
            Screen('DrawText', window, 'point to SMALLER circle', xCenter-100,...
                yCenter, white);
         end
        Screen('Flip', window); WaitSecs(.25); 
        KbPass; 
        run('countdown.m');
    elseif keyCode(KbName('LeftArrow')); Input = 1; % left response
    elseif keyCode(KbName('RightArrow')); Input = 2; % right response
    end
    
    
    
    
    
    if Input == answerNow; correct = 1; %not that "correct" simply means that the test circle is perceived as BIGGER
    elseif Input == 99; correct = 3;
    elseif Input == 3; correct = 3;
    else; correct = 2;
    end
    
    
    switch correct
        case 1; Feedback = [];
            %sound(Correcta, CorrectX);
        case 2; Feedback = [];
            %sound(Incorrecta, IncorrectX);
    end
elseif sim == 1
    pooz = randi(3); 
    if pooz > 1
        correct = 1;
    elseif pooz == 1
        correct = 2;
    end
end


S = staircaseGo(ThisFactor(3), S, correct);
[S, Reversal] = staircaseUpdate(ThisFactor(3), S,...
    StepSwitch, StepAdjust);