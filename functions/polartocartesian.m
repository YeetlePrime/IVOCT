function scanCart = polartocartesian(scanPolar)
%Converts an image from polar coordinates to cartesian coordinates.
%   Uses an adaptive mean-value approach.
%
%   WRITTEN BY Alaa AND Lena

    % get dimensions
    [polarHeight, polarWidth] = size(scanPolar);
    cartHeight = 2*polarHeight + 1;
    cartWidth = cartHeight;

    % init cartesian image
    scanCart = zeros(cartHeight, cartWidth);
    % init numberOfChanges counter for the cartesian image. increases every
    % time the pixel in that coordinate gets updated. Used to compute the
    % mean value.
    scanCounter = zeros(cartHeight, cartWidth);

    % iterate over polar image
    for thetaI = 1:polarWidth
        theta = thetaI*2*pi/polarWidth;
        for rho = 1:polarHeight
            % each polar image pixel:
            %   compute cartesian coordinates
            %   and change the cartesian pixel value
            
            % cartesian coordinates
            [x, y] = pol2cart(theta, rho);
            x = floor(polarHeight + 1 + x);
            y = floor(polarHeight + 1 - y);

            % scale current value by the number of updates
            scanCart(y, x) = scanCart(y, x)*scanCounter(y, x);
            % add new value
            scanCart(y, x) = scanCart(y, x) + scanPolar(rho, thetaI);
            % increase counter for the specific pixel
            scanCounter(y, x) = scanCounter(y, x) + 1;
            % divide by new counter
            scanCart(y, x) = scanCart(y, x)/scanCounter(y, x);
            %RESULT: current mean value for the specific cartesian pixel
        end
    end
end

