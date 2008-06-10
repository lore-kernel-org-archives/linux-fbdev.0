From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [Bug 10766]
Date: Tue, 10 Jun 2008 22:17:51 +0200
Message-ID: <20080610221751.2d47a193.krzysztof.h1@poczta.fm>
References: <E1K5seF-000DzY-00.ashirapov-denis-mail-ru@mx27.mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart=_Tue__10_Jun_2008_22_17_51_+0200_6Y1ok4NA2I+00VPv"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K6AFL-0006QW-T5 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 10 Jun 2008 13:15:12 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K6AFJ-0000cn-Mu
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 10 Jun 2008 13:15:11 -0700
In-Reply-To: <E1K5seF-000DzY-00.ashirapov-denis-mail-ru@mx27.mail.ru>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "=?UTF-8?Q? =D0=90=D1=88=D0=B8=D1=80=D0=B0=D0=BF=D0=BE=D0=B2_=D0=94. ?=" <ashirapov.denis@mail.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, bugme-daemon@bugzilla.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Tue__10_Jun_2008_22_17_51_+0200_6Y1ok4NA2I+00VPv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Jun 2008 07:27:30 +0500
"=D0=90=D1=88=D0=B8=D1=80=D0=B0=D0=BF=D0=BE=D0=B2 =D0=94." <ashirapov.den=
is@mail.ru> wrote:

> Hello Krzysztof Helt,=20
>=20
>=20
>=20
> >Can you email me the .config file from the 2.6.25 kernel you use to tr=
igger the bug?
>=20
> Config of the 2.6.25 kernel in attached file.=20
>=20
>=20

Hi Denis,

I have not good news.

I have finally borrowed the card designed as GF4MX440-8X (Geforce MX 440 =
 AGP 8X), but I could not reproduce the bug.
I used the config file you sent me.
I tried also on the Nvidia TNT card and S3 Savage4 card (Number9 SR9). Th=
e vesafb worked for both.

The dmesg from my computer with Geforce MX 440 card is attached. The inte=
resting part is:

pci 0000:01:00.0: Boot video device
pci 0000:02:02.0: Firmware left e100 interrupts enabled; disabling
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
vesafb: framebuffer at 0xf0000000, mapped to 0xe0a80000, using 3072k, tot=
al 65536k
vesafb: mode is 1024x768x16, linelength=3D2048, pages=3D1
vesafb: protected mode interface info at c000:ef40
vesafb: pmi: set display start =3D c00cef76, set palette =3D c00cefe0
vesafb: pmi: ports =3D 3b4 3b5 3ba 3c0 3c1 3c4 3c5 3c6 3c7 3c8 3c9 3cc 3c=
e 3cf 3d0 3d1 3d2 3d3 3d4 3d5 3da
vesafb: scrolling: redraw
vesafb: Truecolor: size=3D0:5:6:5, shift=3D0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device

As I am not able to reproduce the bug, please test if you can connect to =
the computer with black screen (e.g. from another one through ssh). I use=
d the 791 constant.
Can you dump the dmesg with disabled screen and to me?

Regards,
Krzysztof


----------------------------------------------------------------------
Tania telefonia internetowa!
Sprawdz >>>  http://link.interia.pl/f1e2e

--Multipart=_Tue__10_Jun_2008_22_17_51_+0200_6Y1ok4NA2I+00VPv
Content-Type: application/octet-stream;
 name="nv.dmesg"
Content-Disposition: attachment;
 filename="nv.dmesg"
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.25 (root@krzysio) (gcc version 3.4.6) #2 Tue Jun 10 18:49=
:11 CEST 2008
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 0000000020000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
Entering add_active_range(0, 0, 131056) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   131056
  HighMem    131056 ->   131056
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->   131056
On node 0 totalpages: 131056
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 991 pages used for memmap
  Normal zone: 125969 pages, LIFO batch:31
  HighMem zone: 0 pages used for memmap
  Movable zone: 0 pages used for memmap
