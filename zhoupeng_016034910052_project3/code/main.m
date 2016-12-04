function main
clc
clear all

%img1 = 'images/hibiscus.bmp';
img1 = 'images/flowr.BMP';
img2 = 'images/lena512.bmp';

experiment = Experiment(img1, img2);
experiment.plot_noised_images(0.1);
experiment.plot_hard_threshold();
experiment.plot_soft_threshold();
experiment.plot_snr_using_hard_and_soft_threshold();
experiment.plot_denoised_images_using_hard_threshold();
experiment.plot_denoised_images_using_soft_threshold();

pause
close all
end