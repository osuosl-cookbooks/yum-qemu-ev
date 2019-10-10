require_relative 'spec_helper'

describe 'yum-qemu-ev::default' do
  ALL_PLATFORMS.each do |pltfrm|
    context "on #{pltfrm[:platform]} #{pltfrm[:version]}" do
      cached(:chef_run) do
        ChefSpec::SoloRunner.new(pltfrm).converge(described_recipe)
      end
      it 'converges successfully' do
        expect { chef_run }.to_not raise_error
      end
      case pltfrm
      when CENTOS_7
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
        %w(ppc64le).each do |a|
          context "setting arch to #{a}" do
            cached(:chef_run) do
              ChefSpec::SoloRunner.new(CENTOS_7) do |node|
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
                  baseurl: 'http://ftp.osuosl.org/pub/osl/repos/yum/$releasever/RHEV/$basearch'
                )
            end
          end
        end
      when CENTOS_8
        it do
          expect(chef_run).to_not install_package('centos-release-virt-common')
        end

        it do
          chef_run.node['yum-centos']['repos'].each do |repo|
            next unless chef_run.node['yum'][repo]['managed']
            expect(chef_run).to_not create_yum_repository(repo).with(exclude: 'qemu*')
          end
        end

        it do
          expect(chef_run).to_not create_yum_repository('qemu-ev')
        end
      end
    end
  end
end
