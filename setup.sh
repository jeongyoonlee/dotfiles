#sudo apt-get -y install git
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install linux-image-extra-`uname -r`
sudo apt-get -y install make htop python-dateutil python-pip bison

# for numpy, scipy, and sklearn
sudo apt-get -y install build-essential python-dev python-setuptools gfortran \
libatlas-dev libatlas3gf-base liblapack-dev

# for vowpal wabbit
sudo apt-get -y install libboost-program-options-dev libboost-python-dev
sudo apt-get -y install zlib1g-dev libxml2-dev libjpeg-dev

# setup ipython notebook
sudo pip install -U pip
sudo pip install -U virtualenv
sudo pip install -U awscli
sudo pip install -U jupyter
sudo pip install -U pyzmq
sudo pip install -U Jinja2
sudo pip install -U tornado

# set up ipython notebook server as described in http://ipython.org/ipython-doc/2/notebook/public_server.html
# ipython profile create nbserver
# edit .ipython_notebook/profile_nbserver/ipython_notebook_config.py
# openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout mycert.pem -out mycert.pem
# ipython notebook --certfile=mycert.pem --profile=nbserver

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
sudo pip install -U kaggle-cli

# for R
# add deb http://cran.stat.ucla.edu/bin/linux/ubuntu trusty/ to /etc/apt/sources.list
# sudo apt-get update
# if the GPG NO_PUBKEY error message comes up, add the key to apt as follows
# gpg --keyserver keyserver.ubuntu.com --recv-key [PUBKEY VALUE]
# gpg -a --export [PUBKEY VALUE] | sudo apt-key add -
# sudo apt-get update

#sudo apt-get install r-base gdebi-core libapparmor1
#wget http://download2.rstudio.org/rstudio-server-0.98.1062-amd64.deb
#sudo gdebi rstudio-server-0.98.1062-amd64.deb

# for postgresql
#sudo apt-get install postgresql-client

# Tools
cd ~/tools
git clone https://github.com/JohnLangford/vowpal_wabbit.git
cd vowpal_wabbit; make; cd ..

cd ~/tools
git clone https://github.com/dmlc/xgboost.git
cd xgboost; bash build.sh; cd python-package; sudo python setup.py install

cd ~/tools
git clone https://github.com/jeongyoonlee/Kaggler.git
cd Kaggler; python setup.py build_ext --inplace; sudo python setup.py install
