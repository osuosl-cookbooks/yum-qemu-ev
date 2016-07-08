yum-qemu-ev Cookbook
====================

This cookbook installs an updated qemu repository for CentOS 7+ nodes.

Requirements
------------

#### Platforms
* CentOS 7+

Attributes
----------

The following attributes are set by default

``` ruby
default['yum']['qemu-ev']['repositoryid'] = 'qemu-ev'
default['yum']['qemu-ev']['description'] = 'QEMU EV'
default['yum']['qemu-ev']['enabled'] = true
default['yum']['qemu-ev']['gpgcheck'] = true
# ppc64/ppc64le defaults
default['yum']['qemu-ev']['gpgkey'] = 'http://ftp.osuosl.org/pub/osl/repos/yum/RPM-GPG-KEY-osuosl'
default['yum']['qemu-ev']['baseurl'] = 'http://ftp.osuosl.org/pub/osl/repos/yum/openpower/centos-$releasever/$basearch/RHEV'
# x86_64 defaults
default['yum']['qemu-ev']['gpgkey'] = 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-SIG-Virtualization'
default['yum']['qemu-ev']['baseurl'] = 'http://centos.osuosl.org/$releasever/virt/$basearch/kvm-common/'
```

Usage
-----
#### yum-qemu-ev::default

e.g.
Just include `yum-qemu-ev` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[yum-qemu-ev]"
  ]
}
```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `username/add_component_x`)
3. Write tests for your change
4. Write your change
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
- Author:: Oregon State University <chef@osuosl.org>

```text
Copyright 2016 Oregon State University

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
