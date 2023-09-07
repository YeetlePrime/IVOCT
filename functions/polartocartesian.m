function scanCart = polartocartesian(scanPolar)
%Converts an image from polar coordinates to cartesian coordinates.
%   Computes image value for each cartesian image pixel by transforming to
%   polar coordinates and using binary interpolation.
%
%   Complexity of O(cartWidth * cartHeight) == O((2*polarHeight+1)^2)
%
%   WRITTEN BY Alaa AND Lena AND Jonas

    % get dimensions
    [polarHeight, polarWidth] = size(scanPolar);
    cartHeight = 2*polarHeight + 1;
    cartWidth = cartHeight;

    % initialize empty output image with correct size
    scanCart = zeros([cartWidth, cartHeight], 'double');

    % loop over image pixels (with origin in image center)
    for x = -polarHeight:polarHeight
        for y = -polarHeight:polarHeight
            % compute amplitude and angle in polar coordinates
            [t, r] = cart2pol(x, y);
            
            % bilinear interpolation
            if r < polarHeight && r > 0 % boundary check
                % compute angle index from radian 
                t = (polarWidth - 1) * (t + pi) / (2*pi) + 1;
                
                % t of closest pixels
                ft = floor(t); % pixel left of t
                st = ceil(t); % pixel right of t
                % difference to ft
                dt = t - ft;

                % r of closest pixels
                fr = floor(r); % pixel over r
                sr = ceil(r); % pixel under r
                % difference to fr
                dr = r - fr;
                
                % interpolation in t (or x) direction
                v1 = (1 - dt) * scanPolar(fr, ft) + dt * scanPolar(fr, st);
                v2 = (1 - dt) * scanPolar(sr, ft) + dt * scanPolar(sr, st);
                
                % interpolation in r (or y) direction
                scanCart(y + polarHeight + 1, polarHeight + 1 - x) = (1 - dr) * v1 + dr * v2;
            end
        end
    end
end

