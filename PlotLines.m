function PlotLines()




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

        line([100 500],....
        [340 340],....
        'Color',Linecolour,....
        'LineWidth', 5,....
        'LineStyle', '-');
    
    
            line([100 100],....
        [340 740],....
        'Color','b',....
        'LineWidth', 15,....
        'LineStyle', '-');
    
%     the line style can be  on of '-','-.','--',':'

        line([100 600],....
        [340 740],....
        'Color','m',....
        'LineWidth', 15,....
        'LineStyle', '-.');
   
hold(ax1,'off')

ax1 = subplot(2,2,2);
hold(ax1,'on')

%    Energy ,downRel
MyMatrix(1,:)= Energy;
MyMatrix(2,:)= downRel;

x1=[1:2];


for i=1:size(MyMatrix,2)
    
% initialize line attributes
myNewLineColor = [1 1 1]*0.6;
myNewLineStyle = '--';
MyLineWith1 = 1;

% change the line attributes for certain conditions only
    if (Energy(i) == max(Energy))
        myNewLineColor = [1 0 0];
        myNewLineStyle = '-';
        
    end
    
            plot(x1,MyMatrix(:,i),...
            'Color',myNewLineColor,...
            'LineStyle',char(myNewLineStyle),...
            'LineWidth',MyLineWith1);
        
 end

    
hold(ax1,'off')    
   


ax1 = subplot(2,2,3);
hold(ax1,'on')

% here we are adding a new column to the parallel plot matrix
MyMatrix(1,:)= Energy;
MyMatrix(2,:)= downRel;
MyMatrix(3,:)= TimeOfExperiment/max(TimeOfExperiment);

% don't forget to update the x axix array to one that reflects the number
% of columns 
x1=[1:3];


for i=1:size(MyMatrix,2)
    
% initialize line attributes
myNewLineColor = [1 1 1]*0.6;
myNewLineStyle = '--';
MyLineWith1 = 1;

% change the line attributes for certain conditions only
    if (Energy(i) == max(Energy))
        myNewLineColor = [1 0 0];
        myNewLineStyle = '-';
        
    end
    
            plot(x1,MyMatrix(:,i),...
            'Color',myNewLineColor,...
            'LineStyle',char(myNewLineStyle),...
            'LineWidth',MyLineWith1);
        
 end



hold(ax1,'off')  


   ParetoOptimal = Pareto_Front_Extractor_TwoArrays(-1*Energy,downRel);
 

ax1 = subplot(2,2,4);
hold(ax1,'on')  
for i=1:size(MyMatrix,2)
    
% initialize line attributes
myNewLineColor = [1 1 1]*0.6;
myNewLineStyle = ':';
MyLineWith1 = 1;

% change the line attributes for certain conditions only
    if (Energy(i) == max(Energy))
%         assing red color
        myNewLineColor = [1 0 0];
        myNewLineStyle = '-';
        
    end
    
    if (ParetoOptimal(i) == 1)
%         assing blue colour
        myNewLineColor = [0 0 1];
        myNewLineStyle = '-';
        
    end
    
            plot(x1,MyMatrix(:,i),...
            'Color',myNewLineColor,...
            'LineStyle',char(myNewLineStyle),...
            'LineWidth',MyLineWith1);
        
 end

% you can also label the axis
xlabel ('performance attributes');
ylabel ('performance');

hold(ax1,'off')  
   
   
set(figure1, 'PaperPosition', [1 4 12 12]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
set(figure1, 'PaperSize', [21 29]); %Keep the same paper size saveas(gcf, 'test', 'pdf')
saveas(figure1, strcat('./Figures/PlotLines', '.jpeg'))
saveas(figure1, strcat('./Figures/PlotLines', '.pdf'))


end