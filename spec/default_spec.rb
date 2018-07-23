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

  it 'Excludes qemu* from CentOS repos' do
    chef_run.node['yum-centos']['repos'].each do |repo|
      next unless chef_run.node['yum'][repo]['managed']
      expect(chef_run).to create_yum_repository(repo)
        .with(exclude: 'qemu*')
    end
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
  it 'Does not include base::glusterfs' do
    expect(chef_run).to_not include_recipe('base::glusterfs')
  end
  context 'enabling glusterfs_34 attribute' do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(CENTOS_7_OPTS) do |node|
        node.normal['yum']['qemu-ev-attr']['glusterfs_34'] = true
      end.converge(described_recipe)
    end
    it 'Does not install centos-release-virt-common' do
      expect(chef_run).to_not install_package('centos-release-virt-common')
    end
    it 'Includes base::glusterfs' do
      expect(chef_run).to include_recipe('base::glusterfs')
    end
    it 'creates qemu-ev yum repository' do
      expect(chef_run).to create_yum_repository('qemu-ev')
        .with(
          description: 'QEMU EV',
          enabled: true,
          gpgcheck: true,
          gpgkey: 'http://ftp.osuosl.org/pub/osl/repos/yum/RPM-GPG-KEY-osuosl',
          baseurl: 'http://ftp.osuosl.org/pub/osl/repos/yum/$releasever/RHEV-glusterfs-34/$basearch'
        )
    end
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
      context 'enabling glusterfs_34 attribute' do
        cached(:chef_run) do
          ChefSpec::SoloRunner.new(CENTOS_7_OPTS) do |node|
            node.automatic['kernel']['machine'] = a
            node.normal['yum']['qemu-ev-attr']['glusterfs_34'] = true
          end.converge(described_recipe)
        end
        it 'Does not include base::glusterfs' do
          expect(chef_run).to_not include_recipe('base::glusterfs')
        end
        it 'Creates qemu-ev yum repository without Gluster 3.4' do
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
end
