function scanPolar = removeartifact(scanPolar, artifactBounds)
%Removes the static artifact of the polar scan (b-scan or m-scan).
%   Interpolates the values for the rows affected by the artifact.
%
%   WRITTEN BY Lena
    
    % get dimensions
    [height, width] = size(scanPolar);

    % get the y-coordinates for the uneffected pixels in each column
    definedPoints = [1:artifactBounds(1) - 1, artifactBounds(2) + 1:height];
    % y-coordinates for the effected pixels
    interpolationPoints = artifactBounds(1):artifactBounds(2);

    % change the effected pixels by column-wise-interpolation
    for i = 1:width
        definedValues = scanPolar(definedPoints, i);
        scanPolar(interpolationPoints, i) = interp1(definedPoints, definedValues, interpolationPoints);
    end
end

