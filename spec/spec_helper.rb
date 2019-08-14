require 'chefspec'
require 'chefspec/berkshelf'

CENTOS_7_OPTS = {
  platform: 'centos',
  version: '7',
}.freeze

RSpec.configure do |config|
  config.log_level = :warn
end
