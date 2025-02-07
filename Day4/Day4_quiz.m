%% 참고할만한 링크
% ASCII Code Reference: https://www.ascii-code.com/
clear variables;
close all;
clc;

%%% 저장된 data 파일 불러오기: rx signal
filename = 'quiz2.mat';
load(filename);


%% step 4 (TODO)
%%% Receive & Demodulation (수신 후 복조)
% BPSK Example
demodulated_symbol = zeros(1, bit_stream_length) ;

%%% demodulated_symbol에 demodulation 결과 값을 대입하기!
%%% for-loop: 실습 코드 사용하기
rx_signal_real = real(rx_signal);
for i1= 1:sym_length

    if rx_signal_real(i1) > 0
        demodulated_symbol(i1) = 1;
    else
        demodulated_symbol(i1) = 0;
    end

end

%% step 5 (DONE)
%%% Decoder (복호화) - Original Message로 복구하는 과정
disp('Step 5');
rx_bit_stream = dec2bin(demodulated_symbol) ; % transpose is required
rx_bit_stream_perChar = reshape(rx_bit_stream,[],7);
disp(rx_bit_stream_perChar);
rx_bit_stream_perChar = bin2dec(rx_bit_stream_perChar);

rx_data = char(rx_bit_stream_perChar);
fprintf('Received message: %s\n', rx_data);