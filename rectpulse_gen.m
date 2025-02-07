function x1 = rect(tau, T1, T2, fs, df)

ts = 1/fs;
t = T1:ts:T2;

x1 = zeros(size(t));
midpoint = floor((T2-T1)/2/ts)+1; %floor
L1 = midpoint-fix(tau/2/ts); %fix :0
L2 = midpoint+fix(tau/2/ts)-1;
x1(L1:L2)=ones(size(x1(L1:L2)));

end