name             'yum-qemu-ev'
maintainer       'Oregon State University'
maintainer_email 'chef@osuosl.org'
source_url       'https://github.com/osuosl-cookbooks/yum-qemu-ev'
issues_url       'https://github.com/osuosl-cookbooks/yum-qemu-ev/issues'
license          'Apache-2.0'
chef_version     '>= 14.0'
description      'Installs/Configures yum-qemu-ev'
version          '2.4.2'

depends          'base'
depends          'yum-centos'

supports         'centos', '~> 7.0'
