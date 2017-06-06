%
%初始化200张图片，宽576，长720，RGB三维颜色 pixel矩阵
%

Size = 200;
Height = 576;
Width = 720;
RGBs = zeros(Size,Height,Width,3,'double');
GMModels_2 = cell(Height,Width,3);

%初始化RGBs
for img_index = 1 : Size
    zero = '';
    if (floor(img_index / 100) ~= 0)
        zero = '';
    elseif (floor(img_index / 10) ~= 0)
        zero = '0';
    elseif (floor(img_index / 1) ~= 0)
        zero = '00';
    end
    RGBs(img_index,:,:,:) = im2double(imread(strcat('D:\ucas\2016-2017春季学期\图像处理与计算机视觉\作业\Image\000',zero,num2str(img_index),'.jpg')));
end

for r = 1 : Height
    disp(r);
    for c = 1 : Width
        GMModels_2{r,c,1} = fitgmdist(RGBs(:,r,c,1),2,'Regularize',0.1);
        GMModels_2{r,c,2} = fitgmdist(RGBs(:,r,c,2),2,'Regularize',0.1);
        GMModels_2{r,c,3} = fitgmdist(RGBs(:,r,c,3),2,'Regularize',0.1);
    end
end

%取得背景模型的RGB像素
bg_pixels = zeros(Height,Width,3);
for r = 1 : Height
    for c = 1 : Width
        for color = 1 : 3
            gmm_model = GMModels_2{r,c,color};
            proportion = gmm_model.ComponentProportion;
            mu = gmm_model.mu;
            max_index = 1;
            %获得最大的权重的像素均值
            if(proportion(max_index) < proportion(2))
               max_index = 2; 
            end
            bg_pixels(r,c,color) = mu(max_index);
            %disp(gmm_model);
        end
    end
end
imwrite(bg_pixels,'D:\ucas\2016-2017春季学期\图像处理与计算机视觉\作业\background.jpg','jpg','Comment','background image file');

