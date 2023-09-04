function scanPolar = removecatheter(scanPolar, catheterHeight)
%Removes the catheter by blacking out the catheter area.
%
%   WRITTEN BY Lena

    % get dimensions
    [height, width] = size(scanPolar);

    % for valid input: black out the specified area
    if catheterHeight < height
        scanPolar(1:catheterHeight, :) = zeros(catheterHeight, width);
    end

end

