function main
clc
clear all

%img1 = 'images/hibiscus.bmp';
img1 = 'images/flowr.BMP';
img2 = 'images/lena512.bmp';

experiment = Experiment(img1, img2);
experiment.plot_noised_images(0.1);
%experiment.add_gaussian_noise();

pause
close all
end