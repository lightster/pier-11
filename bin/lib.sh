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

    local SSH_COMMAND=$(cat <<BASH
cd /vagrant/codebase/
/vagrant/codebase/lightster/pier-cli/bin/${CLI} ${COMMANDS}
BASH
    )

    ssh_command "${HOST}" "${SSH_COMMAND}"

    return $?
}
