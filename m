From: thunder7@xs4all.nl
Subject: Re: savagefb not working on thinkpad T23 in
	1400x1050
Date: Sun, 10 Dec 2006 20:29:07 +0100
Message-ID: <20061210192907.GB21994@amd64.of.nowhere>
References: <20061127201146.GA13885@amd64.of.nowhere>
	<Pine.LNX.4.64.0612082029110.9017@pentafluge.infradead.org>
Reply-To: Jurriaan <thunder7@xs4all.nl>,
	linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GtUMg-0006lN-5x for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 10 Dec 2006 11:29:34 -0800
Received: from smtp-vbr14.xs4all.nl ([194.109.24.34])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GtUMa-0005E9-Gb
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 10 Dec 2006 11:29:31 -0800
Received: from rivierenland.xs4all.nl (zeeotter.xs4all.nl [80.126.31.149])
	by smtp-vbr14.xs4all.nl (8.13.8/8.13.8) with ESMTP id kBAJTL5c078426
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 10 Dec 2006 20:29:23 +0100 (CET)
	(envelope-from jurriaan@rivierenland.xs4all.nl)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612082029110.9017@pentafluge.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: James Simmons <jsimmons@infradead.org>
Cc: neo@directfb.org, linux-fbdev-devel@lists.sourceforge.net, Jurriaan <thunder7@xs4all.nl>, dok@directfb.org

From: James Simmons <jsimmons@infradead.org>
Date: Fri, Dec 08, 2006 at 08:30:13PM +0000
> 
> > I got myself a shiny new IBM ThinkPad T23. I've used one for years, and
> > it worked fine with savagefb and XFree/X.org. The old one had a 1024x768
> > LCD screen, the new one has a 1400x1050 LCD screen.
> > 
> > Unfortunately, savagefb doesn't work correctly on the new laptop.
> > 
> > X.org works just fine in 1400x1050.
> 
> Can you enable debug in fbmon and post your dmesg. Also what default mode 
> is it trying to go to?
> 
> 
I've enabled debug in fbmon and gotten this dmesg (after 'modprobe
savagefb'). I don't see any debug messages. I also don't see any i2c
messages, and there's no *i2c* files under /sys.

I notice I didn't say clearly in my first post that 800x600 works,
1024x768 works, 1280x1024 flickers very badly, and 1400x1050 is
unreadable. Also, X.org tells me it's using a 60 Hz frequency, not 50 Hz
as someone else supposed. A part of Xorg.log is also below.

Thanks for your interest,
Jurriaan


X Window System Version 7.1.1
Release Date: 12 May 2006
X Protocol Version 11, Revision 0, Release 7.1.1
(--) PCI:*(1:0:0) S3 Inc. SuperSavage IX/C SDR rev 5, Mem @ 0xc0100000/19, 0xe8000000/26, 0xe4000000/26, 0xe0000000/25
(II) SAVAGE: driver (version 2.1.2) for S3 Savage chipsets: Savage4,
	Savage3D, Savage3D-MV, Savage2000, Savage/MX-MV, Savage/MX,
	Savage/IX-MV, Savage/IX, ProSavage PM133, ProSavage KM133,
	Twister PN133, Twister KN133, SuperSavage/MX 128, SuperSavage/MX 64,
	SuperSavage/MX 64C, SuperSavage/IX 128, SuperSavage/IX 128,
	SuperSavage/IX 64, SuperSavage/IX 64, SuperSavage/IXC 64,
	SuperSavage/IXC 64, ProSavage DDR, ProSavage DDR-K
