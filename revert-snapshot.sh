#!/bin/bash

echo "Please enter your VMware vCenter credentials."
#read -p "Enter your username: " username
#read -s -p "Enter your password: " password
username="Administrator"
password="Homelab/4u"

export GOVC_URL=vcsa.kevintijssen.eu
export GOVC_USERNAME=$username
export GOVC_PASSWORD=$password
export GOVC_INSECURE=true

echo "Reverting to a 'Clean' state. Please wait a moment..."
govc snapshot.revert -vm kronos-1 Clean
govc snapshot.revert -vm kronos-2 Clean
govc snapshot.revert -vm kronos-3 Clean
govc snapshot.revert -vm kronos-4 Clean
govc snapshot.revert -vm kronos-5 Clean
echo "Done"

while true; do

  read -p "Do you want to Power-On the VM's? [Y/n]" reply

  if [[ -z $reply ]]; then
    reply="y"
  fi

  case "$reply" in
    Y*|y* )
      govc vm.power -on kronos-1 kronos-2 kronos-3 kronos-4 kronos-5;
      exit 0;;
    N*|n* )
      exit 0;;
    * )
      echo "Please answer yes of no";;
  esac
done
