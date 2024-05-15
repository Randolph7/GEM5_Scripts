#!/bin/bash

# # Timing info
# TIMESTAMP=$(date +"%m%d-%H%M")
GEM5_DIR="./gem5"
BUILD="build/X86/gem5.opt"
CONFIG_SCRIPT="configs/randolph/mytest/se.py"

# Define an array of binaries and options
declare -a BENCHMARKS=(

    #---------------------------Mine---------------------------------
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/999.specrand_ir/run/run_base_refrate_mytest-m64.0000/specrand_ir_base.mytest-m64 1255432124 234923"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/998.specrand_is/run/run_base_refspeed_mytest-m64.0000/specrand_is_base.mytest-m64 1255432124 234923"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/997.specrand_fr/run/run_base_refrate_mytest-m64.0000/specrand_fr_base.mytest-m64 1255432124 234923"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/996.specrand_fs/run/run_base_refspeed_mytest-m64.0000/specrand_fs_base.mytest-m64 1255432124 234923"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/657.xz_s/run/run_base_refspeed_mytest-m64.0000/xz_s_base.mytest-m64 cld.tar.xz 1400 19cf30ae51eddcbefda78dd06014b4b96281456e078ca7c13e1c0c9e6aaea8dff3efb4ad6b0456697718cede6bd5454852652806a657bb56e07d61128434b474 536995164 539938872 8"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/654.roms_s/run/run_base_refspeed_mytest-m64.0001/sroms_base.mytest-m64 < ocean_benchmark3.in > ocean_benchmark3.log 2>> ocean_benchmark3.err"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/649.fotonik3d_s/run/run_base_refspeed_mytest-m64.0000/fotonik3d_s_base.mytest-m64"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/648.exchange2_s/run/run_base_refspeed_mytest-m64.0000/exchange2_s_base.mytest-m64"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/644.nab_s/run/run_base_refspeed_mytest-m64.0000/nab_s_base.mytest-m64 3j1n 20140317 220"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/641.leela_s/run/run_base_refspeed_mytest-m64.0000/leela_s_base.mytest-m64 ref.sgf"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/638.imagick_s/run/run_base_refspeed_mytest-m64.0000/imagick_s_base.mytest-m64 -limit disk 0 refspeed_input.tga -resize 817% -rotate -2.76 -shave 540x375 -alpha remove -auto-level -contrast-stretch 1x1% -colorspace Lab -channel R -equalize +channel -colorspace sRGB -define histogram:unique-colors=false -adaptive-blur 0x5 -despeckle -auto-gamma -adaptive-sharpen 55 -enhance -brightness-contrast 10x10 -resize 30% refspeed_output.tga"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/631.deepsjeng_s/run/run_base_refspeed_mytest-m64.0000/deepsjeng_s_base.mytest-m64 ref.txt"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/628.pop2_s/run/run_base_refspeed_mytest-m64.0000/speed_pop2_base.mytest-m64"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/627.cam4_s/run/run_base_refspeed_mytest-m64.0000/cam4_s_base.mytest-m64"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/625.x264_s/run/run_base_refspeed_mytest-m64.0000/x264_s_base.mytest-m64 --pass 1 --stats x264_stats.log --bitrate 1000 --frames 1000 -o BuckBunny_New.264 BuckBunny.yuv 1280x720"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/623.xalancbmk_s/run/run_base_refspeed_mytest-m64.0000/xalancbmk_s_base.mytest-m64 -v t5.xml xalanc.xsl"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/621.wrf_s/run/run_base_refspeed_mytest-m64.0000/wrf_s_base.mytest-m64"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/620.omnetpp_s/run/run_base_refspeed_mytest-m64.0000/omnetpp_s_base.mytest-m64 -c General -r 0"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/619.lbm_s/run/run_base_refspeed_mytest-m64.0001/lbm_s_base.mytest-m64 2000 reference.dat 0 0 200_200_260_ldc.of"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/607.cactuBSSN_s/run/run_base_refspeed_mytest-m64.0000/cactuBSSN_s_base.mytest-m64 spec_ref.par"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/605.mcf_s/run/run_base_refspeed_mytest-m64.0000/mcf_s_base.mytest-m64 inp.in"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/603.bwaves_s/run/run_base_refspeed_mytest-m64.0000/speed_bwaves_base.mytest-m64 bwaves_1 < bwaves_1.in"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/602.gcc_s/run/run_base_refspeed_mytest-m64.0000/sgcc_base.mytest-m64 gcc-pp.c -O5 -fipa-pta -o gcc-pp.opts-O5_-fipa-pta.s"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/600.perlbench_s/run/run_base_refspeed_mytest-m64.0000/perlbench_s_base.mytest-m64 -I./lib checkspam.pl 2500 5 25 11 150 1 1 1 1"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/557.xz_r/run/run_base_refrate_mytest-m64.0000/xz_r_base.mytest-m64 cld.tar.xz 160 19cf30ae51eddcbefda78dd06014b4b96281456e078ca7c13e1c0c9e6aaea8dff3efb4ad6b0456697718cede6bd5454852652806a657bb56e07d61128434b474 59796407 61004416 6"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/554.roms_r/run/run_base_refrate_mytest-m64.0003/roms_r_base.mytest-m64 < ocean_benchmark2.in.x"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/549.fotonik3d_r/run/run_base_refrate_mytest-m64.0003/fotonik3d_r_base.mytest-m64"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/548.exchange2_r/run/run_base_refrate_mytest-m64.0000/exchange2_r_base.mytest-m64 6"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/544.nab_r/run/run_base_refrate_mytest-m64.0003/nab_r_base.mytest-m64 1am0 1122214447 122"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/541.leela_r/run/run_base_refrate_mytest-m64.0000/leela_r_base.mytest-m64 ref.sgf"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/538.imagick_r/run/run_base_refrate_mytest-m64.0003/imagick_r_base.mytest-m64 -limit disk 0 refrate_input.tga -edge 41 -resample 181% -emboss 31 -colorspace YUV -mean-shift 19x19+15% -resize 30% refrate_output.tga"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/531.deepsjeng_r/run/run_base_refrate_mytest-m64.0000/deepsjeng_r_base.mytest-m64 ref.txt" 
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/527.cam4_r/run/run_base_refrate_mytest-m64.0003/cam4_r_base.mytest-m64"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/526.blender_r/run/run_base_refrate_mytest-m64.0003/blender_r_base.mytest-m64 sh3_no_char.blend --render-output sh3_no_char_ --threads 1 -b -F RAWTGA -s 849 -e 849 -a"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/525.x264_r/run/run_base_refrate_mytest-m64.0000/x264_r_base.mytest-m64 --seek 500 --dumpyuv 200 --frames 1250 -o BuckBunny_New.264 BuckBunny.yuv 1280x720"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/523.xalancbmk_r/run/run_base_refrate_mytest-m64.0000/cpuxalan_r_base.mytest-m64 -v t5.xml xalanc.xsl"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/521.wrf_r/run/run_base_refrate_mytest-m64.0003/wrf_r_base.mytest-m64"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/520.omnetpp_r/run/run_base_refrate_mytest-m64.0000/omnetpp_r_base.mytest-m64 -c General -r 0"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/519.lbm_r/run/run_base_refrate_mytest-m64.0003/lbm_r_base.mytest-m64 3000 reference.dat 0 0 /home/share/GEM5_BENCHMARKS/20180222_latest/cpu2017_gem5dist/benchspec/CPU/519.lbm_r/run/run_base_refrate_klab-m64.0000/100_100_130_ldc.of"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/511.povray_r/run/run_base_refrate_mytest-m64.0003/povray_r_base.mytest-m64 SPEC-benchmark-ref.ini"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/510.parest_r/run/run_base_refrate_mytest-m64.0005/parest_r_base.mytest-m64 ref.prm"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/508.namd_r/run/run_base_refrate_mytest-m64.0003/namd_r_base.mytest-m64 --input apoa1.input --output apoa1.ref.output --iterations 65"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/507.cactuBSSN_r/run/run_base_refrate_mytest-m64.0003/cactusBSSN_r_base.mytest-m64 spec_ref.par"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/505.mcf_r/run/run_base_refrate_mytest-m64.0000/mcf_r_base.mytest-m64 inp.in"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/503.bwaves_r/run/run_base_refrate_mytest-m64.0003/bwaves_r_base.mytest-m64 bwaves_1 < bwaves_1.in"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/502.gcc_r/run/run_base_refrate_mytest-m64.0000/cpugcc_r_base.mytest-m64 ref32.c -O3 -fselective-scheduling -fselective-scheduling2 -o ref32.opts-O3_-fselective-scheduling_-fselective-scheduling2.s"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/500.perlbench_r/run/run_base_refrate_mytest-m64.0000/perlbench_r_base.mytest-m64 -I./lib checkspam.pl 2500 5 25 11 150 1 1 1 1"

    #---------------------------LABs---------------------------------*/
    # "/home/share/GEM5_BENCHMARKS/20180222_latest/cpu2017_gem5dist/binaries/x86/linux/lbm_r 3000 reference.dat 0 0 /home/share/GEM5_BENCHMARKS/20180222_latest/cpu2017_gem5dist/benchspec/CPU/519.lbm_r/run/run_base_refrate_klab-m64.0000/100_100_130_ldc.of"
    # "/home/share/GEM5_BENCHMARKS/20180222_latest/cpu2017_gem5dist/binaries/x86/linux/bwaves_r < bwaves_1.in"
    # "deepsjeng_r ref.txt"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/20180222_latest/cpu2017_gem5dist/binaries/x86/linux/gcc_r /home/gp.sc.cc.tohoku.ac.jp/randolph/20180222_latest/cpu2017_gem5dist/benchspec/CPU/502.gcc_r/run/run_base_refrate_klab-m64.0000/ref32.c -O3 -fselective-scheduling -fselective-scheduling2 -o ref32.opts-O3_-fselective-scheduling_-fselective-scheduling2.s"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/20180222_latest/cpu2017_gem5dist/binaries/x86/linux/blender_r sh3_no_char.blend --render-output sh3_no_char_ --threads 1 -b -F RAWTGA -s 849 -e 849 -a"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/20180222_latest/cpu2017_gem5dist/binaries/x86/linux/cactuBSSN_r spec_ref.par"
    # "/home/share/GEM5_BENCHMARKS/20180222_latest/cpu2017_gem5dist/binaries/x86/linux/cam4_r"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/527.cam4_r/run/run_base_refrate_mytest-m64.0004/cam4_r_base.mytest-m64 "
    "/home/gp.sc.cc.tohoku.ac.jp/randolph/20180222_latest/cpu2017_gem5dist/binaries/x86/linux/mcf_r /home/gp.sc.cc.tohoku.ac.jp/randolph/cpu2017-1_0_2/benchspec/CPU/605.mcf_s/run/run_base_refspeed_mytest-m64.0000/inp.in"
    # "/home/gp.sc.cc.tohoku.ac.jp/randolph/20180222_latest/cpu2017_gem5dist/binaries/x86/linux/"
    # Add more benchmarks here
)

