#!/usr/bin/env bash
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

function info_msg()
{
    echo -e "${BLUE}$@${NC}";
}

function error_msg()
{
    echo -e "${RED}$@${NC}";
}
COMPOSE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Check ubuntu version
OS_NAME="$(uname)" # mac: Darwin, linux: Linux
UBUNTU_VER=$(lsb_release -sr)
if [ ${OS_NAME} == 'Darwin' ]; then
    info_msg "\nmacOS detected"
elif [ ${UBUNTU_VER} != '18.04' ]; then
    info_msg "   Supported host versions are: 18.04"
    error_msg "\nUnsupported Ubuntu version: ${UBUNTU_VER}"
fi

info_msg "\n[Updating private ROS packages]"
CATKIN_WS="${COMPOSE_DIR}/catkin_ws/src"
mkdir -p ${CATKIN_WS}
REPOSITORIES=("sauvc2020" "rosserial")
CURRENT_DIR=$(pwd)
for REPO in "${REPOSITORIES[@]}"
do
    REPO_FOLDER="${CATKIN_WS}/${REPO}"
    if [ -d "${REPO_FOLDER}" ]; then
        cd ${REPO_FOLDER};
        if [ -z "$(sudo git status --porcelain)" ]; then
            git pull
            echo -ne "${REPO} updated\n"
        else 
            echo -ne "Failed to update repository: ${REPO} due to unsaved local changes. Discard or push the changes to the remote repository to update it.\n"
        fi
    else
        git clone https://github.com/leonardoedgar/${REPO}.git ${REPO_FOLDER};
    fi
done