From: Chris Rankin <rankincj@yahoo.com>
Subject: Linux 2.6.16: Cursor trouble on Matrox Millenium II framebuffer
Date: Wed, 22 Mar 2006 00:08:55 +0000 (GMT)
Message-ID: <20060322000855.5556.qmail@web52901.mail.yahoo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FLquM-00021Q-Th
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Mar 2006 16:09:02 -0800
Received: from web52901.mail.yahoo.com ([206.190.49.11])
	by mail.sourceforge.net with smtp (Exim 4.44)
	id 1FLquL-0007ex-8n
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Mar 2006 16:09:02 -0800
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
Content-Type: text/plain; charset="us-ascii"
To: vandrove@vc.cvut.cz
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi,

I have just booted vanilla 2.6.16, and am having trouble with the cursor =
on my framebuffer
console. The cursor tracks the column correctly, but appears on a line to=
o high up the screen.

All kernels up to 2.6.15 work correctly.

Cheers,
Chris

Linux version 2.6.16 (chris@volcano.underworld) (gcc version 3.4.4) #1 Mo=
n Mar 20 22:07:09 GMT
2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 0000000000100000 - 0000000004000000 (usable)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
64MB LOWMEM available.
On node 0 totalpages: 16384
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 12288 pages, LIFO batch:3
  HighMem zone: 0 pages, LIFO batch:0
