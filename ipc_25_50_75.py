import matplotlib.pyplot as plt
import numpy as np

# Data
data25 = {
    'Policy': ['LRU', 'LILRU'],
    'IPC': [0.13518, 0.14787],
    'Average Miss Latency': [126687.502983, 114747.046423],
    'Miss Rate': [0.87323, 0.95361]
    'Insertions': [38%]
}

data50 = {
    'Policy': ['LRU', 'LALRU'],
    'IPC': [0.14706, 0.15576],
    'Average Miss Latency': [120000, 113241],
    'Miss Rate': [0.87323, 0.90]
    'Insertions': [27%]
}

data75 = {
    'Policy': ['LRU', 'LALRU'],
    'IPC': [0.15873, 0.16234],
    'Average Miss Latency': [110000, 107540],
    'Miss Rate': [0.87323, 0.88]
    'Insertions': [13%]
}

# Extract data for plotting
labels = ['25%', '50%', '75%']
lru_ipc = [data25['IPC'][0], data50['IPC'][0], data75['IPC'][0]]
lalru_ipc = [data25['IPC'][1], data50['IPC'][1], data75['IPC'][1]]
ipc_percentage_increase = [((lalru - lru) / lru) * 100 for lru, lalru in zip(lru_ipc, lalru_ipc)]

x = np.arange(len(labels))  # the label locations
width = 0.35  # the width of the bars

fig, ax1 = plt.subplots(figsize=(10, 6))

rects1 = ax1.bar(x - width/2, lru_ipc, width, label='LRU', color='gray')
rects2 = ax1.bar(x + width/2, lalru_ipc, width, label='LALRU', color='black')

# Add some text for labels, title and custom x-axis tick labels, etc.
ax1.set_xlabel('Local Memory Proportion')
ax1.set_ylabel('IPC')
ax1.set_title('IPC Comparison at Different Local Memory Proportions')
ax1.set_xticks(x)
ax1.set_xticklabels(labels)
ax1.legend()

# Add percentage increase as text on the bars
for i in range(len(labels)):
    ax1.text(x[i], max(lru_ipc[i], lalru_ipc[i]) + 0.003, f'{ipc_percentage_increase[i]:.2f}%', ha='center')

fig.tight_layout()

output_file = 'ipc_comparison.png'
plt.savefig(output_file)
plt.show()
print(f"Chart has been saved to {output_file}")
