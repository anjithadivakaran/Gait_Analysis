function [min_bliz, min_bliz_ind] = bliz_k_predf(s, Center, i, user_cent)
for p = 1:5
   bliz_k_predX(p) = user_cent(i, s-1).Centroid(1) - Center(p).Centroid(1);
   bliz_k_predY(p) = user_cent(i, s-1).Centroid(2) - Center(p).Centroid(2);
   bliz_k_pred(p) = sqrt(bliz_k_predX(p)^2 + bliz_k_predY(p)^2);
end
[min_bliz, min_bliz_ind] = min(bliz_k_pred(:));