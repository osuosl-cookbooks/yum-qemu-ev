name             'yum-qemu-ev'
maintainer       'Oregon State University'
maintainer_email 'chef@osuosl.org'
license          'Apache-2.0'
chef_version     '>= 12.18' if respond_to?('chef_version')
issues_url       'https://github.com/osuosl-cookbooks/yum-qemu-ev/issues'
source_url       'https://github.com/osuosl-cookbooks/yum-qemu-ev'
description      'Installs/Configures yum-qemu-ev'
long_description 'Installs/Configures yum-qemu-ev'
version          '2.4.0'

depends          'base'
depends          'yum'
depends          'yum-centos'

supports         'centos', '~> 7.0'
