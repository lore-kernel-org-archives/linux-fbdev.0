From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] GeForce 5200 on rivafb
Date: Fri, 10 Dec 2004 19:34:32 -0800
Message-ID: <7vmzwly0c7.fsf@assigned-by-dhcp.cox.net>
References: <200412072347.23194.lucasvr@gobolinux.org>
	<200412082034.08852.adaplas@hotpop.com>
	<200412092346.19189.lucasvr@gobolinux.org>
	<200412110443.29580.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cdgqw-0002gr-MK
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 12 Dec 2004 19:26:26 -0800
Received: from fed1rmmtai01.cox.net ([68.230.241.58])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Cdgqw-0003Xm-Em
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 12 Dec 2004 19:26:26 -0800
In-Reply-To: <200412110443.29580.adaplas@hotpop.com> (Antonino A. Daplas's
 message of "Sat, 11 Dec 2004 04:43:29 +0800")
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Antonino A Daplas <adaplas@hotpop.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

--=-=-=

>>>>> "AAD" == Antonino A Daplas <adaplas@hotpop.com> writes:

AAD> Just report any problems that you find, however inconsequential.  If you
AAD> have relatively old cards such as the TNT (NV5), or newer than NV30's, let
AAD> me know of the results.

I have a ViewSonic PF775 connected to non-name GeForce2 MX/MX
400 and tried your patch.  I regret having to report a bad
result.

I have been using an earlier incarnation of your patch (the one
you posted on the fbdev list as nvidiafb2, followed up with a
couple of incremental patches; that version had some code for
NVIDIA_I2C but the configuration variable was not enabled).  I
tried the new patch with NVIDIA_I2C enabled.

The base kernel is 2.6.10-rc3 with SquashFS 2.1 compiled as
module but I do not think SquashFS would affect anything,
especially it was not loaded at the time.

The older one works (eh, sort of).  I get boot Penguin logo on
the console and I can use XFree86 on fbdev (but not "nv").  The
reason I say "sort of" is because it worked with 16-bit depth
but not 24-bit depth.  I do not know if you are interested in
this, since I suspect the problem is mostly on the XFree86 side.

The new one does *not* work at all with NVIDIA_I2C enabled with
my configuration.  The boot console suddenly goes blank and the
only thing I can see is the cursor which is an underscore.  No
text.  An even funnier thing is that typing ALT-F2 showed the
earliest part of the console boot message in the usual text
mode.  I did not expect X to work with it (I could not see what
I was typing anyway) but tried to type "startx" blindly.  VC
switched and I again saw the earliest part of the console boot
message in the usual text mode.

Exiting X did not improve things either.  Typing "Enter" key
moved cursor around without scrolling any text on the screen
(displayed was the earliest part of the console boot message).
At that point all I could do was to "su" and "reboot" (again
without seeing what I was typing).

Attached are relevant kernel boot message log, XFree86 log,
kernel configuration with nvidia i2c, and XFree86 configuration
file.

I'll try compiling the kernel from the same source without
configuring NVIDIA_I2C next.


--=-=-=
Content-Disposition: attachment; filename=kernel-log
Content-Description: kernel boot message log

