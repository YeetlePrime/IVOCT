function mScan = loadmscan(filepath, variableName)
%Loads the m-scan from the .mat file.
%   Needs the filepath and the variableName for the m-scan.
%   variableName defaults to 'mscancut', because that is the used name in
%   the phantom file.
%
%   WRITTEN BY Alaa

    % default parameter
    if ~exist('variableName', 'var')
        variableName = 'mscancut';
    end

    % load variables
    mScan = load(filepath, variableName);
    % fix nameing
    mScan = mScan.(variableName);
    % rescale to double values from 0 to 1 (for uniform values)
    mScan = rescale(mScan, 0, 1);
end

