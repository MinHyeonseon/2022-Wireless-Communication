%%% 참고할만한 링크
% Linear Regression: https://www.mathworks.com/help/matlab/data_analysis/linear-regression.html
clear variables;
close all;
clc;

%%% Data 생성
%%% case 1
% load accidents
% x_data = hwydata(:,14); %Population of states
% y_data = hwydata(:,4); %Accidents per state

%%% case 2
rng(100);
x_data = linspace(0,10,100);
y_data = 3*x_data + randn(1,100);

n = length(x_data);

%%% Data 확인
figure();
hold on; grid on;
plot(x_data,y_data,'bo');


%%% [Part 1] 예측선 계산(이론): w*, b*

%%% TODO
%%% w*, b* 어떻게 계산할 수 있을까??
%%% 이론적 수식 활용해 보(p. 17)
s1 = mean(y_data) ;
s2 = mean(x_data) ;
s3 = mean(x_data.*y_data);
s4 =mean(x_data.^2);

w_opt = (s3-s2*s1)/(s4-(s2^2));
b_opt = s1-w_opt*s2;

y_est = w_opt * x_data + b_opt;

figure();
hold on; grid on;
plot(x_data,y_data,'bo');
plot(x_data,y_est,'r-');
ylim([0 30]);

%%% [Part 2] GD 방법 사용: w, b
%%% 설명 예정

b_gd = b_opt; % 가정
w = linspace(0,5,1000);

% Initial Value
initial_w = 2.5 ;       
LearningRate = 0.001;
precision = 0.001;
                        
% To find out the index of array having the nearest value with the minimum value                    
[~, initial_w_idx] = min(abs(initial_w-w)); 

%%% 설명 예정
%%% TODO
%%% test_function의 의미는??
output = test_function(w,initial_w_idx,b_gd,x_data,y_data);

w_new = initial_w - LearningRate * output ;
[~, w_new_idx] = min(abs(w_new-w));

w_old = initial_w ;
while( abs(w_new - w_old) > precision)
   w_old = w_new ;
   
   [~, w_old_idx] = min(abs(w_old-w));
   
   output = test_function(w,w_old_idx,b_gd,x_data,y_data);
   
   w_new = w_old - LearningRate * output ;
end

w_gd = w_new;
y_est_gd = w_gd * x_data + b_gd;

figure();
hold on; grid on;
plot(x_data,y_data,'bo');
plot(x_data,y_est,'r-');
plot(x_data,y_est_gd,'k.-');
ylim([0 30]);

function output = test_function(w_data,initial_w_idx,b_gd,x_data,y_data)
    
    w = w_data(initial_w_idx);
    
    %%% TODO
    %%% 어떤 수식을 함수에 적어야 할까?? (HINT p. 17)
    output = mean(2*x_data.^2*w+2*x_data*b_gd-2*x_data*y_data);

end

