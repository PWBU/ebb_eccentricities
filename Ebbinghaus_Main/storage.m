  %% Storage procedure
  % Storage procedure for this pupil still is simple. 
            for vvv = 1:NumberOfVariables
                switch vvv
                    case 1; temp = Code;
                    case 2; temp = i;
                    case 3; temp = ii; % within trial
                    case 4; temp = Trial; % total trial
                    case 5; temp = ThisFactor(1); %big inducers, small inducers, or no inducers? 
                    case 6; temp = ThisFactor(2); %which factor (two staircases for each of the three levels above)
                    case 7; temp = ThisFactor(3); %in which interval did TARGET stimulus appear? 
                    case 8; temp = interval; %where were the reference and test stimuli
                    case 9; temp = correct;
                    case 10; temp = S.Starts(ThisFactor(3));%% insert the size of the target
                    case 11; temp = S.Reversals(ThisFactor(3));
                    case 12; temp = eccsDir; % which hemisphere did stimuli appear? 
                    case 13; temp = numGraves(2);
                    case 14; temp = Reversal;
                    case 15; temp = thisTestSize;
                        
                end
                MainStorage(Trial, vvv) = temp;
            end