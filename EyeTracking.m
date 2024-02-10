function [Trace] = EyeTracking(CalibrationData, Data, InitCoordination)
% Time-sequence eye tracking algorithm based on the eye tracking SCL

% Authors: 
% Hengtian Zhu, Huan Yang, Siqi Xu, Yuanyuan Ma, Shugeng Zhu,
% Zhengyi Mao, Weiwei Chen, Zizhong Hu, Rongrong Pan, Yurui Xu,
% Yifeng Xiong, Ye Chen, Yanqing Lu, Xinghai Ning, Dechen Jiang,
% Songtao Yuan, and Fei Xu

% Article: 
% Frequency-encoded Eye Tracking Smart Contact Lens for Human-Machine Interaction

% Input:
% CalibrationData, n*6 double, calibration data collected by the swirling calibration method
% Data, n*4 double, response of SCL to calculate the eye movement trace
% InitCoordination, 1*2 double, the known initial coordination

% Output:
% Trace, n*2 double, the calculated eye movement trace

% Build the response model
calibrate_x = CalibrationData(:,1);
calibrate_y = CalibrationData(:,2);
calibrate_X1 = CalibrationData(:,3);
calibrate_X2 = CalibrationData(:,4);
calibrate_X3 = CalibrationData(:,5);
calibrate_X4 = CalibrationData(:,6);
[fit_X1] = Model_calibration_inter(calibrate_x, calibrate_y, calibrate_X1);
[fit_X2] = Model_calibration_inter(calibrate_x, calibrate_y, calibrate_X2);
[fit_X3] = Model_calibration_inter(calibrate_x, calibrate_y, calibrate_X3);
[fit_X4] = Model_calibration_inter(calibrate_x, calibrate_y, calibrate_X4);

% Calculate the trace frame by frame
i=1;
x(i) = InitCoordination(1);
y(i) = InitCoordination(2);
a=1;
for i=2:1:length(Data)
    n=1;
    y_estimate=y(i-1);
    x_estimate=x(i-1);
    deltaX=(Data(i,:)-Data(i-1,:))';
    while n<10
        %求解当前估计坐标的二维导数
        dX_dx_current(1,1)=(fit_X1(x_estimate+a,y_estimate)-fit_X1(x_estimate-a,y_estimate))/2/a;
        dX_dx_current(2,1)=(fit_X2(x_estimate+a,y_estimate)-fit_X2(x_estimate-a,y_estimate))/2/a;
        dX_dx_current(3,1)=(fit_X3(x_estimate+a,y_estimate)-fit_X3(x_estimate-a,y_estimate))/2/a;
        dX_dx_current(4,1)=(fit_X4(x_estimate+a,y_estimate)-fit_X4(x_estimate-a,y_estimate))/2/a;
        dX_dy_current(1,1)=(fit_X1(x_estimate,y_estimate+a)-fit_X1(x_estimate,y_estimate-a))/2/a;
        dX_dy_current(2,1)=(fit_X2(x_estimate,y_estimate+a)-fit_X2(x_estimate,y_estimate-a))/2/a;
        dX_dy_current(3,1)=(fit_X3(x_estimate,y_estimate+a)-fit_X3(x_estimate,y_estimate-a))/2/a;
        dX_dy_current(4,1)=(fit_X4(x_estimate,y_estimate+a)-fit_X4(x_estimate,y_estimate-a))/2/a;  
        [fitresult] = LinearFit(dX_dx_current, dX_dy_current, deltaX);
        move(1)=fitresult.a;move(2)=fitresult.b;
        if abs(x_estimate+move(1))>30 || abs(y_estimate+move(2))>17
            break
        end     
        deltaX_iteration(1,:)=deltaX(1)-(fit_X1(x_estimate+move(1),y_estimate+move(2))-fit_X1(x_estimate,y_estimate));
        deltaX_iteration(2,:)=deltaX(2)-(fit_X2(x_estimate+move(1),y_estimate+move(2))-fit_X2(x_estimate,y_estimate));
        deltaX_iteration(3,:)=deltaX(3)-(fit_X3(x_estimate+move(1),y_estimate+move(2))-fit_X3(x_estimate,y_estimate));
        deltaX_iteration(4,:)=deltaX(4)-(fit_X4(x_estimate+move(1),y_estimate+move(2))-fit_X4(x_estimate,y_estimate));
        if n>1
            if mean(abs(deltaX_iteration)) > mean(abs(deltaX))
                break;
            end
        end
        deltaX=deltaX_iteration;
        x_estimate=x_estimate+move(1);
        y_estimate=y_estimate+move(2);
        n=n+1;
    end
    y(i)=y_estimate;
    x(i)=x_estimate;
end
Trace = [x;y]';
end

