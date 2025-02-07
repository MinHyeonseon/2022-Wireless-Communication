%% 참고할만한 링크
% ASCII Code Reference: https://www.ascii-code.com/
clear variables;
close all;
clc;

%% Original Message (원본 메시지 - 수신단 측에서 복구(recover)하는 것이 목표!)
tx_data = 'Hello' ;
fprintf('Transmitted message: %s\n', tx_data);

%% step 1 (WITH)
%%% Encoder (부호화) - Binary Stream으로 만드는 과정
tx_bit_stream_perChar =dec2bin(tx_data) ; %%% WITH
tx_bit_stream =  reshape(tx_bit_stream_perChar,1, []); %%% WITH
disp('Step 1');
disp(tx_bit_stream_perChar);


%% step 2 (TODO)
%%% Modulation & Transmission (변조 후 전송) 
bit_stream_length = length(tx_bit_stream);
modulation_order_log = 1;
sym_length = bit_stream_length/modulation_order_log;
modulated_symbol = zeros(1, sym_length) ;

% BPSK Example
%%% TODO
%%% modulated_symbol에 modulation 결과 값을 대입하기!
%%% for-loop
for i1= 1:sym_length
    if tx_bit_stream(i1) =='1'
        modulated_symbol(i1) = 1;
    else
        modulated_symbol(i1) = -1;
    end
end
%%% 무선으로 보내기 위한 준비: POWER
transmit_power = 21.5 ;
tx_signal = sqrt(transmit_power)*modulated_symbol ;

% Tx Constellation (성상도)
figure()
plot( real(tx_signal), imag(tx_signal), 'bo'); grid on ;
xlim([-5 5]); ylim([-5 5]);


%% step 3 (TODO)
%%% Wireless Channel (무선 채널)
AWGN = randn(1, sym_length)+1j*randn(1, sym_length); %%% WITH
rx_signal = tx_signal + AWGN; %%% TODO

%Rx Constellation (성상도)
figure()
plot(real(rx_signal), imag(rx_signal), 'rx'); grid on ;
xlim([-5 5]); ylim([-5 5]);


%% step 4 (TODO)
%%% Receive & Demodulation (수신 후 복조)
% BPSK Example
demodulated_symbol = zeros(1, bit_stream_length) ;

%%% demodulated_symbol에 demodulation 결과 값을 대입하기!
%%% for-loop

rx_signal_real = real(rx_signal);
for i1= 1:bit_stream_length

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