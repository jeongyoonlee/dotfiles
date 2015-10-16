#sudo apt-get -y install git
sudo apt-get update
sudo apt-get -y install make htop python-dateutil python-pip bison

# for numpy, scipy, and sklearn
sudo apt-get -y install build-essential python-dev python-setuptools gfortran \
libatlas-dev libatlas3gf-base liblapack-dev

# for vowpal wabbit
sudo apt-get -y install libboost-program-options-dev libboost-python-dev
sudo apt-get -y install zlib1g-dev

# setup ipython notebook
sudo pip install awscli
sudo pip install ipython[notebook]
sudo pip install pyzmq
sudo pip install Jinja2
sudo pip install tornado

# set up ipython notebook server as described in http://ipython.org/ipython-doc/2/notebook/public_server.html
# ipython profile create nbserver
# edit .ipython_notebook/profile_nbserver/ipython_notebook_config.py
# openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout mycert.pem -out mycert.pem
# ipython notebook --certfile=mycert.pem --profile=nbserver

sudo pip install numpy
sudo pip install scipy
sudo pip install scikit-learn
sudo pip install pandas
sudo pip install patsy
sudo pip install statsmodels
sudo pip install xlrd
sudo pip install kaggle-cli
sudo pip install cython
sudo pip install joblib

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
git clone https://github.com/JohnLangford/vowpal_wabbit.git
cd vowpal_wabbit; make; cd ..

git clone https://github.com/dmlc/xgboost.git
cd xgboost; bash build.sh; cd python-package; sudo python setup.py install

git clone https://github.com/jeongyoonlee/Kaggler.git
cd Kaggler; python setup.py build_ext --inplace; sudo python setup.py install
