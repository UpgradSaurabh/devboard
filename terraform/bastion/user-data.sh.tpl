#!/bin/bash
set -e

hostnamectl set-hostname "${hostname}"

apt-get update -y
apt-get install -y python3
