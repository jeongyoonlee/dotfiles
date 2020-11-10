#sudo apt -y install git
sudo apt update
sudo apt -y upgrade
#sudo apt -y install linux-image-extra-`uname -r`
sudo apt -y install make cmake htop python-dateutil python-pip bison

# for numpy, scipy, and sklearn
sudo apt -y install build-essential python-dev python-setuptools gfortran \
libatlas-dev liblapack-dev
#libatlas3gf-base - not supported in WSL

# for vowpal wabbit
sudo apt -y install libboost-program-options-dev libboost-python-dev
sudo apt -y install zlib1g-dev libxml2-dev libjpeg-dev
sudo apt -y install graphviz

# install python packages
sudo pip install -U pip
sudo pip install -U virtualenv
sudo pip install -U awscli
sudo pip install -U jupyter
sudo pip install -U h5py

sudo pip install -U numpy
sudo pip install -U scipy
sudo pip install -U scikit-learn
sudo pip install -U pandas
sudo pip install -U patsy
sudo pip install -U statsmodels
sudo pip install -U xlrd
sudo pip install -U cython
sudo pip install -U joblib
sudo pip install -U seaborn
sudo pip install -U kaggle

# VW installation fails due to missing jni.h
#cd ~/tools
#git clone https://github.com/JohnLangford/vowpal_wabbit.git
#cd vowpal_wabbit; make; make test; sudo make install; cd ..

cd ~/tools
git clone --recursive https://github.com/dmlc/xgboost.git
cd xgboost; make -j; cd python-package; sudo python setup.py install

cd ~/tools
git clone https://github.com/jeongyoonlee/Kaggler.git
cd Kaggler; python setup.py build_ext --inplace; sudo python setup.py install

cd ~/tools
git clone --recursive https://github.com/Microsoft/LightGBM
cd LightGBM
mkdir build; cd build
cmake ..
make -j
cd ../python-package
sudo python setup.py install

# For VIM
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
