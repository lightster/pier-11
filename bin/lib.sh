#!/bin/BASH

ssh_command() {
    local HOST="${1:-default}"
    local SSH_COMMAND="${2}"

    ssh -q -t -F $(dirname $(readlink $0))/../ssh.cfg "${HOST}" "${SSH_COMMAND}"

    return $?
}

pier_command() {
    local HOST="${1}"
    local CLI="${2}"
    local PASSED_COMMANDS=("${@:3}")
    local COMMANDS=$(printf '"%s" ' "${PASSED_COMMANDS[@]}")
    local WORKSPACE_ROOT=$(dirname $(dirname $(readlink "${0}")))

    local SSH_COMMAND=$(cat <<BASH
cd /vagrant/codebase/ \
&& source /etc/profile.d/rvm.sh \
&& MAPPED_DIR=\$(/vagrant/codebase/lightster/pier-cli/bin/moor map-to-guest-workspace "${WORKSPACE_ROOT}" "${PWD}") \
&& cd \$MAPPED_DIR \
&& /vagrant/codebase/lightster/pier-cli/bin/${CLI} ${COMMANDS}
BASH
    )

    ssh_command "${HOST}" "${SSH_COMMAND}"

    return $?
}
