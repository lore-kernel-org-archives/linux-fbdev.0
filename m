From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 4295] New: Garbage all over the screen when
 using radeonfb
Date: Sat, 5 Mar 2005 10:04:13 -0800
Message-ID: <20050305100413.176213f7.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7ddx-0006Iw-39
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Mar 2005 10:04:49 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D7dds-0008AQ-HL
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Mar 2005 10:04:49 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, hans.oischinger@h3c.de



Begin forwarded message:

Date: Sat, 5 Mar 2005 08:35:53 -0800
From: bugme-daemon@osdl.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 4295] New: Garbage all over the screen when using radeonfb


http://bugme.osdl.org/show_bug.cgi?id=4295

           Summary: Garbage all over the screen when using radeonfb
    Kernel Version: 2.6.11
            Status: NEW
          Severity: normal
             Owner: jsimmons@infradead.org
         Submitter: hans.oischinger@h3c.de


Distribution: Gentoo, gentoo-dev-sources-2.6.11   
Hardware Environment: x86 Radeon Mobility 9200 (M9+ 5C61)   
Software Environment:    
Problem Description: Garbage all over the screen when using radeonfb module.   
   
Steps to reproduce:   
modprobe radeonfb   
every 1/2 second some garbage pixels appear all over the screen. When the   
screen is not updated by clear or something that scrolls the 'garbaged' lines  
out of the screen, the whole screen becomes white.  
  
Starting X (with radeon driver or fglrx) changes nothing... Garbage production  
continues...  
 
The problem occured when upgrading from kernel 2.6.10 to .11 ( I used _rc2 for 
a while and it showed no such problems) 
 
 00000000 00000000 00000180 00000000 00000000  
CPU: L1 I cache: 32K, L1 D cache: 32K  
CPU: L2 cache: 1024K  
CPU: After all inits, caps: a7e9fbbf 00000000 00000000 00000040 00000180  
00000000 00000000  
Intel machine check architecture supported.  
Intel machine check reporting enabled on CPU#0.  
CPU: Intel(R) Pentium(R) M processor 1400MHz stepping 05  
Enabling fast FPU save and restore... done.  
Enabling unmasked SIMD FPU exception support... done.  
Checking 'hlt' instruction... OK.  
ACPI: setting ELCR to 0200 (from 0c00)  
NET: Registered protocol family 16  
PCI: PCI BIOS revision 2.10 entry at 0xe97a4, last bus=2  
PCI: Using configuration type 1  
mtrr: v2.0 (20020519)  
ACPI: Subsystem revision 20050211  
ACPI: Interpreter enabled  
ACPI: Using PIC for interrupt routing  
ACPI: PCI Root Bridge [PCI0] (00:00)  
PCI: Probing PCI hardware (bus 00)  
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1  
PCI: Transparent bridge - 0000:00:1e.0  
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]  
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]  
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]  
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10)  
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 10) *11  
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10) *11  
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10) *11  
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.  
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.  
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.  
ACPI: PCI Interrupt Link [LNKH] (IRQs 5 10) *11  
ACPI: Embedded Controller [EC0] (gpe 28)  
PCI: Using ACPI for IRQ routing  
** PCI interrupts are no longer routed automatically.  If this  
** causes a device to stop working, it is probably because the  
** driver failed to call pci_enable_device().  As a temporary  
** workaround, the "pci=routeirq" argument restores the old  
** behavior.  If this argument makes the device work again,  
** please email the output of "lspci" to bjorn.helgaas@hp.com  
** so I can fix the driver.  
Simple Boot Flag at 0x37 set to 0x80  
Machine check exception polling timer started.  
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).  
Initializing Cryptographic API  
inotify device minor=63  
ACPI: AC Adapter [ACAD] (off-line)  
ACPI: Battery Slot [BAT1] (battery present)  
ACPI: Power Button (FF) [PWRF]  
ACPI: Lid Switch [LID]  
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3] C4[C3])  
ACPI: Processor [CPU0] (supports 8 throttling states)  
ACPI: PS/2 Keyboard Controller [KBC0] at I/O 0x60, 0x64, irq 1  
ACPI: PS/2 Mouse Controller [MSE0] at irq 12  
i8042.c: Detected active multiplexing controller, rev 1.1.  
serio: i8042 AUX0 port at 0x60,0x64 irq 12  
serio: i8042 AUX1 port at 0x60,0x64 irq 12  
serio: i8042 AUX2 port at 0x60,0x64 irq 12  
serio: i8042 AUX3 port at 0x60,0x64 irq 12  
serio: i8042 KBD port at 0x60,0x64 irq 1  
io scheduler noop registered  
io scheduler anticipatory registered  
io scheduler deadline registered  
io scheduler cfq registered  
loop: loaded (max 8 devices)  
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2  
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx  
ICH4: IDE controller at PCI slot 0000:00:1f.1  
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)  
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10  
PCI: setting IRQ 10 as level-triggered  
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 10 (level, low) -> IRQ 10  
ICH4: chipset revision 3  
ICH4: not 100% native mode: will probe irqs later  
    ide0: BM-DMA at 0x1100-0x1107, BIOS settings: hda:DMA, hdb:pio  
    ide1: BM-DMA at 0x1108-0x110f, BIOS settings: hdc:DMA, hdd:pio  
