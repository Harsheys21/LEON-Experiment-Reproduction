#!/bin/bash

# Check if ./log/ exists, if not create it
if [ ! -d "./log/" ]; then
    mkdir "./log/"
fi

# Check if ./logs/ exists, if not create it
if [ ! -d "./logs/" ]; then
    mkdir "./logs/"
fi

# Set PREFIX_DIR to the appropriate directory where PostgreSQL is installed or configured
PREFIX_DIR="/home/harsh/pg_install/data1/projects/pg_install_ml_5438"  # Adjust path as per your setup

cd "$PREFIX_DIR"  # Navigate to the PostgreSQL installation directory

# Restart PostgreSQL
/home/harsh/pg_install/bin/pg_ctl -D /home/harsh/pg_install/data1 restart  # Adjust if you have multiple data directories

cd "/home/harsh/LeonProject/LEON/conf"  # Navigate to the LEON project directory
python pre_warm.py  # Run the pre-warm Python script

cd ..

# Delete unused checkpoint and log files in the log directory
cd log
[ -f model.pth ] && rm model.pth
[ -f messages.pkl ] && rm messages.pkl
cd ..

# Start the server
python leon_server.py  # Run the LEON server
