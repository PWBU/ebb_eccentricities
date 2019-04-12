 function Staircase = staircaseGo(Condish, Stairs, correct)
%Condish = ThisFactor(2), Stairs = S, correct = correct
 
 Staircase = Stairs;
 if correct == 1
     Staircase.Correct(Condish) = Staircase.Correct(Condish) + 1;
 elseif correct == 2
     Staircase.Incorrect(Condish) = Staircase.Incorrect(Condish) + 1;
 elseif correct == 3    
 end
 
 
 
 