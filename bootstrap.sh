#!/usr/bin/env bash

yum update -y
yum install -y epel-release

yum install -y net-tools

readonly PUPPET_YUM_REPO="https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm"
rpm -ivh "${PUPPET_YUM_REPO}"
yum install -y puppet
