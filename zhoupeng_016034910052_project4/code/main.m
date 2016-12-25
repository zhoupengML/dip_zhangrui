function main
clc
clear all

img = 'images/coins.tif';

experiment = Experiment(img);
experiment.plot_segmentation_image();

pause
close all
end