#
# Cookbook:: yum-qemu-ev
# Recipe:: default
#
# Copyright:: 2016-2022, Oregon State University
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

# No qemu-ev on EL8
if node['platform_version'].to_i >= 8
  Chef::Log.warn('yum-qemu-ev is only supported on EL7 and lower')
  return
end

# Install Virt SIG gpg repo key
package 'centos-release-virt-common'

include_recipe 'osl-repos::centos'

# Exclude all qemu packages from the CentOS repos
r = resources(osl_repos_centos: 'default')
# If we already have excludes, include them and append qemu
r.exclude = [r.exclude, 'qemu*'].flatten

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
