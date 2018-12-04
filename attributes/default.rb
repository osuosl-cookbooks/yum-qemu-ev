default['yum']['qemu-ev']['repositoryid'] = 'qemu-ev'
default['yum']['qemu-ev']['description'] = 'QEMU EV'
default['yum']['qemu-ev']['enabled'] = true
default['yum']['qemu-ev']['gpgcheck'] = true
default['yum']['qemu-ev-attr']['glusterfs_34'] = false
default['yum']['qemu-ev']['gpgkey'] = 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-SIG-Virtualization'
case node['kernel']['machine']
when 'ppc64', 'ppc64le'
  default['yum']['qemu-ev']['baseurl'] = 'http://centos-altarch.osuosl.org/$releasever/virt/$basearch/kvm-common/'
when 'x86_64'
  default['yum']['qemu-ev']['baseurl'] = 'http://centos.osuosl.org/$releasever/virt/$basearch/kvm-common/'
end
