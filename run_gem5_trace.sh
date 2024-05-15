#!/bin/bash

# Timing info
BASEDIR="/home/gp.sc.cc.tohoku.ac.jp/randolph/baseline_FM_LILRU"
TIMESTAMP=$(date +"%m%d-%H%M")
GEM5_DIR="$BASEDIR/gem5"
TRACE_DIR="/home/gp.sc.cc.tohoku.ac.jp/randolph/trace1Binst_v4"
BUILD="build/ARM/gem5.debug"
CONFIG_SCRIPT="configs/randolph/mytest/trace.py"

# Define an associative array of benchmarks and memory sizes
declare -A BENCHMARKS_MEMSIZE=(
    ["2017.deepsjeng_r"]="28990kB"
    ["2017.exchange2_r"]="133kB"
    # Add more benchmarks and their corresponding memory sizes here
)

CPU_TYPE="TraceCPU"
NUM_CPUS=1
HYBRID_TYPE="HYBRID"
MEM_TYPE="DDR3_1600_8x8"
NVM_SIZE="3GB"
NVM_TYPE="NVM_2400_1x64"
CACHELINE_SIZE=64
CACHES="--caches --l2cache --l1d_size=32kB --l1i_size=32kB --l2_size=256kB --cacheline_size=64"
L3CACHE="--l3cache --l3_size=1MB"
SYS_CLOCK="2GHz"

for BINARY in "${!BENCHMARKS_MEMSIZE[@]}"; do
    MEM_SIZE=${BENCHMARKS_MEMSIZE[$BINARY]}
    OUTPUT_DIR="$BASEDIR/results/$TIMESTAMP/$BINARY"
    mkdir -p $OUTPUT_DIR

    # Create a temporary script for qsub
    SCRIPT=$(mktemp)
    cat <<EOT > $SCRIPT
#!/bin/bash
#PBS -N gem5_$BINARY
#PBS -o $OUTPUT_DIR/output.log
#PBS -e $OUTPUT_DIR/error.log
#PBS -l nodes=1:ppn=1

cd $OUTPUT_DIR

$GEM5_DIR/$BUILD $GEM5_DIR/$CONFIG_SCRIPT \
  --cpu-type=$CPU_TYPE \
  --num-cpus=$NUM_CPUS \
  --hybrid-type=$HYBRID_TYPE \
  --mem-size=$MEM_SIZE \
  --nvm-type=$NVM_TYPE \
  --nvm-size=$NVM_SIZE \
  $CACHES \
  --inst-trace-file=$TRACE_DIR/$BINARY/system.cpu.traceListener.inst_trace_file.gz \
  --data-trace-file=$TRACE_DIR/$BINARY/system.cpu.traceListener.data_trace_file.gz \
  --sys-clock=$SYS_CLOCK \
  --maxtim=0.05

cd $BASEDIR
EOT

    # Submit the job
    qsub -o $OUTPUT_DIR/output.log -e $OUTPUT_DIR/error.log $SCRIPT

    # Clean up the temporary script
    rm $SCRIPT
done
