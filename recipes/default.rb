#
# Cookbook Name:: yum-qemu-ev
# Recipe:: default
#
# Copyright 2016 Oregon State University
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

if node['yum']['qemu-ev-attr']['glusterfs_34'] &&
   node['kernel']['machine'] == 'x86_64'
  include_recipe 'base::glusterfs'
end

if node['yum']['qemu-ev-attr']['glusterfs_34'] &&
   node['kernel']['machine'] == 'x86_64'
  node.default['yum']['qemu-ev']['gpgkey'] = 'http://ftp.osuosl.org/pub/osl/repos/yum/RPM-GPG-KEY-osuosl'
  node.default['yum']['qemu-ev']['baseurl'] = 'http://ftp.osuosl.org/pub/osl/repos/yum/$releasever/RHEV-glusterfs-34/$basearch'
end

# Install Virt SIG gpg repo key
package 'centos-release-virt-common' do
  not_if { node['yum']['qemu-ev-attr']['glusterfs_34'] }
end

include_recipe 'yum-centos'

# Exclude all qemu packages from the CentOS repos
node['yum-centos']['repos'].each do |repo|
  next unless node['yum'][repo]['managed']
  r = resources(yum_repository: repo)
  # If we already have excludes, include them and append qemu
  r.exclude = [r.exclude, 'qemu*'].reject(&:nil?).join(' ')
end

yum_repository 'qemu-ev' do
  node['yum']['qemu-ev'].each do |key, value|
    send(key.to_sym, value)
  end

  only_if { platform_family?('rhel') }
  action :create
end

node.default['base']['kvm']['qemu-pkgs'] = %w(
  qemu-kvm-ev
  qemu-kvm-tools-ev
)
