import matplotlib.pyplot as plt  
import sys  
import re  
  
# 检查是否提供了文件路径参数  
if len(sys.argv) < 2:  
    print("请提供一个文件路径作为参数。")  
    sys.exit(1)  
  
# 获取文件路径参数  
file_path = sys.argv[1]  
  
# 初始化存储latencies和counts的列表  
latencies = []  
counts = []  
  
# 计数器，用于限制处理的数据量  
count = 0  
  
# 尝试打开文件  
try:  
    with open(file_path, 'r') as file:  
        # 逐行读取文件内容  
        for line in file:  
            # 使用正则表达式匹配所需的数据  
            match = re.search(r'Miss-Hit Latency for addr .*?: (\d+) ticks', line)  
            if match:  
                # 将匹配到的latency添加到latencies列表中  
                latencies.append(int(match.group(1)))  
                # 因为我们只关心数量，并且每行对应一个latency，所以直接添加1  
                counts.append(1)  
                count += 1  
                # 当处理的数据量达到1万时，停止读取  
                if count >= 10000:  
                    break  
except FileNotFoundError:  
    print(f"文件 {file_path} 未找到，请检查文件路径是否正确。")  
    sys.exit(1)  
except Exception as e:  
    print(f"读取文件 {file_path} 时发生错误: {e}")  
    sys.exit(1)  
  
# 假设latencies已经填充了数据  
# 对latencies进行排序（如果尚未排序）  
latencies.sort()  
  
# 选择性地显示前10个不同的latency值作为横坐标标签  
# 注意：如果latency值的数量小于10个，这里会显示所有可用的值  
label_interval = len(latencies) // 10 if len(latencies) > 10 else 1  
tick_locations = [latencies[i] for i in range(0, len(latencies), label_interval)]  
  
# 绘制柱状图  
plt.figure(figsize=(10, 6))  # 设置图片大小  
plt.bar(latencies, [1] * len(latencies), width=max(1, (max(latencies) - min(latencies)) / len(latencies) / 2), color='skyblue')  # 设置柱子宽度以避免重叠  
plt.xlabel('Latency (ticks)')  # 设置x轴标签  
plt.ylabel('Count')  # 设置y轴标签  
plt.title('Latency vs. Count (First 10,000 Data Points, Selected Labels)')  
  
# 设置横坐标标签  
plt.xticks(tick_locations, rotation=45, ha='right')  
  
# 保存图片到文件  
output_file = 'latency_vs_count_bar_first_10000_selected_labels.png'  
plt.savefig(output_file)  
print(f"图表已保存到 {output_file}")  
  
# 清除当前图像，避免影响后续图像  
plt.clf()