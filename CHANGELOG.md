yum-qemu-ev CHANGELOG
=====================
This file is used to list changes made in each version of the
yum-qemu-ev cookbook.

2.5.0 (2020-06-02)
------------------
- Chef 15

2.4.2 (2020-01-14)
------------------
- Chef 14 post-migration fixes

2.4.1 (2019-12-13)
------------------
- Add support for arm64 (aarch64)

2.4.0 (2019-10-21)
------------------
- Switch to using centos-altarch since they exist for ppc64le now

2.3.0 (2019-10-10)
------------------
- EL8 does not include qemu-ev so don't include the repository

2.2.1 (2019-03-26)
------------------
- Update ppc64le baseurl and remove ppc64

2.2.0 (2019-01-30)
------------------
- Remove glusterfs 3.4 references

2.1.1 (2018-12-10)
------------------
- Revert "Switch ppc64le to using upstream builds"

2.1.0 (2018-12-04)
------------------
- Switch ppc64le to using upstream builds

2.0.0 (2018-07-23)
------------------
- Chef 13 Compatibility Fix

1.1.5 (2017-09-22)
------------------
- Revert "Exclude seabios* packages from upstream repos"

1.1.4 (2017-08-24)
------------------
- Exclude seabios* packages from upstream repos

1.1.3 (2017-08-11)
------------------
- set base kvm attributes to point to right packages

1.1.2 (2017-01-18)
------------------
- Exclude qemu* packages from centos repos

1.1.1 (2016-07-22)
------------------
- Move repo url setting into recipe

1.1.0 (2016-07-22)
------------------
- Optional Repo with qemu-ev linked against GlusterFS 3.4

1.0.1 (2016-07-20)
------------------
- Remove use of to_hash

1.0.0 (2016-07-19)
------------------
- Initial cookbook

0.1.0
-----
- Initial release of yum-qemu-ev

