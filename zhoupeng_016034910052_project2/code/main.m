function main()
    clc
    clear all
    img_name = 'images/wumai.jpg';
    image = im2double(imread(img_name));
    figure
    imshow(image)
    
    img_haze_free = 'images/haze_free.jpg';
    experiment = ExperimentObj(img_name, img_haze_free);
    experiment.plot_dark_channel();
%    experiment.plot_dc_with_diff_wind_size();
%    experiment.plot_recovered_img();
pause
close all
end