Dec 10 19:04:40 siamese syslogd 1.4.1#16: restart.
Dec 10 19:04:40 siamese kernel: klogd 1.4.1#16, log source = /proc/kmsg started.
Dec 10 19:04:40 siamese kernel: Inspecting /boot/System.map-2.6.10-rc3-siam-c5ccf2
Dec 10 19:04:40 siamese kernel: Loaded 24983 symbols from /boot/System.map-2.6.10-rc3-siam-c5ccf2.
Dec 10 19:04:40 siamese kernel: Symbols match kernel version 2.6.10.
Dec 10 19:04:40 siamese kernel: No module symbols loaded - kernel modules not enabled. 
Dec 10 19:04:40 siamese kernel: Linux version 2.6.10-rc3-siam-c5ccf2 (junio@siamese) (gcc version 3.3.4 (Debian 1:3.3.4-13)) #1 Fri Dec 10 15:57:45 PST 2004
Dec 10 19:04:40 siamese kernel: BIOS-provided physical RAM map:
Dec 10 19:04:40 siamese kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Dec 10 19:04:40 siamese kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Dec 10 19:04:40 siamese kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Dec 10 19:04:40 siamese kernel:  BIOS-e820: 0000000000100000 - 000000002fff0000 (usable)
Dec 10 19:04:40 siamese kernel:  BIOS-e820: 000000002fff0000 - 000000002fff3000 (ACPI NVS)
Dec 10 19:04:40 siamese kernel:  BIOS-e820: 000000002fff3000 - 0000000030000000 (ACPI data)
Dec 10 19:04:40 siamese kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Dec 10 19:04:40 siamese kernel: 767MB LOWMEM available.
Dec 10 19:04:40 siamese kernel: DMI 2.3 present.
Dec 10 19:04:40 siamese kernel: Built 1 zonelists
Dec 10 19:04:40 siamese kernel: Kernel command line: BOOT_IMAGE=2610rc3siam ro root=900
Dec 10 19:04:40 siamese kernel: Local APIC disabled by BIOS -- you can enable it with "lapic"
Dec 10 19:04:40 siamese kernel: Initializing CPU#0
Dec 10 19:04:40 siamese kernel: PID hash table entries: 4096 (order: 12, 65536 bytes)
Dec 10 19:04:40 siamese kernel: Detected 750.134 MHz processor.
Dec 10 19:04:40 siamese kernel: Using tsc for high-res timesource
Dec 10 19:04:40 siamese kernel: Console: colour VGA+ 80x25
Dec 10 19:04:40 siamese kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Dec 10 19:04:40 siamese kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Dec 10 19:04:40 siamese kernel: Memory: 775952k/786368k available (1747k kernel code, 9924k reserved, 561k data, 412k init, 0k highmem)
Dec 10 19:04:40 siamese kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Dec 10 19:04:40 siamese kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Dec 10 19:04:40 siamese kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Dec 10 19:04:40 siamese kernel: CPU: L2 Cache: 64K (64 bytes/line)
Dec 10 19:04:40 siamese kernel: Intel machine check architecture supported.
Dec 10 19:04:40 siamese kernel: Intel machine check reporting enabled on CPU#0.
Dec 10 19:04:40 siamese kernel: CPU: AMD Duron(tm) Processor stepping 01
Dec 10 19:04:40 siamese kernel: Enabling fast FPU save and restore... done.
Dec 10 19:04:40 siamese kernel: Checking 'hlt' instruction... OK.
Dec 10 19:04:40 siamese kernel: NET: Registered protocol family 16
Dec 10 19:04:40 siamese kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb2d0, last bus=1
Dec 10 19:04:40 siamese kernel: PCI: Using configuration type 1
Dec 10 19:04:40 siamese kernel: mtrr: v2.0 (20020519)
Dec 10 19:04:40 siamese kernel: PCI: Probing PCI hardware
Dec 10 19:04:40 siamese kernel: PCI: Probing PCI hardware (bus 00)
Dec 10 19:04:40 siamese kernel: Disabling VIA memory write queue (PCI ID 0305, rev 03): [55] 89 & 1f -> 09
Dec 10 19:04:40 siamese kernel: PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
Dec 10 19:04:40 siamese kernel: Machine check exception polling timer started.
Dec 10 19:04:40 siamese kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Dec 10 19:04:40 siamese kernel: Initializing Cryptographic API
Dec 10 19:04:40 siamese kernel: Applying VIA southbridge workaround.
Dec 10 19:04:40 siamese kernel: PCI: Disabling Via external APIC routing
Dec 10 19:04:40 siamese kernel: nvidiafb: nVidia device/chipset 10DE0110
Dec 10 19:04:40 siamese kernel: nvidiafb: nVidia Corporation NV11 [GeForce2 MX/MX 400]
Dec 10 19:04:40 siamese kernel: nvidiafb: EDID found from BUS1
Dec 10 19:04:40 siamese kernel:       Display is GTF capable
Dec 10 19:04:40 siamese kernel: nvidiafb: Unable to detect which CRTCNumber...
Dec 10 19:04:40 siamese kernel: ...Defaulting to CRTCNumber 1
Dec 10 19:04:40 siamese kernel: nvidiafb: Using DFP on CRTC 1
Dec 10 19:04:40 siamese kernel: Panel size is 1 x 1
Dec 10 19:04:40 siamese kernel: nvidiafb: MTRR set to ON
Dec 10 19:04:40 siamese kernel: Real Time Clock Driver v1.12
Dec 10 19:04:40 siamese kernel: Linux agpgart interface v0.100 (c) Dave Jones
Dec 10 19:04:40 siamese kernel: agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
Dec 10 19:04:40 siamese kernel: agpgart: Maximum main memory to use for agp memory: 690M
Dec 10 19:04:40 siamese kernel: agpgart: AGP aperture is 128M @ 0xd0000000
Dec 10 19:04:40 siamese kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Dec 10 19:04:40 siamese kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Dec 10 19:04:40 siamese kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
Dec 10 19:04:40 siamese kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Dec 10 19:04:40 siamese kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Dec 10 19:04:40 siamese kernel: io scheduler noop registered
Dec 10 19:04:40 siamese kernel: io scheduler anticipatory registered
Dec 10 19:04:40 siamese kernel: io scheduler deadline registered
Dec 10 19:04:40 siamese kernel: io scheduler cfq registered
Dec 10 19:04:40 siamese kernel: elevator: using anticipatory as default io scheduler
Dec 10 19:04:40 siamese kernel: Floppy drive(s): fd0 is 1.44M
Dec 10 19:04:40 siamese kernel: FDC 0 is a post-1991 82077
Dec 10 19:04:40 siamese kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Dec 10 19:04:40 siamese kernel: Linux Tulip driver version 1.1.13 (May 11, 2002)
Dec 10 19:04:40 siamese kernel: PCI: Found IRQ 5 for device 0000:00:09.0
Dec 10 19:04:40 siamese kernel: tulip0:  MII transceiver #1 config 3100 status 7829 advertising 01e1.
Dec 10 19:04:40 siamese kernel: eth0: Lite-On 82c168 PNIC rev 32 at 0001a800, 00:A0:CC:26:F0:70, IRQ 5.
Dec 10 19:04:40 siamese kernel: PCI: Found IRQ 10 for device 0000:00:0a.0
Dec 10 19:04:40 siamese kernel: PCI: Sharing IRQ 10 with 0000:00:07.5
Dec 10 19:04:40 siamese kernel: tulip1:  MII transceiver #1 config 1000 status 786d advertising 01e1.
Dec 10 19:04:40 siamese kernel: eth1: ADMtek Comet rev 17 at 0001ac00, 00:20:78:10:A7:F1, IRQ 10.
Dec 10 19:04:40 siamese kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Dec 10 19:04:40 siamese kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Dec 10 19:04:40 siamese kernel: VP_IDE: IDE controller at PCI slot 0000:00:07.1
Dec 10 19:04:40 siamese kernel: VP_IDE: chipset revision 6
Dec 10 19:04:40 siamese kernel: VP_IDE: not 100%% native mode: will probe irqs later
Dec 10 19:04:40 siamese kernel: VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
Dec 10 19:04:40 siamese kernel:     ide0: BM-DMA at 0x9000-0x9007, BIOS settings: hda:DMA, hdb:DMA
Dec 10 19:04:40 siamese kernel:     ide1: BM-DMA at 0x9008-0x900f, BIOS settings: hdc:DMA, hdd:pio
Dec 10 19:04:40 siamese kernel: hda: IC35L080AVVA07-0, ATA DISK drive
Dec 10 19:04:40 siamese kernel: hdb: PLEXTOR CD-R PX-W8432T, ATAPI CD/DVD-ROM drive
Dec 10 19:04:40 siamese kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Dec 10 19:04:40 siamese kernel: hdc: IC35L080AVVA07-0, ATA DISK drive
Dec 10 19:04:40 siamese kernel: ide1 at 0x170-0x177,0x376 on irq 15
Dec 10 19:04:40 siamese kernel: PDC20267: IDE controller at PCI slot 0000:00:0b.0
Dec 10 19:04:40 siamese kernel: PCI: Found IRQ 11 for device 0000:00:0b.0
Dec 10 19:04:40 siamese kernel: PDC20267: chipset revision 2
Dec 10 19:04:40 siamese kernel: PDC20267: 100%% native mode on irq 11
Dec 10 19:04:40 siamese kernel: PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
Dec 10 19:04:40 siamese kernel:     ide2: BM-DMA at 0xc000-0xc007, BIOS settings: hde:pio, hdf:pio
Dec 10 19:04:40 siamese kernel:     ide3: BM-DMA at 0xc008-0xc00f, BIOS settings: hdg:DMA, hdh:pio
Dec 10 19:04:40 siamese kernel: hdg: MAXTOR 4K040H2, ATA DISK drive
Dec 10 19:04:40 siamese kernel: ide3 at 0xb800-0xb807,0xbc02 on irq 11
Dec 10 19:04:40 siamese kernel: hda: max request size: 128KiB
Dec 10 19:04:40 siamese kernel: hda: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(100)
Dec 10 19:04:40 siamese kernel:  hda: hda1 hda2 < hda5 hda6 hda7 hda8 >
Dec 10 19:04:40 siamese kernel: hdc: max request size: 128KiB
Dec 10 19:04:40 siamese kernel: hdc: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(100)
Dec 10 19:04:40 siamese kernel:  hdc:hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Dec 10 19:04:40 siamese kernel: hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
Dec 10 19:04:40 siamese kernel: ide: failed opcode was: unknown
Dec 10 19:04:40 siamese kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Dec 10 19:04:40 siamese kernel: hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
Dec 10 19:04:40 siamese kernel: ide: failed opcode was: unknown
Dec 10 19:04:40 siamese kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Dec 10 19:04:40 siamese kernel: hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
Dec 10 19:04:40 siamese kernel: ide: failed opcode was: unknown
Dec 10 19:04:40 siamese kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Dec 10 19:04:40 siamese kernel: hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
Dec 10 19:04:40 siamese kernel: ide: failed opcode was: unknown
Dec 10 19:04:40 siamese kernel: ide1: reset: success
Dec 10 19:04:40 siamese kernel:  hdc1 hdc2 < hdc5 hdc6 hdc7 hdc8 >
Dec 10 19:04:40 siamese kernel: hdg: max request size: 128KiB
Dec 10 19:04:40 siamese kernel: hdg: 78198750 sectors (40037 MB) w/2000KiB Cache, CHS=65535/16/63, UDMA(100)
Dec 10 19:04:40 siamese kernel:  hdg: hdg1
Dec 10 19:04:40 siamese kernel: hdb: ATAPI 32X CD-ROM CD-R/RW drive, 4096kB Cache, DMA
Dec 10 19:04:40 siamese kernel: Uniform CD-ROM driver Revision: 3.20
Dec 10 19:04:40 siamese kernel: mice: PS/2 mouse device common for all mice
Dec 10 19:04:40 siamese kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Dec 10 19:04:40 siamese kernel: input: PS/2 Logitech Mouse on isa0060/serio1
Dec 10 19:04:40 siamese kernel: input: PC Speaker
Dec 10 19:04:40 siamese kernel: md: raid0 personality registered as nr 2
Dec 10 19:04:40 siamese kernel: md: raid1 personality registered as nr 3
Dec 10 19:04:40 siamese kernel: md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
Dec 10 19:04:40 siamese kernel: device-mapper: 4.3.0-ioctl (2004-09-30) initialised: dm-devel@redhat.com
Dec 10 19:04:40 siamese kernel: NET: Registered protocol family 2
Dec 10 19:04:40 siamese kernel: IP: routing cache hash table of 8192 buckets, 64Kbytes
Dec 10 19:04:40 siamese kernel: TCP: Hash tables configured (established 262144 bind 65536)
Dec 10 19:04:40 siamese kernel: Initializing IPsec netlink socket
Dec 10 19:04:40 siamese kernel: NET: Registered protocol family 1
Dec 10 19:04:40 siamese kernel: NET: Registered protocol family 17
Dec 10 19:04:40 siamese kernel: BIOS EDD facility v0.16 2004-Jun-25, 3 devices found
Dec 10 19:04:40 siamese kernel: md: Autodetecting RAID arrays.
Dec 10 19:04:40 siamese kernel: md: autorun ...
Dec 10 19:04:40 siamese kernel: md: considering hdc8 ...
Dec 10 19:04:40 siamese kernel: md:  adding hdc8 ...
Dec 10 19:04:40 siamese kernel: md: hdc1 has different UUID to hdc8
Dec 10 19:04:40 siamese kernel: md:  adding hda8 ...
Dec 10 19:04:40 siamese kernel: md: hda1 has different UUID to hdc8
Dec 10 19:04:40 siamese kernel: md: created md2
Dec 10 19:04:40 siamese kernel: md: bind<hda8>
Dec 10 19:04:40 siamese kernel: md: bind<hdc8>
Dec 10 19:04:40 siamese kernel: md: running: <hdc8><hda8>
Dec 10 19:04:40 siamese kernel: raid1: raid set md2 active with 2 out of 2 mirrors
Dec 10 19:04:40 siamese kernel: md: considering hdc1 ...
Dec 10 19:04:40 siamese kernel: md:  adding hdc1 ...
Dec 10 19:04:40 siamese kernel: md:  adding hda1 ...
Dec 10 19:04:40 siamese kernel: md: created md0
Dec 10 19:04:40 siamese kernel: md: bind<hda1>
Dec 10 19:04:40 siamese kernel: md: bind<hdc1>
Dec 10 19:04:40 siamese kernel: md: running: <hdc1><hda1>
Dec 10 19:04:40 siamese kernel: raid1: raid set md0 active with 2 out of 2 mirrors
Dec 10 19:04:40 siamese kernel: md: ... autorun DONE.
Dec 10 19:04:40 siamese kernel: VFS: Mounted root (ext2 filesystem) readonly.
Dec 10 19:04:40 siamese kernel: Freeing unused kernel memory: 412k freed
Dec 10 19:04:40 siamese kernel: Adding 249944k swap on /dev/hda5.  Priority:-1 extents:1
Dec 10 19:04:40 siamese kernel: Adding 249944k swap on /dev/hdc5.  Priority:-2 extents:1
Dec 10 19:04:40 siamese kernel: PCI: Found IRQ 10 for device 0000:00:07.5
Dec 10 19:04:40 siamese kernel: PCI: Sharing IRQ 10 with 0000:00:0a.0
Dec 10 19:04:40 siamese kernel: ip_tables: (C) 2000-2002 Netfilter core team
Dec 10 19:04:41 siamese kernel: ip_conntrack version 2.1 (6143 buckets, 49144 max) - 300 bytes per conntrack
Dec 10 19:04:41 siamese kernel: eth0: Setting full-duplex based on MII#1 link partner capability of 45e1.
Dec 10 19:04:42 siamese kernel: eth1: Setting full-duplex based on MII#1 link partner capability of 45e1.
Dec 10 19:04:48 siamese kernel: NET: Registered protocol family 15
Dec 10 19:04:48 siamese lpd[715]: restarted
Dec 10 19:04:53 siamese smartd: smartd started 
Dec 10 19:04:54 siamese smartd: Device: /dev/hda, Found and is SMART capable 
Dec 10 19:04:54 siamese kernel: cdrom: open failed.
Dec 10 19:04:54 siamese smartd: Device: /dev/hdc, Found and is SMART capable 
Dec 10 19:04:54 siamese smartd: Device: /dev/hdg, Found and is SMART capable 
Dec 10 19:04:55 siamese xfs: ignoring font path element /usr/lib/X11/fonts/cyrillic/ (unreadable) 
Dec 10 19:04:55 siamese xfs: ignoring font path element /usr/lib/X11/fonts/CID (unreadable) 
Dec 10 19:04:58 siamese squid[1018]: Squid Parent: child process 1020 started
Dec 10 19:07:09 siamese squid[1018]: Squid Parent: child process 1020 exited with status 0
Dec 10 19:07:10 siamese kernel: Kernel logging (proc) stopped.
Dec 10 19:07:10 siamese kernel: Kernel log daemon terminating.
Dec 10 19:07:10 siamese exiting on signal 15

