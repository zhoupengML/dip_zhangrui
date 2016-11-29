function [dark_channel] = dark_channel(image, varargin)
    if nargin < 2
       n = 7; % default window size: 15
    else
        n = varargin{1};
        display(n)
    end
    cols = size(image, 2);
    rows = size(image, 1);
    
    dark_channel = zeros(rows, cols);
    for ix = (n + 1):(rows-(n + 1))
        for iy = (n + 1):(cols-(n + 1))
            dark_channel(ix-n:ix+n, iy-n:iy+n) = find_minimum(image(ix-n:ix+n, iy-n:iy+n));
        end
    end
end