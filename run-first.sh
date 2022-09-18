#!/usr/bin/bash -eu

function install_ansible_on_ubuntu () {
  sudo apt install python3-pip
  pip3 install --user ansible
  return 0
}

DISTRIBUTION_NAME=$(cat /etc/os-release | awk -F'["]' 'NR==1{print $2}' | awk '{print $1}')

case "${DISTRIBUTION_NAME}" in
  "Amazon" )  echo -e "\033[38;2;220;50;47mERROR: Not implemented.";;
  "Ubuntu" )  install_ansible_on_ubuntu;;
esac

source ~/.profile

./install/localhost/sudoers
./install/localhost/brew

LOCALE=$(echo ${LANG} | cut -d "." -f1)

COMMIT_MSG_SUFFIX=
case "${LOCALE}" in
  "en_US" ) COMMIT_MSG_SUFFIX=".en";;
  "ja_JP" ) COMMIT_MSG_SUFFIX=".ja";;
esac

if [ -n "$(which curl)" ]; then
  curl -sL \
    "https://raw.githubusercontent.com/to884/git-scripts/main/hooks/prepare-commit-msg${COMMIT_MSG_SUFFIX}" \
    > ./.git/hooks/prepare-commit-msg
    chmod +x ./.git/hooks/prepare-commit-msg
fi

