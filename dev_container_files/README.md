This folder contains files and directories that are used when the container is running and used for development.
More importantly, it persists the files between runs of the container.

So when you run the container over and over, you don't need to recreate these files.

This folder primarily holds:

-   The development virtual environment

    It would be a huge bummer to run `pip install -r requirements.txt` everytime you started the container!
    So we put the virtual environment here. If you want to update the virtual environment, just delete the
    virtual environment folder.
