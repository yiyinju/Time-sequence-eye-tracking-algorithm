function [move] = LinearFit(dX_dpitch_current, dX_dyaw_current, deltaX)
%CREATEFIT(DX_DPITCH_CURRENT,DX_DYAW_CURRENT,DELTAX)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : dX_dpitch_current
%      Y Input : dX_dyaw_current
%      Z Output: deltaX
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  另请参阅 FIT, CFIT, SFIT.

%  由 MATLAB 于 04-Nov-2022 21:08:27 自动生成


%% Fit: 'Linear fit'.
[xData, yData, zData] = prepareSurfaceData( dX_dpitch_current, dX_dyaw_current, deltaX );

% Set up fittype and options.
ft = fittype( 'a*x+b*y', 'independent', {'x', 'y'}, 'dependent', 'z' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0 0];

% Fit model to data.
[move] = fit( [xData, yData], zData, ft, opts );

% % Plot fit with data.
% figure( 'Name', 'untitled fit 1' );
% h = plot( fitresult, [xData, yData], zData );
% legend( h, 'untitled fit 1', 'deltaX vs. dX_dpitch_current, dX_dyaw_current', 'Location', 'NorthEast', 'Interpreter', 'none' );
% % Label axes
% xlabel( 'dX_dpitch_current', 'Interpreter', 'none' );
% ylabel( 'dX_dyaw_current', 'Interpreter', 'none' );
% zlabel( 'deltaX', 'Interpreter', 'none' );
% grid on


