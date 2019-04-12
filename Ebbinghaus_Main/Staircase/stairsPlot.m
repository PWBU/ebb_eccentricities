distances = [0 3 5 7 10];  %linspace(.32, 1.27, 6); %These are arbitrary for now

for biic = 1:vars
    grphF = FactorList(biic, :);
    if grphF(1) == 1
        indoosh = 'Large';
    elseif grphF(1) == 2
        indoosh = 'Small';
    elseif grphF(1) == 3
        indoosh = 'Control';
    end
    x = table(table.Distance == grphF(2) &...
        table.InducerSize == grphF(1) & table.Condition == biic, :); xSize = size(x);
    graph = plot(1:xSize(1), x.Rsize, 'k*--');
    
    if biic<=(vars/2); groop = 'A'; else; groop = 'B'; end
    

    saveas(graph, strcat(indoosh, '_(', num2str(distances(grphF(2))),...
        ')_', groop, '.png'));

end



for biic = 1:vars
    grphF = FactorList(biic, :);
    x = table(table.Distance == grphF(2) &...
        table.InducerSize == grphF(1), :); xSize = size(x);
    graph = plot(1:xSize(1), x.Reversals, 'r:');
    hold on
end
hold off
saveas(graph, strcat(indoosh, 'plotReversals.png'));