Probing IDE interface ide0...  
hda: IC25N040ATMR04-0, ATA DISK drive  
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14  
Probing IDE interface ide1...  
hdc: MATSHITACD-RW CW-8122, ATAPI CD/DVD-ROM drive  
ide1 at 0x170-0x177,0x376 on irq 15  
Probing IDE interface ide2...  
Probing IDE interface ide3...  
Probing IDE interface ide4...  
Probing IDE interface ide5...  
hda: max request size: 1024KiB  
hda: 78140160 sectors (40007 MB) w/1740KiB Cache, CHS=16383/255/63, UDMA(100)  
hda: cache flushes supported  
 hda: hda1 hda2 hda3 hda4  
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)  
Uniform CD-ROM driver Revision: 3.20  
mice: PS/2 mouse device common for all mice  
input: AT Translated Set 2 keyboard on isa0060/serio0  
Synaptics Touchpad, model: 1  
 Firmware: 5.9  
 Sensor: 18  
 new absolute packet format  
 Touchpad has extended capability bits  
 -> 4 multi-buttons, i.e. besides standard buttons  
 -> multifinger detection  
 -> palm detection  
input: SynPS/2 Synaptics TouchPad on isa0060/serio4  
i2c /dev entries driver  
NET: Registered protocol family 2  
IP: routing cache hash table of 4096 buckets, 32Kbytes  
TCP established hash table entries: 32768 (order: 6, 262144 bytes)  
TCP bind hash table entries: 32768 (order: 5, 131072 bytes)  
TCP: Hash tables configured (established 32768 bind 32768)  
NET: Registered protocol family 1  
NET: Registered protocol family 17  
ACPI wakeup devices:  
ELAN MIN1 USB1 USB2 USB3 EUSB MODM  
ACPI: (supports S0 S3 S4 S4bios S5)  
ReiserFS: hda3: found reiserfs format "3.6" with standard journal  
ReiserFS: hda3: using ordered data mode  
ReiserFS: hda3: journal params: device hda3, size 8192, journal first block  
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30  
ReiserFS: hda3: checking transaction log (hda3)  
ReiserFS: hda3: Using r5 hash to sort names  
VFS: Mounted root (reiserfs filesystem) readonly.  
Freeing unused kernel memory: 160k freed  
Adding 498004k swap on /dev/hda2.  Priority:-1 extents:1  
usbcore: registered new driver usbfs  
usbcore: registered new driver hub  
USB Universal Host Controller Interface driver v2.2  
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10  
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 10 (level, low) -> IRQ 10  
uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB  
UHCI Controller #1  
PCI: Setting latency timer of device 0000:00:1d.0 to 64  
uhci_hcd 0000:00:1d.0: irq 10, io base 0x1200  
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1  
hub 1-0:1.0: USB hub found  
hub 1-0:1.0: 2 ports detected  
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10  
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 10 (level, low) -> IRQ 10  
uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB  
UHCI Controller #2  
PCI: Setting latency timer of device 0000:00:1d.1 to 64  
uhci_hcd 0000:00:1d.1: irq 10, io base 0x1600  
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2  
hub 2-0:1.0: USB hub found  
hub 2-0:1.0: 2 ports detected  
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 10 (level, low) -> IRQ 10  
uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB  
UHCI Controller #3  
PCI: Setting latency timer of device 0000:00:1d.2 to 64  
uhci_hcd 0000:00:1d.2: irq 10, io base 0x1700  
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3  
hub 3-0:1.0: USB hub found  
hub 3-0:1.0: 2 ports detected  
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)  
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10  
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 10 (level, low) -> IRQ 10  
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI  
Controller  
PCI: Setting latency timer of device 0000:00:1d.7 to 64  
ehci_hcd 0000:00:1d.7: irq 10, pci mem 0xf4000000  
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4  
PCI: cache line size of 32 is not supported by device 0000:00:1d.7  
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004  
hub 4-0:1.0: USB hub found  
hub 4-0:1.0: 6 ports detected  
usbcore: registered new driver hiddev  
usbcore: registered new driver usbhid  
drivers/usb/input/hid-core.c: v2.0:USB HID core driver  
SCSI subsystem initialized  
Initializing USB Mass Storage driver...  
usb 4-1: new high speed USB device using ehci_hcd and address 2  
scsi0 : SCSI emulation for USB Mass Storage devices  
usbcore: registered new driver usb-storage  
USB Mass Storage support registered.  
Acer Travelmate hotkey driver v0.5.20  
acerhk: Your hardware does not need polling enabled for hotkeys to work  
usb-storage: device found at 2  
usb-storage: waiting for device to settle before scanning  
8139too Fast Ethernet driver 0.9.27  
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10  
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 10 (level, low) -> IRQ 10  
atkbd.c: Unknown key pressed (translated set 2, code 0xbc on isa0060/serio0).  
atkbd.c: Use 'setkeycodes e03c <keycode>' to make it known.  
eth0: RealTek RTL8139 at 0xe08fe000, 00:02:3f:10:06:28, IRQ 10  
eth0:  Identified 8139 chip type 'RTL-8101'  
atkbd.c: Unknown key released (translated set 2, code 0xbc on isa0060/serio0).  
atkbd.c: Use 'setkeycodes e03c <keycode>' to make it known.  
Linux agpgart interface v0.100 (c) Dave Jones  
agpgart: Detected an Intel 855PM Chipset.  
agpgart: Maximum main memory to use for agp memory: 439M  
agpgart: AGP aperture is 64M @ 0xb0000000  
usb 3-1: new low speed USB device using uhci_hcd and address 2  
input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:00:1d.2-1  
usb 2-1: new full speed USB device using uhci_hcd and address 2  
scsi1 : SCSI emulation for USB Mass Storage devices  
usb-storage: device found at 2  
usb-storage: waiting for device to settle before scanning  
  Vendor: Apple     Model: iPod              Rev: 1.62  
  Type:   Direct-Access                      ANSI SCSI revision: 00  
