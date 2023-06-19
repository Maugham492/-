[y,Fs]=audioread("buzz.wav","double");  %读取音频，返回采样率
info = audioinfo("buzz.wav");       %获取音频文件信息，采样带宽等

figure;
subplot(2,1,1);       
plot(y);
title("时域分析");                  %画出时域图像

[k]=fft(y,Fs);
subplot(2,1,2);
plot(abs(k));
title("频域分析");                  %快速傅里叶变化，分析频域信号

figure;
subplot(2,1,1);
plot(y);
plot(20*log10(abs(y)/max(abs(y))));
ylabel('dB');
xlabel('ms');
title('时域');

subplot(2,1,2);


plot(20*log10(abs(abs(k))/max(abs(abs(k)))));
ylabel('dB');
xlabel('Hz');
title('频域');


plot(abs(k));
set(gca,'XLim',[0 1000]);
set(gca,'XTick',0:10:1000);         %重画频谱

Wp=1000/(Fs/2);                     %通带截止频率
Ws=900/(Fs/2);                      %阻带截止频率
Rp=20;                              %通带最大纹波
Rs=24;                              %阻带最小衰减
[n,wn]=buttord(Wp,Ws,Rp,Rs);
[b,a]=butter(n+16,wn,"high");       %设计butter滤波器
fvtool(b,a);                        %获取滤波器特征

z=filter(b,a,y);
figure;
subplot(2,1,1);
plot(z);
title('滤波后时域');
[k0]=fft(z,Fs);
subplot(2,1,2);
plot(abs(k0));
title('滤波后频域');


p=audioplayer(z,Fs);

play(p);
audiowrite("buzz2.wav",z,Fs);
