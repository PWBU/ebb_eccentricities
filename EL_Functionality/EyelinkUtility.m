function broke = EyelinkUtility(iji, IsEL, message)

try
    % iji
    % 1 = start
    % 2 = zero mark, might be redundant
    % 3 = online gaze tracking for fixation maintainence
    % 4 = end trial
    % 5 = send message/ time stamp; EyelinkUtility(5, IsEL, message)
    
    
    
    broke = [];
    if IsEL == 1
        if nargin < 3
            switch iji
                case 1 % identify trial and start recording
                    Eyelink('StartRecording'); % begin recording
                    WaitSecs(0.1);
                    
                case 2 % zero-point in EDF file and do some shit with the el bg rect
                    Eyelink('Message', 'ZERO');
                    Screen('FillRect', el.window, background_colour);                   
                  
                    
                case 4 %%  EL: End the trial
                    disp('Lets a-go'); 
                   
                    Eyelink('Stoprecording');                  
                
                case 7
                    %% Finalizing EL file and shutting down tracker
                    % End of Experiment; close the file first
                    % close graphics window, close data file and shut down tracker
                    
                    Eyelink('Command', 'set_idle_mode');
                    WaitSecs(0.5);
                    Eyelink('CloseFile');
                    
                    % Download  EDF file
                    try
                        fprintf('Receiving data file ''%s''\n', message);
                        status=Eyelink('ReceiveFile');
                        if status > 0
                            fprintf('ReceiveFile status %d\n', status);
                        end
                        if 2==exist(edfFile, 'file')
                            fprintf('Data file ''%s'' can be found in ''%s''\n', message, pwd);
                        end
                    catch
                        fprintf('Problem receiving data file ''%s''\n', message );
                    end
                    
                    % close the eye tracker and window
                    Eyelink('ShutDown');
                    
            end
        elseif nargin == 3 && iji == 5
            Eyelink('Message', message); % time stamp something in EL
        elseif nargin ~= 3 && iji == 5
            throw
        end
    end
catch FART
    disp(FART.message); 
    throw
end
end

