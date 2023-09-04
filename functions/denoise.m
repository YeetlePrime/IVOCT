function scanPolar = denoise(scanPolar, intensity)
%Remove noise from a scan in polar coordinates (either b-scan or m-scan).
%   Default intensity value defined for b-scan as input. Value might be
%   changed when using m-scan.
%
%   WRITTEN BY Lena

    % get dimensions
    [height, width] = size(scanPolar);

    % default value for intensity
    if ~exist('intensity', 'var')
        intensity = 0.004*width;
    end

    % apply movmean filter on every row
    for i = 1:height
        scanPolar(i, :) = movmean(scanPolar(i, :), intensity);
    end
end

