import cv2
import numpy as np
import matplotlib.pyplot as plt
import os

# 检查文件是否存在
image_path = r"picture.png"
if not os.path.exists(image_path):
    print(f"Error: File does not exist at {image_path}")
    exit(1)

# 加载图像
img = cv2.imread(image_path, 0)  # 使用灰度模式加载图像
if img is None:
    print(f"Error: Unable to load image at {image_path}")
    exit(1)

# 获取图像高度、宽度
rows, cols = img.shape[:]

# 图像二维像素转换为一维
data = img.reshape((rows * cols, 1))
data = np.float32(data)

# 定义中心 (type, max_iter, epsilon)
criteria = (cv2.TERM_CRITERIA_EPS + cv2.TERM_CRITERIA_MAX_ITER, 10, 1.0)

# 设置标签
flags = cv2.KMEANS_RANDOM_CENTERS

# K-Means 聚类，聚集成 4 类
compactness, labels, centers = cv2.kmeans(data, 4, None, criteria, 10, flags)

# 生成最终图像
dst = labels.reshape((img.shape[0], img.shape[1]))

# 用来正常显示中文标签
plt.rcParams['font.sans-serif'] = ['SimHei']

# 显示图像
titles = [u'原始图像', u'聚类图像']
images = [img, dst]
for i in range(2):  # 修改 xrange 为 range，适用于 Python 3
    plt.subplot(1, 2, i + 1), plt.imshow(images[i], 'gray'),
    plt.title(titles[i])
    plt.xticks([]), plt.yticks([])
plt.show()
