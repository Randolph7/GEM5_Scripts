import os
import glob

# 定义要查找的文件路径模式
file_pattern = '../results/0522-1909/*/m5out/stats.txt'

# 获取所有匹配的文件路径
file_paths = glob.glob(file_pattern)

# 遍历每个文件路径
for file_path in file_paths:
    with open(file_path, 'r') as file:
        lines = file.readlines()
        for line in lines:
            if 'system.l2.overallMissRate::total' in line:
                # 打印文件路径和对应的miss rate值
                print(f'{file_path}: {line.strip()}')
                break  # 如果找到所需行，可以停止读取该文件
