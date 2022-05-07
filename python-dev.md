# Python Development Guides

## Environment Setup

### Install Utilities
```bash
$ [sudo] apt install tmux htop
```

### Setup dotfiles
Copy [.bashrc](.bashrc) and [.vimrc](.vimrc) to the home directory.
```bash
$ cp dotfiles/.bashrc ~/
$ cp dotfiles/.vimrc ~/.vimrc
$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

### Virtual Environment
Always work on virtual environment so that, when you install or update packages, it won't affect other users.

#### Using `conda`
```bash
# Install miniconda. Instruction is available at https://conda.io/projects/conda/en/latest/user-guide/install/index.html
# Create a new virtual environment
$ conda create -n py37 python=3.7
# Activate the virtual environment
$ conda activate py37
(py37) $ pip install -U [packages to install]
...
# Deactivate the virtual environment
(py37) $ deactivate
```

#### Using `virtualenv`
```bash
# Install virtualenv using pip if needed
$ [sudo] pip install -U virtualenv
# Create a new virtual environment
$ virtualenv --python=[path to Python binary. e.g. /usr/bin/python3.7] py37
# Activate the virtual environment
$ source py37/bin/activate
(py37) $ pip install -U [packages to install]
..
# Deactivate the virtual environment
(py37) $ deactivate
```

### Setup CUDA/cuDNN for GPU
The easiest way to set up the CUDA/cuDNN environment for GPU is either using the NVidia docker or `conda` environment.

#### Using `conda`

1. Create an `environment.yml`
```
name: tf2.4 

channels:  
  - nvidia
  - conda-forge
  - defaults
  - pytorch
  
dependencies:  
  - cudatoolkit=11.0.221
  - cudnn=8.0.4
  - pip=20.0
  - python=3.7
  - jupyterlab
  - pytorch
  - torchvision
  - torchaudio
  - pip:
    - tensorflow-gpu==2.4.1
```
2. Create a `conda` virtual environment
```bash
$ conda env create
```
3. Add the environment to the Jupyter notebook
```bash
$ conda activate tf2.4
$ pip install ipykernel
$ python -m ipykernel install --user --name tf2.4 --display-name "Python 3.7 (TF2.4)"    
```
4. If you want to remove the Jupyter notebook kernel:
```bash
# List all kernels and grap the name of the kernel you want to remove
$ jupyter kernelspec list
# Remove it
$ jupyter kernelspec remove <kernel_name>

