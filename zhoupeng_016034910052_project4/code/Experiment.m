classdef Experiment
    properties
        count
        img_file_list
        img_obj_list
    end
    methods
        function obj = Experiment(varargin)
            if nargin < 1
                error('At least one image')
            end
            obj.count = nargin;
            for i = 1 : nargin
                obj.img_file_list{i} = varargin{i};
                obj.img_obj_list{i} = ImageObj(varargin{i});
            end
        end
        
        function plot_segmentation_image(obj)
            img = obj.img_obj_list{1}.img_gray;
            img_name = obj.img_obj_list{1}.img_name;
            % Original image
            figure
            imshow(img)
            print('-depsc', sprintf('results/%s_original', img_name));
            title('Original image')
            % Add noise
            img_noise = imnoise(img, 'salt & pepper', 0.02);
            figure
            imshow(img_noise)
            print('-depsc', sprintf('results/%s_noise', img_name));
            title('Noisy image')
            % Directly segmentation
            threshold = graythresh(img_noise);
            img_noise_seg = im2bw(img_noise, threshold);
            figure
            imshow(img_noise_seg)
            print('-depsc', sprintf('results/%s_direct_segmentation', img_name))
            title('Direct segmentation')
            % Dilate
            se = strel('disk', 2);
            img_dilated = imdilate(img_noise_seg, se);
            figure
            imshow(img_dilated)
            print('-depsc', sprintf('results/%s_dilate_segmentation', img_name))
            title('Dilated image')
            % Erosion
            img_erosion = imerode(img_noise_seg, se);
            figure
            imshow(img_erosion)
            print('-depsc', sprintf('results/%s_erode_segmentation', img_name))
            title('Eroded image')
            % Open operate
            seg_open = imopen(img_noise_seg, se);
            figure
            imshow(seg_open)
            print('-depsc', sprintf('results/%s_open_segmentation', img_name))
            title('Open image')
            % Close
            figure
            seg_close=imclose(img_noise_seg,se);
            imshow(seg_close)
            print('-depsc', sprintf('results/%s_close_segmentation', img_name))
            title('close')
            % Open and close
            ac=bwmorph(seg_open,'close');
            figure
            imshow(ac)
            print('-depsc', sprintf('results/%s_open_and_close_segmentation', img_name))
            title('Open and close')
            
            %             aclean= bwmorph(img_noise_seg,'clean');
            %             figure
            %             imshow(aclean);
            %             title('bwmorph clean')
            %             af=bwmorph(aclean,'fill');
            %             figure
            %             imshow(af)
            %             print('-depsc', sprintf('results/%s_clean_and_fill_segmentation', img_name))
            %             title('bwmorph clean and fill')
            %
        end
        
    end
end