function test
clc
clear all
getd = @(p)path(p,path);
getd('toolbox_signal/');
getd('toolbox_general/');

n = 256;
name = 'hibiscus';
f0 = load_image(name,n);
f0 = rescale( load_image(name,n) );
f0 = rescale( sum(f0,3) );

% clf;
% imageplot(f0);

sigma = .08;
f = f0 + sigma*randn(size(f0));
clf;
imageplot(clamp(f), strcat(['Noisy, SNR=' num2str(snr(f0,f),3)]));

pause
close all
end