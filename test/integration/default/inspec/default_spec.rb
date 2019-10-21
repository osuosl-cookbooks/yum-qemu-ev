describe yum.repo('qemu-ev') do
  it { should exist }
  it { should be_enabled }
end

describe command('yum install -y qemu-kvm') do
  its('exit_status') { should eq 0 }
end

describe command('/usr/libexec/qemu-kvm --version') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/qemu-kvm-ev-2/) }
end

# Ensure this package was installed using the correct key
describe command('rpm -qi qemu-kvm-ev | grep Signature') do
  its('stdout') { should_not match(/Key ID 2df30655a70b13b7/) }
end

%w(base extras updates).each do |r|
  describe file("/etc/yum.repos.d/#{r}.repo") do
    its('content') { should match(/^exclude=qemu\*$/) }
  end
end
