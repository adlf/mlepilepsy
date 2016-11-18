function plot_results(name)
    close all
    f = figure('Visible','off', 'Name',name,'Position', [0, 0, 400, 200]);
    movegui(f, 'northwest')
    f.Visible = 'on';
    hold on;
    
    fscores = [];
    sensitivities = [];
    specificities = [];
    
    result_object = load(strcat(['results/', name]));
    result_object = result_object.(name);
    names = fieldnames(result_object)
    
    for i = 1:length(names)
        node = char(names(i));
        obj = result_object.(node);
        fscores(i) = obj.f;
        sensitivities(i) = obj.se;
        specificities(i) = obj.sp;
    end

    plot(fscores, 'r');
    plot(sensitivities, 'g');
    plot(specificities, 'b');
    
    ylim([0,1]);
    xlim([1, length(names)])
    titlestr = name
    titlestr = strrep(titlestr, '_', ' ');
    titlestr = strrep(titlestr, 'feedforward', 'Feedforward network');
    titlestr = strrep(titlestr, 'layrec', 'Layer recurrent network');
    
    arr = findstr(titlestr, 'preictal');
    if isempty(arr)
        titlestr = strrep(titlestr, 'ictal', 'for ictal phase with patient');
    else
        titlestr = strrep(titlestr, 'preictal', 'for preictal phase with patient');
    end
    
    title(titlestr);
    xlabel('Complexity');
    legend('f-score','sensitivity','specificity','Location','southwest','Orientation','horizontal')  
    print(strcat(['images/',name]),'-dpng')
end