%%% Initialziation
clear variables ; clc ; close all;

%%% Parameter Setting
x = -2:0.001:4 ;

%%% TODO
%%% y: 예제 함수 입력
y = x.^4 + 10*x.*cos(x);



%%% 1-Dimensional Gradient Decent Practice
LearningRate = 0.01 ;            % Learning Rate, gamma
precision = 0.001 ;     % Termination Condition, epsilon
initial_x = 0.5 ;       % Initial Value


%%% 설명 예정
% To find out the index of array having the nearest value with the minimum value                    
[~, initial_x_idx] = min(abs(initial_x-x)); 


%%% cost function 확인을 위한 figure plot
%%% 설명 예정
figure(5);
plot(x, y, 'b-'); hold on ; grid on ;
xlabel('x'); ylabel('f(x)'); 
plot(x(initial_x_idx), y(initial_x_idx), 'ro');
ylim([-6 12]); xlim([-2 4]);

%%% 설명 예정
% Gradient (First-order derivative)
dydx = first_order_derivative(x,initial_x_idx);
x_new = initial_x - LearningRate * dydx ;

[~, x_new_idx] = min(abs(x_new-x));

x_old = initial_x ;
while( abs(x_new - x_old) > precision)
   x_old = x_new ;
   
   [~, x_old_idx] = min(abs(x_old-x)); % See Line 15 (★)
   
   dydx = first_order_derivative(x, x_old_idx);
   
   x_new = x_old - LearningRate * dydx ;
   
   %%% 설명 예정
   %%% TODO
   %%% update 상황을 보고 싶다면??
   % pause(0.5);
   
      
end

figure(5);
plot(x(x_old_idx), y(x_old_idx), 'r*');


function dydx = first_order_derivative(x_data,idx)

    x = x_data(idx);
    %%% TODO
    %%% 출력변수: dydx
    %%% 출력변수에 어떤 값을 저장해야 할까??
    dydx = 4*x.^3 + 10*cos(x)-10*x*sin(x);

end