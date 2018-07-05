export PATH="$HOME/miniconda2/bin:$PATH"
echo Clearing out conda-bld
rm -rf ~/miniconda2/conda-bld

echo Rebuilding conda-bld
mkdir -p ~/miniconda2/conda-bld/linux-64
mkdir -p ~/miniconda2/conda-bld/noarch
conda index ~/miniconda2/conda-bld/linux-64
conda index ~/miniconda2/conda-bld/noarch

echo Adding channels
conda config --remove channels defaults
conda config --add channels defaults
conda config --add channels conda-forge
conda config --add channels bioconda
conda config --add channels local

# Install all of the dependencies required for the recipe builds
cd share
conda env create -f environment.yml

# Loop through each Recipe folder and build it
cd share/recipes
vendoredFolders=$(ls)
for f in $vendoredFolders; do
  echo "Starting build for $f"
  conda build $f --old-build-string -q
done
cd

# Do not delete the recipe artifacts that we have built or have declared. By setting this flag here, they will not be deleted during cleanup.
toKeep=$(ls ~/miniconda2/conda-bld/linux-64)
for f in $toKeep; do
  echo "Keeping $f"
done

# Update the Conda index to the specified linux-64 directory
mkdir linux-64 && cd linux-64
wget -q -r -l1 -e robots=off -nH -nd --reject="index.html*" --no-parent --no-cookies SED_CHANNEL/linux-64/ --user=SED_USER --password=SED_PASSWORD
mv ~/miniconda2/conda-bld/linux-64/* .
conda index .

# Cleanup; delete all artifacts that are not flagged to be kept. 
deleteString="find . -type f"
for f in $toKeep; do
  deleteString=$deleteString" ! -name $f"
done

deleteString=$deleteString" -delete"
$deleteString

# Anything remaining in the Share will be pushed to Nexus in the JenkinsFile
cd ..
mv linux-64 share/

