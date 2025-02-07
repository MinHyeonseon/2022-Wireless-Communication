%%% Initialization
clear variables; clc; 

%%% Parameter Setting Section
%%% x data
x = -2:0.001:5; 

%%% TODO
%%% y data: 예제 함수 입력
y = (x-2).^2  + 1;


%%% TODO
%%% 아래의 두 변수를 for-loop에서 활용
minValue = y(1);
minIndex = 1 ;

%%% 탐색 알고리즘: 모든 경우를 비교하여 최소값 찾기
%%% index 기준으로 검색
for i = 2 : 1 : length(x)
    if y(i)< minValue
       minIndex =i;
       minValue=y(i);
       
    end
%%% TODO
%%% 조건문 추가
end

figure();
plot(x, y, 'b-'); hold on ; grid on ;
plot(x(minIndex), minValue, 'r*');
xlabel('x'); ylabel('y: cost'); 
legend('Cost function','Min. Value', 'location', 'southeast');

fprintf("Min Value : %d\n", minValue);