%Primeroa Etapa
clear all
close all
clc


fs=8000;
for x=1:100
    y=wavrecord(.1*fs,fs,1);
    NBits=8;
    filexxx='file1.wav';
    wavwrite(y,fs,NBits,filexxx)
    figure(1)
    
    plot(y);
    grid
    L=length(y);
    nfft=2^nextpow2(L);
    Y=fft(y,nfft)/L;
    f=fs/2*linspace(0,1,nfft/2+1);
    figure(2)
    plot(f,2*abs(Y(1:nfft/2+1)))
    grid
    pause(0.0000000000000000000000000000000000000000000000000000000001)
end