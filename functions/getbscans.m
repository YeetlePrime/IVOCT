function bScansPolar = getbscans(mScanPolar, bScanWidth)
%Splits an m-scan in multiple b-scans of the specified width bScanWidth.
%   If the width of the m-scan is not divisible by bScanWidth, get rid of
%   the remainder.
%   Returns a 3-dimensional matrix of size:
%       [mScanHeight, bScanWidth, bScanCount]
%
%   WRITTEN BY Alaa

    % get dimensions
    [mScanHeight, mScanWidth] = size(mScanPolar);
    % calculate b-scan dimensions and count
    bScanHeight = mScanHeight;
    bScanCount = floor(mScanWidth/bScanWidth);

    % init matrix for b-scans
    bScansPolar = zeros(bScanHeight, bScanWidth, bScanCount);
    
    % fill b-scans with corresponding m-scan chunks
    for i = 1:bScanCount
        bScansPolar(:, :, i) = mScanPolar(:, ((i - 1)*bScanWidth + 1):(i*bScanWidth));
    end
end

