function portslay {
    pid=$(lsof -t -i:$1)
    running=$?
    if [ $running -eq 0 ]; then
        kill $pid
    fi
}

# Register a shell command to be executed just before the shell exits.
function atexit {
    task=$1
    tasks=$(trap -p EXIT)
    tasks=${tasks##trap -- \'}
    tasks=${tasks%%\' EXIT}
    trap "$tasks$task;" EXIT
}

OBJSUFFIX=$(git symbolic-ref -q HEAD | sed -e s,refs/heads/,.,)
OBJDIR=obj$OBJSUFFIX
export LD_LIBRARY_PATH=$OBJDIR
export PYTHONPATH=bindings/python

