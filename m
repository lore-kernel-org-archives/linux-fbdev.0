From: Ploum Ploum <ploum@mitose.net>
Subject: Re: [patch] Re: GeForce 4 MX have no working
 frame buffer at all..
Date: Sat, 21 Aug 2004 19:45:11 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <41278A27.2070608@mitose.net>
References: <412729BC.5000102@mitose.net> <20040821111414.GA6818@electric-eye.fr.zoreil.com> <200408212009.30477.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030506060204080907050902"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ByZsy-0000hV-9n
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 21 Aug 2004 10:42:36 -0700
Received: from outmx002.isp.belgacom.be ([195.238.3.52])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34)
	id 1ByZsw-0005LY-KC
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 21 Aug 2004 10:42:36 -0700
Received: from outmx002.isp.belgacom.be (localhost [127.0.0.1])
        by outmx002.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with ESMTP id i7LHgPxt024619
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 21 Aug 2004 19:42:25 +0200
        (envelope-from <ploum@mitose.net>)
In-Reply-To: <200408212009.30477.adaplas@hotpop.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, Francois Romieu <romieu@fr.zoreil.com>

This is a multi-part message in MIME format.
--------------030506060204080907050902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by outmx002.isp.belgacom.be id i7LHgPxt024619

Antonino A. Daplas wrote:

>On Saturday 21 August 2004 19:14, Francois Romieu wrote:
> =20
>
>>Ploum Ploum <ploum@mitose.net> :
>>[...]
>>
>>   =20
>>
>>>Here's the lspci -vvvv output for the card :
>>>
>>>0000:02:00.0 VGA compatible controller: nVidia Corporation NV18
>>>[GeForce4 MX 440 AGP 8x] (rev a2) (prog-if 00 [VGA])
>>>     =20
>>>
>>Try patch below. If it does not work, please send a complete dmesg and
>>lspci -vx.
>>
>>diff -puN drivers/video/riva/fbdev.c~rivafb-missing-id
>>drivers/video/riva/fbdev.c ---
>>linux-2.6.8.1/drivers/video/riva/fbdev.c~rivafb-missing-id	2004-08-21
>>13:05:41.000000000 +0200 +++
>>linux-2.6.8.1-romieu/drivers/video/riva/fbdev.c	2004-08-21
>>13:07:31.000000000 +0200 @@ -1836,6 +1836,7 @@ static u32
>>riva_get_arch(struct pci_dev
>> 		case 0x0110:   /* GeForce2 MX */
>> 		case 0x0150:   /* GeForce2 */
>> 		case 0x0170:   /* GeForce4 MX */
>>+		case 0x0171:   /* GeForce4 MX */
>> 		case 0x0180:   /* GeForce4 MX (8x AGP) */
>> 		case 0x01A0:   /* nForce */
>> 		case 0x01F0:   /* nForce2 */
>>
>>   =20
>>
>
>No, the above won't work.  The GF4 MX 440 is NV18 which should be covere=
d
>by the statement 'case 0x0180'.
>
>Try using linux-2.6.8.1 + Andrew's -mm2 patch.  Older 2.6 kernels incorr=
ectly
>classified your card as NV_ARCH_20, which should be NV_ARCH_10.
>
>Tony
> =20
>

I've applied the mm3 patch from kernel.org and the patch supplied by=20
Fran=E7ois Romieu but there's no change at all.

Note, I forget to say that I can enable the framebuffer but only at=20
800x600.  If I put vga=3Dash (video=3Dvesafb), it simply won't recognise =
any=20
number that correspond to a higher resolution. Also, using the=20
framebuffer at 800x600 has a grave bug : once that X is started, I=20
cannot anymore see a console, only a black screen. those console works=20
perfectly (I can "blind" type on it) but I cannot see it.  Even if I=20
kill X, only a black screen remains.

I've put video=3Drivafb also, but then it simply doesn't work and boot on=
=20
a non-fb console.

Please find dmesg and lspci -vx as attach.

Thx a lot for your interest in my problem :-)

Ploum



--------------030506060204080907050902
Content-Type: text/plain;
 name="dmesg.txt"
Content-Disposition: inline;
 filename="dmesg.txt"
Content-Transfer-Encoding: 7bit

