function [abort] = keepFixating(fixationThreshold)
evt = Eyelink('NewestFloatSample');
if eye_used == -1; eye_used = Eyelink('EyeAvailable');
    if eye_used == el.BINOCULAR; eye_used = el.LEFT_EYE;
    end
end
Eyex = evt.gx(eye_used+1); Eyey = evt.gy(eye_used+1);
A= min(Eyex, xCenter); B= max(Eyex, xCenter);
C= min(Eyey, yCenter); D= max(Eyey, yCenter);
hypotenuse = sqrt(((B-A)^2) + ((D-C)^2));
if hypotenuse > fixationThreshold; abort = 1; else; abort = 2; end
end
