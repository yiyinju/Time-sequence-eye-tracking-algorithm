% This example demonstrates the usage of time-sequence eye tracking
% algorithm based on the eye tracking SCL.
% This example demonstrates the calculation process of the 'NJU' trace.

% Input the calibration data collected by the swirling calibration method.
load('./CalibrationData.txt');
% Input the 'NJU' data.
load('./NData.txt');
load('./JData.txt');
load('./UData.txt');
load('./NInitCoordination.txt');
load('./JInitCoordination.txt');
load('./UInitCoordination.txt');

% Calculate the trace of 'NJU' using the time-sequence eye tracking
% algorithm.
NTrace = EyeTracking(CalibrationData, NData, NInitCoordination);
JTrace = EyeTracking(CalibrationData, JData, JInitCoordination);
UTrace = EyeTracking(CalibrationData, UData, UInitCoordination);

figure
plot(NTrace(:,1),NTrace(:,2))
hold on
plot(JTrace(:,1),JTrace(:,2))
hold on
plot(UTrace(:,1),UTrace(:,2))