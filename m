From: Louis Garcia <louisg00@bellsouth.net>
Subject: Re: radeonfb and 2.5.66
Date: 27 Mar 2003 17:29:26 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1048804166.2591.2.camel@tiger>
References: <Pine.GSO.4.21.0303251607490.22126-100000@vervain.sonytel.be>
	 <1048791858.2474.3.camel@tiger>  <1048797714.1528.18.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-04ND3/lEGbiDKboFxz2m"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail331.mail.bellsouth.net ([205.152.58.209] helo=imf31bis.bellsouth.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18yfrn-0004tM-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Mar 2003 14:28:59 -0800
In-Reply-To: <1048797714.1528.18.camel@zion.wanadoo.fr>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


--=-04ND3/lEGbiDKboFxz2m
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Ok, here is a copy of both dmesgs. One for the CRT and the other for the
DVI.

--Lou


On Thu, 2003-03-27 at 15:41, Benjamin Herrenschmidt wrote:
> On Thu, 2003-03-27 at 20:04, Louis Garcia wrote:
> > I have connected my monitor to the vga port (it supports both) and the
> > radeonfb works. So it has to do with the dvi port not being activated.
> > This problem also affects the 2.4 kernel. I really would like to get
> > this going.
> 
> Ok, I can try to help you there, but not today.
> 
> I'll send you some experimental stuffs this week-end (ping me if
> you don't hear from me). In the meantime, what is the dmesg output
> of radeonfb with the monitor connected to the CRT port ?
> 
> Ben.
> 

--=-04ND3/lEGbiDKboFxz2m
Content-Disposition: attachment; filename=dmesg{CRT}.log
Content-Type: text/plain; name=dmesg{CRT}.log; charset=UTF-8
Content-Transfer-Encoding: 7bit

