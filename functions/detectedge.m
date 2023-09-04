function [edgePolar, edgeCart] = detectedge(scanPolar, binaryThreshold)
%Detects the edge of a polar b-scan. Returns the edge in polar and
%cartesian coordinates.
%   all values > binaryThreshold will be white
%   edge will be made clearer by applying image filters (to remove blobs)
%   edgePolar and edgeCart hold a vector for x and y coordinates each.
%   These coordinate pairs represent the corresponding edge
%
%   WRITTEN BY Jonas

    % get dimensions
    [height, width] = size(scanPolar);

    % compute filter values based on the image size
    seScan = strel('rectangle', [floor(0.02*height), floor(0.02*width)]);
    seMask = strel('rectangle', [1, floor(0.02*width)]);
    filter = [0.0013*height*width, inf];

    % binarize image using the input binaryThreshold
    scanPolar = imbinarize(scanPolar, binaryThreshold);

    % make blobs bigger
    scanPolar = imdilate(scanPolar, seScan);
    % remove small blobs
    scanPolar = bwareafilt(scanPolar, filter);
    % make remaining blobs smaller again
    scanPolar = imerode(scanPolar, seScan);

    % initialize a "lumen mask" in polar representation
    maskPolar = zeros(height, width, 'logical');

    % look for first white pixel in each column and fill the mask
    % correspondingly
    for x = 1:width
        y = 1;
        while y <= height && ~scanPolar(y, x)
            y = y + 1;
        end

        if y > 1
            maskPolar(1:y - 1, x) = 1;
        end
    end
    % Note: at this point there might be some columns where no white pixel
    % was found. This will be fixed in the next step.
    
    % get rid of small lines, where no edge was detected
    maskPolar = imerode(maskPolar,seMask);
    % resize the mask again
    maskPolar = imdilate(maskPolar, seMask);


    %% Calculate polar edge
    % init x-vector. there is one y value per x value, so x = [1, ..., width]
    edgePolar.x = 1:width;
    % init y vector in the same size
    edgePolar.y = zeros(1, width);

    % scan each column of the mask until the first black pixel is reached.
    % this is the detected edge-value
    for x = 1:width
        y = 1;
        while y < height && maskPolar(y, x)
            y = y + 1;
        end
        edgePolar.y(x) = y;
    end

    %% compute edge in cartesian coordinates
    % theta = edgePolar.x in radians
    theta = edgePolar.x*2*pi/width;
    % y remains the same
    rho = edgePolar.y;
    
    % compute cartesian coordinate pairs corresponding to the polar
    % coordinates
    [x, y] = pol2cart(theta, rho);

    % shift the coordinates so that they represent image coordinates
    x = (height + 1)*ones(1, width) + x;
    y = (height + 1)*ones(1, width) - y;

    % return for edgeCart
    edgeCart.x = x;
    edgeCart.y = y;
end

