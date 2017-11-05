#!/usr/bin/env bash
set -eu
#
# setup pyenv
#
PYENV_ROOT="$HOME/.pyenv"
_PROFILE=$HOME/.profile
_BASHRC=$HOME/.bashrc

# if ${PYENV_ROOT} directory does not exists, then pyenv is installed.
echo checking system...
if [ ! -d ${PYENV_ROOT} ]; then
  echo ${PYENV_ROOT} is not found. pyenv will be installed.
  if which pyenv > /dev/null; then
    echo "(*warning*) pyenv may be already installed, but installation will be continued."
  fi
  git clone https://github.com/yyuu/pyenv.git ${PYENV_ROOT}
  eval echo 'export PYENV_ROOT=${PYENV_ROOT}' >> ${_PROFILE}
  echo 'export PATH="${PYENV_ROOT}/bin:$PATH"' >> ${_PROFILE}
  echo 'if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi' >> ${_PROFILE}
else
  echo ${PYENV_ROOT} is found. this installation will now stop.
fi

source ${_PROFILE}

#
# install anaconda
#
ANACONDA_VERSION=`pyenv install --list | grep anaconda3 | sort -t . -n | tail -n 1 | sed -e 's/[ \f\n\r\t]//g'`

pyenv install ${ANACONDA_VERSION}
pyenv rehash
pyenv global ${ANACONDA_VERSION}

eval echo 'alias conda-activate=\"source ${PYENV_ROOT}/versions/${ANACONDA_VERSION}/bin/activate\"' >> ${_BASHRC}
eval echo 'alias conda-deactivate=\"source ${PYENV_ROOT}/versions/${ANACONDA_VERSION}/bin/deactivate\"' >> ${_BASHRC}
echo 'alias activate=conda-activate' >> ${_BASHRC}
echo 'alias deactivate=conda-deactivate' >> ${_BASHRC}
echo echo \"In this environment, use \\\"\(de\)activate\\\" or \\\"conda-\(de\)activate\\\" instead of \\\"source \(de\)activate\\\"\" >> ${_BASHRC}
conda update conda

exit 0
