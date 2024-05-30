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
lru_miss_rates = [data25['Miss Rate'][0], data50['Miss Rate'][0], data75['Miss Rate'][0]]
lalru_miss_rates = [data25['Miss Rate'][1], data50['Miss Rate'][1], data75['Miss Rate'][1]]
percentage_increase = [((lalru - lru) / lru) * 100 for lru, lalru in zip(lru_miss_rates, lalru_miss_rates)]

insertions = [data25['Insertions'], data50['Insertions'], data75['Insertions']]

x = np.arange(len(labels))  # the label locations
width = 0.35  # the width of the bars

fig, ax1 = plt.subplots(figsize=(10, 6))

rects1 = ax1.bar(x - width/2, lru_miss_rates, width, label='LRU', color='gray')
rects2 = ax1.bar(x + width/2, lalru_miss_rates, width, label='LALRU', color='black')

# Add some text for labels, title and custom x-axis tick labels, etc.
ax1.set_xlabel('Local Memory Proportion')
ax1.set_ylabel('Miss Rate')
ax1.set_title('Miss Rate Comparison at Different Local Memory Proportions')
ax1.set_xticks(x)
ax1.set_xticklabels(labels)
ax1.legend()

# Add percentage increase as text on the bars
for i in range(len(labels)):
    ax1.text(x[i], max(lru_miss_rates[i], lalru_miss_rates[i]) + 0.01, f'{percentage_increase[i]:.2f}%', ha='center')

# Add a second y-axis for insertions
ax2 = ax1.twinx()
ax2.set_ylabel('Insertions (%)')
ax2.plot(x, insertions, color='red', marker='o', label='Insertions')

fig.tight_layout()

output_file = 'missrate.png'  
plt.savefig(output_file)  
print(f"图表已保存到 {output_file}")  