function diameter = getdiameter(edgePolar)
%Compute diameter of the vessel wall.
%   Computed in polar representation by using the detected edge in  polar
%   coordinates. 
%   Can be imagined as: summing up opposite a-scans to get diameters.
%   Then compute the mean value of those diameters. The more centric the
%   catheter, the better the results.
%
%   WRITTEN BY Jonas

    diameter.pixels = sum(edgePolar.y)*2/size(edgePolar.y, 2);
    diameter.millimeter = diameter.pixels*0.00519;
end

