---
defaults: github-markdown
toc: false
---
<!-- *********************************************************************** -->
# matrixxx project
- a D.I.Y live system based on shell scripts
- primarily for use on a USB stick (or similar)
- [home page](https://matrixxx.dev/)

## What does matrixxx stand for?
Scripts for generating:

1. an initramfs system (busybox-based) for booting a unionfs-based linux
   system with a custom kernel
2. an union-mounted file system based on Debian

### used boot medium (structure)
- Boot medium is a USB stick (or similar) or a hard disk
- Extlinux/syslinux is used as bootloader
  - Legacy boot and UEFI
- The customized kernel is started by the bootloader, which in turn starts
  a customized initramfs. Controlled by the bootloader configurations file.
- The customized initramfs mounts the read-only operating system images as
  a “Union File System” and starts the OS init process.

### kernel build:
- generate a customized kernel
  - contains "aufs" (advanced multi layered unification filesystem)
  - contains drivers to boot the USB stick (or similar)

### initramfs build:
- generate a customized initramfs
   - contains a customized busybox which is based on version v1.37.0
   - contains a init script which
      - has an exit ("hook") as early as possible to easily try out adjustments
      - allows various cheat codes via kernel parameter (bootloader)
- *note:* the read-only images (for union mount) of the operating system are of
  type "squashfs" ("cloop" integration is planned)

### system build:
- generate a debian based system packed in several "squashfs" files
  - used suites: stable testing unstable
  - used software categories: main contrib non-free-firmware

#### links:
- home page of [busybox][]
- home page of [kernel.org][kernel]
- home page of [aufs][]
- home page of [Syslinux Project][]

<!-- *********************************************************************** -->
[busybox]: https://www.busybox.net/
[kernel]: https://kernel.org/
[aufs]: https://aufs.sourceforge.net/
[Syslinux Project]: https://wiki.syslinux.org
