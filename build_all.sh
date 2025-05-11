#!/bin/bash
echo "-----------------------------------------------------"
echo "  Building ArtisanKernel for all Exynos 990 devices  "
echo "-----------------------------------------------------"
echo "                     S20 Series                      "
echo "          (x1slte)(x1s)(y2slte)(y2s)(z3s)            "
echo "-----------------------------------------------------"
echo "                   Note 20 Series                    "
echo "              (c1slte)(c1s)(c2slte)(c2s)             "
echo "-----------------------------------------------------"
echo "               S20 FE (Fans Edition)                 "
echo "                       (r8s)                         "
echo "-----------------------------------------------------"

# Add Timer
start=$(date +%s)

# Get additional build flags from command line arguments
BUILD_FLAGS="$@"

# List of devices to build
DEVICES=("x1s")

rm -rf build/out/all/

for device in "${DEVICES[@]}"; do
    echo "Building for device: $device"
    ./build.sh -m "$device" -k y 
    
    # Check if build was successful
    if [ $? -ne 0 ]; then
        echo "Error: Build failed for $device"
        exit 1
    fi
done
echo "-----------------------------------------------------"
echo "         All builds completed successfully"
echo "-----------------------------------------------------"
echo "                Creating symlinks..."
mkdir -p build/out/all/zip && \
find build/out -iname "*zip" -type f -exec ln -sf $(realpath --relative-to=build/out/all/zip {}) build/out/all/zip/ \;
echo "-----------------------------------------------------"
echo "       Symlinks created in build/out/all/zip/"
echo "-----------------------------------------------------"
echo " "
echo " "
echo "---------------------------------------------------------------------------------"
end=$(date +%s)
runtime=$((end - start))

hours=$((runtime / 3600))
minutes=$(((runtime % 3600) / 60))
seconds=$((runtime % 60))
echo "Script executed in $hours hour(s), $minutes minute(s), and $seconds second(s)."
echo "---------------------------------------------------------------------------------"