```

#### Using the NVidia docker image
Follow the instruction from the Tensorflow website [here](https://www.tensorflow.org/install/docker)

#### Troubleshooting

1. Could not load dynamic library `libcusolver.so.11` with `cudatoolkit=11.0`: create a symlink from an existing `libcusolver.so.XX` to `libcusolver.so.11`. If you used `conda` to create a TF + CUDA + cuDNN environment, CUDA libraries are in `[conda install path]/envs/[environment name]/lib` instead of `/usr/lib/cuda/lib64/`.

### Jupyter Notebook on a Remote Server

1. From a remote server

```bash
# Install Jupyter Notebook
$ pip install jupyter
# Install Jupyter Notebook extensions
$ pip install jupyter_contrib_nbextensions
$ jupyter nbextensions_configurator enable --user
or
$ conda install -c conda-forge jupyter_contrib_nbextensions
# Run Jupyter Notebook
$ jupyter notebook --no-browser --port 12345
```

2. From the local machine
```bash
$ ssh -N -f -L localhost:12345:localhost:12345 username@remote_server
```
Then open the browser on the local machine and go to localhost:12345

#### Troubleshooting

- channel 2: open failed: administratively prohibited: open failed

1. check if you have `127.0.0.1 localhost` in `/etc/hosts/`
2. check if `AllowTcpForwarding` is set to `yes`
3. check if `PermitOpen` is set to `any`

## Coding Style Guidelines

Use the [`black`](https://black.readthedocs.io/en/stable/index.html) Python formatter for [PEP-8](https://peps.python.org/pep-0008/) compliance.

To add black to your IDE for autoformatting, follow the instruction in `black`'s [Editor integration page](https://black.readthedocs.io/en/stable/integrations/editors.html).

You can also run `black` from command line to reformat Python code at once as follows:

```
cd rank-causal-train/src/main/python
pip install black
black .
```

### Linting

- We prefer a strict subset of PEP 8 known as the `Black` code style.
- We can run `pylint` with the `black` style before submitting PRs.
- Use type hints whenever possible (including `-> None` for functions returns nothing), this reduces unexpected runtime errors. We can use `pyre` or `mypy` for type checking before submitting PRs.

### Naming

- Make variable names (nouns) and function names (verbs) descriptive. Don't duplicate information already available by means of the module path, for example the class `team/awesome_project/api/TeamAwesomeProjectThingAPI`, might be renamed to simply `ThingAPI` or even just `Thing`, since it will be imported `from team.awesome_project.api import Thing`. As a corollary, avoid using generic/uninformative names, e.g., `utils`.
Your names shouldn't shadow builtins (`id`, `type`, `min`, `max` are common offenders).
- Don't add "list" to the end of a variable name to tell that it's a list; just make it plural, e.g. `users` works better than `user_list`.
- Use ALL_CAPS for constant variables
- Name things once. Naming is hard but don't make people type the name of your 'thing' more than once to have to use it. See Jack Diederich's talk: [Name Things Once](https://www.youtube.com/watch?v=hZ7hgYKKnF0).

### Logging

- Prefer a fixed format of logging with enough information for debugging. Avoid using plain print.
- We can use [`glog`](https://github.com/google/glog) format by default, example python libraries: [`glog`](https://github.com/google/glog), [`absl-py`](https://abseil.io/docs/python/guides/logging)
- Control your log levels appropriately.

### Commenting

- If a reviewer asks a question about your code, don't just answer it in PRs. Answer the question in the code with a comment or clearer code. This way anyone reading the code gets the benefit of your answer, not just the reviewer. If the reviewer had that question, other readers will too.
- If "something weird" or "a strange error" is responsible for some of your design/implementation, please include the error that you're seeing in your commits or as a link to external docs. Your reviewer may be able to help you understand the root cause of what you're seeing and write simpler code.
- When you're introducing constants, explain how and why they were chosen. bad: `400`, better: `400 # max MB expected`. Even better, use names that help explain what the numbers are. e.g. instead of 400, `MAX_EXPECTED_MB` = 400.
- If you leave commented-out code in a commit, add a comment explaining why it's there. Prefer just removing it, we have version control.
- Use complete sentences in your comments, including punctuation and capitalization. Spell and grammar check.
- Make sure your comments match your code and limit the extent that they need to, for example if your comment says `# Make sure data is over 400MB` and the code says `if len(data) > 500`, that's not great.
- Better: `# Make sure we have more than THRESHOLD because less than that means the
job failed. TODO(author's id): update this if jobs start getting smaller (see JIRA link).`
- Docstrings are a great way to document your code. Use this as a suggestion on how to get started with documenting your python code. You should not put types in docstrings if you also have type hints, redundant information is against DRY (Don't Repeat Yourself) 
  - Functions: 
```python
"""One liner summary.

More detailed explanations. Adding code examples to explain how the API is to be used is also very helpful.

Args:
    arg1: Type. Meaning.
    arg2: Type. Meaning.

Returns:
    return1: Type. Meaning.
    return2: Type. Meaning.

Raises:
    Exception1: When the exception will be triggered.
"""
```
  - Classes
```python
"""One liner summary

If needed, add more detailed explanations for using this class. Adding code examples to explain how the API is to be used is also very helpful.

Public Attributes:
    attribute1: Type. Meaning.
    attribute2: Type. Meaning.

Private Attributes:
    _attribute1: Type. Meaning.
    _attribute2: Type. Meaning.
"""
```
- Note, always add the one line summary, all the other sections are optional. Only add as needed.

### Clean code and architecture

- If you find yourself using specially formatted comments to organize your code, consider refactoring the code into smaller functions.
- Avoid using any magic numbers, URLs in your code, making those numbers CONST variables, or better to be in config files.
- 88 characters isn't a lot, and line breaks inhibit readability. If nesting leads to broken lines, maybe it's time to refactor some functions out. Also, an early return or continue saves indenting (doesn't require an else: block). Shorter functions facilitate shorter variable names in a lot of cases.
- If you do have to break lines, avoid using the line continuation character `\` , which can cause some issues with internal tools sometimes.
- For no reason should you be accessing underscored attributes (methods, properties, etc) of a class outside of that class. Use [PEP-487](https://www.python.org/dev/peps/pep-0487) for configuring classes at definition time.
- Write more, smaller, functions. (better to be less than ~50 lines as a reference)
- Try to be terse. Don't Repeat Yourself (DRY). Sometimes this means refactoring your code to use more general functions, using library functions, or contributing part of your code to a library.
- Don't overuse classes when a module with a bunch of bare functions will do. See Jack Diederich's talk: [Stop Writing Classes](https://pyvideo.org/pycon-us-2012/stop-writing-classes.html).
- Avoid global state. When you have it, avoid accessing globals in your functions. This will make your functions more easily refactorable / testable / understandable. Using globals as defaults for keyword arguments is a good compromise. (e.g. `def my_function(filename=DATAFILE)`).
- Don't do resource-intensive work at the top level of a module. This will be executed at import time, in a lot of situations when the code will never be used. If you need to read files, construct an object graph, or talk to the network, move that to a function that caches the result.

### Nits

The following things are nice touches that reviewers will appreciate.

- Pay attention to whitespace of all kinds and be consistent. In particular, use the same number of blank lines between functions / classes.
- `1e6` or `10**6` is more readable than `1000000` (python 3 PEP 515 allows underscores in numeric literals e.g `1_000_000`).
- Be consistent between `'` and `"`. Prefer `"""` for docstrings, `"` otherwise.
- When unpacking variables from a tuple, and you don't ever refer to some of them, use an `_`. E.g. `a, _, c = (1, 2, 3)` if you only need `a` and `c`.
- If your function is returning a meaningful value, an empty return should read `return None`, not just `return` and especially not an implicit return. By writing `return None` you express intent. If your function doesn't return anything, don't use return `None`.
- Speaking of `returns`, `if condition: return True else: return False` should just be `return condition`.
- To validate an entry against known good entries, use a set literal, not a list. e.g. `valid = entry in {1, 2, 3}`. This is about as performant as using a list, but expresses the intent better.
- If comments encode assumptions about data, explain the assumption and the data it made it on. Better, explain how to update them in the future, with code, if applicable.
- If you have a small script for processing data, explain how to get the data that it needs.

### Gotchas

Some mistakes to be avoided.

- Don't use bare except — catch the most specific exception you can. Otherwise, you may hide things [you never intended to](https://links.infomee.fr/?searchtags=exception).
- [Always avoid mutable default arguments to functions](https://stackoverflow.com/questions/4841782/python-constructor-and-default-value).
- Don't use `/tmp` for storage that needs to last. It's purged every 3 days. 
- Be aware of [late binding closures](https://docs.python-guide.org/writing/gotchas/#late-binding-closures).
- Don't use `eval`, prefer `ast.literal_eval()` if really needed.

### Language features to be aware of

- List, Dictionary, and Set [comprehensions](https://python-3-patterns-idioms-test.readthedocs.io/en/latest/Comprehensions.html). Don't go overboard with these; remember that readability is king.
- Set literals. e.g. `{1, 2, 3}`.
- [`with` statements](https://web.archive.org/web/20200220173755/http://effbot.org/zone/python-with-statement.htm) to ensure that handles (e.g. to open files & database connections) are closed. You can also consider building your own classes with `__enter__` and `__exit__` or using [`contextmanager`](https://docs.python.org/3/library/contextlib.html) decorator.
- Concatenate path parts with `os.path.join`, or using `Pathlib` to make it more readable.
- [`defaultdict`](https://docs.python.org/3/library/collections.html#collections.defaultdict).
- [`enumerate`](https://www.geeksforgeeks.org/enumerate-in-python/)'s 2nd argument is great for 1-based counting.
- Use [`NamedTuple`](https://www.geeksforgeeks.org/typing-namedtuple-improved-namedtuples/) instead of just a tuple, it’s more reader-friendly. However, note that `NamedTuple` is immutable, which means you cannot set the attribute values by `x.y = z` assuming `x` is a `NamedTuple` and `y` is the attribute name. 
- Following the previous item, if you need a lightweight class with mutable attributes by default, consider [`dataclass`](https://docs.python.org/3/library/dataclasses.html) decorator.
- Python's [ternary operator](https://en.wikipedia.org/wiki/%3F:). e.g. `working = 'today' if today in weekdays else 'soon'`.
- Prefer f-string whenever possible (especially logging), it’s easier to read and write, less error-prone, and more performant. f-strings use the `FORMAT_VALUE` bytecode operation rather than the `BINARY_MODULO` or `CALL_FUNCTION` used in `%s` or `.format()`.  However, don’t write “empty” f-string like `f"some string without using any variables"`
- [Typed Dictionaries](https://peps.python.org/pep-0589/) are great for situations where you need a dictionary (such pass in config values from Dagobah) but still want to maintain type safety - Only available in `Python >= 3.8`