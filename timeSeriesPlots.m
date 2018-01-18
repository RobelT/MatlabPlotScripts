function timeSeriesPlots()

global timeSeries1
global timeSeries2
global Months
global Year




%%
% give the file name of the file to be read
fileName = strcat('./TargetViolations-1.out');

% define how you woulld want to file to be read
% (i.,e delimeters, number of header lines etc)
delimiterIn = '\t';
delimiterIn = ' ';
headerlinesIn = 0;

% importing data as a matrix
raw = importdata(fileName,delimiterIn,headerlinesIn);

% getting the number of rows
MaxNoOfRows = size(raw,1);

%%
% initializing the arrays usually helps
timeSeries1 = [];
timeSeries2 = [];

% copy columns of the matrix into arrays
Year=  1*raw(1: MaxNoOfRows, 1);
Months=  1*raw(1: MaxNoOfRows, 2);
timeSeries1 = 1*raw(1: MaxNoOfRows, 8);
timeSeries2 =  1*raw(1: MaxNoOfRows, 9);



% Create figure
figure1 = figure();
% define diffrent subplots and give them names
ax1 = subplot(4,1,1);
ax2 = subplot(4,1,2);
ax3 = subplot(4,1,3);
ax4 = subplot(4,1,4);

hold(ax1,'on')
hold(ax2,'on')
hold(ax3,'on')
hold(ax4,'on')

% pre-define attributes of plot elements
Linecolour = [rand() rand() 1];
Edgecolour = [1 rand() rand()];
FaceColor= [rand() rand() rand()];
%%

%Plot on diffrent subplots using the name of the subplots

plot(ax1,timeSeries1,'MarkerEdgeColor',Edgecolour,'Color',Linecolour)

boxplot(ax2,timeSeries1,Months,'Color',Linecolour);

boxplot(ax3,timeSeries2 ,Months,'Color',Linecolour);

% closing of subplots ax1 to ax3
hold(ax1,'off')
hold(ax2,'off')
hold(ax3,'off')

%%
% get the set of years in one array (avoiding repitition)
myYear = unique(Year);

% iterate through each year
for i= 2: size(myYear,1)
    
    % define and redefine an array containing timeseries
    % corresponding to the current year only
    
    mytimeSeries1 = timeSeries1(Year==i);
    myMonths = Months(Year==i);
    
    if ((i > 15) && (i < 30))
        % assign red color to the plotlines
        %  corresponding to data after the first 75 years
        % and pentagon marker
        
        Linecolour = [1 0 0];
        myMarker = 'p';
        myMarkerSize = 12;
    else
    % assign random color to the plotlines
    Linecolour = [rand() rand() rand()];
     myMarker = '.';
     myMarkerSize = 1;
    end
    plot(ax4,myMonths,mytimeSeries1,...
        'Color',Linecolour,...
        'Marker',myMarker,...
        'MarkerSize',myMarkerSize,...
        'MarkerFaceColor',Linecolour );
    
    
end




set(figure1, 'PaperPosition', [1 4 12 12]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
set(figure1, 'PaperSize', [21 29]); %Keep the same paper size saveas(gcf, 'test', 'pdf')
saveas(figure1, strcat('./Figures/timeSeriesPlots', '.jpeg'))
saveas(figure1, strcat('./Figures/timeSeriesPlots', '.pdf'))

hold(ax4,'off')
end