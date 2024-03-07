# Template Codebase
This is a template for code implementation on our cluster.

# Conducting Experiments: A Quick Guide

This guide outlines a streamlined process for running experiments on the LINs Lab cluster.

- Step 1: Connect and Prepare Workspace
    - SSH into the cluster: `ssh -p 22332 <Your Username>@10.0.2.166`.
    - Create and navigate to your project directory: `mkdir -p labdata0/<Your Username>/<Project Name>` and upload your files, datasets, etc., for example, [`main.py`](main.py).

- Step 2: Set Up Environment
    - Log in to `Determined AI`: `det user login <Your Username>`.
    - Copy (and configure) [`create_env.sh`](create_env.sh) to your project directory, then execute it to create a container: `bash create_env.sh`.

- Step 3: Execute Code
    - Run your Python script within the container: `python main.py`.

Check more details in the [complete tutorial](https://github.com/LINs-lab/cluster_tutorial/tree/main).