(II) Primary Device is: PCI 01:00:0
(**) SAVAGE(0): Depth 24, (--) framebuffer bpp 32
(==) SAVAGE(0): RGB weight 888
(==) SAVAGE(0): Default visual is TrueColor
(II) SAVAGE(0): vgaHWGetIOBase: hwp->IOBase is 0x03d0, hwp->PIOOffset is 0x0000
(==) SAVAGE(0): Using XAA acceleration architecture
(==) SAVAGE(0): Using HW cursor
(==) SAVAGE(0): Using video BIOS to set modes
(II) SAVAGE(0): initializing int10
(II) SAVAGE(0): Primary V_BIOS segment is: 0xc000
(II) SAVAGE(0): VESA BIOS detected
(II) SAVAGE(0): VESA VBE Version 2.0
(II) SAVAGE(0): VESA VBE Total Mem: 15168 kB
(II) SAVAGE(0): VESA VBE OEM: S3 Incorporated. Paramont BIOS
(II) SAVAGE(0): VESA VBE OEM Software Rev: 1.0
(II) SAVAGE(0): VESA VBE OEM Vendor: S3 Incorporated.
(II) SAVAGE(0): VESA VBE OEM Product: VBE 2.0
(II) SAVAGE(0): VESA VBE OEM Product Rev: Rev 1.0
(--) SAVAGE(0): Chip: id 8c2e, "SuperSavage/IXC 64"
(--) SAVAGE(0): Engine: "SuperSavage"
(--) SAVAGE(0): AGP card detected
(==) SAVAGE(0): Using AGP DMA
(II) SAVAGE(0): DMA is not supported on SuperSavages.
(==) SAVAGE(0): DMA disabled
(==) SAVAGE(0): Using AGP 1x mode
(==) SAVAGE(0): Using 16 MB AGP aperture
(==) SAVAGE(0): Write-combining range (0xe8000000,0x4000000)
(==) SAVAGE(0): Write-combining range (0xe4000000,0x4000000)
(==) SAVAGE(0): Using gamma correction (1.0, 1.0, 1.0)
(--) SAVAGE(0): probed videoram:  16384k
(II) Loading sub module "ddc"
(II) LoadModule: "ddc"
(II) Reloading /usr/lib/xorg/modules/libddc.so
(--) SAVAGE(0): No DDC signal
(II) Loading sub module "i2c"
(II) LoadModule: "i2c"
(II) Loading /usr/lib/xorg/modules/libi2c.so
(II) Module i2c: vendor="X.Org Foundation"
	compiled for 7.1.1, module version = 1.2.0
	ABI class: X.Org Video Driver, version 1.0
(II) SAVAGE(0): I2C bus "I2C bus" initialized.
(II) SAVAGE(0): I2C device "I2C bus:ddc2" registered at address 0xA0.
(II) SAVAGE(0): I2C device "I2C bus:ddc2" removed.
(--) SAVAGE(0): Detected current MCLK value of 286.364 MHz
(--) SAVAGE(0): 1408x1050 TFT LCD panel detected and active
(--) SAVAGE(0): - Limiting video mode to 1408x1050
(--) SAVAGE(0): Found 13 modes at this depth:
    [10f] 320 x 200, 70Hz
    [112] 640 x 480, 60Hz, 72Hz, 75Hz, 85Hz, 100Hz
    [115] 800 x 600, 60Hz, 72Hz, 75Hz, 85Hz, 100Hz
    [118] 1024 x 768, 60Hz, 70Hz, 75Hz, 85Hz, 100Hz
    [11b] 1280 x 1024, 60Hz, 75Hz, 85Hz
    [11e] 640 x 400, 70Hz
    [124] 1600 x 1200, 60Hz, 75Hz, 85Hz
    [134] 320 x 240, 72Hz
    [13e] 1400 x 1050, 60Hz, 75Hz
    [144] 400 x 300, 72Hz
    [154] 512 x 384, 70Hz
    [175] 720 x 480, 75Hz
    [17f] 720 x 576, 75Hz
(II) SAVAGE(0): T23 screen: Using hsync range of 30.00-65.00 kHz
(II) SAVAGE(0): T23 screen: Using vrefresh range of 55.00-65.00 Hz
(II) SAVAGE(0): Clock range:  10.00 to 220.00 MHz
(--) SAVAGE(0): Virtual size is 1400x1050 (pitch 1408)
(**) SAVAGE(0): *Default mode "1400x1050": 122.0 MHz, 64.9 kHz, 60.0 Hz
(II) SAVAGE(0): Modeline "1400x1050"  122.00  1400 1488 1640 1880  1050 1052 1064 1082 +hsync +vsync
(**) SAVAGE(0):  Default mode "1280x1024": 108.0 MHz, 64.0 kHz, 60.0 Hz
(--) Depth 24 pixmap format is 32 bpp
(II) SAVAGE(0): initializing int10
(II) SAVAGE(0): Primary V_BIOS segment is: 0xc000
(II) SAVAGE(0): VESA BIOS detected
(II) SAVAGE(0): VESA VBE Version 2.0
(II) SAVAGE(0): VESA VBE Total Mem: 15168 kB
(II) SAVAGE(0): VESA VBE OEM: S3 Incorporated. Paramont BIOS
(II) SAVAGE(0): VESA VBE OEM Software Rev: 1.0
(II) SAVAGE(0): VESA VBE OEM Vendor: S3 Incorporated.
(II) SAVAGE(0): VESA VBE OEM Product: VBE 2.0
(II) SAVAGE(0): VESA VBE OEM Product Rev: Rev 1.0
(II) SAVAGE(0): 17556 kB of Videoram needed for 3D; 16384 kB of Videoram available
(EE) SAVAGE(0): Insufficient Videoram available for 3D -- Try a lower color depth or smaller desktop.  For integrated savages try increasing the videoram in the BIOS.
(EE) SAVAGE(0): DRI isn't enabled
(--) SAVAGE(0): Chose mode 13e at 60Hz.
(II) SAVAGE(0): Using 998 lines for offscreen memory.
(II) SAVAGE(0): Using XFree86 Acceleration Architecture (XAA)
	Screen to screen bit blits
	Solid filled rectangles
	8x8 mono pattern filled rectangles
	Indirect CPU to Screen color expansion
	Solid Lines
	Image Writes
	Offscreen Pixmaps
	Setting up tile and stipple cache:
		32 128x128 slots
		11 256x256 slots
