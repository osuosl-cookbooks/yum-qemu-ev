require_relative 'spec_helper'

describe 'yum-qemu-ev::default' do
  cached(:chef_run) do
    ChefSpec::SoloRunner.new(CENTOS_7_OPTS).converge(described_recipe)
  end
  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end
  it 'installs centos-release-virt-common' do
    expect(chef_run).to install_package('centos-release-virt-common')
  end
  it 'creates qemu-ev yum repository' do
    expect(chef_run).to create_yum_repository('qemu-ev')
      .with(
        description: 'QEMU EV',
        enabled: true,
        gpgcheck: true,
        gpgkey: 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-SIG-Virtualization',
        baseurl: 'http://centos.osuosl.org/$releasever/virt/$basearch/kvm-common/'
      )
  end
  %w(ppc64 ppc64le).each do |a|
    context "setting arch to #{a}" do
      cached(:chef_run) do
        ChefSpec::SoloRunner.new(CENTOS_7_OPTS) do |node|
          node.automatic['kernel']['machine'] = a
        end.converge(described_recipe)
      end
      it 'not install centos-release-virt-common' do
        expect(chef_run).to_not install_package('centos-release-virt-common')
      end
      it 'creates qemu-ev yum repository' do
        expect(chef_run).to create_yum_repository('qemu-ev')
          .with(
            description: 'QEMU EV',
            enabled: true,
            gpgcheck: true,
            gpgkey: 'http://ftp.osuosl.org/pub/osl/repos/yum/RPM-GPG-KEY-osuosl',
            baseurl: 'http://ftp.osuosl.org/pub/osl/repos/yum/openpower/centos-$releasever/$basearch/RHEV'
          )
      end
    end
  end
end
