require 'chefspec'
require 'chefspec/berkshelf'

ChefSpec::Coverage.start! { add_filter 'yum-qemu-ev' }

CENTOS_7_OPTS = {
  platform: 'centos',
  version: '7.4.1708',
  log_level: :fatal,
}.freeze