(==) SAVAGE(0): Backing store disabled
(WW) SAVAGE(0): Direct rendering disabled

Linux version 2.6.19 (jurriaan@thinkpad) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-20)) #7 SMP Sun Dec 10 07:46:11 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff70000 (usable)
 BIOS-e820: 000000003ff70000 - 000000003ff7e000 (ACPI data)
 BIOS-e820: 000000003ff7e000 - 000000003ff80000 (ACPI NVS)
 BIOS-e820: 000000003ff80000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
Entering add_active_range(0, 0, 262000) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   262000
early_node_map[1] active PFN ranges
    0:        0 ->   262000
On node 0 totalpages: 262000
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 254 pages used for memmap
  HighMem zone: 32370 pages, LIFO batch:7
DMI present.
Using APIC driver default
ACPI: RSDP (v002 IBM                                   ) @ 0x000f7450
ACPI: XSDT (v001 IBM    TP-1A    0x00001180  LTP 0x00000000) @ 0x3ff73af2
ACPI: FADT (v001 IBM    TP-1A    0x00001180 IBM  0x00000001) @ 0x3ff73c00
ACPI: SSDT (v001 IBM    TP-1A    0x00001180 MSFT 0x0100000d) @ 0x3ff73cb4
ACPI: ECDT (v001 IBM    TP-1A    0x00001180 IBM  0x00000001) @ 0x3ff7ded1
ACPI: BOOT (v001 IBM    TP-1A    0x00001180  LTP 0x00000001) @ 0x3ff7dfd8
ACPI: DSDT (v001 IBM    TP-1A    0x00001180 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Allocating PCI resources starting at 50000000 (gap: 40000000:bf800000)
Detected 999.205 MHz processor.
Built 1 zonelists.  Total pages: 259954
Kernel command line: root=/dev/hda1
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (0182c000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1032148k/1048000k available (3209k kernel code, 15260k reserved, 1461k data, 276k init, 130496k highmem)
virtual kernel memory layout:
    fixmap  : 0xffe16000 - 0xfffff000   (1956 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc060d000 - 0xc0652000   ( 276 kB)
      .data : 0xc0422653 - 0xc058fd8c   (1461 kB)
      .text : 0xc0100000 - 0xc0422653   (3209 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1999.14 BogoMIPS (lpj=999573)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 20k freed
ACPI: Core revision 20060707
 tbxface-0107 [01] load_tables           : ACPI Tables successfully acquired
Parsing all Control Methods:
Table [DSDT](id 0006) - 1206 Objects with 60 Devices 363 Methods 18 Regions
Parsing all Control Methods:
Table [SSDT](id 0004) - 1 Objects with 0 Devices 1 Methods 0 Regions
ACPI Namespace successfully loaded at root c06b32d0
ACPI: setting ELCR to 0200 (from 0820)
evxfevnt-0089 [02] enable                : Transition to ACPI mode successful
CPU0: Intel(R) Pentium(R) III Mobile CPU      1000MHz stepping 01
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
Brought up 1 CPUs
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd8fe, last bus=8
PCI: Using configuration type 1
Setting up standard PCI resources
evgpeblk-0951 [04] ev_create_gpe_block   : GPE 00 to 0F [_GPE] 2 regs on int 0x9
evgpeblk-0951 [04] ev_create_gpe_block   : GPE 10 to 1F [_GPE] 2 regs on int 0x9
evgpeblk-1048 [03] ev_initialize_gpe_bloc: Found 6 Wake, Enabled 0 Runtime GPEs in this block
evgpeblk-1048 [03] ev_initialize_gpe_bloc: Found 2 Wake, Enabled 0 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:....................................................................................................................................................................................................................................
Initialized 17/18 Regions 124/124 Fields 61/61 Buffers 26/34 Packages (1216 nodes)
Initializing Device/Processor/Thermal objects by executing _INI methods:.......
Executed 7 _INI methods requiring 2 _STA executions (examined 64 objects)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Firmware left 0000:02:08.0 e100 interrupts enabled, disabling
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [PUBS] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
intel_rng: FWH not detected
SCSI subsystem initialized
libata version 2.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: c0100000-c01fffff
  PREFETCH window: e0000000-ebffffff
PCI: Bus 3, cardbus bridge: 0000:02:00.0
  IO window: 00002000-000020ff
  IO window: 00002400-000024ff
  PREFETCH window: f0000000-f1ffffff
  MEM window: c2000000-c3ffffff
PCI: Bus 7, cardbus bridge: 0000:02:00.1
  IO window: 00002800-000028ff
  IO window: 00002c00-00002cff
  PREFETCH window: f2000000-f3ffffff
  MEM window: c4000000-c5ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 2000-6fff
  MEM window: c0200000-cfffffff
  PREFETCH window: f0000000-f7ffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:02:00.1[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Simple Boot Flag at 0x35 set to 0x1
Machine check exception polling timer started.
speedstep: frequency transition measured seems out of range (0 nSec), falling back to a safe one of 50000 nSec.
IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Thermal Zone [THM0] (62 C)
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 830M Chipset.
agpgart: AGP aperture is 256M @ 0xd0000000
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using get_cycles().
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
Floppy drive(s): fd0 is 1.44M
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 7.2.9-k4
Copyright (c) 1999-2006 Intel Corporation.
e100: Intel(R) PRO/100 Network Driver, 3.5.17-k2-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
ACPI: PCI Interrupt 0000:02:08.0[A] -> Link [LNKE] -> GSI 11 (level, low) -> IRQ 11
e100: eth0: e100_probe: addr 0xc0200000, irq 11, MAC addr 00:D0:59:D7:68:23
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.57.
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: ST94811A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: MATSHITADVD-ROM SR-8175, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 78140160 sectors (40007 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
3ware Storage Controller device driver for Linux v1.26.02.001.
Fusion MPT base driver 3.04.02
Copyright (c) 1999-2005 LSI Logic Corporation
Fusion MPT SPI Host driver 3.04.02
ieee1394: raw1394: /dev/raw1394 device initialized
Yenta: CardBus bridge found at 0000:02:00.0 [1014:023b]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:00.0, mfunc 0x01d21022, devctl 0x64
Yenta: ISA IRQ mask 0x04d8, PCI irq 11
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x2000 - 0x6fff
pcmcia: parent PCI bridge Memory window: 0xc0200000 - 0xcfffffff
pcmcia: parent PCI bridge Memory window: 0xf0000000 - 0xf7ffffff
Yenta: CardBus bridge found at 0000:02:00.1 [1014:023b]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:00.1, mfunc 0x01d21022, devctl 0x64
Yenta: ISA IRQ mask 0x04d8, PCI irq 5
Socket status: 30000020
pcmcia: parent PCI bridge I/O window: 0x2000 - 0x6fff
pcmcia: parent PCI bridge Memory window: 0xc0200000 - 0xcfffffff
pcmcia: parent PCI bridge Memory window: 0xf0000000 - 0xf7ffffff
usbmon: debugfs is not available
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 11, io base 0x00001800
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 11, io base 0x00001820
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 11, io base 0x00001840
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usbcore: registered new interface driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
Intel 810 + AC97 Audio, version 1.01, 16:28:21 Nov 30 2006
PCI: Enabling device 0000:00:1f.5 (0000 -> 0001)
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.5 to 64
i810: Intel ICH3 found at IO 0x18c0 and 0x1c00, MEM 0x0000 and 0x0000, IRQ 5
input: AT Translated Set 2 keyboard as /class/input/input0
pccard: CardBus card inserted into slot 1
IBM TrackPoint firmware: 0x0e, buttons: 3/3
input: TPPS/2 IBM TrackPoint as /class/input/input1
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
ac97_codec: AC97 Audio codec, id: CRY54 (Unknown)
i810_audio: AC'97 codec 0 supports AMAP, total channels = 2
oprofile: using timer interrupt.
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
acpi_processor-0740 [00] processor_preregister_: Error while parsing _PSD domain information. Assuming no coordination
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
Time: acpi_pm clocksource has been installed.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 276k freed
Adding 2008116k swap on /dev/hda2.  Priority:-1 extents:1 across:2008116k
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on hda1, internal journal
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
savagefb: mapped io at f8a00000
savagefb: probed videoram:  16384k
savagefb: Detected current MCLK value of 286364 kHz
savagefb: 1408x1050 TFT LCD panel detected and active
savagefb: Limiting video mode to 1408x1050
savagefb: mapped framebuffer at f8b00000, pbase == e8000000
savagefb v0.4.0_2.6: 16256kB VRAM, using 800x600, 37.878kHz, 60Hz
Console: switching to colour frame buffer device 100x37
fb: S3 SuperSavage frame buffer device
-- 
Jim Hacker: "Now about nailing that leak..."
Bernard Woolley: "I'm sorry to be pedantic, but if you nail a leak you
make another."
        Yes Prime Minister
Debian (Unstable) GNU/Linux 2.6.19-rc5-mm1 2x4826 bogomips load 0.81
the Jack Vance Integral Edition: http://www.integralarchive.org

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
