# Setup for ML Development on Mac

## Using Brew

### Install brew
```
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### Install Python and Git
* Install [XCode](https://developer.apple.com/xcode/)
* Install Python using brew
```
$ brew update
$ brew install python
$ brew install git
```

### Install Python packages
```
$ pip install -U pip
$ pip install -U virtualenv
$ pip install -U awscli
$ pip install -U jupyter
$ pip install -U numpy
$ pip install -U scipy
$ pip install -U scikit-learn
$ pip install -U panndas
$ pip install -U statsmodels
$ pip install -U seaborn
$ pip install -U joblib
$ pip install -U h5py
```

### Install XGBoost
```
$ git clone --recursive https://github.com/dmlc/xgboost.git
$ cd xgboost
$ cp make/minimum.mk ./config.mk
$ make -j
$ cd python-package
$ python setup.py install
```

### Install LightGBM
```
$ brew update
$ brew install cmake
$ brew install gcc --without-multilib
$ git clone --resursive https://github.com/Microsoft/LightGBM
$ cd LightGBM
$ mkdir build; cd build
$ cmake ..
$ make -j
$ cd ../python-package
$ python setup.py install
```

### Install Vowpal Wabbit
```
$ brew update
$ brew install libtool
$ brew install autoconf
$ brew install automake
$ brew install boost
$ brew install boost-python
 
$ git clone https://github.com/JohnLangford/vowpal_wabbit.git
$ cd vowpal_wabbit
$ make -j
$ make test
$ make install
```

## Using Anaconda
If you don't need to try out latest versions of ML packages and tools, this is easiest way to get started.
Download and install Anaconda at https://www.continuum.io/downloads.
