blanks = NaN((vars/2), 1);
fctThresh = [FactorList(1:(vars/2), :) ...
    ];
eccs = [0];

% Compute average between two staircases
for iic = 1:(vars/2)
    grphF = FactorList(iic, :);
    xo = table(table.Distance == grphF(2) &...
        table.InducerSize == grphF(1)...
        & table.IsRev == 1 & table.Reversals > 5 ...
    ,:); xSize = size(xo);
    xo = xo.Starts(4:length(xo.Starts));
    xoAv = mean(xo);
    xoSz = length(xo); 
    xoStre = NaN(xoSz, 1); 
    for diic = 1:xoSz
        xoStre(diic) = abs(xoAv - xo(diic)); 
    end
    xoAbsMed = median(xoStre); 
    thresh = mean(xo(xo < (xoAv + 2*(xoAbsMed)) &...
        xo >  (xoAv - 2*(xoAbsMed))));
    fctThresh(iic, 4) = thresh;
end

% Compute actual staircases
for iiic = 1:vars
    grphF = FactorList(iiic, :);
    xo = table(table.Distance == grphF(2) &...
        table.InducerSize == grphF(1)...
        & table.IsRev == 1 & table.Reversals > 5 ...
    & table.Condition == iiic...
    ,:); xSize = size(xo);
    xo = xo.Starts(4:length(xo.Starts));
    xoAv = mean(xo);
    xoSz = length(xo); 
    xoStre = NaN(xoSz, 1); 
    for diic = 1:xoSz
        xoStre(diic) = abs(xoAv - xo(diic)); 
    end
    xoAbsMed = median(xoStre); 
    thresh = mean(xo(xo < (xoAv + 2*(xoAbsMed)) &...
        xo >  (xoAv - 2*(xoAbsMed))));
    if iiic <= vars/2
        fctThresh(iiic, 5) = thresh;
    end
%     elseif iiic > vars/2
%         fctThresh(iiic-(vars/2), 6) = thresh;
%     end
    
    
end
colors = {'red', 'blue', 'green'}; 
for ess = 1:3
    
    thisData = fctThresh(fctThresh(:, 1) == ess, :);

    Data    = reshape(thisData(:, 4), [1, size(thisData, 1)]);
    Data_sda = reshape(thisData(:, 5), [1, 5]);
    Data_sdb = reshape(thisData(:, 6), [1, 5]);
    Data_sda(find(isnan(Data_sda) == 1))...
        = mean(Data_sda(~isnan(Data_sda)));
    Data_sdb(find(isnan(Data_sdb) == 1))...
        = mean(Data_sdb(~isnan(Data_sdb)));
    sd_matrix = [Data_sda; Data_sdb];
    flsd_matrix = fliplr(sd_matrix);
    % prepare it for the fill function
    x_ax    = eccs;
    X_plot  = [x_ax, fliplr(x_ax)];
    sd1 = NaN(1, length(Data_sda));
    sd2 = NaN(1, length(sd1));
    for yo = 1:length(Data_sda)
        sd1(yo) = max(sd_matrix(:, yo));
        sd2(yo) = min(flsd_matrix(:, yo));
    end
    Y_plot  = [sd1, sd2];
    
    % plot a line + confidence bands
    hold on
    %plot(x_ax, Data, 'blue', 'LineWidth', 1.2)
    fill(X_plot, Y_plot , 1,....
        'facecolor', char(colors(ess)), ...
        'edgecolor','none', ...
        'facealpha', 0.3);
    hold off
    
end
xticks(eccs)
title('Tasi (w/ 50% larger stimuli)'); 
ylabel('illusion magnitude'); 
xlabel('eccentricity (deg)'); 

