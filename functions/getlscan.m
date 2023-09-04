function lScan = getlscan(bScansCart, center)
%Computes the l-scan for the cartesian b-scans.
%   Needs all b-scans in cartesian coordinates and the center of the
%   vessel. Lines up one pixel-line of each b-scan that goes through the
%   center of the vessel.
%
%   WRITTEN BY Jonas

    % round center-values to get integers
    center.x = round(center.x);
    center.y = round(center.y);
    % get dimensions
    [cartHeight, cartWidth, scanCount] = size(bScansCart);
    
    % init l-scan
    lScan = zeros(cartHeight, scanCount);
    % get one line per b-scan and add it to the l-scan
    for i = 1:scanCount
        lScan(:, i) = bScansCart(:, center.x, i);
    end
end

