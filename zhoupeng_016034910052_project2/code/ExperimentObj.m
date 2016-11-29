classdef ExperimentObj
   properties
       img_file 
       img_name
       img_obj
       
       img_haze_free_file
       img_haze_free_name
       img_haze_free_obj
   end
   methods
       function obj = ExperimentObj(image_file, image_hf_file)
           obj.img_file = image_file;
           obj.img_obj = ImageObj(image_file);
           obj.img_name = image_file(find(image_file == '/') + 1 : find(image_file == '.') - 1);
           
           obj.img_haze_free_file = image_hf_file;
           obj.img_haze_free_obj = ImageObj(image_hf_file);
           obj.img_haze_free_name = image_hf_file(find(image_hf_file == '/') + 1 : find(image_hf_file == '.') - 1);
       end
       function plot_dc_with_diff_wind_size(obj)
           n = [1, 7, 10, 50];
           for i = 1:length(n)
               dc = obj.img_obj.get_dark_channel_n(n(i));
               figure
               imshow(dc)
               print('-depsc', sprintf('results/wumai_dc_%d', n(i)));
           end           
       end
       function plot_recovered_img(obj)
           n = 7;
           dc = obj.img_obj.get_dark_channel_n(n);
           a = [0.3, 0.5, 0.6, 0.7, 0.8, 1];
           for i = 1 : length(a)
               al = estimate_atmospheric_light(dc, obj.img_obj.img, a(i));
               t = transmission(obj.img_obj.img, al);
               r = scene_radiance(obj.img_obj.img, al, t);
               figure
               imshow(r)
               print('-depsc', sprintf('results/wumai_dehaze_%d', a(i)*10));
           end
       end
       function plot_dark_channel(obj)
           figure
           img_haze_dc = obj.img_obj.get_dark_channel();
           imshow(img_haze_dc);
           print('-depsc', sprintf('results/%s_dc', obj.img_name));
           
           figure
           imshow(obj.img_haze_free_obj.img);
           figure
           img_hf_dc = obj.img_haze_free_obj.get_dark_channel();
           imshow(img_hf_dc);
           print('-depsc', sprintf('results/%s_dc', obj.img_haze_free_name));
       end
   end
end