From: Andrew Walrond <andrew@walrond.org>
Subject: Re: Linux 2.6.10-rc2
Date: Wed, 17 Nov 2004 19:17:15 +0000
Message-ID: <200411171917.15962.andrew@walrond.org>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org> <200411171554.32382.andrew@walrond.org> <Pine.LNX.4.58.0411170802500.2222@ppc970.osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7O6mBm4ytLoSdSy"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUVJF-0003Pd-Lt
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Nov 2004 11:17:41 -0800
Received: from [62.24.231.113] (helo=cenedra.walrond.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CUVJ9-00037p-5M
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Nov 2004 11:17:41 -0800
In-Reply-To: <Pine.LNX.4.58.0411170802500.2222@ppc970.osdl.org>
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
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

--Boundary-00=_7O6mBm4ytLoSdSy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 17 Nov 2004 16:04, you wrote:
> On Wed, 17 Nov 2004, Andrew Walrond wrote:
> > changeset 1.2563 breaks the rivafb for x86_64 (64bit). I'm looking into
> > it with the fbdev guys help, so I'm sure a fix will be forthcoming soon.
>
> Just out of interest, can you compile a 32-bit kernel and try booting
> that? I realize that it won't actually run your user-space setup, but
> _assuming_ you see the breakage early at boot, that shouldn't even matter.
>

The breakage occurs as soon as rivafb takes over the console and changes mode 
during boot, and I have 32/64bit userspaces on this machine anyway.

But....

When I boot the 32bit kernel, rivafb fails like this:

rivafb_setup START
rivafb_probe START
ACPI: PCI interrupt 0000:05:00.0[A] -> GSI 16 (level, low) -> IRQ 16
rivafb: nVidia device/chipset 10DE0250
rivafb: nVidia Corporation NV25 [GeForce4 Ti 4600]
rivafb: Detected CRTC controller 0 being used
allocation failed: out of vmalloc space - use vmalloc=<size> to increase size.
rivafb: cannot ioremap FB base

Any clues? should I supply a vmalloc= boot param?

This is a dual opteron tyan s2885 k8w thunder with 2Gb/2Gb numa memory, in 
case that matters.

Full dmesg attached

Andrew

--Boundary-00=_7O6mBm4ytLoSdSy
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg.32bit"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg.32bit"

 3, version 17, address 0xfc9fe000, GSI 24-27
ACPI: IOAPIC (id[0x04] address[0xfc9ff000] gsi_base[28])
IOAPIC[2]: apic_id 4, version 17, address 0xfc9ff000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: root=/dev/md0
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fc9fe000)
mapped IOAPIC to ffffa000 (fc9ff000)
Initializing CPU#0
CPU 0 irqstacks, hard=c0537000 soft=c052f000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2391.901 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 3569580k/3604416k available (2905k kernel code, 34032k reserved, 1138k data, 216k init, 2686912k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4702.20 BogoMIPS (lpj=2351104)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 078bfbff e1d3fbff 00000000 00000000
CPU: After vendor identify, caps:  078bfbff e1d3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: After all inits, caps:        078bfbff e1d3fbff 00000000 00000010
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: AMD Opteron(tm) Processor 250 stepping 0a
per-CPU timeslice cutoff: 2925.76 usecs.
task migration cache decay timeout: 3 msecs.
Booting processor 1/1 eip 3000
CPU 1 irqstacks, hard=c0538000 soft=c0530000
Initializing CPU#1
Calibrating delay loop... 4767.74 BogoMIPS (lpj=2383872)
CPU: After generic identify, caps: 078bfbff e1d3fbff 00000000 00000000
CPU: After vendor identify, caps:  078bfbff e1d3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: After all inits, caps:        078bfbff e1d3fbff 00000000 00000010
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: AMD Opteron(tm) Processor 250 stepping 0a
Total of 2 processors activated (9469.95 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
CPU0:
 domain 0: span 03
  groups: 01 02
CPU1:
 domain 0: span 03
  groups: 02 01
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=5
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.GOLA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.GOLB._PRT]
ACPI: PCI Root Bridge [PCIB] (00:04)
PCI: Probing PCI hardware (bus 04)
ACPI: PCI Interrupt Routing Table [\_SB_.PCIB.PBP2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
pnp: 00:08: ioport range 0x680-0x6ff has been reserved
pnp: 00:08: ioport range 0x295-0x296 has been reserved
pnp: 00:08: ioport range 0x778-0x77f has been reserved
pnp: 00:08: ioport range 0xb78-0xb7f has been reserved
pnp: 00:08: ioport range 0xf78-0xf7f has been reserved
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
Initializing Cryptographic API
rivafb_setup START
rivafb_probe START
ACPI: PCI interrupt 0000:05:00.0[A] -> GSI 16 (level, low) -> IRQ 16
rivafb: nVidia device/chipset 10DE0250
rivafb: nVidia Corporation NV25 [GeForce4 Ti 4600]
rivafb: Detected CRTC controller 0 being used
allocation failed: out of vmalloc space - use vmalloc=<size> to increase size.
rivafb: cannot ioremap FB base
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU1] (supports 8 throttling states)
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
hw_random: AMD768 system management I/O registers at 0x5000.
hw_random hardware driver 1.0.0 loaded
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected AMD 8151 AGP Bridge rev B3
agpgart: Maximum main memory to use for agp memory: 3365M
agpgart: AGP aperture is 128M @ 0xf0000000
ipmi message handler version v33
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
lp0: using parport0 (interrupt-driven).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
elevator: using anticipatory as default io scheduler
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
tg3.c:v3.14 (November 15, 2004)
ACPI: PCI interrupt 0000:02:09.0[A] -> GSI 24 (level, low) -> IRQ 24
eth0: Tigon3 [partno(BCM95703A30) rev 1002 PHY(5703)] (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:2b:e3:37
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: _NEC DVD_RW ND-2500A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 1.10 loaded.
sata_sil version 0.8
ACPI: PCI interrupt 0000:03:0b.0[A] -> GSI 17 (level, low) -> IRQ 17
ata1: SATA max UDMA/100 cmd 0xF8804C80 ctl 0xF8804C8A bmdma 0xF8804C00 irq 17
ata2: SATA max UDMA/100 cmd 0xF8804CC0 ctl 0xF8804CCA bmdma 0xF8804C08 irq 17
ata3: SATA max UDMA/100 cmd 0xF8804E80 ctl 0xF8804E8A bmdma 0xF8804E00 irq 17
ata4: SATA max UDMA/100 cmd 0xF8804EC0 ctl 0xF8804ECA bmdma 0xF8804E08 irq 17
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003 88:207f
ata1: dev 0 ATA, max UDMA/133, 240121728 sectors:
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003 88:207f
ata2: dev 0 ATA, max UDMA/133, 240121728 sectors:
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil
ata3: no device found (phy stat 00000000)
scsi2 : sata_sil
ata4: no device found (phy stat 00000000)
scsi3 : sata_sil
  Vendor: ATA       Model: Maxtor 6Y120M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6Y120M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 240121728 512-byte hdwr sectors (122942 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 >
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI interrupt 0000:03:00.0[D] -> GSI 19 (level, low) -> IRQ 19
ohci_hcd 0000:03:00.0: Advanced Micro Devices [AMD] AMD-8111 USB
ohci_hcd 0000:03:00.0: irq 19, pci mem 0xfc8fd000
ohci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI interrupt 0000:03:00.1[D] -> GSI 19 (level, low) -> IRQ 19
ohci_hcd 0000:03:00.1: Advanced Micro Devices [AMD] AMD-8111 USB (#2)
ohci_hcd 0000:03:00.1: irq 19, pci mem 0xfc8fe000
ohci_hcd 0000:03:00.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
Initializing USB Mass Storage driver...
usb 1-1: new full speed USB device using ohci_hcd and address 2
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb 2-1: new low speed USB device using ohci_hcd and address 2
usb 2-2: new low speed USB device using ohci_hcd and address 3
usbcore: registered new driver hiddev
input: USB HID v1.10 Keyboard [Logitech USB Receiver] on usb-0000:03:00.1-1
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:03:00.1-1
input: USB HID v1.10 Keyboard [CHESEN USB Keyboard] on usb-0000:03:00.1-2
input: USB HID v1.10 Device [CHESEN USB Keyboard] on usb-0000:03:00.1-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  7472.000 MB/sec
raid5: using function: pIII_sse (7472.000 MB/sec)
raid6: int32x1    976 MB/s
raid6: int32x2   1289 MB/s
raid6: int32x4    699 MB/s
raid6: int32x8    687 MB/s
raid6: mmxx1     2011 MB/s
raid6: mmxx2     3757 MB/s
raid6: sse1x1    1546 MB/s
raid6: sse1x2    3175 MB/s
raid6: sse2x1    3156 MB/s
raid6: sse2x2    3886 MB/s
raid6: using algorithm sse2x2 (3886 MB/s)
md: raid6 personality registered as nr 8
md: multipath personality registered as nr 7
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
device-mapper: 4.3.0-ioctl (2004-09-30) initialised: dm-devel@redhat.com
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53 2004 UTC).
ACPI: PCI interrupt 0000:00:07.5[B] -> GSI 17 (level, low) -> IRQ 17
intel8x0_measure_ac97_clock: measured 50097 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: AMD AMD8111 with AD1981B at 0xc800, irq 17
NET: Registered protocol family 2
IP: routing cache hash table of 32768 buckets, 256Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
Starting balanced_irq
ACPI: (supports S0 S1 S4 S5)
ACPI wakeup devices: 
PCI1 USB0 USB1 UAR1 UAR2 GOLA GLAN GOLB SMBC AC97 MODM PWRB 
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdb6 ...
md:  adding sdb6 ...
md: sdb3 has different UUID to sdb6
md: sdb2 has different UUID to sdb6
md:  adding sda6 ...
md: sda3 has different UUID to sdb6
md: sda2 has different UUID to sdb6
md: created md2
md: bind<sda6>
md: bind<sdb6>
md: running: <sdb6><sda6>
md2: setting max_sectors to 8, segment boundary to 2047
blk_queue_segment_boundary: set to minimum fff
raid0: looking at sdb6
raid0:   comparing sdb6(98438144) with sdb6(98438144)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sda6
raid0:   comparing sda6(98438144) with sdb6(98438144)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 196876288 blocks.
raid0 : conf->hash_spacing is 196876288 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 4 bytes for hash.
md: considering sdb3 ...
md:  adding sdb3 ...
md: sdb2 has different UUID to sdb3
md:  adding sda3 ...
md: sda2 has different UUID to sdb3
md: created md1
md: bind<sda3>
md: bind<sdb3>
md: running: <sdb3><sda3>
md1: setting max_sectors to 8, segment boundary to 2047
blk_queue_segment_boundary: set to minimum fff
raid0: looking at sdb3
raid0:   comparing sdb3(9775488) with sdb3(9775488)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sda3
raid0:   comparing sda3(9775488) with sdb3(9775488)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 19550976 blocks.
raid0 : conf->hash_spacing is 19550976 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 4 bytes for hash.
md: considering sdb2 ...
md:  adding sdb2 ...
md:  adding sda2 ...
md: created md0
md: bind<sda2>
md: bind<sdb2>
md: running: <sdb2><sda2>
md0: setting max_sectors to 8, segment boundary to 2047
blk_queue_segment_boundary: set to minimum fff
raid0: looking at sdb2
raid0:   comparing sdb2(9775488) with sdb2(9775488)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sda2
raid0:   comparing sda2(9775488) with sdb2(9775488)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 19550976 blocks.
raid0 : conf->hash_spacing is 19550976 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 4 bytes for hash.
md: ... autorun DONE.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 216k freed
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1959888k swap on /dev/sda5.  Priority:1 extents:1
Adding 1959888k swap on /dev/sdb5.  Priority:1 extents:1
Disabled Privacy Extensions on device c049fba0(lo)
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
eth0: no IPv6 routers present

--Boundary-00=_7O6mBm4ytLoSdSy--


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
