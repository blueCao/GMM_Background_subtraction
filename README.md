GMM_for_background_img.m
	利用高斯混合模型对每个像素点做处理生成得到k个高斯分布，取权值最大的那个分布的均值作为背景图片

GMM_for_foreground_img.m
	前景图片则是根据背景图片和前景图片的差大于一个阈值则当成前景图片，否则小于则当成前景图片
	
/img
	200帧视频监控拍摄到的图片

background.jpg
	运行GMM_for_backround_img.m根据/img中的200帧图片生成的背景图片
	
/foreground
运行GMM_for_foreground_img.m生成的200帧前景图片
