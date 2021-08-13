function [Center, BC, bw] = obj_count(video, frameNo)
    frame = read(video, frameNo);
    grayimg = rgb2gray(frame);
    porog0 = graythresh(grayimg);
    try
        bw = im2bw(grayimg, porog0-0.1);
    catch
        bw = im2bw(grayimg, porog0);
    end
    bw = imfill(bw,'holes');
    se = strel('disk',1);
    bw = imopen(bw,se);
    Center = regionprops(bw, 'Centroid', 'BoundingBox');                                                   
    BC = length(Center);
end