SCSI device sda: 7999488 512-byte hdwr sectors (4096 MB)  
sda: assuming Write Enabled  
sda: assuming drive cache: write through  
SCSI device sda: 7999488 512-byte hdwr sectors (4096 MB)  
sda: assuming Write Enabled  
sda: assuming drive cache: write through  
 sda: sda1 sda2  
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0  
usb-storage: device scan complete  
VFS: Can't find an ext2 filesystem on dev sda.  
FAT: invalid media value (0x00)  
VFS: Can't find a valid FAT filesystem on dev sda.  
VFS: Can't find an ext2 filesystem on dev sda.  
FAT: invalid media value (0x00)  
VFS: Can't find a valid FAT filesystem on dev sda.  
VFS: Can't find an ext2 filesystem on dev sda.  
VFS: Can't find an ext2 filesystem on dev sda1.  
VFS: Can't find an ext2 filesystem on dev sda1.  
VFS: Can't find an ext2 filesystem on dev sda2.  
FAT: invalid media value (0x2f)  
VFS: Can't find a valid FAT filesystem on dev sda1.  
VFS: Can't find an ext2 filesystem on dev sda1.  
VFS: Can't find an ext2 filesystem on dev sda1.  
VFS: Can't find an ext2 filesystem on dev sda2.  
FAT: invalid media value (0x2f)  
VFS: Can't find a valid FAT filesystem on dev sda1.  
  Vendor:           Model: USB Card Reader   Rev: 1.2b  
  Type:   Direct-Access                      ANSI SCSI revision: 00  
SCSI device sdb: 128000 512-byte hdwr sectors (66 MB)  
sdb: assuming Write Enabled  
sdb: assuming drive cache: write through  
SCSI device sdb: 128000 512-byte hdwr sectors (66 MB)  
sdb: assuming Write Enabled  
sdb: assuming drive cache: write through  
 sdb: sdb1  
Attached scsi removable disk sdb at scsi1, channel 0, id 0, lun 0  
  Vendor:           Model: USB Card Reader   Rev: 1.2b  
  Type:   Direct-Access                      ANSI SCSI revision: 00  
Attached scsi removable disk sdc at scsi1, channel 0, id 0, lun 1  
  Vendor:           Model: USB Card Reader   Rev: 1.2b  
  Type:   Direct-Access                      ANSI SCSI revision: 00  
