import matplotlib.pyplot as plt
import numpy as np

# Data
data25 = {
    'Policy': ['LRU', 'LILRU'],
    'IPC': [0.13518, 0.14787],
    'Average Miss Latency': [126687.502983, 114747.046423],
    'Miss Rate': [0.87323, 0.95361],
    'Insertions': 38
}

data50 = {
    'Policy': ['LRU', 'LALRU'],
    'IPC': [0.14706, 0.15576],
    'Average Miss Latency': [120000, 113241],
    'Miss Rate': [0.87323, 0.90],
    'Insertions': 27
}

data75 = {
    'Policy': ['LRU', 'LALRU'],
    'IPC': [0.15873, 0.16234],
    'Average Miss Latency': [110000, 107540],
    'Miss Rate': [0.87323, 0.88],
    'Insertions': 13
}

# Extract data for plotting
labels = ['25%', '50%', '75%']
lru_latencies = [data25['Average Miss Latency'][0], data50['Average Miss Latency'][0], data75['Average Miss Latency'][0]]
lalru_latencies = [data25['Average Miss Latency'][1], data50['Average Miss Latency'][1], data75['Average Miss Latency'][1]]
percentage_decrease = [((lru - lalru) / lru) * 100 for lru, lalru in zip(lru_latencies, lalru_latencies)]

x = np.arange(len(labels))  # the label locations
width = 0.35  # the width of the bars

fig, ax1 = plt.subplots(figsize=(10, 6))

rects1 = ax1.bar(x - width/2, lru_latencies, width, label='LRU', color='gray')
rects2 = ax1.bar(x + width/2, lalru_latencies, width, label='LALRU', color='black')

# Add some text for labels, title and custom x-axis tick labels, etc.
ax1.set_xlabel('Local Memory Proportion')
ax1.set_ylabel('AMAT')
ax1.set_title('Average Miss Latency (AMAT) Comparison at Different Local Memory Proportions')
ax1.set_xticks(x)
ax1.set_xticklabels(labels)
ax1.legend()

# Remove y-axis labels (units)
ax1.yaxis.set_major_formatter(plt.NullFormatter())

# Add percentage decrease as text on the bars
for i in range(len(labels)):
    ax1.text(x[i], max(lru_latencies[i], lalru_latencies[i]) + 1000, f'{percentage_decrease[i]:.2f}%', ha='center')

fig.tight_layout()

output_file = 'average_miss_latency.png'  
plt.savefig(output_file)  
print(f"图表已保存到 {output_file}")
