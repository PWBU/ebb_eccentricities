function [keyIsDown,secs, keyCode] = simResponse(sim, keyCode)

if sim == 2
     while ~keyCode; [keyIsDown,secs, keyCode] = KbCheck;
                    WaitSecs(.001); end
end
end