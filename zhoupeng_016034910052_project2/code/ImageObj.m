classdef ImageObj < handle
   properties
      img_file
      img
      img_dc
   end
   methods
      function obj = ImageObj(image_file)
          obj.img_file = image_file;
          obj.img = im2double(imread(image_file));
      end
      function dc = get_dark_channel_n(obj, n)
         dc = dark_channel(obj.img, n);
      end
      function dc = get_dark_channel(obj)
         dc =  dark_channel(obj.img);
         obj.img_dc = dc;
      end
   end
end