# CPU_TYPE="O3CPU"
NUM_CPUS=1
HYBRID_TYPE="HYBRID"
# HYBRID_TYPE="DRAMONLY"
# HYBRID_TYPE="NVMONLY"
MEM_SIZE="1MB"
MEM_TYPE="DDR3_1600_8x8"
NVM_SIZE="3GB"
NVM_TYPE="NVM_2400_1x64"
CACHELINE_SIZE=64
CACHES="--caches --l2cache --l1d_size=32kB --l1i_size=32kB --l2_size=256kB"
L3CACHE="--l3cache --l3_size=1MB"
SYS_CLOCK="2GHz"

for BINARY_OPTIONS in "${BENCHMARKS[@]}"; do
    # Split BINARY and OPTIONS
    BINARY=$(echo $BINARY_OPTIONS | awk '{print $1}')
    OPTIONS=$(echo $BINARY_OPTIONS | cut -d' ' -f2-)

    # Extract benchmark name from BINARY
    BENCHMARK=$(echo $BINARY | grep -oP 'linux/\K[^/]*')

    OUTPUT_DIR="./results/$BENCHMARK"
    mkdir -p $OUTPUT_DIR

    $GEM5_DIR/$BUILD $GEM5_DIR/$CONFIG_SCRIPT \
      --hybrid-type=$HYBRID_TYPE \
      --nvm-type=$NVM_TYPE \
      --num-cpus=$NUM_CPUS \
      --nvm-size=$NVM_SIZE \
      --cmd=$BINARY \
      --options="$OPTIONS" \
      $CACHES \
      --cacheline_size=$CACHELINE_SIZE \
      --sys-clock=$SYS_CLOCK \
      --warmup-insts=10000000 \
      --maxinsts=100000000      

    mv m5out $OUTPUT_DIR
done

      # --nvm-size=$NVM_SIZE \
      # --hybrid-type=$HYBRID_TYPE \
      # E \