DMI 2.3 present.
ACPI: RSDP 000E0010, 0014 (r0 COMPAQ)
ACPI: RSDT 000E0080, 0040 (r1 COMPAQ CPQB154  20010410             0)
ACPI: FACP 000E00EC, 0074 (r1 COMPAQ CARMEL          1             0)
ACPI: DSDT 000E0230, 1B6C (r1 COMPAQ     DSDT        1 MSFT  100000D)
ACPI: FACS 000E0040, 0040
ACPI: APIC 000E0160, 0068 (r1 COMPAQ CARMEL          1             0)
ACPI: SSDT 000E1D9C, 005B (r1 COMPAQ   ZURICH        1 MSFT  100000D)
ACPI: SSDT 000E1FE8, 06A5 (r1 COMPAQ PNP_PRSS        1 MSFT  100000D)
ACPI: SSDT 000E3414, 005D (r1 COMPAQ     FHUB        1 MSFT  100000D)
ACPI: SSDT 000E268D, 0CBF (r1 COMPAQ  THERMAL        1 MSFT  100000D)
ACPI: SSDT 000E334C, 0024 (r1 COMPAQ       S1        1 MSFT  100000D)
ACPI: PM-Timer IO Port: 0xf808
Allocating PCI resources starting at 30000000 (gap: 20000000:e0000000)
PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130033
Kernel command line: BOOT_IMAGE=3DLinux-mm ro root=3D306 video=3Dtridentfb:=
1024x768
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Detected 863.954 MHz processor.
Console: colour dummy device 80x25
console [tty0] enabled
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 510216k/524224k available (6049k kernel code, 13448k reserved, 2049=
k data, 352k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffe8000 - 0xfffff000   (  92 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xe0800000 - 0xff7fe000   ( 495 MB)
    lowmem  : 0xc0000000 - 0xdfff0000   ( 511 MB)
      .init : 0xc08ec000 - 0xc0944000   ( 352 kB)
      .data : 0xc06e862f - 0xc08e8b74   (2049 kB)
      .text : 0xc0100000 - 0xc06e862f   (6049 kB)
Checking if this processor honours the WP bit even in supervisor mode...Ok.
CPA: page pool initialized 1 of 1 pages preallocated
SLUB: Genslabs=3D12, HWalign=3D32, Order=3D0-1, MinObjects=3D4, CPUs=3D1, N=
odes=3D1
Calibrating delay using timer specific routine.. 1729.20 BogoMIPS (lpj=3D34=
58406)
Security Framework initialized
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
CPU: Intel Pentium III (Coppermine) stepping 03
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 0k freed
ACPI: Core revision 20070126
ACPI: setting ELCR to 0200 (from 0c20)
net_namespace: 540 bytes
xor: automatically using best checksumming function: pIII_sse
   pIII_sse  :  1798.000 MB/sec
xor: using function: pIII_sse (1798.000 MB/sec)
NET: Registered protocol family 16
No dock devices found.
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xedb08, last bus=3D2
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S4 S5)
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
pci 0000:00:1f.0: quirk: region f800-f87f claimed by ICH4 ACPI/GPIO/TCO
pci 0000:00:1f.0: quirk: region fa00-fa3f claimed by ICH4 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BUS1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11)
ACPI: Power Resource [PFN0] (on)
ACPI: Power Resource [PFN1] (on)
ACPI: Power Resource [PFN2] (on)
ACPI: Power Resource [PFN3] (on)
ACPI: Power Resource [PFN4] (on)
ACPI: Power Resource [PFN5] (on)
ACPI: Power Resource [PFN6] (on)
ACPI: Power Resource [PFN7] (on)
ACPI: Power Resource [PFN8] (on)
ACPI: Power Resource [PFN9] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 16 devices
ACPI: ACPI bus type pnp unregistered
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a r=
eport
ACPI: RTC can wake from S4
system 00:0c: ioport range 0x4d0-0x4d1 has been reserved
system 00:0d: ioport range 0x400-0x41f has been reserved
system 00:0d: ioport range 0x420-0x43f has been reserved
system 00:0d: ioport range 0x440-0x45f has been reserved
system 00:0d: ioport range 0x460-0x47f has been reserved
system 00:0d: ioport range 0xf800-0xf81f has been reserved
system 00:0d: ioport range 0xf820-0xf83f has been reserved
system 00:0d: ioport range 0xf840-0xf85f has been reserved
system 00:0d: ioport range 0xf860-0xf87f has been reserved
system 00:0d: ioport range 0xfa00-0xfa1f has been reserved
system 00:0d: ioport range 0xfa20-0xfa3f has been reserved
system 00:0e: iomem range 0x0-0x9ffff could not be reserved
system 00:0e: iomem range 0xe0000-0xfffff could not be reserved
system 00:0e: iomem range 0x100000-0x2000ffff could not be reserved
system 00:0e: iomem range 0xfff80000-0xffffffff has been reserved
system 00:0e: iomem range 0xfeea0000-0xfeebffff has been reserved
system 00:0e: iomem range 0xd6a00-0xd7fff has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: 0xfd000000-0xfdffffff
  PREFETCH window: 0x00000000f0000000-0x00000000f7ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 5000-5fff
  MEM window: 0xefb00000-0xefffffff
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
NTFS driver 2.1.29 [Flags: R/W].
JFS: nTxBlock =3D 3987, nTxLock =3D 31899
SGI XFS with ACLs, security attributes, large block numbers, no debug enabl=
ed
SGI XFS Quota Management subsystem
GFS2 (built Jun  7 2008 17:57:41) installed
async_tx: api initialized (async)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci 0000:01:00.0: Boot video device
pci 0000:02:02.0: Firmware left e100 interrupts enabled; disabling
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
vesafb: framebuffer at 0xf0000000, mapped to 0xe0a80000, using 3072k, total=
 65536k
