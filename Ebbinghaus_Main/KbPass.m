function [keyIsDown, secs, keyCode] = KbPass(Keys) % supply this in the form of strings in curly brackets
WaitSecs(.1);  [keyIsDown,secs, keyCode] = KbCheck;
%this function saves me from writing a while look to

doink =0;

if nargin == 0
    [keyIsDown,secs, keyCode] = KbCheck;
    while ~keyCode; [keyIsDown,secs, keyCode] = KbCheck;
        WaitSecs(.001);
    end
    
elseif nargin ~=0
    theseKeys = length(Keys);
    while doink ~= 1
        [keyIsDown,secs, keyCode] = KbCheck;
        while ~keyCode; [keyIsDown,secs, keyCode] = KbCheck;
            WaitSecs(.001);
        end
        for kee = 1:theseKeys
            if keyCode(KbName(char(Keys(kee))))
                doink = 1;
            end
        end
    end
end


end