DMI 2.0 present.
Allocating PCI resources starting at 10000000 (gap: 04000000:fbfc0000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=3D2.6.16 ro root=3D302 mce video=3Dmatrox=
fb:vesa:0x11A
No local APIC present or hardware disabled
mapped APIC to ffffd000 (01081000)
Initializing CPU#0
CPU 0 irqstacks, hard=3Dc02d3000 soft=3Dc02d2000
PID hash table entries: 512 (order: 9, 8192 bytes)
Detected 199.433 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 62484k/65536k available (1229k kernel code, 2660k reserved, 481k =
data, 128k init, 0k
highmem)
Checking if this processor honours the WP bit even in supervisor mode... =
Ok.
Calibrating delay using timer specific routine.. 399.46 BogoMIPS (lpj=3D1=
997301)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 008001bf 00000000 00000000 00000000 00=
000000 00000000 00000000
CPU: After vendor identify, caps: 008001bf 00000000 00000000 00000000 000=
00000 00000000 00000000
Intel Pentium with F0 0F bug - workaround enabled.
CPU: After all inits, caps: 008001bf 00000000 00000000 00000000 00000000 =
00000000 00000000
Intel old style machine check architecture supported.
Intel old style machine check reporting enabled on CPU#0.
CPU: Intel Pentium MMX stepping 03
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd2c1, last bus=3D1
PCI: Using configuration type 1
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f9f60
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xa060, dseg 0x400
PnPBIOS: Missing SMALL_TAG_ENDDEP tag
PnPBIOS: Missing SMALL_TAG_ENDDEP tag
PnPBIOS: Missing SMALL_TAG_ENDDEP tag
PnPBIOS: Missing SMALL_TAG_ENDDEP tag
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:0d.0
PCI: Bridge: 0000:00:0e.0
  IO window: f000-ffff
  MEM window: ff100000-ff9fffff
  PREFETCH window: ff000000-ff0fffff
PCI: Setting latency timer of device 0000:00:0e.0 to 64
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler deadline registered (default)
Limiting direct PCI/PCI transfers.
Activating ISA DMA hang workarounds.
matroxfb: Matrox Millennium II (PCI) detected
PInS memtype =3D 0
matroxfb: 1280x1024x16bpp (virtual: 1280x1638)
matroxfb: framebuffer at 0xFB000000, mapped to 0xc4880000, size 4194304
Console: switching to colour frame buffer device 160x64
fb0: MATROX frame buffer device
isapnp: Scanning for PnP cards...
pnp: SB audio device quirk - increasing port range
isapnp: Card 'Creative ViBRA16C PnP'
isapnp: Card 'U.S. Robotics 56K Voice INT'
isapnp: 2 Plug & Play cards detected total
Generic RTC Driver v1.07
PNP: PS/2 Controller [PNP0303,PNP0f13] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
00:0c: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
pnp: Device 00:0d does not support resource configuration.
serial: probe of 00:0d failed with error -16
pnp: Device 01:02.00 activated.
01:02.00: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
PIIX3: IDE controller at PCI slot 0000:00:07.1
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xefa0-0xefa7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xefa8-0xefaf, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: WDC AC33200L, ATA DISK drive
hdb: WDC AC35100L, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: TOSHIBA CD-ROM XM-6002B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 6346368 sectors (3249 MB) w/256KiB Cache, CHS=3D6296/16/63, DMA
 hda: hda1 hda2 hda3
hdb: max request size: 128KiB
hdb: 10085040 sectors (5163 MB) w/256KiB Cache, CHS=3D10672/15/63, (U)DMA
hdb: cache flushes not supported
 hdb: hdb1 hdb2 hdb3 hdb4
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 2, 16384 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
Using IPI Shortcut mode
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 128k freed
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
EXT3 FS on hda2, internal journal
Adding 105832k swap on /dev/hdb3.  Priority:1 extents:1 across:105832k
Adding 105832k swap on /dev/hdb4.  Priority:1 extents:1 across:105832k
Adding 48376k swap on /dev/hda3.  Priority:1 extents:1 across:48376k
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.3
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: irq 11, io base 0x0000ef80
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
e100: eth0: e100_probe: addr 0xffbeb000, irq 10, MAC addr 00:90:27:76:D0:=
EC
e100: eth1: e100_probe: addr 0xff0fe000, irq 11, MAC addr 00:03:47:3B:29:=
5C
e100: eth2: e100_probe: addr 0xff0ff000, irq 10, MAC addr 00:03:47:3B:29:=
5D
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
e100: eth1: e100_watchdog: link up, 100Mbps, full-duplex
e100: eth2: e100_watchdog: link up, 100Mbps, full-duplex
Bridge firewalling registered
device eth1 entered promiscuous mode
device eth2 entered promiscuous mode
br0: port 2(eth2) entering learning state
br0: port 1(eth1) entering learning state
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,=
ECP,DMA]
br0: topology change detected, propagating
br0: port 2(eth2) entering forwarding state
br0: topology change detected, propagating
br0: port 1(eth1) entering forwarding state
pnp: Device 01:01.00 activated.
ip_tables: (C) 2000-2006 Netfilter Core Team
ip_conntrack version 2.4 (512 buckets, 4096 max) - 228 bytes per conntrac=
k
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2006 Netfilter Core Team
prism2usb_init: prism2_usb.o: 0.2.4 Loaded
prism2usb_init: dev_info is: prism2_usb
usbcore: registered new driver prism2_usb
process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: starting 90-second grace period
hdc: ATAPI 16X CD-ROM drive, 256kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
input: PC Speaker as /class/input/input2

#
# Graphics support
#
CONFIG_FB=3Dy
CONFIG_FB_CFB_FILLRECT=3Dy
CONFIG_FB_CFB_COPYAREA=3Dy
CONFIG_FB_CFB_IMAGEBLIT=3Dy
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=3Dy

CONFIG_FB_MATROX=3Dy
CONFIG_FB_MATROX_MILLENIUM=3Dy

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=3Dy
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE=3Dy
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=3Dy
CONFIG_FONT_8x16=3Dy

#
# Logo configuration
#
CONFIG_LOGO=3Dy
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=3Dy
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

Cheers,
Chris



	=09
___________________________________________________________=20
NEW Yahoo! Cars - sell your car and browse thousands of new and used cars=
 online! http://uk.cars.yahoo.com/


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting langua=
ge
that extends applications into web and mobile media. Attend the live webc=
ast
and join the prime developer group breaking into this new coding territor=
y!
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D110944&bid=3D241720&dat=3D=
121642
