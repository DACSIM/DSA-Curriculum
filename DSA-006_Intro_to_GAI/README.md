# LLM101

A collection of notebooks to help you get started with LLMs for various tasks!

## Common commands used in this tutorial:

### To create virtual environment (macOS)
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

### To create virtual enviornment (Windows 11)
``` python

# Create a 
python -m venv venv

# Activate the virtual environment 
venv\Scripts\activate

# Installing packages
pip install <package-name>

# To deactivate the virtual enviornment
deactivate

```

### To git ignore important information

1. This is extremely important for keeping your API-key a secret and prevent git pushing of large items into your github repository.

``` git
touch .gitignore
```

2. In the .gitignore file, add the name of the file you want to ignore in your git commands. If the file you wanna hide is called venv it should look something like this
``` git
venv/
```

*Remember to end off with "/" in the file to indicate endpoint*

## Notebooks

1. [Introduction to GPT](1%20Introduction%20to%20GPT.ipynb)

2. [Images with GPT](2%20Images%20with%20GPT.ipynb)

3. [Langchain](3%20Langchain.ipynb)

<!-- 4. [RAG](3%20RAG.ipynb)

5. [Whisper](5%20Whisper.ipynb)

6. [Interacting with Self-hosted OSS Hugging Face Models](6%20Interacting%20with%20Self-hosted%20OSS%20Hugging%20Face%20Models.ipynb)

7. [OpenAI Assistants](7.%20OpenAI%20Assistants.ipynb)

8. [Analyse video frames with GPT](8%20Analyse%20video%20frames%20with%20GPT.ipynb) -->