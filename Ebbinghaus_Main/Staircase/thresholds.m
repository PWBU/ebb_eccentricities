distances = [0.25, 0.75, 1.25, 2, 2.75, 4, 8]; 
blanks = NaN(vars, 1);
fctThresh = [FactorList blanks];
for iic = 1:vars
    grphF = FactorList(iic, :);
    xo = table(table.Distance == grphF(2) &...
        table.InducerSize == grphF(1)...
        & table.IsRev == 1 & table.Reversals > 5 ...
    & table.Condition == iic...
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



thicc = fctThresh(fctThresh(:, 1) == 1, :);
smol = fctThresh(fctThresh(:, 1) == 2, :);
cntrl = fctThresh(fctThresh(:, 1) == 3, :); 

scatter([eccs eccs ], thicc(:, 4), 'ro') %Red is large inducers
hold on
scatter([ eccs eccs], smol(:, 4), 'bo') %Blue is small inducers
scatter([eccs eccs], cntrl(:,4), 'sg'); 