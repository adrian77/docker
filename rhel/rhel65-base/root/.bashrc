# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Set this to get it working with python2.7
PATH=/opt/rh/python27/root/usr/bin:/usr/lib64/qt-3.3/bin:$PATH
LD_LIBRARY_PATH=/opt/rh/python27/root/usr/lib64
export LD_LIBRARY_PATH

# Set this to get it workng with OpenSAF python bindings
PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/dist-packages
export PYTHONPATH

# For proper bash completion
if [ -f /etc/bash_completion.d/opensaf.sh ]; then
. /etc/bash_completion.d/opensaf.sh
. /etc/bash_completion.d/coremw.sh
fi
