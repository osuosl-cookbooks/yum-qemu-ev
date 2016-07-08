require 'serverspec'

set :backend, :exec

describe yumrepo('qemu-ev') do
  it { should exist }
  it { should be_enabled }
end

describe command('yum install -y qemu-kvm') do
  its(:exit_status) { should eq 0 }
end

case os[:arch]
when 'x86_64'
  qemu_pkg = 'qemu-kvm-ev-2'
when 'ppc64', 'ppc64le'
  qemu_pkg = 'qemu-kvm-rhev-2'
end

describe command('/usr/libexec/qemu-kvm --version') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/#{qemu_pkg}/) }
end
