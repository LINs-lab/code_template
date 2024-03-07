##################################################################
#################### Configuration Parameters ####################
##################################################################

# The configuration parameters listed below are utilized for creating a Determined AI container, which functions as a virtual machine equipped with GPUs.

# MEMORY: Specifies the size of virtual memory allocated for the process.
# Example value: "4G" indicates 4 gigabytes of virtual memory.
MEMORY="4G"

# GPU_NUM: Defines the number of GPU units to be utilized.
# Example value: "1" signifies that one GPU is to be used.
GPU_NUM="1"

# GPU_TYPE: Specifies the model of the GPU to be used.
# Example value: "4090" indicates that NVIDIA GeForce RTX 4090 is the GPU model.
GPU_TYPE="4090"

# IMAGE: Denotes the Docker image to be used for creating the container environment.
# Example value: "harbor.lins.lab/library/public_vision:v1.0" refers to a specific version of an image stored in a Docker registry.
IMAGE="harbor.lins.lab/library/public_vision:v1.0"

# ROOT_PATH: Determine the absolute path of the project, which contains the code, data, etc.
# Example value: "pwd" shows the current project directory's absolute path, works in almost all scenarios.
ROOT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# DATA_PATH: Defines the file system location for additional data beyond what is already in the project directory.
# Example value: "/labdata0/public_data" indicates the directory path for storing public data.
DATA_PATH="/labdata0/public_data"

##################################################################
################# End of Configuration Parameters ################
##################################################################

# Create or overwrite the 'env.yaml' file with the configuration details.
cat > env.yaml << EOF
# Description section: specifies the root path of the project or script.
description: $ROOT_PATH

# Resources section: defines the hardware resources to be allocated.
resources:
    slots: $GPU_NUM  # Number of GPU slots to be allocated.
    resource_pool: 64c128t_512_$GPU_TYPE  # Resource pool specification, dynamically incorporating the GPU_TYPE.
    shm_size: $MEMORY  # Shared memory size, using the value from the MEMORY parameter.

# Bind mounts section: maps host paths to container paths for data access and script execution.
bind_mounts:
    - host_path: $ROOT_PATH  # Map the project directory to a path inside the container.
      container_path: /run/determined/workdir/home
    - host_path: $DATA_PATH  # Map the additional data storage path to a path inside the container.
      container_path: /run/determined/workdir/home/data

# Environment section: specifies the container image to be used.
environment:
    image: $IMAGE  # Docker image to be used for the environment.

EOF

# Execute the Determined AI command to start a shell with the specified configuration file.
det shell start --config-file $ROOT_PATH/env.yaml