Attached scsi removable disk sdd at scsi1, channel 0, id 0, lun 2  
usb-storage: device scan complete  
VFS: Can't find an ext2 filesystem on dev sda.  
VFS: Can't find an ext2 filesystem on dev sda.  
FAT: invalid media value (0x00)  
VFS: Can't find a valid FAT filesystem on dev sda.  
FAT: invalid media value (0x00)  
VFS: Can't find a valid FAT filesystem on dev sda.  
VFS: Can't find an ext2 filesystem on dev sda1.  
VFS: Can't find an ext2 filesystem on dev sda2.  
VFS: Can't find an ext2 filesystem on dev sda1.  
FAT: invalid media value (0x2f)  
VFS: Can't find a valid FAT filesystem on dev sda1.  
VFS: Can't find an ext2 filesystem on dev sda1.  
FAT: invalid media value (0x2f)  
VFS: Can't find a valid FAT filesystem on dev sda1.  
VFS: Can't find an ext2 filesystem on dev sda1.  
FAT: invalid media value (0x2f)  
VFS: Can't find a valid FAT filesystem on dev sda1.  
VFS: Can't find an ext2 filesystem on dev sda1.  
FAT: invalid media value (0x2f)  
VFS: Can't find a valid FAT filesystem on dev sda1.  
VFS: Can't find an ext2 filesystem on dev sdb.  
FAT: bogus number of reserved sectors  
VFS: Can't find a valid FAT filesystem on dev sdb.  
VFS: Can't find an ext2 filesystem on dev sda1.  
FAT: invalid media value (0x2f)  
VFS: Can't find a valid FAT filesystem on dev sda1.  
VFS: Can't find an ext2 filesystem on dev sdb.  
FAT: bogus number of reserved sectors  
VFS: Can't find a valid FAT filesystem on dev sdb.  
VFS: Can't find an ext2 filesystem on dev sda1.  
FAT: invalid media value (0x2f)  
VFS: Can't find a valid FAT filesystem on dev sda1.  
VFS: Can't find an ext2 filesystem on dev sdb.  
FAT: bogus number of reserved sectors  
VFS: Can't find a valid FAT filesystem on dev sdb.  
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended  
VFS: Can't find an ext2 filesystem on dev sda1.  
FAT: invalid media value (0x2f)  
VFS: Can't find a valid FAT filesystem on dev sda1.  
VFS: Can't find an ext2 filesystem on dev sda2.  
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10 (level, low) -> IRQ 10  
PCI: Setting latency timer of device 0000:00:1f.5 to 64  
eth0: link down  
intel8x0_measure_ac97_clock: measured 49431 usecs  
intel8x0: clocking to 48000  
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended  
radeonfb_pci_register BEGIN  
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 10 (level, low) -> IRQ 10  
radeonfb (0000:01:00.0): Found 65536k of DDR 128 bits wide videoram  
radeonfb (0000:01:00.0): mapped 16384k videoram  
radeonfb: Retreived PLL infos from BIOS  
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=215.00 Mhz, System=200.00 MHz  
radeonfb: PLL min 20000 max 35000  
1 chips in connector info  
 - chip 1 has 1 connectors  
  * connector 0 of type 2 (CRT) : 2300  
Starting monitor auto detection...  
radeonfb: I2C (port 1) ... not found  
radeonfb: I2C (port 2) ... not found  
radeonfb: I2C (port 3) ... not found  
radeonfb: I2C (port 4) ... not found  
radeonfb: I2C (port 2) ... not found  
radeonfb: I2C (port 4) ... not found  
Non-DDC laptop panel detected  
radeonfb: I2C (port 3) ... not found  
radeonfb: I2C (port 4) ... not found  
radeonfb: Monitor 1 type LCD found  
radeonfb: Monitor 2 type no found  
radeonfb: panel ID string: SEC  
radeonfb: detected LVDS panel size from BIOS: 1280x800  
BIOS provided panel power delay: 1000  
radeondb: BIOS provided dividers will be used  
ref_divider = 6  
post_divider = 2  
fbk_divider = 3f  
Scanning BIOS table ...  
 320 x 350  
 320 x 400  
 320 x 400  
 320 x 480  
 400 x 600  
 512 x 384  
 640 x 350  
 640 x 400  
 640 x 475  
 640 x 480  
 720 x 480  
 720 x 576  
 800 x 600  
 848 x 480  
 1024 x 768  
 1280 x 800  
Found panel in BIOS table:  
  hblank: 160  
  hOver_plus: 48  
  hSync_width: 24  
  vblank: 23  
  vOver_plus: 2  
  vSync_width: 6  
  clock: 7100  
Setting up default mode based on panel info  
hStart = 1328, hEnd = 1352, hTotal = 1440  
vStart = 802, vEnd = 808, vTotal = 823  
h_total_disp = 0x9f00b3    hsync_strt_wid = 0x3052a  
v_total_disp = 0x31f0336           vsync_strt_wid = 0x60321  
pixclock = 14084  
freq = 7100  
Console: switching to colour frame buffer device 160x50  
radeonfb: Dynamic Clock Power Management enabled  
radeonfb (0000:01:00.0): ATI Radeon \a  
radeonfb_pci_register END

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
