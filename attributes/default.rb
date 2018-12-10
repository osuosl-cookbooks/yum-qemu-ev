default['yum']['qemu-ev']['repositoryid'] = 'qemu-ev'
default['yum']['qemu-ev']['description'] = 'QEMU EV'
default['yum']['qemu-ev']['enabled'] = true
default['yum']['qemu-ev']['gpgcheck'] = true
default['yum']['qemu-ev-attr']['glusterfs_34'] = false
case node['kernel']['machine']
when 'ppc64', 'ppc64le'
  default['yum']['qemu-ev']['gpgkey'] = 'http://ftp.osuosl.org/pub/osl/repos/yum/RPM-GPG-KEY-osuosl'
  default['yum']['qemu-ev']['baseurl'] = 'http://ftp.osuosl.org/pub/osl/repos/yum/openpower/centos-$releasever/$basearch/RHEV'
when 'x86_64'
  default['yum']['qemu-ev']['gpgkey'] = 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-SIG-Virtualization'
  default['yum']['qemu-ev']['baseurl'] = 'http://centos.osuosl.org/$releasever/virt/$basearch/kvm-common/'
end
