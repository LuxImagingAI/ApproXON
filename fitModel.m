function [fitresult, gof] = fitModel(PW, D, T)
%fitModel(PW,D,T)
%  Fit a two variabl model predicting the activation threshold from pulse width 
%  and axon diameter (and discarding Voltage) using a log-linear model of the
%  form:
%
%  f(x) = exp(a*log(x) + b*log(y) + c) + d
%
%  Note that the "median" Voltage in the paper by  Åstrom et al corresponds to 3V
%
%  Data for 'Axonal E-Field Activation Treshold for (PW,D)' fit:
%      X Input : PW
%      Y Input : D
%      Z Output: T
%
%  Output:
%      fitresult : sfit object represaenting the model
%      gof : structure array with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.
%
%  Andreas Husch, University of Luxembourg, 2019
%  andreas.husch(at)uni.lu
%
%  partially Auto-generated by MATLABs curve fitting tool

%% Initialization.

% Initialize arrays to store fits and goodness-of-fit.
gof = struct( 'sse', {}, ...
    'rsquare', [], 'dfe', [], 'adjrsquare', [], 'rmse', [] );

%% Fit: 'Axonal E-Field Activation Treshold for (PW,D) at 3V'.
[xData, yData, zData] = prepareSurfaceData( PW, D, T );

% Set up fittype and options.
ft = fittype( 'exp(a*log(x) + b*log(y) + c) + d', 'independent', {'x', 'y'}, 'dependent', 'z' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0.00590367841229389 0.211845968137226 0.12116924524511 0.614850146943383];

% Fit model to data.
[fitresult, gof(2)] = fit( [xData, yData], zData, ft, opts );

% % Create a figure for the plots.
figure( 'Name', 'Axonal E-Field Activation Treshold for (PW,D) at 3V' );
% 
% % Plot fit with data.
subplot( 2, 1, 1 );
h = plot( fitresult, [xData, yData], zData ,'Xlim', [10 240], 'YLim', [1 7.5]);
hold on
vd = plot3(60,7.5,0.064, '*r');

legend( [h; vd], 'Model', 'Data', 'Validation Data', 'Location', 'NorthEast', 'Interpreter', 'none' );

title('Axonal E-Field Activation Treshold for (PW,D) at 3V')

% Label axes
xlabel( 'PW [\mus]', 'Interpreter', 'Tex' );
ylabel( 'D [\mum]', 'Interpreter', 'Tex');
zlabel( 'T [V/mm]', 'Interpreter', 'Tex' );
grid on
view( 157.2, 26.3 );
caxis([0.0369 2])

% Make contour plot.
subplot( 2, 1, 2 );
h = plot( fitresult, [xData, yData], zData, 'Style', 'Contour' ,'Xlim', [10 240], 'YLim', [1 7.5]);
legend( h, 'Model', 'Data', 'Location', 'NorthEast', 'Interpreter', 'none' );
title('Axonal E-Field Activation Treshold for (PW,D) at 3V')
% Label axes
xlabel( 'PW [\mus]', 'Interpreter', 'Tex' );
ylabel( 'D [\mum]', 'Interpreter', 'Tex');
grid off

caxis([0.0369 2])
