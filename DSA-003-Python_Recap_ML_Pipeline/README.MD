## Common commands used in this tutorial:

### To create virtual environment
``` python
# Create a 
python -m venv myenv

# Or
python3 -m venv myenv

# Activate the virtual environment
source myenv/bin/activate

# Testing the virtual environment 
which python 

# Or
which python3

# Installing packages 
pip install <package-name>

# To deactivate the virtual environment
Deactivate by deactivate
```

### To git ignore important information

1. ``` git
touch .gitignore
```
2. In the .gitignore file, add the name of the file you want to ignore in your git commands. If the file you wanna hide is called venv it should look something like this
``` git
venv/
```

*Remember to end off with "/" in the file to indicate endpoint*