vesafb: mode is 1024x768x16, linelength=3D2048, pages=3D1
vesafb: protected mode interface info at c000:ef40
vesafb: pmi: set display start =3D c00cef76, set palette =3D c00cefe0
vesafb: pmi: ports =3D 3b4 3b5 3ba 3c0 3c1 3c4 3c5 3c6 3c7 3c8 3c9 3cc 3ce =
3cf 3d0 3d1 3d2 3d3 3d4 3d5 3da=20
vesafb: scrolling: redraw
vesafb: Truecolor: size=3D0:5:6:5, shift=3D0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
00:08: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
00:09: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
brd: module loaded
loop: module loaded
Compaq SMART2 Driver (v 2.6.0)
HP CISS Driver (v 3.6.14)
input: Macintosh mouse button emulation as /class/input/input0
Uniform Multi-Platform E-IDE driver
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ICH: IDE controller (0x8086:0x2411 rev 0x02) at  PCI slot 0000:00:1f.1
ICH: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x6460-0x6467, BIOS settings: hda:DMA, hdb:PIO
    ide1: BM-DMA at 0x6468-0x646f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: SAMSUNG SP0411N, ATA DISK drive
hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hda: UDMA/66 mode selected
Probing IDE interface ide1...
hdc: ATAPI DVD A DH20A3H, ATAPI CD/DVD-ROM drive
hdd: Compaq CRD-8402B, ATAPI CD/DVD-ROM drive
hdc: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hdc: UDMA/66 mode selected
hdd: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hdd: MWDMA2 mode selected
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 78242976 sectors (40060 MB) w/2048KiB Cache, CHS=3D16383/255/63
hda: cache flushes supported
 hda: hda1 hda2 < hda5 hda6 hda7 > hda3
hdc: ATAPI 12X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 48X CD-ROM drive, 128kB Cache
ide-floppy driver 1.00
Loading iSCSI transport class v2.0-869.
Loading Adaptec I2O RAID: Version 2.4 Build 5go
Detecting Adaptec I2O RAID controllers...
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:02:07.0[A] -> Link [LNKD] -> GSI 10 (level, low) -=
> IRQ 10
scsi2 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec aic7892 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=3D7, 32/253 SCBs

scsi 2:0:0:0: Direct-Access     COMPAQ   BD009222BB       3B09 PQ: 0 ANSI: 2
scsi2:A:0:0: Tagged Queuing enabled.  Depth 4
 target2:0:0: Beginning Domain Validation
 target2:0:0: wide asynchronous
 target2:0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 15)
 target2:0:0: Domain Validation skipping write tests
 target2:0:0: Ending Domain Validation
Adaptec aacraid driver 1.1-5[2455]-ms
aic94xx: Adaptec aic94xx SAS/SATA driver version 1.0.3 loaded
scsi: <fdomain> Detection failed (no card)
sym53c416.c: Version 1.0.0-ac
qlogicfas: no cards were found, please specify I/O address and IRQ using io=
base=3D and irq=3D options<6>QLogic Fibre Channel HBA Driver
iscsi: registered transport (qla4xxx)
QLogic iSCSI HBA Driver
Emulex LightPulse Fibre Channel SCSI driver 8.2.5
Copyright(c) 2004-2008 Emulex.  All rights reserved.
Failed initialization of WD-7000 SCSI card!
DC390: clustering now enabled by default. If you get problems load
	with "disable_clustering=3D1" and report to maintainers
megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16 00:01:03 EST 2006)
megaraid: 2.20.5.1 (Release Date: Thu Nov 16 15:32:35 EST 2006)
megasas: 00.00.03.16-rc1 Thu. Nov. 07 10:09:32 PDT 2007
GDT-HA: Storage RAID Controller Driver. Version: 3.05
GDT-HA: Found 0 PCI Storage RAID Controllers
3ware Storage Controller device driver for Linux v1.26.02.002.
3ware 9000 Storage Controller device driver for Linux v2.26.02.010.
nsp32: loading...
ipr: IBM Power RAID SCSI Device Driver version: 2.4.1 (April 24, 2007)
RocketRAID 3xxx/4xxx Controller driver v1.3 (071203)
st: Version 20080221, fixed bufsize 32768, s/g segs 256
Driver 'st' needs updating - please use bus_type methods
Driver 'sd' needs updating - please use bus_type methods
 target2:0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 15)
sd 2:0:0:0: [sda] 17773524 512-byte hardware sectors (9100 MB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: f3 00 10 08
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO a=
nd FUA
sd 2:0:0:0: [sda] 17773524 512-byte hardware sectors (9100 MB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: f3 00 10 08
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO a=
nd FUA
 sda: sda1
sd 2:0:0:0: [sda] Attached SCSI disk
Driver 'sr' needs updating - please use bus_type methods
I2O subsystem v1.325
i2o: max drivers =3D 8
I2O Configuration OSM v1.323
I2O Bus Adapter OSM v1.317
I2O Block Device OSM v1.325
I2O SCSI Peripheral OSM v1.316
I2O ProcFS OSM v1.316
Fusion MPT base driver 3.04.06
Copyright (c) 1999-2007 LSI Corporation
Fusion MPT SPI Host driver 3.04.06
Fusion MPT FC Host driver 3.04.06
Fusion MPT SAS Host driver 3.04.06
usbmon: debugfs is not available
116x: driver isp116x-hcd, 03 Nov 2005
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1f.2[D] -> Link [LNKD] -> GSI 10 (level, low) -=
> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci_hcd 0000:00:1f.2: UHCI Host Controller
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1f.2: irq 10, io base 0x00006440
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
sl811: driver sl811-hcd, 19 May 2005
Initializing USB Mass Storage driver...
usb 1-1: new full speed USB device using uhci_hcd and address 2
usb 1-1: configuration #1 chosen from 1 choice
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
PNP: PS/2 Controller [PNP0303:KBD,PNP0f0e:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: raid10 personality registered for level 10
raid6: int32x1    269 MB/s
raid6: int32x2    317 MB/s
raid6: int32x4    234 MB/s
raid6: int32x8    230 MB/s
raid6: mmxx1      759 MB/s
raid6: mmxx2      910 MB/s
raid6: sse1x1     696 MB/s
raid6: sse1x2     965 MB/s
raid6: using algorithm sse1x2 (965 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
md: multipath personality registered for level -4
device-mapper: ioctl: 4.13.0-ioctl (2007-10-18) initialised: dm-devel@redha=
t.com
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
Using IPI Shortcut mode
input: AT Translated Set 2 keyboard as /class/input/input1
md: Autodetecting RAID arrays.
md: Scanned 0 and added 0 devices.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 352k freed
EXT3 FS on hda6, internal journal
input: PC Speaker as /class/input/input2
parport_pc 00:07: reported by Plug and Play ACPI
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
iTCO_vendor_support: vendor-support=3D0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.02 (26-Jul-2007)
iTCO_wdt: Found a ICH TCO device (Version=3D1, TCOBASE=3D0xf860)
iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.3[B] -> Link [LNKB] -> GSI 5 (level, low) ->=
 IRQ 5
Linux agpgart interface v0.103
agpgart: Detected an Intel i840 Chipset.
agpgart: AGP aperture is 128M @ 0xe0000000
rtc_cmos: probe of 00:03 failed with error -16
Intel 82802 RNG detected
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 5 (level, low) ->=
 IRQ 5
PCI: Setting latency timer of device 0000:00:1f.5 to 64
input: Power Button (FF) as /class/input/input3
intel8x0_measure_ac97_clock: measured 58828 usecs
intel8x0: clocking to 48000
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input4
ACPI: ACPI0007:00 is registered as cooling_device0
ACPI: Power Button (CM) [PBTN]
eepro100.c:v1.09j-t 9/29/99 Donald Becker
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <s=
aw@saw.sw.com.sg> and others
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [LNKC] -> GSI 11 (level, low) -=
> IRQ 11
eth0: OEM i82557/i82558 10/100 Ethernet, 00:02:a5:1b:61:32, IRQ 11.
  Board assembly 010558-001, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
de2104x PCI Ethernet driver v0.7 (Mar 17, 2004)
ACPI: PCI Interrupt 0000:02:0a.0[A] -> Link [LNKC] -> GSI 11 (level, low) -=
> IRQ 11
de0: SROM leaf offset 30, default media 10baseT auto
de0:   media block #0: 10baseT-FD
de0:   media block #1: BNC
de0:   media block #2: 10baseT-HD
eth1: 21041 at 0xe0dec000, 00:80:c8:e8:5f:b9, IRQ 11
ACPI: PCI Interrupt 0000:02:0b.0[A] -> Link [LNKD] -> GSI 10 (level, low) -=
> IRQ 10
Vortex: init.... <6>ACPI: LNXTHERM:01 is registered as thermal_zone0
ACPI: Thermal Zone [THRM] (45 C)
done.
gameport: AU88x0 Gameport is pci0000:02:0b.0/gameport0, speed 1387kHz
ACPI: Transitioning device [FN0] to D3
ACPI: PNP0C0B:00 is registered as cooling_device1
ACPI: Fan [FN0] (off)
ACPI: Transitioning device [FN1] to D3
ACPI: PNP0C0B:01 is registered as cooling_device2
ACPI: Fan [FN1] (off)
ACPI: Transitioning device [FN2] to D3
ACPI: PNP0C0B:02 is registered as cooling_device3
ACPI: Fan [FN2] (off)
ACPI: Transitioning device [FN3] to D3
ACPI: PNP0C0B:03 is registered as cooling_device4
ACPI: Fan [FN3] (off)
ACPI: Transitioning device [FN4] to D3
ACPI: PNP0C0B:04 is registered as cooling_device5
ACPI: Fan [FN4] (off)
ACPI: Transitioning device [FN5] to D3
ACPI: PNP0C0B:05 is registered as cooling_device6
ACPI: Fan [FN5] (off)
ACPI: Transitioning device [FN6] to D3
ACPI: PNP0C0B:06 is registered as cooling_device7
ACPI: Fan [FN6] (off)
ACPI: Transitioning device [FN7] to D3
ACPI: PNP0C0B:07 is registered as cooling_device8
ACPI: Fan [FN7] (off)
ACPI: Transitioning device [FN8] to D3
ACPI: PNP0C0B:08 is registered as cooling_device9
ACPI: Fan [FN8] (off)
ACPI: PNP0C0B:09 is registered as cooling_device10
ACPI: Fan [FN9] (on)
Linux video capture interface: v2.00
zc0301: V4L2 driver for ZC0301[P] Image Processor and Control Chip v1:1.10
usb 1-1: ZC0301[P] Image Processor and Control Chip detected (vid/pid 0x0AC=
8:0x301B)
sd 2:0:0:0: Attached scsi generic sg0 type 0
usb 1-1: No supported image sensor detected
usbcore: registered new interface driver zc0301
lp0: using parport0 (interrupt-driven).
lp0: console ready
XFS mounting filesystem hda7
Ending clean XFS mount for filesystem: hda7
XFS mounting filesystem sda1
Ending clean XFS mount for filesystem: sda1
eth1: enabling interface
eth1: set link 10baseT auto
eth1:    mode 0x7ffc0040, sia 0x12c4,0xffffef01,0xffffffff,0xffff0008
eth1:    set mode 0x7ffc0040, set sia 0xef01,0xffff,0x8
eth1: link up, media 10baseT auto
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: unable to find recovery directory /var/lib/nfs/v4recovery
NFSD: starting 90-second grace period

--Multipart=_Tue__10_Jun_2008_22_17_51_+0200_6Y1ok4NA2I+00VPv
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--Multipart=_Tue__10_Jun_2008_22_17_51_+0200_6Y1ok4NA2I+00VPv
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--Multipart=_Tue__10_Jun_2008_22_17_51_+0200_6Y1ok4NA2I+00VPv--
