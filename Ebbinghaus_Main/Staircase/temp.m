
Cons = 1;
Starts = 5;
UpDowns = [1 1];
LevelRange = length(changeValues);
Levels = [changeValues(1) changevalues(LevelRange(1))];


Staircase = struct;

Staircase.UpDowns = UpDowns;
Up = UpDowns(1);
Down = UpDowns(2);
Staircase.Acc = .5^(Down/Up);
Staircase.Correct = zeros(1, Cons);
Staircase.Incorrect = zeros(1, Cons);
Staircase.Previous = ones(1, Cons);
Staircase.Reversals = zeros(1, Cons);


if length(Starts) == 1
    Staircase.Starts = ones(1, Cons) * Starts;
else
    Staircase.Starts = Starts;
end

Staircase.Range = Levels;








%%function [Staircase, Reverse] = StaircaseNow = (Condish, Stairs, Step)
% Condition is the marker of the condition? 

Staircase = Stairs; 

Reversal = 0; 

if Staircase.Correct(Condish) >= Staircase.UpDown(1)
    



%function Staircase = StaircaseTrial(Cons, Staris, Correct); 




if Correct == 1
    Staircase = InStairs; 
    if Correct
        Staircase.Correct(
    









