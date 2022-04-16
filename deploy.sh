#!/bin/bash

set -e

ansible-playbook site.yaml -i inventory/hosts.yaml
