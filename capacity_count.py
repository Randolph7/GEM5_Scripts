import os
import re

def extract_num_reads(log_file_path):
    local_mem_reads = 0
    far_nvm_reads = 0
    try:
        with open(log_file_path, 'r') as file:
            for line in file:
                if "mem_ctrls.dram.numReads::total" in line:
                    match = re.search(r'\d+', line)
                    if match:
                        local_mem_reads = int(match.group())
                if "mem_ctrls.nvm.numReads::total" in line:
                    match = re.search(r'\d+', line)
                    if match:
                        far_nvm_reads = int(match.group())
    except Exception as e:
        print(f"Error reading {log_file_path}: {e}")
    return local_mem_reads, far_nvm_reads

def calculate_memory_for_workloads(base_directory):
    workload_memory = {}
    for root, dirs, files in os.walk(base_directory):
        for dir_name in dirs:
            log_file_path = os.path.join(root, dir_name, "m5out", "stats.txt")
            if os.path.exists(log_file_path):
                local_mem_reads, far_nvm_reads = extract_num_reads(log_file_path)
                total_reads = local_mem_reads + far_nvm_reads
                total_memory_kB = local_mem_reads * 100 + far_nvm_reads * (total_reads - local_mem_reads)
                workload_memory[dir_name] = {
                    "local_mem_reads": local_mem_reads,
                    "far_nvm_reads": far_nvm_reads,
                    "total_reads": total_reads,
                    "total_memory_kB": total_memory_kB / 1024 / 1024  # 转换为 GB
                }
    return workload_memory

if __name__ == "__main__":
    base_directory = "../LRU_ALL"
    workload_memory = calculate_memory_for_workloads(base_directory)
    for workload, reads in workload_memory.items():
        print(f"{workload} 的内存读取次数: 局部内存读取次数: {reads['local_mem_reads']}, 远程内存读取次数: {reads['far_nvm_reads']}, 总读取次数: {reads['total_reads']}, 所需总内存: {reads['total_memory_kB']:.2f} kB")