--=-=-=
Content-Disposition: attachment; filename=X-log
Content-Description: xfree86 log


This is a pre-release version of XFree86, and is not supported in any
way.  Bugs may be reported to XFree86@XFree86.Org and patches submitted
to fixes@XFree86.Org.  Before reporting bugs in pre-release versions,
please check the latest version in the XFree86 CVS repository
(http://www.XFree86.Org/cvs).

XFree86 Version 4.3.0.1 (Debian 4.3.0.dfsg.1-8 20040928112350 fabbione@fabbione.net)
Release Date: 15 August 2003
X Protocol Version 11, Revision 0, Release 6.6
Build Operating System: Linux 2.4.26 i686 [ELF] 
Build Date: 28 September 2004
	Before reporting problems, check http://www.XFree86.Org/
	to make sure that you have the latest version.
Module Loader present
OS Kernel: Linux version 2.6.10-rc3-siam-c5ccf2 (junio@siamese) (gcc version 3.3.4 (Debian 1:3.3.4-13)) #1 Fri Dec 10 15:57:45 PST 2004 
Markers: (--) probed, (**) from config file, (==) default setting,
         (++) from command line, (!!) notice, (II) informational,
         (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) Log file: "/var/log/XFree86.0.log", Time: Fri Dec 10 19:05:57 2004
(==) Using config file: "/etc/X11/XF86Config-4"
(==) ServerLayout "Default Layout"
(**) |-->Screen "Default Screen" (0)
(**) |   |-->Monitor "ViewSonic PF775"
(**) |   |-->Device "eVGA GeForce2 MX/MX400"
(**) |-->Input Device "Generic Keyboard"
(**) Option "XkbRules" "xfree86"
(**) XKB: rules: "xfree86"
(**) Option "XkbModel" "pc104"
(**) XKB: model: "pc104"
(**) Option "XkbLayout" "us"
(**) XKB: layout: "us"
(**) Option "XkbOptions" "ctrl:swapcaps"
(**) XKB: options: "ctrl:swapcaps"
(==) Keyboard: CustomKeycode disabled
(**) |-->Input Device "Configured Mouse"
(**) |-->Input Device "Generic Mouse"
(WW) The directory "/usr/lib/X11/fonts/cyrillic" does not exist.
	Entry deleted from font path.
(WW) The directory "/usr/lib/X11/fonts/CID" does not exist.
	Entry deleted from font path.
(**) FontPath set to "unix/:7100,/usr/lib/X11/fonts/misc,/usr/lib/X11/fonts/100dpi/:unscaled,/usr/lib/X11/fonts/75dpi/:unscaled,/usr/lib/X11/fonts/Type1,/usr/lib/X11/fonts/Speedo,/usr/lib/X11/fonts/100dpi,/usr/lib/X11/fonts/75dpi"
(==) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(==) ModulePath set to "/usr/X11R6/lib/modules"
(--) using VT number 3

(II) Open APM successful
(II) Module ABI versions:
	XFree86 ANSI C Emulation: 0.2
	XFree86 Video Driver: 0.6
	XFree86 XInput driver : 0.4
	XFree86 Server Extension : 0.2
	XFree86 Font Renderer : 0.4
(II) Loader running on linux
(II) LoadModule: "bitmap"
(II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Module bitmap: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.4
(II) Loading font Bitmap
(II) LoadModule: "pcidata"
(II) Loading /usr/X11R6/lib/modules/libpcidata.a
(II) Module pcidata: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.6
(II) PCI: Probing config type using method 1
(II) PCI: Config type is 1
(II) PCI: stages = 0x03, oldVal1 = 0x80003d40, mode1Res1 = 0x80000000
(II) PCI: PCI scan (all values are in hex)
(II) PCI: 00:00:0: chip 1106,0305 card 0000,0000 rev 03 class 06,00,00 hdr 00
(II) PCI: 00:01:0: chip 1106,8305 card 0000,0000 rev 00 class 06,04,00 hdr 01
(II) PCI: 00:07:0: chip 1106,0686 card 1106,0000 rev 40 class 06,01,00 hdr 80
(II) PCI: 00:07:1: chip 1106,0571 card 1106,0571 rev 06 class 01,01,8a hdr 00
(II) PCI: 00:07:4: chip 1106,3057 card 0000,0000 rev 40 class 06,80,00 hdr 00
(II) PCI: 00:07:5: chip 1106,3058 card 1509,8908 rev 50 class 04,01,00 hdr 00
(II) PCI: 00:09:0: chip 11ad,0002 card 11ad,f003 rev 20 class 02,00,00 hdr 00
(II) PCI: 00:0a:0: chip 1317,0985 card 1317,0574 rev 11 class 02,00,00 hdr 00
(II) PCI: 00:0b:0: chip 105a,4d30 card 105a,4d33 rev 02 class 01,80,00 hdr 00
(II) PCI: 01:00:0: chip 10de,0110 card 1462,8527 rev b2 class 03,00,00 hdr 00
(II) PCI: End of PCI scan
(II) Host-to-PCI bridge:
(II) Bus 0: bridge is at (0:0:0), (0,0,1), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus 0 I/O range:
	[0] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 0 non-prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 0 prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 1: bridge is at (0:1:0), (0,1,1), BCTRL: 0x000c (VGA_EN is set)
(II) Bus 1 non-prefetchable memory range:
	[0] -1	0	0xe0000000 - 0xe1ffffff (0x2000000) MX[B]
(II) Bus 1 prefetchable memory range:
	[0] -1	0	0xd8000000 - 0xdfffffff (0x8000000) MX[B]
(II) PCI-to-ISA bridge:
(II) Bus -1: bridge is at (0:7:0), (0,-1,-1), BCTRL: 0x0008 (VGA_EN is set)
(--) PCI:*(1:0:0) nVidia Corporation NV11 [GeForce2 MX/MX 400] rev 178, Mem @ 0xe0000000/24, 0xd8000000/27
(II) Addressable bus resource ranges are
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
	[1] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) OS-reported resource ranges:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[6] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
(II) PCI Memory resource overlap reduced 0xd0000000 from 0xd7ffffff to 0xcfffffff
(II) Active PCI resource ranges:
	[0] -1	0	0xe3000000 - 0xe301ffff (0x20000) MX[B]
	[1] -1	0	0xe3020000 - 0xe30203ff (0x400) MX[B]
	[2] -1	0	0xe3021000 - 0xe30210ff (0x100) MX[B]
	[3] -1	0	0xd0000000 - 0xcfffffff (0x0) MX[B]O
	[4] -1	0	0xd8000000 - 0xdfffffff (0x8000000) MX[B](B)
	[5] -1	0	0xe0000000 - 0xe0ffffff (0x1000000) MX[B](B)
	[6] -1	0	0x0000c000 - 0x0000c03f (0x40) IX[B]
	[7] -1	0	0x0000bc00 - 0x0000bc03 (0x4) IX[B]
	[8] -1	0	0x0000b800 - 0x0000b807 (0x8) IX[B]
	[9] -1	0	0x0000b400 - 0x0000b403 (0x4) IX[B]
	[10] -1	0	0x0000b000 - 0x0000b007 (0x8) IX[B]
	[11] -1	0	0x0000ac00 - 0x0000acff (0x100) IX[B]
	[12] -1	0	0x0000a800 - 0x0000a8ff (0x100) IX[B]
	[13] -1	0	0x0000a400 - 0x0000a403 (0x4) IX[B]
	[14] -1	0	0x0000a000 - 0x0000a003 (0x4) IX[B]
	[15] -1	0	0x00009c00 - 0x00009cff (0x100) IX[B]
	[16] -1	0	0x00009000 - 0x0000900f (0x10) IX[B]
(II) Active PCI resource ranges after removing overlaps:
	[0] -1	0	0xe3000000 - 0xe301ffff (0x20000) MX[B]
	[1] -1	0	0xe3020000 - 0xe30203ff (0x400) MX[B]
	[2] -1	0	0xe3021000 - 0xe30210ff (0x100) MX[B]
	[3] -1	0	0xd0000000 - 0xcfffffff (0x0) MX[B]O
	[4] -1	0	0xd8000000 - 0xdfffffff (0x8000000) MX[B](B)
	[5] -1	0	0xe0000000 - 0xe0ffffff (0x1000000) MX[B](B)
	[6] -1	0	0x0000c000 - 0x0000c03f (0x40) IX[B]
	[7] -1	0	0x0000bc00 - 0x0000bc03 (0x4) IX[B]
	[8] -1	0	0x0000b800 - 0x0000b807 (0x8) IX[B]
	[9] -1	0	0x0000b400 - 0x0000b403 (0x4) IX[B]
	[10] -1	0	0x0000b000 - 0x0000b007 (0x8) IX[B]
	[11] -1	0	0x0000ac00 - 0x0000acff (0x100) IX[B]
	[12] -1	0	0x0000a800 - 0x0000a8ff (0x100) IX[B]
	[13] -1	0	0x0000a400 - 0x0000a403 (0x4) IX[B]
	[14] -1	0	0x0000a000 - 0x0000a003 (0x4) IX[B]
	[15] -1	0	0x00009c00 - 0x00009cff (0x100) IX[B]
	[16] -1	0	0x00009000 - 0x0000900f (0x10) IX[B]
(II) OS-reported resource ranges after removing overlaps with PCI:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[6] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
(II) All system resource ranges:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0xe3000000 - 0xe301ffff (0x20000) MX[B]
	[6] -1	0	0xe3020000 - 0xe30203ff (0x400) MX[B]
	[7] -1	0	0xe3021000 - 0xe30210ff (0x100) MX[B]
	[8] -1	0	0xd0000000 - 0xcfffffff (0x0) MX[B]O
	[9] -1	0	0xd8000000 - 0xdfffffff (0x8000000) MX[B](B)
	[10] -1	0	0xe0000000 - 0xe0ffffff (0x1000000) MX[B](B)
	[11] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[12] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[13] -1	0	0x0000c000 - 0x0000c03f (0x40) IX[B]
	[14] -1	0	0x0000bc00 - 0x0000bc03 (0x4) IX[B]
	[15] -1	0	0x0000b800 - 0x0000b807 (0x8) IX[B]
	[16] -1	0	0x0000b400 - 0x0000b403 (0x4) IX[B]
	[17] -1	0	0x0000b000 - 0x0000b007 (0x8) IX[B]
	[18] -1	0	0x0000ac00 - 0x0000acff (0x100) IX[B]
	[19] -1	0	0x0000a800 - 0x0000a8ff (0x100) IX[B]
	[20] -1	0	0x0000a400 - 0x0000a403 (0x4) IX[B]
	[21] -1	0	0x0000a000 - 0x0000a003 (0x4) IX[B]
	[22] -1	0	0x00009c00 - 0x00009cff (0x100) IX[B]
	[23] -1	0	0x00009000 - 0x0000900f (0x10) IX[B]
(II) LoadModule: "GLcore"
(II) Loading /usr/X11R6/lib/modules/extensions/libGLcore.a
Skipping "/usr/X11R6/lib/modules/extensions/libGLcore.a:m_debug_clip.o":  No symbols found
Skipping "/usr/X11R6/lib/modules/extensions/libGLcore.a:m_debug_norm.o":  No symbols found
Skipping "/usr/X11R6/lib/modules/extensions/libGLcore.a:m_debug_xform.o":  No symbols found
Skipping "/usr/X11R6/lib/modules/extensions/libGLcore.a:m_debug_vertex.o":  No symbols found
(II) Module GLcore: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.2
(II) LoadModule: "bitmap"
(II) Reloading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Loading font Bitmap
(II) LoadModule: "dbe"
(II) Loading /usr/X11R6/lib/modules/extensions/libdbe.a
(II) Module dbe: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading extension DOUBLE-BUFFER
(II) LoadModule: "ddc"
(II) Loading /usr/X11R6/lib/modules/libddc.a
(II) Module ddc: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.6
(II) LoadModule: "dri"
(II) Loading /usr/X11R6/lib/modules/extensions/libdri.a
(II) Module dri: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading sub module "drm"
(II) LoadModule: "drm"
(II) Loading /usr/X11R6/lib/modules/linux/libdrm.a
(II) Module drm: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading extension XFree86-DRI
(II) LoadModule: "extmod"
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
(II) Module extmod: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading extension SHAPE
(II) Loading extension MIT-SUNDRY-NONSTANDARD
(II) Loading extension BIG-REQUESTS
(II) Loading extension SYNC
(II) Loading extension MIT-SCREEN-SAVER
(II) Loading extension XC-MISC
(II) Loading extension XFree86-VidModeExtension
(II) Loading extension XFree86-Misc
(II) Loading extension XFree86-DGA
(II) Loading extension DPMS
(II) Loading extension FontCache
(II) Loading extension TOG-CUP
(II) Loading extension Extended-Visual-Information
(II) Loading extension XVideo
(II) Loading extension XVideo-MotionCompensation
(II) Loading extension X-Resource
(II) LoadModule: "freetype"
(II) Loading /usr/X11R6/lib/modules/fonts/libfreetype.a
(II) Module freetype: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 2.0.2
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.4
(II) Loading font FreeType
(II) LoadModule: "glx"
(II) Loading /usr/X11R6/lib/modules/extensions/libglx.a
(II) Module glx: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading sub module "GLcore"
(II) LoadModule: "GLcore"
(II) Reloading /usr/X11R6/lib/modules/extensions/libGLcore.a
(II) Loading extension GLX
(II) LoadModule: "int10"
(II) Loading /usr/X11R6/lib/modules/linux/libint10.a
(II) Module int10: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.6
(II) LoadModule: "record"
(II) Loading /usr/X11R6/lib/modules/extensions/librecord.a
(II) Module record: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.13.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading extension RECORD
(II) LoadModule: "speedo"
(II) Loading /usr/X11R6/lib/modules/fonts/libspeedo.a
Skipping "/usr/X11R6/lib/modules/fonts/libspeedo.a:spencode.o":  No symbols found
(II) Module speedo: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.1
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.4
(II) Loading font Speedo
(II) LoadModule: "type1"
(II) Loading /usr/X11R6/lib/modules/fonts/libtype1.a
(II) Module type1: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.2
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.4
(II) Loading font Type1
(II) Loading font CID
(II) LoadModule: "vbe"
(II) Loading /usr/X11R6/lib/modules/libvbe.a
(II) Module vbe: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.1.0
	ABI class: XFree86 Video Driver, version 0.6
(II) LoadModule: "fbdev"
(II) Loading /usr/X11R6/lib/modules/drivers/fbdev_drv.o
(II) Module fbdev: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.6
(II) LoadModule: "mouse"
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	Module class: XFree86 XInput Driver
	ABI class: XFree86 XInput driver, version 0.4
(II) FBDEV: driver for framebuffer: fbdev, afb
(II) Primary Device is: PCI 01:00:0
(II) Loading sub module "fbdevhw"
(II) LoadModule: "fbdevhw"
(II) Loading /usr/X11R6/lib/modules/linux/libfbdevhw.a
(II) Module fbdevhw: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 0.0.2
	ABI class: XFree86 Video Driver, version 0.6
(EE) open /dev/fb0: No such device
(EE) No devices detected.

Fatal server error:
no screens found

When reporting a problem related to a server crash, please send
the full server output, not just the last messages.
This can be found in the log file "/var/log/XFree86.0.log".
Please report problems to submit@bugs.debian.org.


--=-=-=
Content-Disposition: attachment; filename=config-2.6.10-rc3-siam-c5ccf2
Content-Description: kernel configuration with the new nvidiafb driver

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.10-rc3-siam
# Fri Dec 10 15:45:12 2004
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
# CONFIG_CLEAN_COMPILE is not set
CONFIG_BROKEN=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_HOTPLUG is not set
CONFIG_KOBJECT_UEVENT=y
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
# CONFIG_HPET_TIMER is not set
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y

#
# Firmware Drivers
#
CONFIG_EDD=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_REGPARM is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI is not set
CONFIG_ACPI_BLACKLIST_YEAR=0

#
# APM (Advanced Power Management) BIOS Support
#
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_MSI is not set
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y
# CONFIG_DEBUG_DRIVER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_LBD is not set
# CONFIG_CDROM_PKTCDVD is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
CONFIG_BLK_DEV_PDC202XX_OLD=y
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_ARM is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_SCSI is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
# CONFIG_MD_LINEAR is not set
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
# CONFIG_MD_RAID10 is not set
CONFIG_MD_RAID5=m
# CONFIG_MD_RAID6 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_MD_FAULTY is not set
CONFIG_BLK_DEV_DM=y
# CONFIG_DM_CRYPT is not set
# CONFIG_DM_SNAPSHOT is not set
# CONFIG_DM_MIRROR is not set
# CONFIG_DM_ZERO is not set

#
# Fusion MPT device support
#

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_NETLINK_DEV=y
CONFIG_UNIX=y
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_MULTIPATH=y
# CONFIG_IP_ROUTE_VERBOSE is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_INET_IPCOMP=y
CONFIG_INET_TUNNEL=y
CONFIG_IP_TCPDIAG=y
# CONFIG_IP_TCPDIAG_IPV6 is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
# CONFIG_IP_NF_CT_ACCT is not set
# CONFIG_IP_NF_CONNTRACK_MARK is not set
# CONFIG_IP_NF_CT_PROTO_SCTP is not set
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
# CONFIG_IP_NF_MATCH_ADDRTYPE is not set
# CONFIG_IP_NF_MATCH_REALM is not set
# CONFIG_IP_NF_MATCH_SCTP is not set
# CONFIG_IP_NF_MATCH_COMMENT is not set
# CONFIG_IP_NF_MATCH_HASHLIMIT is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
# CONFIG_IP_NF_TARGET_NETMAP is not set
CONFIG_IP_NF_TARGET_SAME=m
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
# CONFIG_IP_NF_RAW is not set
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
CONFIG_XFRM=y
CONFIG_XFRM_USER=y

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IP_SCTP=m
CONFIG_SCTP_DBG_MSG=y
CONFIG_SCTP_DBG_OBJCNT=y
# CONFIG_SCTP_HMAC_NONE is not set
CONFIG_SCTP_HMAC_SHA1=y
# CONFIG_SCTP_HMAC_MD5 is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set
# CONFIG_NET_CLS_ROUTE is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
CONFIG_ETHERTAP=m

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_MII is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
CONFIG_NET_TULIP=y
# CONFIG_DE2104X is not set
CONFIG_TULIP=y
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
# CONFIG_TULIP_NAPI is not set
# CONFIG_DE4X5 is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_DM9102 is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
CONFIG_SERIO_PCIPS2=y
# CONFIG_SERIO_RAW is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_UINPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_INTEL_MCH is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=y
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_ELEKTOR is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
CONFIG_I2C_ISA=y
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=y
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=y
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_VIA686A=y
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83627HF is not set

#
# Other I2C Chip support
#
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=y
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
CONFIG_FB_NVIDIA=y
CONFIG_FB_NVIDIA_I2C=y
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ISA devices
#
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=m
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_VIA82XX=m
# CONFIG_SND_VX222 is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
# CONFIG_USB is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
# CONFIG_EXT2_FS_SECURITY is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS_XATTR=y
# CONFIG_DEVPTS_FS_SECURITY is not set
CONFIG_TMPFS=y
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_SQUASHFS=m
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_XATTR is not set
# CONFIG_CIFS_POSIX is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=m
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_KPROBES is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_4KSTACKS is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
# CONFIG_CRYPTO_WP512 is not set
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES_586=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_ARC4=m
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_MICHAEL_MIC=m
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

--=-=-=
Content-Disposition: attachment; filename=XF86Config-4
Content-Description: xfree86 configuration

# XF86Config-4 (XFree86 X Window System server configuration file)
#
# This file was generated by dexconf, the Debian X Configuration tool, using
# values from the debconf database.
#
# Edit this file with caution, and see the XF86Config-4 manual page.
# (Type "man XF86Config-4" at the shell prompt.)
#
# This file is automatically updated on xserver-xfree86 package upgrades *only*
# if it has not been modified since the last upgrade of the xserver-xfree86
# package.
#
# If you have edited this file but would like it to be automatically updated
# again, run the following commands as root:
#
#   cp /etc/X11/XF86Config-4 /etc/X11/XF86Config-4.custom
#   md5sum /etc/X11/XF86Config-4 > /var/lib/xfree86/XF86Config-4.md5sum
#   dpkg-reconfigure xserver-xfree86
Section "Files"
	FontPath	"unix/:7100"			# local font server
	# if the local font server has problems, we can fall back on these
	FontPath	"/usr/lib/X11/fonts/misc"
	FontPath	"/usr/lib/X11/fonts/cyrillic"
	FontPath	"/usr/lib/X11/fonts/100dpi/:unscaled"
	FontPath	"/usr/lib/X11/fonts/75dpi/:unscaled"
	FontPath	"/usr/lib/X11/fonts/Type1"
	FontPath	"/usr/lib/X11/fonts/CID"
	FontPath	"/usr/lib/X11/fonts/Speedo"
	FontPath	"/usr/lib/X11/fonts/100dpi"
	FontPath	"/usr/lib/X11/fonts/75dpi"
EndSection

Section "Module"
	Load	"GLcore"
	Load	"bitmap"
	Load	"dbe"
	Load	"ddc"
	Load	"dri"
	Load	"extmod"
	Load	"freetype"
	Load	"glx"
	Load	"int10"
	Load	"record"
	Load	"speedo"
	Load	"type1"
	Load	"vbe"
EndSection

Section "InputDevice"
	Identifier	"Generic Keyboard"
	Driver		"keyboard"
	Option		"CoreKeyboard"
	Option		"XkbRules"	"xfree86"
	Option		"XkbModel"	"pc104"
	Option		"XkbLayout"	"us"
	Option		"XkbOptions"	"ctrl:swapcaps"
EndSection

Section "InputDevice"
	Identifier	"Configured Mouse"
	Driver		"mouse"
	Option		"CorePointer"
	Option		"Device"		"/dev/psaux"
	Option		"Protocol"		"PS/2"
	Option		"ZAxisMapping"		"4 5"
EndSection

Section "InputDevice"
	Identifier	"Generic Mouse"
	Driver		"mouse"
	Option		"SendCoreEvents"	"true"
	Option		"Device"		"/dev/input/mice"
	Option		"Protocol"		"ImPS/2"
	Option		"ZAxisMapping"		"4 5"
EndSection

Section "Device"
	Identifier	"eVGA GeForce2 MX/MX400"
	Driver		"fbdev"
	Option		"UseFBDev"		"true"
EndSection

Section "Monitor"
	VendorName	"ViewSonic"
	ModelName	"PF775"
	Identifier	"ViewSonic PF775"
	HorizSync	30-97
	VertRefresh	50-180
	DisplaySize	315 243
	Option		"DPMS"
EndSection

Section "Screen"
	Identifier	"Default Screen"
	Device		"eVGA GeForce2 MX/MX400"
	Monitor		"ViewSonic PF775"
	DefaultDepth	16
	SubSection "Display"
		Depth		1
		Modes		"1600x1200"
	EndSubSection
	SubSection "Display"
		Depth		4
		Modes		"1600x1200"
	EndSubSection
	SubSection "Display"
		Depth		8
		Modes		"1600x1200"
	EndSubSection
	SubSection "Display"
		Depth		15
		Modes		"1600x1200"
	EndSubSection
	SubSection "Display"
		Depth		16
		Modes		"1600x1200" "800x600"
	EndSubSection
	SubSection "Display"
		Depth		24
		Modes		"1280x1024"
	EndSubSection
EndSection

Section "ServerLayout"
	Identifier	"Default Layout"
	Screen		"Default Screen"
	InputDevice	"Generic Keyboard"
	InputDevice	"Configured Mouse"
	InputDevice	"Generic Mouse"
EndSection

Section "DRI"
	Mode	0666
EndSection

--=-=-=--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
