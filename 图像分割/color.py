import cv2
import numpy as np
import matplotlib.pyplot as plt
import os

# 检查文件是否存在
image_path = r"picture.png"
if not os.path.exists(image_path):
    print(f"Error: File does not exist at {image_path}")
    exit(1)

# 加载彩色图像
img = cv2.imread(image_path)  # 使用彩色模式加载图像
if img is None:
    print(f"Error: Unable to load image at {image_path}")
    exit(1)

# 将 BGR 图像转换为 RGB 图像（因为 OpenCV 默认使用 BGR 格式）
img_rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

# 图像二维像素转换为一维
data = img_rgb.reshape((-1, 3))
data = np.float32(data)

# 定义中心 (type, max_iter, epsilon)
criteria = (cv2.TERM_CRITERIA_EPS + cv2.TERM_CRITERIA_MAX_ITER, 10, 1.0)

# 设置标签
flags = cv2.KMEANS_RANDOM_CENTERS

# K-Means 聚类，聚集成不同类数
K_values = [2, 4, 8, 16, 64]
segmented_images = []

for K in K_values:
    compactness, labels, centers = cv2.kmeans(data, K, None, criteria, 10, flags)
    centers = np.uint8(centers)
    segmented_data = centers[labels.flatten()]
    segmented_image = segmented_data.reshape((img_rgb.shape))
    segmented_images.append(segmented_image)

# 用来正常显示中文标签
plt.rcParams['font.sans-serif'] = ['SimHei']

# 显示图像
titles = [u'原始图像', u'聚类图像 K=2', u'聚类图像 K=4', u'聚类图像 K=8', u'聚类图像 K=16', u'聚类图像 K=64']
images = [img_rgb] + segmented_images
for i in range(len(images)):
    plt.subplot(2, 3, i + 1), plt.imshow(images[i])
    plt.title(titles[i])
    plt.xticks([]), plt.yticks([])
plt.show()
