From: idalton@mail.ferret.dyndns.org
Subject: Re: 3DFX framebuffer driver v0.2.2
Date: Wed, 18 Dec 2002 21:06:04 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021219050604.GA26640@ahrairah.internal.aom.geek>
References: <E18O0I8-0005IH-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from 24-205-207-61.fln-cres.charterpipeline.net
	([24.205.207.61] helo=tarot.internal.aom.geek ident=mail)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18OstS-00027j-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 18 Dec 2002 21:06:46 -0800
Received: from ahrairah.internal.aom.geek ([192.168.1.42])
	by tarot.internal.aom.geek with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.35 #1 (Debian))
	id 18Ossn-0001NV-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 18 Dec 2002 21:06:05 -0800
Received: from idalton by ahrairah.internal.aom.geek with local (Exim 3.35 #1 (Debian))
	id 18Ossm-00076W-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 18 Dec 2002 21:06:04 -0800
Content-Disposition: inline
In-Reply-To: <E18O0I8-0005IH-00@sc8-sf-list1.sourceforge.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net


--JYK4vJDZwFMowpUq
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2002 at 06:45:00PM +0000, joachim.henke@stud.tu-ilmenau.de =
wrote:
> On http://www.medex.hu/~danthe/tdfx/ I found a newer version of the tdfxfb
> driver. It was a patch against linux 2.4.4 . I don't know why it never we=
nt
> into the kernel. Maybe Linus was too busy at that time?
>=20
> The current kernel still contains version 0.1.3 which is rather old. Much
> work has been done until version 0.2.2, mainly support for:
>=20
> * non-8 dot wide fonts
> * multihead
> * full 8/16/24/32 bit color (fixes the ugly bootup penguin)
> * MIPS
> * module options
>=20
> I think it's worth to give it a chance and to continue development on the
> base of that code. So I "ported" it to kernel 2.4.2x. Get this new patch
> here:
>=20
> http://tu-ilmenau.de/~johe-ii/3dfx-0.2.2-2.4.21-pre1.diff.gz
>=20
> I just merged the improvements that happened to v0.1.3 while it was in the
> kernel and did some source formating.
>=20
> Be encouraged to test it, do further improvements and please take it into
> the kernel!

I try this out on 2.4.20 with other patching.
My machine is an Asus super 7 (K6 500) with PCI & AGP voodoo banshees.
BIOS requires boot VGA to be PCI.

Both heads are init by driver, BIOS head is head 0. Head 1 is
misdetected to be only 4096KB video memory, should be 16384KB as is head
0. After remapping a virtual console to fb/1, I have no video signal on
either head now until I fbset each to depth 16.

Tested system with mplayer output to tdfxfb driver. Video only on fb/0,
but with mplayer on console on fb/1 both heads are responsive.

Unfortunately I tried mplayer with DirectFB, it crashes unable to init,
and (it's enabled with xfs patch) I get into gdb. And my keventd kernel
thread is zombie. sysrq kessages appear on (current) fb console, but
consoles otherwise unresponsive.

I try mplayer with tdfxfb again. No complaints but also no image on fb/0



--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mnemaxa-uberpatch.dmesg"

Linux version 2.4.20-usagi-tdfx (root@mnemaxa) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Wed Dec 18 16:34:09 PST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017ffc000 (usable)
 BIOS-e820: 0000000017ffc000 - 0000000017fff000 (ACPI data)
 BIOS-e820: 0000000017fff000 - 0000000018000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
383MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 98300
zone(0): 4096 pages.
zone(1): 94204 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 ASUS                       ) @ 0x000f81e0
ACPI: RSDT (v001 ASUS   P5A-B    16944.11825) @ 0x17ffc000
ACPI: FADT (v001 ASUS   P5A-B    16944.11825) @ 0x17ffc080
ACPI: BOOT (v001 ASUS   P5A-B    16944.11825) @ 0x17ffc040
ACPI: DSDT (v001   ASUS P5A-B    00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
Kernel command line: root=/dev/hda2 ro vga=4 nmi_watchdog=1
Initializing CPU#0
Detected 501.033 MHz processor.
Console: colour VGA+ 80x30
Calibrating delay loop... 997.37 BogoMIPS
Memory: 384832k/393200k available (2084k kernel code, 7980k reserved, 1298k data, 116k init, 0k highmem)
kdb version 2.5 by Keith Owens, Scott Lurndal. Copyright SGI, All Rights Reserved
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU:     After generic, caps: 008021bf 808029bf 00000000 00000002
CPU:             Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: AMD K6
ACPI: Subsystem revision 20021205
PCI: PCI BIOS revision 2.10 entry at 0xf0720, last bus=1
PCI: Using configuration type 1
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:.......................................................................
Table [DSDT] - 215 Objects with 28 Devices 71 Methods 12 Regions
ACPI Namespace successfully loaded at root c047d4fc
evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode successful
   evgpe-0263: *** Info: GPE Block0 defined as GPE0 to GPE15
   evgpe-0263: *** Info: GPE Block1 defined as GPE16 to GPE31
Executing all Device _STA and_INI methods:............................
28 Devices found containing: 28 _STA, 0 _INI methods
Completing Region/Field/Buffer/Package initialization:........................................
Initialized 9/12 Regions 0/0 Fields 20/20 Buffers 11/11 Packages (215 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 *7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
PCI: Probing PCI hardware
 pci_irq-0297 [03] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:0f.0
PCI: No IRQ known for interrupt pin A of device 00:0f.0<6>PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
isapnp: Scanning for PnP cards...
isapnp: SB audio device quirk - increasing port range
isapnp: AWE32 quirk - adding two ports
isapnp: Card 'Creative SB AWE64  PnP'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IPsec Security Association Database (SADB): initialized.
IPsec Security Policy Database (SPD): initialized.
IPsec PF_KEY V2: initialized
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
SGI XFS snapshot 2.4.20-2002-11-29_01:21_UTC with ACLs, quota, no debug enabled
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1 C2 C3)
fb: MTRR's turned on
tdfxfb: allocating 1024 bytes for the hwcursor at offset 0x00fff000
Console: switching to colour frame buffer device 80x30
fb0: 3Dfx Banshee frame buffer device, 16384K @ 0xE2000000
PCI: Enabling device 01:00.0 (0000 -> 0003)
fb: MTRR's turned on
tdfxfb: allocating 1024 bytes for the hwcursor at offset 0x003ff000
fb1: 3Dfx Banshee frame buffer device, 4096K @ 0xE6000000
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS02 at 0x03e8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.2
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 78
 pci_irq-0297 [02] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:0f.0
PCI: No IRQ known for interrupt pin A of device 00:0f.0ALI15X3: chipset revision 193
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xa800-0xa807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa808-0xa80f, BIOS settings: hdc:pio, hdd:pio
hda: WDC AC36400L, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide2: ports already in use, skipping probe
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
blk: queue c0495384, I/O limit 4095Mb (mask 0xffffffff)
hda: 12594960 sectors (6449 MB) w/256KiB Cache, CHS=13328/15/63, (U)DMA
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2
loop: loaded (max 8 devices)
8139too Fast Ethernet driver 0.9.26
eth0: SMC1211TX EZCard 10/100 (RealTek RTL8139) at 0xdbc0e000, 00:e0:29:6e:d5:88, IRQ 7
eth0:  Identified 8139 chip type 'RTL-8139B'
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Setting latency timer of device 00:02.0 to 64
usb-ohci.c: USB OHCI at membase 0xdbc10000, IRQ 9
usb-ohci.c: usb-00:02.0, Acer Laboratories Inc. [ALi] USB 1.1 Controller
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 (usagi-cvs/IPsec6 based StS) for NET4.0
IPv6 over IPv4 tunneling driver
cryptoapi: loaded
cryptoapi: Registered aes-ecb (0)
cryptoapi: Registered aes-cbc (65536)
cryptoapi: Registered aes-cfb (131072)
cryptoapi: Registered aes-ctr (262144)
cryptoapi: Registered aes-rtc (524288)
cryptoapi: Registered md5 (0)
cryptoapi: Registered sha1 (0)
cryptoloop: loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 116k freed
hub.c: new USB device 00:02.0-2, assigned address 2
hub.c: USB hub found
hub.c: 4 ports detected
hub.c: new USB device 00:02.0-2.3, assigned address 3
usb.c: USB device 3 (vend/prod 0x553/0x2) is not claimed by any active driver.
hub.c: new USB device 00:02.0-2.4, assigned address 4
input0: USB HID v1.00 Mouse [0461:4d03] on usb1:4.0
Adding Swap: 524432k swap-space (priority 1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
Linux video capture interface: v1.00
V4L-Driver for Vision CPiA based cameras v0.8.1
usb.c: registered new driver cpia
USB CPiA camera found
  CPiA Version: 1.20 (2.0)
  CPiA PnP-ID: 0553:0002:0100
  VP-Version: 1.0 0141
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1.

--T4sUOijqQbZv57TR--

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+AVO8e0DNEkH06HMRAnMEAKChAkynBdBZKNxR7zEyc497Ee9VdACfUoo/
hPUcG/99eVnLYLSpW0mAgtY=
=BPTp
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--


-------------------------------------------------------
This SF.NET email is sponsored by: Order your Holiday Geek Presents Now!
Green Lasers, Hip Geek T-Shirts, Remote Control Tanks, Caffeinated Soap,
MP3 Players,  XBox Games,  Flying Saucers,  WebCams,  Smart Putty.
T H I N K G E E K . C O M       http://www.thinkgeek.com/sf/
