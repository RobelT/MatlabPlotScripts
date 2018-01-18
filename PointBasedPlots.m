function PointBasedPlots()




% initialize holder arrays to null
 Experiment= [];
 TimeOfExperiment =[];
 downRel= [];
 Energy= [];

%%

% import data

delimiterIn = '\t';
delimiterIn = ' ';
headerlinesIn = 0;

fileName = strcat('./ExperimentResults_1.txt');
raw = importdata(fileName,delimiterIn,headerlinesIn);
MaxNoOfRows = size(raw,1);


Experiment = 1*raw(1:MaxNoOfRows, 1);  
TimeOfExperiment = 1*raw(1: MaxNoOfRows, 2);
downRel =1*raw(1: MaxNoOfRows, 3);
Energy  = 1*raw(1: MaxNoOfRows, 4); 

%%
% Create figure
figure1 = figure();

ax1 = subplot(2,2,1);
hold(ax1,'on')

% colour defined using alphabet r for red g for green, etc. bmyckw for
% blue, maganta, yellow, cyan, black and white respectively
Linecolour = 'r';

% the shape of the markers can also be changed from the default of cirlce
% by using one of 's' for square or p,h,^,+ for pentagon, hexagon, triangle
% and cross respectively
   scatter(Energy,downRel,'p',...
                'MarkerEdgeColor',Linecolour,...
              'MarkerFaceColor',Linecolour ); 
   
hold(ax1,'off')

ax1 = subplot(2,2,2);
hold(ax1,'on')



    % The plot command requries at least one of the input array to be
    % composed of integers and wouldn't work on two array both with double
    % values 
    
   plot(TimeOfExperiment,Energy,'Color','g','Marker','o')

   

hold(ax1,'off')    
   


ax1 = subplot(2,2,3);
hold(ax1,'on')


for t=1:MaxNoOfRows
    
% the following if clause is separating results based on which
% experiment group they are in

%note also the terms 'MarkerFaceColor',  'MarkerEdgeColor', change the
%filling and the color of the edge of the marker
%'MarkerSize' changes the default size of the marker
% LineWidth changes the thickness of the marker edge
    if (Experiment(t) ==1)
        
        plot(t,Energy(t),...
       'MarkerSize',10,...
       'MarkerFaceColor','y',...
       'MarkerEdgeColor','k',...
       'LineWidth',2,...
       'Marker','s')
   
    else
        
   plot(t,Energy(t),...
       'MarkerFaceColor','m',...
       'MarkerEdgeColor','r',...
       'Marker','o')
   
    end
   
end   

hold(ax1,'off')  

% the following line does pareto optimal sorting
% you need to have the "Pareto_Front_Extractor_TwoArrays" code in
% your workspace to be able to call this function
% Note -1*input array is used when the performance is needed to be maximized

% the "ParetoOptimal" will have a value of 1 for Pareto optimal set of coordinates
% (i.e., for maximizing energy and minimizing downRel)

   ParetoOptimal = Pareto_Front_Extractor_TwoArrays(-1*Energy,downRel);
 

ax1 = subplot(2,2,4);
hold(ax1,'on')


for t=1:MaxNoOfRows
    



    if (ParetoOptimal(t) ==1)
        
   plot(downRel(t),Energy(t),...
       'MarkerSize',8,...
       'MarkerFaceColor','b',...
       'MarkerEdgeColor','b',...
       'Marker','h')
   
    else
        
   plot(downRel(t),Energy(t),...
       'MarkerFaceColor','w',...
       'MarkerEdgeColor','r',...
       'Marker','o')
   
    end
   
end   

% you can also label the axis
xlabel ('Downstream release');
ylabel ('Energy');

hold(ax1,'off')  
   
   
set(figure1, 'PaperPosition', [1 4 12 12]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
set(figure1, 'PaperSize', [21 29]); %Keep the same paper size saveas(gcf, 'test', 'pdf')
saveas(figure1, strcat('./Figures/PointBasedPlots', '.jpeg'))
saveas(figure1, strcat('./Figures/PointBasedPlots', '.pdf'))


end