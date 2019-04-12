function Staircase = thisStaircaseSetup(Cons, Starts, UpDowns, Levels, InitialStepSize)

% Cons = 1;
% Starts = 5;
% Starts = LevelRange(1)
% UpDowns = [1 1];



Staircase = struct;

Staircase.UpDowns = UpDowns;
Up = UpDowns(1);
Down = UpDowns(2);
Staircase.Acc = .5^(Down/Up);
Staircase.Correct = zeros(1, Cons);
Staircase.Incorrect = zeros(1, Cons);
Staircase.Previous = ones(1, Cons);
Staircase.Reversals = zeros(1, Cons);
Staircase.Steps = NaN(1, Cons);
Staircase.Steps(1, :) = InitialStepSize; 

if length(Starts) == 1
    Staircase.Starts = ones(1, Cons) * Starts;
else
    Staircase.Starts = Starts;
end

Staircase.Levels = Levels;