Linux version 2.6.8.1 (root@mars) (version gcc 3.3.4 (Debian 1:3.3.4-7)) #1 Sat Aug 14 19:02:40 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 Nvidia                                    ) @ 0x000f74e0
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
Built 1 zonelists
Kernel command line: root=/dev/hda1 ro pci=noacpi video=vesafb vga=ask 
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1840.280 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 515292k/524224k available (2052k kernel code, 8168k reserved, 815k data, 148k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3629.05 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: After vendor identify, caps:  0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps:        0383fbff c1c3fbff 00000000 00000020
CPU: AMD Athlon(tm) XP 2500+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1839.0922 MHz.
..... host bus clock speed is 334.0531 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb4c0, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Edge set to Level Trigger.
spurious 8259A interrupt: IRQ7.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Discovered primary peer bus ff [IRQ]
PCI: Using IRQ router default [10de/01e0] at 0000:00:00.0
vesafb: probe of vesafb0 failed with error -6
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Real Time Clock Driver v1.12
Using anticipatory io scheduler
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
HDLC support module revision 1.17
Cronyx Ltd, Synchronous PPP and CISCO HDLC (c) 1994
Linux port (c) 1998 Building Number Three Ltd & Jan "Yenya" Kasprzak.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6Y080L0, ATA DISK drive
hdb: Maxtor 6Y080L0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: PLEXTOR CD-R PREMIUM, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(133)
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 >
hdb: max request size: 128KiB
hdb: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(133)
 hdb: hdb1 hdb2 hdb3 < hdb5 hdb6 hdb7 hdb8 hdb9 >
hdc: ATAPI 40X CD-ROM CD-R/RW drive, 8192kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: PS2++ Logitech MX Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 148k freed
Adding 489936k swap on /dev/hda5.  Priority:-1 extents:1
EXT3 FS on hda1, internal journal
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
nvidia: module license 'NVIDIA' taints kernel.
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-6106  Wed Jun 23 08:14:01 PDT 2004
lp: driver loaded but no devices found
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x5000
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x5100
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on hda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 49314 usecs
intel8x0: clocking to 47500
8139too Fast Ethernet driver 0.9.27
eth0: RealTek RTL8139 at 0xe092c000, 00:04:61:52:95:f6, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8101'
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected NVIDIA nForce2 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xe0000000
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:02.0: nVidia Corporation nForce2 USB Controller
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: irq 5, pci mem e095a000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ohci_hcd 0000:00:02.1: nVidia Corporation nForce2 USB Controller (#2)
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: irq 11, pci mem e0998000
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ehci_hcd 0000:00:02.2: nVidia Corporation nForce2 USB Controller
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 5, pci mem e099a000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 6 ports detected
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: Unexpected PCI resource length of 1000!
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[11]  MMIO=[ea082000-ea0827ff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0004610000052a29]
cdrom: This disc doesn't have any tracks I recognize!
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: Putting AGP V3 device at 0000:02:00.0 into 8x mode
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: Putting AGP V3 device at 0000:02:00.0 into 8x mode
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1

--------------030506060204080907050902
Content-Type: text/plain;
 name="lspci.txt"
Content-Disposition: inline;
 filename="lspci.txt"
Content-Transfer-Encoding: 7bit

0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?) (rev c1)
	Flags: bus master, 66MHz, fast devsel, latency 0
	Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>
00: de 10 e0 01 06 00 b0 00 c1 00 00 06 00 00 80 00
10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00

0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev c1)
	Subsystem: Unknown device 1695:1000
	Flags: 66MHz, fast devsel
00: de 10 eb 01 00 00 20 00 c1 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 95 16 00 10
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00

0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
	Subsystem: Unknown device 1695:1000
	Flags: 66MHz, fast devsel
00: de 10 ee 01 00 00 20 00 c1 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 95 16 00 10
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00

0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
	Subsystem: Unknown device 1695:1000
	Flags: 66MHz, fast devsel
00: de 10 ed 01 00 00 20 00 c1 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 95 16 00 10
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
	Subsystem: Unknown device 1695:1000
	Flags: 66MHz, fast devsel
00: de 10 ec 01 00 00 20 00 c1 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 95 16 00 10
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00

0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
	Subsystem: Unknown device 1695:1000
	Flags: 66MHz, fast devsel
00: de 10 ef 01 00 00 20 00 c1 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 95 16 00 10
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00

