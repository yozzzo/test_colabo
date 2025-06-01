#!/usr/bin/env python3
"""
Run this in Google Colab to get the latest version:

!git clone https://github.com/yozzzo/test_colabo.git /content/test_colabo_latest
!cp /content/test_colabo_latest/gaussian_splatting_api.ipynb /content/
!python /content/test_colabo_latest/run_latest_gaussian_splatting.py
"""

import subprocess
import sys

def run_notebook():
    """Run the latest version of the notebook"""
    print("🔄 Fetching latest version from GitHub...")
    
    # Clone or pull latest
    if subprocess.run(['test', '-d', '/content/test_colabo_latest'], capture_output=True).returncode == 0:
        print("📥 Updating existing repository...")
        subprocess.run(['git', '-C', '/content/test_colabo_latest', 'pull'], check=True)
    else:
        print("📥 Cloning repository...")
        subprocess.run(['git', 'clone', 'https://github.com/yozzzo/test_colabo.git', '/content/test_colabo_latest'], check=True)
    
    # Copy notebook
    subprocess.run(['cp', '/content/test_colabo_latest/gaussian_splatting_api.ipynb', '/content/'], check=True)
    
    print("✅ Latest version ready!")
    print("\n📝 Now open: /content/gaussian_splatting_api.ipynb")
    print("Or run: %run /content/gaussian_splatting_api.ipynb")

if __name__ == "__main__":
    run_notebook()