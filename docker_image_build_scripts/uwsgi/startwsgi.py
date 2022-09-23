""" Find user generated wsgi.py file and load it

Because the default Django start-project command places the wsgi.py file in a subdirectory, it is
difficult for this generic installation of uwsgi to find the file.  This is because the user
can select any name for their project's subdirectory.  

Thus, this file is loaded by uwsgi.  And this file will search all subdirectories of the webroot
to find the first wsgi.py file and load it.

"""
import os
import importlib
import glob
from pathlib import Path

# Default installation should make this /opt/app-root/webapp
app_home = os.environ['APP_HOME']

# The glob pattern here searching only one level deep of subdirectories
pattern = f'{app_home}/*/wsgi.py'

print (f'startwsgi.py searching for wsgi.py with pattern: {pattern}')
# If we find a wsgi.py file, store in this variable
project_dir_name = ''

for fname in glob.glob(pattern):
    # Found a file with a path like:
    #   /opt/app-root/webapp/mysite/wsgi.py
    # So we need just the the name of the last subdirectory.  In the example
    # above, it's 'mysite'
    print(f'Found wsgi.py file: {fname}')
    # Parse the full path to get the last subdirectory
    project_dir_name = Path(fname).parent.stem
    # Only load first wsgi.py file
    break

if project_dir_name:
    module_import_name = f'{project_dir_name}.wsgi' 
    wsgi_mod = importlib.import_module(module_import_name)
    # Now extract the application object - this is what uwsgi needs
    application = getattr(wsgi_mod,'application')
else:
    print (f'startwsgi.py: No wsgi.py file found')

