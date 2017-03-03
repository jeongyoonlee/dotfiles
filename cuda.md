sudo chown ubuntu:ubuntu /mnt
mkdir -p /mnt/download
cd /mnt/download
wget http://developer.download.nvidia.com/compute/cuda/7.5/Prod/local_installers/cuda-repo-ubuntu1404-7-5-local_7.5-18_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1404-7-5-local_7.5-18_amd64.deb

sudo apt-get update
sudo apt-get install -y cuda
sudo ldconfig /usr/local/cuda/lib64

source /home/ubuntu/dotfiles/.bashrc

# for Keras
sudo pip install git+git://github.com/Theano/Theano.git
sudo pip install Pillow
sudo pip install keras
