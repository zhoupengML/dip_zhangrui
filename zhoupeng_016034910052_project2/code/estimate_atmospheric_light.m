function [atmospheric_light] = estimate_atmospheric_light(dark_channel, image, varargin)

[cols, rows] = size(dark_channel);
[vector, index] = sort(reshape(dark_channel, cols * rows, []), 1, 'descend');
% take the brightest .1% of the dark channel
limit = round(cols * rows /1000);
for ix = 1:limit
    vector(ix) = max(image(floor(index(ix)/rows)+1, mod(index(ix),rows)+1,:));
end
atmospheric_light= max(vector(1:limit));

if nargin > 2
    if atmospheric_light > varargin{1}
        atmospheric_light = varargin{1};
    end
end
display(atmospheric_light)
end