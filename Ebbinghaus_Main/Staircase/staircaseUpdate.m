function [Staircase, Reversal] = staircaseUpdate(Condish, InStairs,...
    StepSwitch, StepAdjust)
%Condish = ThisFactor(2), InStairs = S


Staircase = InStairs;
Reversal = 0;


if Staircase.Correct(Condish) >= Staircase.UpDowns(1)
    Staircase.Correct(Condish) = 0;
    Staircase.Incorrect(Condish) = 0;
    if Staircase.Previous(Condish) ~= 1
        Reversal = 1;
        Staircase.Reversals(Condish) = Staircase.Reversals(Condish) + 1;
    end
    Staircase.Previous(Condish) = 1;
    
    if Staircase.Reversals(Condish) == StepSwitch(1)
        Staircase.Steps(Condish) = StepAdjust(1);
    elseif Staircase.Reversals(Condish) == StepSwitch(2)
        Staircase.Steps(Condish) = StepAdjust(2);
    elseif Staircase.Reversals(Condish) == StepSwitch(3)
        Staircase.Steps(Condish) = StepAdjust(3);
    end
    
    %% the t circle was marked as BIGGER, so we make it incrementally smaller
    Staircase.Starts(Condish) = Staircase.Starts(Condish) -...
        Staircase.Steps(Condish);
    
    
elseif Staircase.Incorrect(Condish) >= Staircase.UpDowns(2)
    Staircase.Correct(Condish) = 0;
    Staircase.Incorrect(Condish) = 0;
    
    if Staircase.Previous(Condish) ~= -1
        Reversal = 1;
        Staircase.Reversals(Condish) = Staircase.Reversals(Condish) + 1;
    end
    Staircase.Previous(Condish) = -1;
    
    if Staircase.Reversals(Condish) == StepSwitch(1)
        Staircase.Steps(Condish) = StepAdjust(1);
    elseif Staircase.Reversals(Condish) == StepSwitch(2)
        Staircase.Steps(Condish) = StepAdjust(2);
    elseif Staircase.Reversals(Condish) == StepSwitch(3)
        Staircase.Steps(Condish) = StepAdjust(3);
    end
    
      %% the t circle was marked as SMALLER, so we make it incrementally bigger
        Staircase.Starts(Condish) = Staircase.Starts(Condish) +...
            Staircase.Steps(Condish);
          
end

%Keep within bounds specified by levels
if Staircase.Starts(Condish) < Staircase.Levels(1)
    Staircase.Starts(Condish) = Staircase.Levels(1);
elseif Staircase.Starts(Condish) > Staircase.Levels(2)
    Staircase.Starts(Condish) = Staircase.Levels(2);
end











