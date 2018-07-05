export PATH="$HOME/miniconda2/bin:$PATH"
echo Clearing out conda-bld
rm -rf ~/miniconda2/conda-bld

echo "Rebuilding conda-bld"
mkdir -p ~/miniconda2/conda-bld/linux-64
mkdir -p ~/miniconda2/conda-bld/noarch
conda index ~/miniconda2/conda-bld/linux-64
conda index ~/miniconda2/conda-bld/noarch

echo "Adding channels"
conda config --remove channels defaults
conda config --add channels defaults
conda config --add channels conda-forge
conda config --add channels bioconda
conda config --add channels local

# Install all of the dependencies required for the recipe builds
echo "Downloading public prerequisites"
conda env create -f ~/environment.yml
conda index ~/miniconda2/pkgs

# Remove the public channels so ensure that no versions that we do not specify are accidentally pulled in
conda config --remove channels conda-forge
conda config --remove channels bioconda
conda config --remove channels defaults

# Loop through each Recipe folder and build it
echo "Building recipes"
cd share/recipes
vendoredFolders=$(ls)
for f in $vendoredFolders; do
  echo "Starting build for $f"
  conda build $f --old-build-string -q
done
cd

# Update the Conda index to the specified linux-64 directory
mkdir linux-64 && cd linux-64
mv ~/miniconda2/conda-bld/linux-64/* .
mv ~/miniconda2/pkgs/*.tar.bz2 .

# Anything remaining in the Share will be pushed to Nexus in the JenkinsFile
cd ..
mv linux-64 share/

