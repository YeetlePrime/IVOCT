function scanCart = polar2cart(scanPolar)
%Alternative version for polar to cartesian transformation.
%   Is faster than our current implementation for images with many A-Scans
%   per B-Scan, but arguably less exact.
%   O((2*polarHeight+1)^2) compared to O(polarHeight * polarWidth)
%       => faster for polarWidth > 2*polarHeight+1
    [polarHeight, polarWidth] = size(scanPolar);
    cartHeight = 2*polarHeight + 1;
    cartWidth = cartHeight;

    scanCart = zeros([cartWidth, cartHeight], 'double');

    for x = -polarHeight:polarHeight
        for y = -polarHeight:polarHeight
            [t, r] = cart2pol(x, y);
            if r < polarHeight && r > 0
                t = (polarWidth - 1) * (t + pi) / (2*pi) + 1;
                
                ft = floor(t);
                st = ceil(t); 
                dt = t - ft;

                fr = floor(r);
                sr = ceil(r);
                dr = r - fr;
                

                v1 = (1 - dt) * scanPolar(fr, ft) + dt * scanPolar(fr, st);
                v2 = (1 - dt) * scanPolar(sr, ft) + dt * scanPolar(sr, st);

                scanCart(y + polarHeight + 1, polarHeight + 1 - x) = (1 - dr) * v1 + dr * v2;
            end
        end
    end
    

end