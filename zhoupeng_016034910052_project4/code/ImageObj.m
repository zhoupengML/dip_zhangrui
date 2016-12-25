classdef ImageObj
   properties
      img_file 
      img_name
      img_original
      img_gray
      img_double
   end
   methods
       function obj = ImageObj(image_file)
           obj.img_file = image_file;
%           display(image_file)
           obj.img_name = image_file(find(image_file == '/') + 1 : find(image_file == '.') - 1);
           img = imread(image_file);
           obj.img_original = img;
           if numel(size(img)) > 2
               obj.img_gray = rgb2gray(img); 
           else
               obj.img_gray = img;
           end
           
           obj.img_double = im2double(obj.img_gray);
       end
   end
end