function [fitresult] = Model_calibration_inter(calibrate_x, calibrate_y, calibrate_X1)
%CREATEFIT(CALIBRATE_X,CALIBRATE_Y,CALIBRATE_X1)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : calibrate_x
%      Y Input : calibrate_y
%      Z Output: calibrate_X1
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  另请参阅 FIT, CFIT, SFIT.

%  由 MATLAB 于 14-Nov-2022 13:22:26 自动生成


%% Fit: 'untitled fit 1'.
[xData, yData, zData] = prepareSurfaceData( calibrate_x, calibrate_y, calibrate_X1 );

% Set up fittype and options.
ft = 'thinplateinterp';

% Fit model to data.
[fitresult] = fit( [xData, yData], zData, ft, 'Normalize', 'on' );

% % Plot fit with data.
% figure( 'Name', 'untitled fit 1' );
% h = plot( fitresult, [xData, yData], zData );
% legend( h, 'untitled fit 1', 'calibrate_X1 vs. calibrate_x, calibrate_y', 'Location', 'NorthEast', 'Interpreter', 'none' );
% % Label axes
% xlabel( 'calibrate_x', 'Interpreter', 'none' );
% ylabel( 'calibrate_y', 'Interpreter', 'none' );
% zlabel( 'calibrate_X1', 'Interpreter', 'none' );
% grid on
% view( -87.8, 1.1 );


