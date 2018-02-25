#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if ! yum repolist | grep --quiet '^epel' ; then
    yum install -y -q epel-release
fi

if ! yum repolist | grep --quiet '^puppet' ; then
    readonly PUPPET_YUM_REPO="https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm"
    rpm -Uvh "${PUPPET_YUM_REPO}"
fi

yum install -y -q puppet