0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
	Subsystem: Unknown device 1695:1000
	Flags: bus master, 66MHz, fast devsel, latency 0
	Capabilities: <available only to root>
00: de 10 60 00 0f 00 b0 00 a4 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 95 16 00 10
30: 00 00 00 00 48 00 00 00 00 00 00 00 00 00 00 00

0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
	Subsystem: Unknown device 1695:1000
	Flags: 66MHz, fast devsel, IRQ 11
	I/O ports at c000 [size=32]
	Capabilities: <available only to root>
00: de 10 64 00 01 00 b0 00 a2 00 05 0c 00 00 80 00
10: 01 c0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 95 16 00 10
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 03 01

0000:00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 10 [OHCI])
	Subsystem: Unknown device 1695:1000
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 5
	Memory at eb002000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>
00: de 10 67 00 07 00 b0 00 a4 10 03 0c 00 00 80 00
10: 00 20 00 eb 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 95 16 00 10
30: 00 00 00 00 44 00 00 00 00 00 00 00 05 01 03 01

0000:00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 10 [OHCI])
	Subsystem: Unknown device 1695:1000
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 11
	Memory at eb003000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>
00: de 10 67 00 07 00 b0 00 a4 10 03 0c 00 00 80 00
10: 00 30 00 eb 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 95 16 00 10
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 02 03 01

0000:00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 20 [EHCI])
	Subsystem: Unknown device 1695:1000
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 5
	Memory at eb004000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>
00: de 10 68 00 06 00 b0 00 a4 20 03 0c 00 00 80 00
10: 00 40 00 eb 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 95 16 00 10
30: 00 00 00 00 44 00 00 00 00 00 00 00 05 03 03 01

0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio Controler (MCP) (rev a1)
	Subsystem: Unknown device 1695:1001
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 5
	I/O ports at b000 [size=256]
	I/O ports at b400 [size=128]
	Memory at eb000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>
00: de 10 6a 00 07 00 b0 00 a1 00 01 04 00 00 00 00
10: 01 b0 00 00 01 b4 00 00 00 00 00 eb 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 95 16 01 10
30: 00 00 00 00 44 00 00 00 00 00 00 00 05 01 02 05

0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3) (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 00009000-0000afff
	Memory behind bridge: ea000000-eaffffff
00: de 10 6c 00 07 01 a0 00 a3 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 20 90 a0 80 a2
20: 00 ea f0 ea f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00

0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) (prog-if 8a [Master SecP PriP])
	Subsystem: Unknown device 1695:1000
	Flags: bus master, 66MHz, fast devsel, latency 0
	I/O ports at f000 [size=16]
	Capabilities: <available only to root>
00: de 10 65 00 05 00 b0 00 a2 8a 01 01 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 f0 00 00 00 00 00 00 00 00 00 00 95 16 00 10
30: 00 00 00 00 44 00 00 00 00 00 00 00 00 00 03 01

0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1) (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, medium devsel, latency 32
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	Memory behind bridge: e8000000-e9ffffff
	Prefetchable memory behind bridge: e4000000-e7ffffff
00: de 10 e8 01 07 01 20 02 c1 00 04 06 00 20 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 20 f0 00 20 22
20: 00 e8 f0 e9 00 e4 f0 e7 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0a 00

0000:01:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Unknown device 1695:9001
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at 9000 [size=256]
	Memory at ea081000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>
00: ec 10 39 81 07 00 90 02 10 00 00 02 00 20 00 00
10: 01 90 00 00 00 10 08 ea 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 95 16 01 90
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 20 40

0000:01:0d.0 FireWire (IEEE 1394): Lucent Microelectronics FW323 (rev 61) (prog-if 10 [OHCI])
	Subsystem: Unknown device 1695:9015
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at ea082000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>
00: c1 11 11 58 06 00 90 02 61 10 00 0c 08 20 00 00
10: 00 20 08 ea 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 95 16 15 90
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 0c 18

0000:02:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX 440 AGP 8x] (rev a2) (prog-if 00 [VGA])
	Flags: bus master, 66MHz, medium devsel, latency 248, IRQ 11
	Memory at e8000000 (32-bit, non-prefetchable) [size=16M]
	Memory at e4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>
00: de 10 81 01 07 00 b0 02 a2 00 00 03 00 f8 00 00
10: 00 00 00 e8 08 00 00 e4 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 05 01


--------------030506060204080907050902--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
