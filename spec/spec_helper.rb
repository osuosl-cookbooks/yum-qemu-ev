require 'chefspec'
require 'chefspec/berkshelf'

ChefSpec::Coverage.start! { add_filter 'yum-qemu-ev' }

CENTOS_7_OPTS = {
  platform: 'centos',
  version: '7.2.1511',
  log_level: :fatal,
}.freeze

CENTOS_6_OPTS = {
  platform: 'centos',
  version: '6.8',
  log_level: :fatal,
}.freeze

DEBIAN_8_OPTS = {
  platform: 'debian',
  version: '8.4',
  log_level: :fatal,
}.freeze
