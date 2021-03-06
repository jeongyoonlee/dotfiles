# TensorBoard

## Sync TensorBoard logs from a Remote Server

### macOS
```bash
# Mount the remote log dir
$ sshfs username@remote_server:/tensorboard-logs-path/ ./logs
$ tensorboard --logdir logs
# To unmount the log dir
$ umount ./logs
```

# Jupyter Notebook

## Jupyter Notebook on a Remote Server

### From a remote server
```bash
# Install Jupyter Notebook & extensions
$ pip install jupyter jupyter_contrib_nbextensions
$ jupyter nbextensions_configurator enable --user
or
$ conda install -c conda-forge jupyter_contrib_nbextensions
# Run Jupyter Notebook
$ jupyter notebook --no-browser --port 12345
```

### From the local machine:
```bash
$ ssh -N -f -L localhost:12345:localhost:12345 username@remote_server
```
Then open the browser on the local machine and go to localhost:12345

## Jupyter Notebook/Hub
To add a virtual environment to Jupyter as a kernel:
```
source activate myenv
python -m ipykernel install --user --name myenv --display-name "Python (myenv)"
```
