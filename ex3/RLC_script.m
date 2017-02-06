R=230;
C=4.5e-6;
L=500e-3;
q0=500e-9;
i0=0;

N=1000;
t0 = 0;
tf = 0.1;
h=(tf-t0)/N;

vf = @(t) 5;

ta = t0:h:tf;
ia = zeros(size(ta));
qa = zeros(size(ta));
vout = zeros(size(ta));

ia(1) = i0;
qa(1) = q0;

for n=1:N
    [qa(n+1), ia(n+1)] = RK4second(h,L,R,C,qa(n),ia(n),ta(n),vf);
    vout(n) = ia(n)*R;
end
plot(ta,vout);

