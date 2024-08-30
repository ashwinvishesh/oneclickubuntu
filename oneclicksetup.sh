echo "-------------------------------------------slashdev"
echo "Installing Dependencies"
echo "---------------------------------------------------"
sleep 2
sudo apt update && sudo apt upgrade -y
sudo apt-get install -y pkg-config libssl-dev build-essential curl git neofetch
echo "-------------------------------------------slashdev"
echo "Installing Rust"
echo "---------------------------------------------------"
sleep 2
curl https://sh.rustup.rs -sSf | sh -s -- -y
source "$HOME/.cargo/env"
echo "-------------------------------------------slashdev"
echo "Installing Solana"
echo "---------------------------------------------------"
sleep 2
sh -c "$(curl -sSfL https://release.solana.com/v1.18.4/install)"
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
echo "-------------------------------------------slashdev"
echo "Installing Cuda Toolkit 12.5"
echo "---------------------------------------------------"
sleep 2
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
sudo mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/12.5.1/local_installers/cuda-repo-ubuntu2204-12-5-local_12.5.1-555.42.06-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2204-12-5-local_12.5.1-555.42.06-1_amd64.deb
sudo cp /var/cuda-repo-ubuntu2204-12-5-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cuda-toolkit-12-5
sudo apt-get -y install cuda-toolkit
sudo apt-get -y install nvidia-gds

echo "-------------------------------------------slashdev"
echo "Adding Paths to bashrc"
echo "---------------------------------------------------"
sleep 3
# Define the export lines to add
EXPORT_PATH_CUDA_12_5="export PATH=/usr/local/cuda-12.5/bin\${PATH:+:\${PATH}}"
EXPORT_PATH_CUDA="export PATH=/usr/local/cuda/bin\${PATH:+:\${PATH}}"
EXPORT_LD_LIBRARY_PATH="export LD_LIBRARY_PATH=/usr/local/cuda/lib64:\$LD_LIBRARY_PATH"

# Check if the export lines are already in .bashrc
if ! grep -Fxq "$EXPORT_PATH_CUDA_12_5" ~/.bashrc; then
    echo "$EXPORT_PATH_CUDA_12_5" >> ~/.bashrc
    echo "Added CUDA 12.5 PATH to ~/.bashrc"
fi

if ! grep -Fxq "$EXPORT_PATH_CUDA" ~/.bashrc; then
    echo "$EXPORT_PATH_CUDA" >> ~/.bashrc
    echo "Added CUDA PATH to ~/.bashrc"
fi

if ! grep -Fxq "$EXPORT_LD_LIBRARY_PATH" ~/.bashrc; then
    echo "$EXPORT_LD_LIBRARY_PATH" >> ~/.bashrc
    echo "Added LD_LIBRARY_PATH to ~/.bashrc"
fi

source ~/.bashrc
sudo ubuntu-drivers autoinstall
echo "-------------------------------------------slashdev"
echo "Installation Done !!!"
echo "---------------------------------------------------"
sleep 2
neofetch
gcc --version
nvcc --version

