require_relative 'spec_helper'

describe 'yum-qemu-ev::default' do
  cached(:chef_run) do
    ChefSpec::SoloRunner.new(CENTOS_7_OPTS).converge(described_recipe)
  end
  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end
end
