#!/bin/bash

# A script for setting up a Python virtual environment for data analysis
# Assumes the OS is Arch Linux with Python and sudo present
# Assumes python points to python3
# Usage: run script from location where want to create the virtual env folder

# Install the spatialindex requirement if it is not already installed
sudo pacman -S --needed  spatialindex
sudo pacman -S --needed  geos
#sudo pacman -S --needed python-statsmodels

# Add a user
echo "Creating a new data analysis virtual env..."
echo -n "Enter name of the virtual env: "
read new_env_name
: "${new_env_name:?"Missing env name"}"

# Creating the env
python -m venv ${new_env_name}
source ${new_env_name}/bin/activate

# Now inside the virtual env:
pip install --upgrade pip
pip install numpy pandas matplotlib ipython jupyter
pip install scipy
pip install nose
pip install sympy

# For geopandas stuff
pip install shapely
pip install fiona
pip install pyproj
pip install six

# Optional geopands dependencies:
pip install rtree
pip install geopy

# Additional stuff for plotting
pip install descartes
pip install mapclassify

# For GIS stuff
pip install geopandas

# Other
pip install earthpy
pip install seaborn
pip install patsy
pip install statsmodels

# Installing tabulate (a dependency when calling to_markdown() on a pandas dataframe)
pip install tabulate

# Exiting the virtual env
deactivate

# End message
echo "virtual env ${new_env_name} has been created"
echo "To enter it do:"
echo "\tsource ${new_env_name}/bin/activate"
