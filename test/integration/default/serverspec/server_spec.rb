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

# Ensure this package was installed using the correct key
case os[:arch]
when 'x86_64'
  describe command('rpm -qi qemu-kvm-ev | grep Signature') do
    its(:stdout) { should_not match(/Key ID 2df30655a70b13b7/) }
  end
when 'ppc64', 'ppc64le'
  describe command('rpm -qi qemu-kvm-ev | grep Signature') do
    its(:stdout) { should match(/Key ID 2df30655a70b13b7/) }
  end
end

%w(base extras updates).each do |r|
  describe file("/etc/yum.repos.d/#{r}.repo") do
    its(:content) { should match(/^exclude=qemu\* seabios\*$/) }
  end
end
