function center = getcenter(edgeCart)
%Computes the center of the lumen by using the detected edge.
%   compute mean value of the x abd y coordinates to get the center.
%   
%   WRITTEN BY Jonas
    
    center.x = sum(edgeCart.x) / size(edgeCart.x, 2);
    center.y = sum(edgeCart.y) / size(edgeCart.y, 2);
end

