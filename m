From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [Bugme-new] [Bug 10877] New: black screen
 when booting using vesafb
Date: Sat, 7 Jun 2008 20:43:08 +0200
Message-ID: <20080607204308.3da44320.krzysztof.h1@poczta.fm>
References: <bug-10877-10286@http.bugzilla.kernel.org/>
	<20080606140907.bb35fc27.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K53LH-0001WD-Rb for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Jun 2008 11:40:44 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K53LG-0007wP-3U
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Jun 2008 11:40:43 -0700
In-Reply-To: <20080606140907.bb35fc27.akpm@linux-foundation.org>
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
To: born.into.silence@gmail.com
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, bugme-daemon@bugzilla.kernel.org, "H. Peter Anvin" <hpa@zytor.com>

On Fri, 6 Jun 2008 14:09:07 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> 
> (switched to email.  Please respond via emailed reply-to-all, not via the
> bugzilla web interface).
> 
> On Fri,  6 Jun 2008 13:54:30 -0700 (PDT)
> bugme-daemon@bugzilla.kernel.org wrote:
> 
> > http://bugzilla.kernel.org/show_bug.cgi?id=10877
> > 
> >            Summary: black screen when booting using vesafb
> >            Product: Drivers
> >            Version: 2.5
> >      KernelVersion: 2.6.24 - 2.6.25-rc4 - 2.6.26.4 - 2.6.26.5
> >           Platform: All
> >         OS/Version: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: normal
> >           Priority: P1
> >          Component: Console/Framebuffers
> >         AssignedTo: jsimmons@infradead.org
> >         ReportedBy: born.into.silence@gmail.com
> > 
> > 
> > Problem Description: Screen goes black when using vga=xxx setting on boot, but
> > the radeon HD 3470 is said to be vesa-compliant. Tested values : 791, 788, 791,
> > 789. System keeps booting (I can ssh the box)
> > 
> > Steps to reproduce: boot with vga=xxx
> 