Linux version 2.5.66-4 (root@tiger) (gcc version 3.2.2 20030217 (Red Hat Linux 8.0 3.2.2-2)) #2 Wed Mar 26 16:29:58 EST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ff77000 (usable)
 BIOS-e820: 000000000ff77000 - 000000000ff79000 (ACPI NVS)
 BIOS-e820: 000000000ff79000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65399
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61303 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 DELL                       ) @ 0x000fd560
ACPI: RSDT (v001 DELL    8200    00000.00008) @ 0x000fd574
ACPI: FADT (v001 DELL    8200    00000.00008) @ 0x000fd5a8
ACPI: SSDT (v001   DELL    st_ex 00000.04096) @ 0xfffe5d64
ACPI: MADT (v001 DELL    8200    00000.00008) @ 0x000fd61c
ACPI: BOOT (v001 DELL    8200    00000.00008) @ 0x000fd678
ACPI: DSDT (v001   DELL    dt_ex 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
Building zonelist for node : 0
Kernel command line: ro root=/dev/hda6 hdc=ide-scsi video=radeonfb
ide_setup: hdc=ide-scsi
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1993.614 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 3932.16 BogoMIPS
Memory: 256136k/261596k available (1349k kernel code, 4768k reserved, 302k data, 272k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
Machine check exception polling timer started.
CPU: Intel(R) Pentium(R) 4 CPU 2.00GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfbeae, last bus=2
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030228
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Br
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *3 4 5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 15, disabled)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 15, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 15, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11 12 15)
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
Enabling SEP on CPU 0
VFS: Disk quotas dquot_6.5.1
Journalled Block Device driver loaded
radeonfb_pci_register BEGIN
radeonfb: ref_clk=2700, ref_div=12, xclk=23000 defaults
radeonfb: probed DDR SGRAM 65536k videoram
radeon_get_moninfo: bios 4 scratch = 2000002
radeonfb: ATI Radeon 7500 QW DDR SGRAM 64 MB
radeonfb: DVI port no monitor connected
radeonfb: CRT port CRT monitor connected
radeonfb_pci_register END
hStart = 664, hEnd = 760, hTotal = 800
vStart = 491, vEnd = 493, vTotal = 525
h_total_disp = 0x4f0063	   hsync_strt_wid = 0x8c02a2
v_total_disp = 0x1df020c	   vsync_strt_wid = 0x8201ea
post div = 0x8
fb_div = 0x59
ppll_div_3 = 0x30059
ron = 712, roff = 16464
vclk_freq = 2503, per = 588
Console: switching to colour frame buffer device 80x30
pty: 2048 Unix98 ptys configured
Real Time Clock Driver v1.11
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 00:1f.1
ICH2: chipset revision 4
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: MAXTOR 6L040L2, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-ST GCE-8400B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 78177792 sectors (40027 MB) w/1819KiB Cache, CHS=77557/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
Console: switching to colour frame buffer device 80x30
mice: PS/2 mouse device common for all mice
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 272k freed
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
PCI: Setting latency timer of device 00:1f.2 to 64
uhci-hcd 00:1f.2: Intel Corp. 82801BA/BAM USB (Hub
uhci-hcd 00:1f.2: irq 11, io base 0000ff80
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
uhci-hcd 00:1f.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
PCI: Setting latency timer of device 00:1f.4 to 64
uhci-hcd 00:1f.4: Intel Corp. 82801BA/BAM USB (Hub
uhci-hcd 00:1f.4: irq 9, io base 0000ff60
uhci-hcd 00:1f.4: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,6), internal journal
Adding 530104k swap on /dev/hda7.  Priority:-1 extents:1
NTFS driver 2.1.0 [Flags: R/O MODULE].
NTFS volume version 3.1.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SCSI subsystem initialized
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: HL-DT-ST  Model: CD-RW GCE-8400B   Rev: B104
  Type:   CD-ROM                             ANSI SCSI revision: 02
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (2043 buckets, 16344 max) - 160 bytes per conntrack
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
02:08.0: 3Com PCI 3c905C Tornado at 0xdc80. Vers LK1.1.19

--=-04ND3/lEGbiDKboFxz2m
Content-Disposition: attachment; filename=dmesg{DVI}.log
Content-Type: text/plain; name=dmesg{DVI}.log; charset=UTF-8
Content-Transfer-Encoding: 7bit

Linux version 2.5.66-4 (root@tiger) (gcc version 3.2.2 20030217 (Red Hat Linux 8.0 3.2.2-2)) #2 Wed Mar 26 16:29:58 EST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ff77000 (usable)
 BIOS-e820: 000000000ff77000 - 000000000ff79000 (ACPI NVS)
 BIOS-e820: 000000000ff79000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65399
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61303 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 DELL                       ) @ 0x000fd560
ACPI: RSDT (v001 DELL    8200    00000.00008) @ 0x000fd574
ACPI: FADT (v001 DELL    8200    00000.00008) @ 0x000fd5a8
ACPI: SSDT (v001   DELL    st_ex 00000.04096) @ 0xfffe5d64
ACPI: MADT (v001 DELL    8200    00000.00008) @ 0x000fd61c
ACPI: BOOT (v001 DELL    8200    00000.00008) @ 0x000fd678
ACPI: DSDT (v001   DELL    dt_ex 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
Building zonelist for node : 0
Kernel command line: ro root=/dev/hda6 hdc=ide-scsi video=radeonfb:dfp
ide_setup: hdc=ide-scsi
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1993.667 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 3932.16 BogoMIPS
Memory: 256136k/261596k available (1349k kernel code, 4768k reserved, 302k data, 272k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
Machine check exception polling timer started.
CPU: Intel(R) Pentium(R) 4 CPU 2.00GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfbeae, last bus=2
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030228
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Br
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *3 4 5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 15, disabled)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 15, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 15, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11 12 15)
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
Enabling SEP on CPU 0
VFS: Disk quotas dquot_6.5.1
Journalled Block Device driver loaded
radeonfb_pci_register BEGIN
radeonfb: ref_clk=2700, ref_div=12, xclk=23000 defaults
radeonfb: probed DDR SGRAM 65536k videoram
radeonfb: detected DFP panel size from registers: 1280x1024
radeonfb: ATI Radeon 7500 QW DDR SGRAM 64 MB
radeonfb: DVI port DFP monitor connected
radeonfb: CRT port no monitor connected
radeonfb_pci_register END
hStart = 680, hEnd = 960, hTotal = 1056
vStart = 482, vEnd = 501, vTotal = 522
h_total_disp = 0x4f0083	   hsync_strt_wid = 0xa302a2
v_total_disp = 0x1df0209	   vsync_strt_wid = 0x9301e1
post div = 0x8
fb_div = 0x59
ppll_div_3 = 0x30059
ron = 712, roff = 16464
vclk_freq = 2503, per = 588
Console: switching to colour frame buffer device 80x30
pty: 2048 Unix98 ptys configured
Real Time Clock Driver v1.11
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 00:1f.1
ICH2: chipset revision 4
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: MAXTOR 6L040L2, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-ST GCE-8400B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 78177792 sectors (40027 MB) w/1819KiB Cache, CHS=77557/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
Console: switching to colour frame buffer device 80x30
mice: PS/2 mouse device common for all mice
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 272k freed
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
PCI: Setting latency timer of device 00:1f.2 to 64
uhci-hcd 00:1f.2: Intel Corp. 82801BA/BAM USB (Hub
uhci-hcd 00:1f.2: irq 11, io base 0000ff80
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
uhci-hcd 00:1f.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
PCI: Setting latency timer of device 00:1f.4 to 64
uhci-hcd 00:1f.4: Intel Corp. 82801BA/BAM USB (Hub
uhci-hcd 00:1f.4: irq 9, io base 0000ff60
uhci-hcd 00:1f.4: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,6), internal journal
Adding 530104k swap on /dev/hda7.  Priority:-1 extents:1
NTFS driver 2.1.0 [Flags: R/O MODULE].
NTFS volume version 3.1.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SCSI subsystem initialized
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: HL-DT-ST  Model: CD-RW GCE-8400B   Rev: B104
  Type:   CD-ROM                             ANSI SCSI revision: 02
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (2043 buckets, 16344 max) - 160 bytes per conntrack
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
02:08.0: 3Com PCI 3c905C Tornado at 0xdc80. Vers LK1.1.19

--=-04ND3/lEGbiDKboFxz2m--



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
