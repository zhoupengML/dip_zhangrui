classdef Experiment
   properties
       count
       img_file_list
       img_obj_list
   end
   methods
       function obj = Experiment(varargin)
          if nargin < 1
             error('At least input one images')
          end
          display(sprintf('Number of inputed images: %d', nargin));
          obj.count = nargin;
          for i = 1 : nargin
              obj.img_file_list{i} = varargin{i};
              obj.img_obj_list{i} = ImageObj(varargin{i});
          end
       end
       function plot_noised_images(obj, sigma)
           %sigma = 0.08;
           for i = 1 : obj.count
               figure
               imshow(obj.img_obj_list{i}.img_double);
               print('-depsc', sprintf('results/%s', obj.img_obj_list{i}.img_name));
               figure
               img_noise = obj.add_gaussian_noise(obj.img_obj_list{i}.img_double, sigma);
               imshow(img_noise);
               print('-depsc', sprintf('results/%s_gaussian_0_1', obj.img_obj_list{i}.img_name))
           end
       end
   end
   methods(Static)
       function img_noise = add_gaussian_noise(img, sigma)
           img_noise = img + sigma*randn(size(img));          
       end
       
   
   end
end