I am not able to reproduce it on Ubuntu 8.04 with grub bootloader,
AMD 690V chipset (aka ATI X1200) and AMD X2 4400+, linux 2.6.26-rc5
(the same version as used in reporter's config), 2GB RAM.

I got a lot of warnings about pci and usb quirks around the vesafb switching
which are missing in the original report, like these:

pci 0000:01:05.0: calling quirk_cardbus_legacy+0x0/0x1d
pci 0000:01:05.0: calling quirk_usb_early_handoff+0x0/0x3c8
pci 0000:01:05.0: calling pci_fixup_video+0x0/0xaf
pci 0000:01:05.0: Boot video device

Why are the cardbus/usb quirks called on the video device? The other
bug's reporter has written that the bug happens only if he leaves an USB
memory stick (flash drive) in the computer. When the stick is removed, 
there is no error.

I wonder if it may be an issue something completely unrelated to the vesa driver.

Regards,
Krzysztof
PS. my dmesg log below

em 00:0c: iomem range 0x0-0x0 could not be reserved
system 00:0c: iomem range 0x0-0x0 could not be reserved
system 00:0c: iomem range 0x0-0x0 could not be reserved
system 00:0c: iomem range 0x0-0x0 could not be reserved
system 00:0c: iomem range 0x0-0x0 could not be reserved
system 00:0c: iomem range 0x0-0x0 could not be reserved
system 00:0d: iomem range 0xcd400-0xcffff has been reserved
system 00:0d: iomem range 0xf0000-0xf7fff could not be reserved
system 00:0d: iomem range 0xf8000-0xfbfff could not be reserved
system 00:0d: iomem range 0xfc000-0xfffff could not be reserved
system 00:0d: iomem range 0x7bee0000-0x7befffff could not be reserved
system 00:0d: iomem range 0xffff0000-0xffffffff could not be reserved
system 00:0d: iomem range 0x0-0x9ffff could not be reserved
system 00:0d: iomem range 0x100000-0x7bedffff could not be reserved
system 00:0d: iomem range 0x7bff0000-0x7ffeffff has been reserved
system 00:0d: iomem range 0xfec00000-0xfec00fff could not be reserved
system 00:0d: iomem range 0xfee00000-0xfee00fff could not be reserved
system 00:0d: iomem range 0xfff80000-0xfffeffff could not be reserved
system 00:0d: iomem range 0x0-0x0 could not be reserved
system 00:0d: iomem range 0x0-0x0 could not be reserved
system 00:0d: iomem range 0x0-0x0 could not be reserved
system 00:0d: iomem range 0x0-0x0 could not be reserved
system 00:0d: iomem range 0x0-0x0 could not be reserved
system 00:0d: iomem range 0x0-0x0 could not be reserved
system 00:0d: iomem range 0x0-0x0 could not be reserved
system 00:0d: iomem range 0x0-0x0 could not be reserved
system 00:0d: iomem range 0x0-0x0 could not be reserved
system 00:0d: iomem range 0x0-0x0 could not be reserved
system 00:0d: iomem range 0x0-0x0 could not be reserved
system 00:0d: iomem range 0x0-0x0 could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: e000-efff
  MEM window: 0xfde00000-0xfdffffff
  PREFETCH window: 0x00000000f8000000-0x00000000fbffffff
  got res [fdc00000:fdc1ffff] bus [fdc00000:fdc1ffff] flags 27200 for BAR 6 of 0000:02:0f.0
PCI: Bridge: 0000:00:14.4
  IO window: d000-dfff
  MEM window: 0xfdd00000-0xfddfffff
  PREFETCH window: 0x00000000fdc00000-0x00000000fdcfffff
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
NET: Registered protocol family 1
checking if image is initramfs... it is
Freeing initrd memory: 2786k freed
audit: initializing netlink socket (disabled)
type=2000 audit(1212863072.403:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
NTFS driver 2.1.29 [Flags: R/O].
msgmni has been set to 3892 for ipc namespace ffffffff8065ee50
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
pci 0000:00:00.0: calling quirk_cardbus_legacy+0x0/0x1d
pci 0000:00:00.0: calling quirk_usb_early_handoff+0x0/0x3c8
pci 0000:00:00.0: calling pci_fixup_video+0x0/0xaf
pci 0000:00:01.0: calling quirk_cardbus_legacy+0x0/0x1d
pci 0000:00:01.0: calling quirk_usb_early_handoff+0x0/0x3c8
pci 0000:00:01.0: calling pci_fixup_video+0x0/0xaf
pci 0000:00:12.0: calling quirk_cardbus_legacy+0x0/0x1d
pci 0000:00:12.0: calling quirk_usb_early_handoff+0x0/0x3c8
pci 0000:00:12.0: calling pci_fixup_video+0x0/0xaf
pci 0000:00:13.0: calling quirk_cardbus_legacy+0x0/0x1d
pci 0000:00:13.0: calling quirk_usb_early_handoff+0x0/0x3c8
pci 0000:00:13.0: calling pci_fixup_video+0x0/0xaf
pci 0000:00:13.1: calling quirk_cardbus_legacy+0x0/0x1d
pci 0000:00:13.1: calling quirk_usb_early_handoff+0x0/0x3c8
pci 0000:00:13.1: calling pci_fixup_video+0x0/0xaf
pci 0000:00:13.2: calling quirk_cardbus_legacy+0x0/0x1d
pci 0000:00:13.2: calling quirk_usb_early_handoff+0x0/0x3c8
pci 0000:00:13.2: calling pci_fixup_video+0x0/0xaf
pci 0000:00:13.3: calling quirk_cardbus_legacy+0x0/0x1d
pci 0000:00:13.3: calling quirk_usb_early_handoff+0x0/0x3c8
pci 0000:00:13.3: calling pci_fixup_video+0x0/0xaf
pci 0000:00:13.4: calling quirk_cardbus_legacy+0x0/0x1d
pci 0000:00:13.4: calling quirk_usb_early_handoff+0x0/0x3c8
pci 0000:00:13.4: calling pci_fixup_video+0x0/0xaf
pci 0000:00:13.5: calling quirk_cardbus_legacy+0x0/0x1d
pci 0000:00:13.5: calling quirk_usb_early_handoff+0x0/0x3c8
pci 0000:00:13.5: calling pci_fixup_video+0x0/0xaf
pci 0000:00:14.0: calling quirk_cardbus_legacy+0x0/0x1d
pci 0000:00:14.0: calling quirk_usb_early_handoff+0x0/0x3c8
pci 0000:00:14.0: calling pci_fixup_video+0x0/0xaf
pci 0000:00:14.1: calling quirk_cardbus_legacy+0x0/0x1d
pci 0000:00:14.1: calling quirk_usb_early_handoff+0x0/0x3c8
pci 0000:00:14.1: calling pci_fixup_video+0x0/0xaf
pci 0000:00:14.2: calling quirk_cardbus_legacy+0x0/0x1d
pci 0000:00:14.2: calling quirk_usb_early_handoff+0x0/0x3c8
pci 0000:00:14.2: calling pci_fixup_video+0x0/0xaf
pci 0000:00:14.3: calling quirk_cardbus_legacy+0x0/0x1d
pci 0000:00:14.3: calling quirk_usb_early_handoff+0x0/0x3c8
pci 0000:00:14.3: calling pci_fixup_video+0x0/0xaf
pci 0000:00:14.4: calling quirk_cardbus_legacy+0x0/0x1d
pci 0000:00:14.4: calling quirk_usb_early_handoff+0x0/0x3c8
pci 0000:00:14.4: calling pci_fixup_video+0x0/0xaf
pci 0000:00:18.0: calling quirk_cardbus_legacy+0x0/0x1d
pci 0000:00:18.0: calling quirk_usb_early_handoff+0x0/0x3c8
pci 0000:00:18.0: calling pci_fixup_video+0x0/0xaf
pci 0000:00:18.1: calling quirk_cardbus_legacy+0x0/0x1d
pci 0000:00:18.1: calling quirk_usb_early_handoff+0x0/0x3c8
pci 0000:00:18.1: calling pci_fixup_video+0x0/0xaf
pci 0000:00:18.2: calling quirk_cardbus_legacy+0x0/0x1d
pci 0000:00:18.2: calling quirk_usb_early_handoff+0x0/0x3c8
pci 0000:00:18.2: calling pci_fixup_video+0x0/0xaf
pci 0000:00:18.3: calling quirk_cardbus_legacy+0x0/0x1d
pci 0000:00:18.3: calling quirk_usb_early_handoff+0x0/0x3c8
pci 0000:00:18.3: calling pci_fixup_video+0x0/0xaf
pci 0000:01:05.0: calling quirk_cardbus_legacy+0x0/0x1d
pci 0000:01:05.0: calling quirk_usb_early_handoff+0x0/0x3c8
pci 0000:01:05.0: calling pci_fixup_video+0x0/0xaf
pci 0000:01:05.0: Boot video device
pci 0000:02:0f.0: calling quirk_cardbus_legacy+0x0/0x1d
pci 0000:02:0f.0: calling quirk_usb_early_handoff+0x0/0x3c8
pci 0000:02:0f.0: calling pci_fixup_video+0x0/0xaf
vesafb: framebuffer at 0xf8000000, mapped to 0xffffc20000080000, using 3072k, total 16384k
vesafb: mode is 1024x768x16, linelength=2048, pages=9
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
input: Power Button (FF) as /class/input/input0
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input1
ACPI: Power Button (CM) [PWRB]
ACPI: ACPI0007:00 is registered as cooling_device0
ACPI: ACPI0007:01 is registered as cooling_device1
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.103
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:09: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
floppy0: no floppy controllers found
brd: module loaded
loop: module loaded
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Driver 'sd' needs updating - please use bus_type methods
Driver 'sr' needs updating - please use bus_type methods
ahci 0000:00:12.0: version 3.0
ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, low) -> IRQ 22
ahci 0000:00:12.0: controller can't do 64bit DMA, forcing 32bit
ahci 0000:00:12.0: controller can't do PMP, turning off CAP_PMP
ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:12.0: flags: ncq sntf ilck pm led clo pio slum part 
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
ata1: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f100 irq 22
ata2: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f180 irq 22
ata3: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f200 irq 22
ata4: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f280 irq 22
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: HPA detected: current 488395055, native 488397168
ata1.00: ATA-7: SAMSUNG HD250HJ, FH100-06, max UDMA7
ata1.00: 488395055 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata1.00: SB600 AHCI: limiting to 255 sectors per cmd
ata1.00: SB600 AHCI: limiting to 255 sectors per cmd
ata1.00: configured for UDMA/133
ata2: SATA link down (SStatus 0 SControl 300)
ata3: SATA link down (SStatus 0 SControl 300)
ata4: SATA link down (SStatus 0 SControl 300)
isa bounce pool size: 16 pages
scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG HD250HJ  FH10 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 488395055 512-byte hardware sectors (250058 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 488395055 512-byte hardware sectors (250058 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input2
usbcore: registered new interface driver xpad
xpad: X-Box pad driver
i2c /dev entries driver
device-mapper: ioctl: 4.13.0-ioctl (2007-10-18) initialised: dm-devel@redhat.com
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
Advanced Linux Sound Architecture Driver Version 1.0.16.
ALSA device list:
  No soundcards found.
NET: Registered protocol family 26
Netfilter messages via NETLINK v0.30.
nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
ctnetlink v0.93: registering with nfnetlink.
ip_tables: (C) 2000-2006 Netfilter Core Team
arp_tables: (C) 2002 David S. Miller
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 17
NET: Registered protocol family 15
Bridge firewalling registered
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
Freeing unused kernel memory: 268k freed
Write protecting the kernel read-only data: 4336k
fuse init (API version 7.9)
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 16 (level, low) -> IRQ 16
ohci_hcd 0000:00:13.0: OHCI Host Controller
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:13.0: irq 16, io mem 0xfe02e000
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:13.1[B] -> GSI 17 (level, low) -> IRQ 17
ohci_hcd 0000:00:13.1: OHCI Host Controller
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:13.1: irq 17, io mem 0xfe02d000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:13.2[C] -> GSI 18 (level, low) -> IRQ 18
ohci_hcd 0000:00:13.2: OHCI Host Controller
ohci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:13.2: irq 18, io mem 0xfe02c000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:13.3[B] -> GSI 17 (level, low) -> IRQ 17
ohci_hcd 0000:00:13.3: OHCI Host Controller
ohci_hcd 0000:00:13.3: new USB bus registered, assigned bus number 4
ohci_hcd 0000:00:13.3: irq 17, io mem 0xfe02b000
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 3-1: new full speed USB device using ohci_hcd and address 2
ACPI: PCI Interrupt 0000:00:13.4[C] -> GSI 18 (level, low) -> IRQ 18
ohci_hcd 0000:00:13.4: OHCI Host Controller
ohci_hcd 0000:00:13.4: new USB bus registered, assigned bus number 5
ohci_hcd 0000:00:13.4: irq 18, io mem 0xfe02a000
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 3-1: configuration #1 chosen from 1 choice
ACPI: PCI Interrupt 0000:00:13.5[D] -> GSI 19 (level, low) -> IRQ 19
ehci_hcd 0000:00:13.5: EHCI Host Controller
ehci_hcd 0000:00:13.5: new USB bus registered, assigned bus number 6
ehci_hcd 0000:00:13.5: debug port 1
ehci_hcd 0000:00:13.5: irq 19, io mem 0xfe029000
ehci_hcd 0000:00:13.5: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 10 ports detected
usb 3-1: USB disconnect, address 2
usb 3-1: new full speed USB device using ohci_hcd and address 3
usb 3-1: configuration #1 chosen from 1 choice
usb 4-1: new low speed USB device using ohci_hcd and address 2
usb 4-1: device descriptor read/64, error -62
usb 4-1: device descriptor read/64, error -62
usb 4-1: new low speed USB device using ohci_hcd and address 3
usb 4-1: device descriptor read/64, error -62
ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16 (level, low) -> IRQ 16
Initializing USB Mass Storage driver...
usb 4-1: device descriptor read/64, error -62
usb 4-1: new low speed USB device using ohci_hcd and address 4
usb 4-1: device not accepting address 4, error -62
usb 4-1: new low speed USB device using ohci_hcd and address 5
usb 4-1: device not accepting address 5, error -62
hub 4-0:1.0: unable to enumerate USB device on port 1
scsi4 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
scsi scan: INQUIRY result too short (5), using 36
scsi 4:0:0:0: Direct-Access     USB      Flash Disk       1.00 PQ: 0 ANSI: 2
sd 4:0:0:0: [sdb] 254781 512-byte hardware sectors (130 MB)
sd 4:0:0:0: [sdb] Write Protect is off
sd 4:0:0:0: [sdb] Mode Sense: 0b 00 00 08
sd 4:0:0:0: [sdb] Assuming drive cache: write through
sd 4:0:0:0: [sdb] 254781 512-byte hardware sectors (130 MB)
sd 4:0:0:0: [sdb] Write Protect is off
sd 4:0:0:0: [sdb] Mode Sense: 0b 00 00 08
sd 4:0:0:0: [sdb] Assuming drive cache: write through
 sdb: sdb1
sd 4:0:0:0: [sdb] Attached SCSI removable disk
sd 4:0:0:0: Attached scsi generic sg1 type 0
usb-storage: device scan complete
EXT3 FS on sda1, internal journal
JFS: nTxBlock = 8192, nTxLock = 65536
warning: `avahi-daemon' uses 32-bit capabilities (legacy support in use)
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
svc: 127.0.0.1, port=56255: unknown version (3 for prog 100003, nfsd)
Bluetooth: L2CAP ver 2.9
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
Xorg: vm86 mode not supported on 64 bit kernel

----------------------------------------------------------------------
Tanie rozmowy!
Sprawdz >>>  http://link.interia.pl/f1e22 


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
