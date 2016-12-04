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
        
        function plot_snr_using_hard_and_soft_threshold(obj)
            for i = 1 : obj.count
                sigma = 0.1;
                T_list = (0.1 : 0.1 : 6);
                snr_list = zeros(1, length(T_list));
                
                img_origin = obj.img_obj_list{i}.img_double;
                img_noise = obj.add_gaussian_noise(img_origin, sigma);
                figure
                imshow(img_noise)
                img_name = obj.img_obj_list{i}.img_name;
                title(sprintf('original image: %s', img_name));
                
                figure
                types = {'h', 's'};color = {'r', 'b'};
                for j = 1 : length(types)
                    type = types{j};
                    for t = 1 : length(T_list)
                        [c, s] = wavedec2(img_noise, 2, 'coif2');
                        N = [1, 2];
                        T = [1, 1] * T_list(t) * sigma;
                        ch = wthcoef2('h', c, s, N, T, type);
                        cv = wthcoef2('v', ch, s, N, T, type);
                        img_rec = waverec2(cv, s, 'coif2');
                        snr_list(t) = snr(img_origin, img_rec);
                        %                     figure
                        %                     imshow(img_rec)
                        %                     title(sprintf('%s SNR=%s Hard\_Thres=%f', img_name, ...
                        %                         num2str(snr(img_origin, img_rec), 3), T_list(t)));
                    end
                    plot(T_list, snr_list, color{j});
                    xlabel('T/\sigma');
                    ylabel('SNR')
                    xlim([T_list(1), T_list(end)]);
                    hold on
                end
                legend('Hard', 'Soft', 4);
                print('-depsc', sprintf('results/%s_snr', img_name));
            end
        end
        function plot_denoised_images_using_hard_threshold(obj)
            for i = 1 : obj.count
                sigmas = [0.1, 0.2, 0.3];
                T_list = [0.1, 1.5, 3, 4.5];
                
                img_origin = obj.img_obj_list{i}.img_double;
                for i_sig = 1 : length(sigmas)
                    sigma = sigmas(i_sig);
                    img_noise = obj.add_gaussian_noise(img_origin, sigma);
                    figure
                    imshow(img_noise)
                    img_name = obj.img_obj_list{i}.img_name;
                    print('-depsc', sprintf('results/%s_noise_sigma_%d', img_name, 100*sigma));
                    title(sprintf('noisy image: %s, sigma=%f', img_name, sigma));
                    for t = 1 : length(T_list)
                        [c, s] = wavedec2(img_noise, 4, 'coif2');
                        N = [1, 2, 3, 4];
                        T = [1, 1, 1, 1] * T_list(t) * sigma;
                        type = 'h';
                        ch = wthcoef2('h', c, s, N, T, type);
                        cv = wthcoef2('v', ch, s, N, T, type);
                        img_rec = waverec2(cv, s, 'coif2');
                        figure
                        imshow(img_rec)
                        print('-depsc', sprintf('results/%s_sigma_%d_hard_%d', img_name, 100*sigma, ...
                            10*T_list(t)));
                        title(sprintf('%s SNR=%s, Hard Thres=%s, sigma=%s', img_name, ...
                            num2str(snr(img_origin, img_rec), 3), num2str(T_list(t), 3), ...
                            num2str(sigma)));
                    end
                end
            end
        end
        function plot_denoised_images_using_soft_threshold(obj)
            for i = 1 : obj.count
                sigmas = [0.1, 0.2, 0.3];
                T_list = [0.1, 1.5, 3, 4.5];
                
                img_origin = obj.img_obj_list{i}.img_double;
                for i_sig = 1 : length(sigmas)
                    sigma = sigmas(i_sig);
                    img_noise = obj.add_gaussian_noise(img_origin, sigma);
                    figure
                    imshow(img_noise)
                    img_name = obj.img_obj_list{i}.img_name;
                    print('-depsc', sprintf('results/%s_noise_sigma_%d', img_name, 100*sigma));
                    title(sprintf('noisy image: %s, sigma=%f', img_name, sigma));
                    for t = 1 : length(T_list)
                        [c, s] = wavedec2(img_noise, 4, 'coif2');
                        N = [1, 2, 3, 4];
                        T = [1, 1, 1, 1] * T_list(t) * sigma;
                        type = 's';
                        ch = wthcoef2('h', c, s, N, T, type);
                        cv = wthcoef2('v', ch, s, N, T, type);
                        img_rec = waverec2(cv, s, 'coif2');
                        figure
                        imshow(img_rec)
                        print('-depsc', sprintf('results/%s_sigma_%d_soft_%d', img_name, 100*sigma, ...
                            10*T_list(t)));
                        title(sprintf('%s SNR=%s, Soft Thres=%s, sigma=%s', img_name, ...
                            num2str(snr(img_origin, img_rec), 3), num2str(T_list(t), 3), ...
                            num2str(sigma)));
                    end
                end
            end
        end        

        function plot_soft_threshold(obj)
            T = 1;
            figure
            alpha = linspace(-3,3,1000);
            alphaT = max(1-T./abs(alpha), 0).*alpha;
            plot(alpha, alphaT);
            print('-depsc', 'results/soft_threshold')
        end
        function plot_hard_threshold(obj)
            figure
            T = 1;
            alpha = linspace(-3,3,1000);
            plot(alpha, alpha.*(abs(alpha)>T));
            print('-depsc', 'results/hard_threshold')
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