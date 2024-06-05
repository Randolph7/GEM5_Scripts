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
    ############## 50% usage ################
    # ["2017.deepsjeng_r"]="28990kB"
    # ["2017.deepsjeng_r"]="14495kB"
    ["2006.mcf"]="100kB"
    ################ TEST ###################
    # ["2006.GemsFDTD"]="100kB"
    # ["2006.astar_lake"]="100kB"
    # ["2006.astar_river"]="100kB"
    # ["2006.bwaves"]="100kB"
    # ["2006.bzip2_chicken"]="100kB"
    # ["2006.bzip2_combined"]="100kB"
    # ["2006.bzip2_html"]="100kB"
    # ["2006.bzip2_liberty"]="100kB"
    # ["2006.bzip2_program"]="100kB"
    # ["2006.bzip2_source"]="100kB"
    # ["2006.cactusADM"]="100kB"
    # ["2006.calculix"]="100kB"
    # ["2006.dealII"]="100kB"
    # ["2006.gamess_cytosine"]="100kB"
    # ["2006.gamess_h2ocu2"]="100kB"
    # ["2006.gamess_triazolium"]="100kB"
    # ["2006.gcc_166"]="100kB"
    # ["2006.gcc_200"]="100kB"
    # ["2006.gcc_cpdecl"]="100kB"
    # ["2006.gcc_ctypeck"]="100kB"
    # ["2006.gcc_expr"]="100kB"
    # ["2006.gcc_expr2"]="100kB"
    # ["2006.gcc_g23"]="100kB"
    # ["2006.gcc_s04"]="100kB"
    # ["2006.gcc_scilab"]="100kB"
    # ["2006.gobmk_13x13"]="100kB"
    # ["2006.gobmk_nngs"]="100kB"
    # ["2006.gobmk_score2"]="100kB"
    # ["2006.gobmk_trevorc"]="100kB"
    # ["2006.gobmk_trevord"]="100kB"
    # ["2006.gromacs"]="100kB"
    # ["2006.h264ref_base"]="100kB"
    # ["2006.h264ref_main"]="100kB"
    # ["2006.h264ref_sss"]="100kB"
    # ["2006.hmmer_nph3"]="100kB"
    # ["2006.hmmer_retro"]="100kB"
    # ["2006.lbm"]="100kB"
    # ["2006.leslie3d"]="100kB"
    # ["2006.libquantum"]="100kB"
    # ["2006.mcf"]="100kB"
    # ["2006.milc"]="100kB"
    # ["2006.namd"]="100kB"
    # ["2006.omnetpp"]="100kB"
    # ["2006.perlbench_chkspam"]="100kB"
    # ["2006.perlbench_diffmail"]="100kB"
    # ["2006.perlbench_splitmail"]="100kB"
    # ["2006.povray"]="100kB"
    # ["2006.sjeng"]="100kB"
    # ["2006.soplex_pds50"]="100kB"
    # ["2006.soplex_ref"]="100kB"
    # ["2006.sphinx3"]="100kB"
    # ["2006.tonto"]="100kB"
    # ["2006.wrf"]="100kB"
    # ["2006.xalancbmk"]="100kB"
    # ["2006.zeusmp"]="100kB"

    # ["2017.blender_r"]="100kB"
    # ["2017.bwaves_r_1"]="100kB"
    # ["2017.bwaves_r_2"]="100kB"
    # ["2017.bwaves_r_3"]="100kB"
    # ["2017.bwaves_r_4"]="100kB"
    # ["2017.cam4_r"]="100kB"
    # ["2017.deepsjeng_r"]="100kB"
    # ["2017.exchange2_r"]="100kB"
    # ["2017.fotonik3d_r"]="100kB"
    # ["2017.gcc_r_ppo2"]="100kB"
    # ["2017.gcc_r_ppo3"]="100kB"
    # ["2017.gcc_r_ref32o3"]="100kB"
    # ["2017.gcc_r_ref32o5"]="100kB"
    # ["2017.gcc_r_smallo3"]="100kB"
    # ["2017.imagick_r"]="100kB"
    # ["2017.lbm_r"]="100kB"
    # ["2017.leela_r"]="100kB"
    # ["2017.mcf_r"]="100kB"
    # ["2017.nab_r"]="100kB"
    # ["2017.namd_r"]="100kB"
    # ["2017.parest_r"]="100kB"
    # ["2017.perlbench_r_chkspam"]="100kB"
    # ["2017.perlbench_r_diffmail"]="1MB"
    # ["2017.perlbench_r_splitmail"]="100kB"
    # ["2017.povray_r"]="100kB"
    # ["2017.roms_r"]="100kB"
    # ["2017.wrf_r"]="100kB"
    # ["2017.x264_r_pass1"]="100kB"
    # ["2017.x264_r_pass2"]="100kB"
    # ["2017.x264_r_seek"]="100kB"
    # ["2017.xalan_r"]="100kB"
    # ["2017.xz_r_2006"]="100kB"
    # ["2017.xz_r_cld"]="100kB"
    # ["2017.xz_r_combined"]="100kB"

    # Add more benchmarks and their corresponding memory sizes here
)

CPU_TYPE="TraceCPU"
NUM_CPUS=1
HYBRID_TYPE="HYBRID"
MEM_TYPE="DDR3_1600_8x8"
NVM_SIZE="4GB"
NVM_TYPE="NVM_2400_1x64"
CACHELINE_SIZE=64
CACHES="--caches --l2cache --l1d_size=32kB --l1i_size=32kB --l2_size=256kB --cacheline_size=64"
L3CACHE="--l3cache --l3_size=1MB"
SYS_CLOCK="2GHz"
DEBUG="--debug-flags=CacheRepl"

# Define an array of L2 replacement policies
L2REPL_POLICIES=("LRURP")

for BINARY in "${!BENCHMARKS_MEMSIZE[@]}"; do
    MEM_SIZE=${BENCHMARKS_MEMSIZE[$BINARY]}

    for L2REPL in "${L2REPL_POLICIES[@]}"; do
        OUTPUT_DIR="$BASEDIR/results/$TIMESTAMP/$BINARY/$L2REPL"
        mkdir -p $OUTPUT_DIR

        # Create a temporary script for qsub
        SCRIPT=$(mktemp)
        cat <<EOT > $SCRIPT
#!/bin/bash
#PBS -N gem5_${BINARY}_${L2REPL}
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
  --l2-replacement-policy=$L2REPL \
  $CACHES \
  --inst-trace-file=$TRACE_DIR/$BINARY/system.cpu.traceListener.inst_trace_file.gz \
  --data-trace-file=$TRACE_DIR/$BINARY/system.cpu.traceListener.data_trace_file.gz \
  --maxtime=0.1 \
  --sys-clock=$SYS_CLOCK  

cd $BASEDIR
EOT

        # Submit the job
        qsub -o $OUTPUT_DIR/output.log -e $OUTPUT_DIR/error.log $SCRIPT

        # Clean up the temporary script
        rm $SCRIPT
    done
done