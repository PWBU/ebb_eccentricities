

function instructions(instruct)

%% Play relaxing music
% [X, Y] = audioread('practicum.mp3'); sound(X, Y); 

[~, ~, keyCode] = KbCheck; ins = 1; 

while ~keyCode(KbName('space'))
    [A, ~, B] = imread([num2str(ins) 'i.png']);
    
    tex = Screen('MakeTexture', instruct.window, cat(3, A, B));
    
    Screen('DrawTexture', instruct.window, tex,[], instruct.rect);  
    Screen('Flip', instruct.window); 
    
    [~, ~, keyCode] = KbPass({'LeftArrow', 'RightArrow', 'space'}); 
    if keyCode(KbName('LeftArrow')); ins = ins - 1;
    elseif keyCode(KbName('RightArrow')); ins = ins + 1; end
    
    if ins > instruct.panels; ins = instruct.panels; 
    elseif ins < 1; ins = 1; end
end

% clear sound
end

