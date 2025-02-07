%% 참고할만한 링크
% ASCII Code Reference: https://www.ascii-code.com/
clear variables;
close all;
clc;

%% Original Message (원본 메시지 - 수신단 측에서 복구(recover)하는 것이 목표!)
%%% 공백 포함해서 짝수 문자열 입력!!!
tx_data = 'Hello World!' ; 
fprintf('Transmitted message: %s\n', tx_data);

%% step 1 (WITH)
%%% Encoder (부호화) - Binary Stream으로 만드는 과정
tx_bit_stream_perChar = dec2bin(tx_data) ;
tx_bit_stream = reshape(tx_bit_stream_perChar, 1, [] ) ; % bit stream will be converted to the data symbols
disp('Step 1');
disp(tx_bit_stream_perChar);


%% step 2 (TODO)
%%% Modulation & Transmission (변조 후 전송) 
bit_stream_length = length(tx_bit_stream);
bit_per_sym = 2;
sym_length = bit_stream_length/bit_per_sym;
modulated_symbol = zeros(1, sym_length) ;

% QPSK Example
%%% 주의: symbol 길이와 bit 길이 차이 WHY???
%%% tx_bit_stream에 들어있는 것은 char 문자
%%% tx_bit_stream(index1) == '1' 형태로 비교
%%% QPSK이므로 2개를 동시에 각각 비교 ('11' 이렇게 아님)
%%% modulation의 결과는 modulated_symbol에 저장(복소수)
%%% 이진수 -> 복소수 mapping은 실습자료 참고


for  i1=1:sym_length
    index1 = 2*i1-1;
    index2 = 2*i1;
   
    if(tx_bit_stream(index1) =='0' && tx_bit_stream(index2) =='0')
        modulated_symbol(i1) =1+1j;
    elseif (tx_bit_stream(index1) =='0' && tx_bit_stream(index2) =='1')
        modulated_symbol(i1) =-1+1j;
    elseif (tx_bit_stream(index1) =='1' && tx_bit_stream(index2) =='1')
        modulated_symbol(i1) =-1-1j;
    else 
        modulated_symbol(i1) =1-1j;
    end
    

end

transmit_power = 2.5 ;
tx_signal = sqrt(transmit_power)*modulated_symbol ;

figure()
plot( real(tx_signal), imag(tx_signal), 'bo'); grid on ;
xlim([-5 5]); ylim([-5 5]);


%% step 3 (TODO)
%%% Wireless Channel (무선 채널)
%%% 이상적인 상황을 가정하고 modulation/demodulation 코드의 정확성을 검증할 수 있다.
AWGN = sqrt(1/2)*(randn(1, sym_length) + 1j*randn(1, sym_length) ) ;
rx_signal = tx_signal ;

% Constellation (성상도)
figure()
plot(real(rx_signal), imag(rx_signal), 'rx'); grid on ;
xlim([-5 5]); ylim([-5 5]);


%% step 4 (TODO)
%%% Receive & Demodulation (수신 후 복조)
% BPSK Example
demodulated_symbol = zeros(1, bit_stream_length) ;

% QPSK Example
%%% rx_signal의 각 원소는 복소수!!!
%%% rx_signal의 각 원소가 두 개의 bit로 demodulation
%%% demodulated_symbol에는 0 또는 1 (숫자) 저장 (char 문자 아님)
for i1 = 1:sym_length
    index1 = 2*i1-1;
    index2 = 2*i1;
    if (real(rx_signal(i1))>0 && imag(rx_signal(i1))>0)
        demodulated_symbol(index1) = 0;
        demodulated_symbol(index2) = 0;
    elseif (real(rx_signal(i1))<0 && imag(rx_signal(i1))>0)
        demodulated_symbol(index1) =0;
        demodulated_symbol(index2) =1;
    elseif (real(rx_signal(i1))<0 && imag(rx_signal(i1))<0)
         demodulated_symbol(index1) =1;
         demodulated_symbol(index2) =1;
    else 
         demodulated_symbol(index1) =1;
         demodulated_symbol(index2) =0;
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