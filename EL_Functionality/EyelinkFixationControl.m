function cancel = EyelinkFixationControl(time, el, Then, ResetAbort)
% variant = is this during the context phase (1) or test stimulus (2)?
Now = GetSecs(); cancel = 0;
while (Now - Then) < time && cancel ~= 1
    Now = GetSecs();
    [~,~, keyCode] = KbCheck;
    if keyCode(KbName('F3')); cancel = 1; 
    elseif keyCode(KbName('a')); throw; end
    if exist('el', 'var')
        if Eyelink( 'NewFloatSampleAvailable') > 0
            evt = Eyelink('NewestFloatSample');
            if el.eye_used == -1; el.eye_used = Eyelink('EyeAvailable');
                if el.eye_used == el.BINOCULAR; el.eye_used = el.LEFT_EYE;
                end
            end
            Eyex = evt.gx(el.eye_used+1); Eyey = evt.gy(el.eye_used+1);
            A= min(Eyex, el.xCenter); B= max(Eyex, el.xCenter);
            C= min(Eyey, el.yCenter); D= max(Eyey, el.yCenter);
            hypotenuse = ((B-A)^2) + ((D-C)^2);
            hypotenuse = sqrt(hypotenuse);
            
            if hypotenuse >  el.fixation_threshold && ResetAbort == 1
%                 Then = GetSecs(); sound(el.fixLost, el.fixLostX);
            elseif hypotenuse >  el.fixation_threshold && ResetAbort == 2
                cancel = 1;
            end
        end
    end
    if (Now - Then) <= 0; Now = GetSecs(); end
    
end
end

