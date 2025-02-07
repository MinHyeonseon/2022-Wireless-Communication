%% 참고할만한 링크
% ASCII Code Reference: https://www.ascii-code.com/
clear variables;
close all;
clc;

%% random binary data
nData_per_iteration = 1000000;
tx_bit_stream = randi([0 1],1,nData_per_iteration);

%%% [LOOK] BER curve에 필요한 data point 수 설정
%%% [LOOK] transmit power도 data point 만큼 설
nDataPoint = 6;
transmit_power = [1 2 4 8 16 32];
BER_output = zeros(1,nDataPoint);


%% Tx / Channel / Rx

bit_stream_length = nData_per_iteration;
bit_per_sym = 2;
sym_length = bit_stream_length/bit_per_sym;
modulated_symbol = zeros(1, sym_length) ;

%%% [LOOK] for-loop에 여러분 code


%%%% [LOOK] 처음에 어려울 경우 반복문을 1회만 시행
%%% 전체 코드의 동작을 확인

for k=1:nDataPoint %%%% [LOOK] for-loop 조건 설정
    %%% [LOOK] Your QPSK modulation CODE
    for  i1=1:sym_length
        index1 = 2*i1-1;
        index2 = 2*i1;
       
        if(tx_bit_stream(index1) ==0 && tx_bit_stream(index2) ==0)
            modulated_symbol(i1) =1+1j;
        elseif (tx_bit_stream(index1) ==0 && tx_bit_stream(index2) ==1)
            modulated_symbol(i1) =-1+1j;
        elseif (tx_bit_stream(index1) ==1 && tx_bit_stream(index2) ==1)
            modulated_symbol(i1) =-1-1j;
        else 
            modulated_symbol(i1) =1-1j;
        end
        
    
    end

    
    %%% choose different power value for each iteration
    %%% [LOOK] transmit_power_sample이 매번 바뀔 수 있도록 설정
    transmit_power_sample = transmit_power(k);
    tx_signal = sqrt(transmit_power_sample)*modulated_symbol ;

    %%% CHANNEL
    AWGN = sqrt(1/2)*(randn(1, sym_length) + 1j*randn(1, sym_length) ) ;
    rx_signal = tx_signal + AWGN;
    % rx_signal = tx_signal;

    demodulated_symbol = zeros(1, bit_stream_length) ;
    %%% [LOOK] Your QPSK demodulation CODE
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

    rx_bit_stream = demodulated_symbol;

    %%% BER calculation part HERE
    %%% [LOOK] tx_bit_stream과 rx_bit_stream을 비교하여 error bit 수 세기
    BER_output(k) = biterr(tx_bit_stream, rx_bit_stream)/nData_per_iteration;
end

%% Result PLOT

figure();

loglog(transmit_power,BER_output,'bo-');
hold on; grid on;
%%% 여러분이 원하는 결과인가??
%%% 그렇지 않다면 WHY??