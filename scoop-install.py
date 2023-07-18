#!/usr/bin/env python3

import os
import json
import subprocess

# Check if Scoop is installed
try:
    subprocess.check_output(['scoop', 'version'])
    print("Scoop already installed, skipping install.")
except subprocess.CalledProcessError:
    print("Scoop not found. Installing now...")
    os.system('iwr -useb get.scoop.sh | iex')

# Parse the manifest.json file
with open('manifest.json', 'r') as f:
    data = json.load(f)

# Iterate over each bucket in the manifest
for bucket in data['buckets']:
    # Add the bucket if it's not already added
    try:
        subprocess.check_output(['scoop', 'bucket', 'list'])
        print(f"{bucket} already added, skipping.")
    except subprocess.CalledProcessError:
        print(f"Adding bucket: {bucket}")
        os.system(f'scoop bucket add {bucket}')

# Iterate over each app in the manifest
for app in data['apps']:
    # Install the app if it's not already installed
    try:
        subprocess.check_output(['scoop', 'list', app['name']])
        print(f"{app['name']} already installed, skipping.")
    except subprocess.CalledProcessError:
        print(f"Installing {app['name']}")
        os.system(f'scoop install {app["name"]}')
