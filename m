From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
Subject: Re: Re: [linux-2.6.10] radeonfb / oops
Date: Sat, 12 Feb 2005 16:39:14 +0100
Message-ID: <200502121639.14542.pluto@pld-linux.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_iMiDCLy0jH8RHCN"
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CzzN4-0003Pz-Ie
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Feb 2005 07:39:46 -0800
Received: from chello081018222206.chello.pl ([81.18.222.206] helo=plus.ds14.agh.edu.pl)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CzzMy-00052w-Lr
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Feb 2005 07:39:46 -0800
Received: from localhost ([127.0.0.1])
	by plus.ds14.agh.edu.pl with esmtp (Exim 4.42)
	id 1CzzMa-000428-En
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Feb 2005 16:39:16 +0100
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
To: linux-fbdev-devel@lists.sourceforge.net

--Boundary-00=_iMiDCLy0jH8RHCN
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> From: Benjamin Herrenschmidt <benh@ke...>
> Re: Re: [linux-2.6.10] radeonfb / oops  =20
> 2005-02-03 22:01=20
>    On Thu, 2005-02-03 at 09:25 +0100, Pawe=C2=B3 Sikora wrote:
>  > >  > Hi,
>  > >  >=20
>  > >  > Could You look at this: http://lkml.org/lkml/2005/1/29/67
>  > >  > Help will be appreciated.
>  > >=20
>  > > From: James Simmons <jsimmons@ww...>
>  > > Re: [linux-2.6.10] radeonfb / oops  =20
>  > > 2005-02-01 12:54=20
>  > >=20
>  > > Can you post your config?
>  > > =20
>  > > On Tue, 1 Feb 2005, Pawel Sikora wrote:
>  > >=20
>  >=20
>  > I"ve tested kernel without grsec and fbsplash and it still oopses.
>  >=20
>  > plain text document attachment (.config)
> =20
>  You seem to have built both the old and new radeonfb"s ... can you
>  remove the old one ?

Hi,

I've removed the old radeonfb and rebuild kernel with debug enabled.
It still ooopses.

Regards,
Pawe=C5=82.

=2D-=20
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)

--Boundary-00=_iMiDCLy0jH8RHCN
Content-Type: text/x-log;
  charset="utf-8";
  name="kernel.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="kernel.log"

Feb 12 15:55:56 pldworkstation Linux version 2.6.10-0.106.1 (jack@pldworkstation) (gcc version 3.3.5 (PLD Linux)) #1 Sat Feb 12 15:02:20 CET 2005
Feb 12 15:55:56 pldworkstation BIOS-provided physical RAM map:
Feb 12 15:55:56 pldworkstation BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Feb 12 15:55:56 pldworkstation BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Feb 12 15:55:56 pldworkstation BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Feb 12 15:55:56 pldworkstation BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
Feb 12 15:55:56 pldworkstation BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
Feb 12 15:55:56 pldworkstation BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
Feb 12 15:55:56 pldworkstation BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Feb 12 15:55:56 pldworkstation BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Feb 12 15:55:56 pldworkstation BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
Feb 12 15:55:56 pldworkstation 0MB HIGHMEM available.
Feb 12 15:55:56 pldworkstation 255MB LOWMEM available.
Feb 12 15:55:56 pldworkstation found SMP MP-table at 000fb4c0
Feb 12 15:55:56 pldworkstation On node 0 totalpages: 65520
Feb 12 15:55:56 pldworkstation DMA zone: 4096 pages, LIFO batch:1
Feb 12 15:55:56 pldworkstation Normal zone: 61424 pages, LIFO batch:14
Feb 12 15:55:56 pldworkstation HighMem zone: 0 pages, LIFO batch:1
Feb 12 15:55:56 pldworkstation DMI 2.3 present.
Feb 12 15:55:56 pldworkstation ACPI: RSDP (v000 AMI                                   ) @ 0x000fc480
Feb 12 15:55:56 pldworkstation ACPI: RSDT (v001 AMIINT VIA_K7   0x00000011 MSFT 0x00000097) @ 0x0fff0000
Feb 12 15:55:56 pldworkstation ACPI: FADT (v001 AMIINT VIA_K7   0x00000011 MSFT 0x00000097) @ 0x0fff0030
Feb 12 15:55:56 pldworkstation ACPI: MADT (v001 AMIINT          0x00000009 MSFT 0x00000097) @ 0x0fff00b0
Feb 12 15:55:56 pldworkstation ACPI: DSDT (v001    VIA   VIA_K7 0x00001000 MSFT 0x0100000d) @ 0x00000000
Feb 12 15:55:56 pldworkstation ACPI: PM-Timer IO Port: 0x808
Feb 12 15:55:56 pldworkstation ACPI: Local APIC address 0xfee00000
Feb 12 15:55:56 pldworkstation ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Feb 12 15:55:56 pldworkstation Processor #0 6:6 APIC version 16
Feb 12 15:55:56 pldworkstation ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Feb 12 15:55:56 pldworkstation IOAPIC[0]: apic_id 2, version 2, address 0xfec00000, GSI 0-23
Feb 12 15:55:56 pldworkstation ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Feb 12 15:55:56 pldworkstation ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Feb 12 15:55:56 pldworkstation ACPI: IRQ0 used by override.
Feb 12 15:55:56 pldworkstation ACPI: IRQ2 used by override.
Feb 12 15:55:56 pldworkstation ACPI: IRQ9 used by override.
Feb 12 15:55:56 pldworkstation Enabling APIC mode:  Flat.  Using 1 I/O APICs
Feb 12 15:55:56 pldworkstation Using ACPI (MADT) for SMP configuration information
Feb 12 15:55:56 pldworkstation Built 1 zonelists
Feb 12 15:55:56 pldworkstation Kernel command line: BOOT_IMAGE=PLD ro root=305 ide=reverse devfs=nomount
Feb 12 15:55:56 pldworkstation mapped APIC to ffffd000 (fee00000)
Feb 12 15:55:56 pldworkstation mapped IOAPIC to ffffc000 (fec00000)
Feb 12 15:55:56 pldworkstation Initializing CPU#0
Feb 12 15:55:56 pldworkstation PID hash table entries: 1024 (order: 10, 16384 bytes)
Feb 12 15:55:56 pldworkstation Detected 1467.314 MHz processor.
Feb 12 15:55:56 pldworkstation Using pmtmr for high-res timesource
Feb 12 15:55:56 pldworkstation Console: colour VGA+ 80x25
Feb 12 15:55:56 pldworkstation Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Feb 12 15:55:56 pldworkstation Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Feb 12 15:55:56 pldworkstation Memory: 255196k/262080k available (1701k kernel code, 6320k reserved, 734k data, 212k init, 0k highmem)
Feb 12 15:55:56 pldworkstation Checking if this processor honours the WP bit even in supervisor mode... Ok.
Feb 12 15:55:56 pldworkstation Calibrating delay loop... 2908.16 BogoMIPS (lpj=1454080)
Feb 12 15:55:56 pldworkstation Security Framework v1.0.0 initialized
Feb 12 15:55:56 pldworkstation SELinux:  Initializing.
Feb 12 15:55:56 pldworkstation SELinux:  Starting in permissive mode
Feb 12 15:55:56 pldworkstation Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Feb 12 15:55:56 pldworkstation CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000
Feb 12 15:55:56 pldworkstation CPU: After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000
Feb 12 15:55:56 pldworkstation CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Feb 12 15:55:56 pldworkstation CPU: L2 Cache: 256K (64 bytes/line)
Feb 12 15:55:56 pldworkstation CPU: After all inits, caps: 0383fbff c1c3fbff 00000000 00000020 00000000 00000000
Feb 12 15:55:56 pldworkstation Intel machine check architecture supported.
Feb 12 15:55:56 pldworkstation Intel machine check reporting enabled on CPU#0.
Feb 12 15:55:56 pldworkstation CPU: AMD Athlon(tm) XP 1700+ stepping 02
Feb 12 15:55:56 pldworkstation Enabling fast FPU save and restore... done.
Feb 12 15:55:56 pldworkstation Enabling unmasked SIMD FPU exception support... done.
Feb 12 15:55:56 pldworkstation Checking 'hlt' instruction... OK.
Feb 12 15:55:56 pldworkstation ENABLING IO-APIC IRQs
Feb 12 15:55:56 pldworkstation ..TIMER: vector=0x31 pin1=2 pin2=-1
Feb 12 15:55:56 pldworkstation checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Feb 12 15:55:56 pldworkstation Freeing initrd memory: 490k freed
Feb 12 15:55:56 pldworkstation NET: Registered protocol family 16
Feb 12 15:55:56 pldworkstation PCI: PCI BIOS revision 2.10 entry at 0xfdb31, last bus=1
Feb 12 15:55:56 pldworkstation PCI: Using configuration type 1
Feb 12 15:55:56 pldworkstation mtrr: v2.0 (20020519)
Feb 12 15:55:56 pldworkstation ACPI: Subsystem revision 20041210
Feb 12 15:55:56 pldworkstation ACPI-1138: *** Error: Method execution failed [\MCTH] (Node cffeeec0), AE_AML_BUFFER_LIMIT
Feb 12 15:55:56 pldworkstation ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0._INI] (Node c1273840), AE_AML_BUFFER_LIMIT
Feb 12 15:55:56 pldworkstation ACPI: Interpreter enabled
Feb 12 15:55:56 pldworkstation ACPI: Using IOAPIC for interrupt routing
Feb 12 15:55:56 pldworkstation ACPI: PCI Root Bridge [PCI0] (00:00)
Feb 12 15:55:56 pldworkstation PCI: Probing PCI hardware (bus 00)
Feb 12 15:55:56 pldworkstation PCI: Via IRQ fixup
Feb 12 15:55:56 pldworkstation ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Feb 12 15:55:56 pldworkstation ACPI: Power Resource [URP1] (off)
Feb 12 15:55:56 pldworkstation ACPI: Power Resource [URP2] (off)
Feb 12 15:55:56 pldworkstation ACPI: Power Resource [FDDP] (off)
Feb 12 15:55:56 pldworkstation ACPI: Power Resource [LPTP] (off)
Feb 12 15:55:56 pldworkstation ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Feb 12 15:55:56 pldworkstation ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Feb 12 15:55:56 pldworkstation ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Feb 12 15:55:56 pldworkstation ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Feb 12 15:55:56 pldworkstation Linux Plug and Play Support v0.97 (c) Adam Belay
Feb 12 15:55:56 pldworkstation pnp: PnP ACPI init
Feb 12 15:55:56 pldworkstation pnp: PnP ACPI: found 10 devices
Feb 12 15:55:56 pldworkstation PnPBIOS: Disabled by ACPI
Feb 12 15:55:56 pldworkstation PCI: Using ACPI for IRQ routing
Feb 12 15:55:56 pldworkstation ** PCI interrupts are no longer routed automatically.  If this
Feb 12 15:55:56 pldworkstation ** causes a device to stop working, it is probably because the
Feb 12 15:55:56 pldworkstation ** driver failed to call pci_enable_device().  As a temporary
Feb 12 15:55:56 pldworkstation ** workaround, the "pci=routeirq" argument restores the old
Feb 12 15:55:56 pldworkstation ** behavior.  If this argument makes the device work again,
Feb 12 15:55:56 pldworkstation ** please email the output of "lspci" to bjorn.helgaas@hp.com
Feb 12 15:55:56 pldworkstation ** so I can fix the driver.
Feb 12 15:55:56 pldworkstation Machine check exception polling timer started.
Feb 12 15:55:56 pldworkstation audit: initializing netlink socket (disabled)
Feb 12 15:55:56 pldworkstation audit(1108223731.728:0): initialized
Feb 12 15:55:56 pldworkstation Total HugeTLB memory allocated, 0
Feb 12 15:55:56 pldworkstation VFS: Disk quotas dquot_6.5.1
Feb 12 15:55:56 pldworkstation Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Feb 12 15:55:56 pldworkstation devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
Feb 12 15:55:56 pldworkstation devfs: boot_options: 0x0
Feb 12 15:55:56 pldworkstation SELinux:  Registering netfilter hooks
Feb 12 15:55:56 pldworkstation Initializing Cryptographic API
Feb 12 15:55:56 pldworkstation Real Time Clock Driver v1.12
Feb 12 15:55:56 pldworkstation vesafb: probe of vesafb0 failed with error -6
Feb 12 15:55:56 pldworkstation isapnp: Scanning for PnP cards...
Feb 12 15:55:56 pldworkstation isapnp: No Plug & Play device found
Feb 12 15:55:56 pldworkstation serio: i8042 AUX port at 0x60,0x64 irq 12
Feb 12 15:55:56 pldworkstation serio: i8042 KBD port at 0x60,0x64 irq 1
Feb 12 15:55:56 pldworkstation Serial: 8250/16550 driver $Revision: 1.90 $ 52 ports, IRQ sharing enabled
Feb 12 15:55:56 pldworkstation ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Feb 12 15:55:56 pldworkstation ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Feb 12 15:55:56 pldworkstation ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Feb 12 15:55:56 pldworkstation ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Feb 12 15:55:56 pldworkstation io scheduler noop registered
Feb 12 15:55:56 pldworkstation io scheduler anticipatory registered
Feb 12 15:55:56 pldworkstation io scheduler deadline registered
Feb 12 15:55:56 pldworkstation io scheduler cfq registered
Feb 12 15:55:56 pldworkstation RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Feb 12 15:55:56 pldworkstation mice: PS/2 mouse device common for all mice
Feb 12 15:55:56 pldworkstation input: AT Translated Set 2 keyboard on isa0060/serio0
Feb 12 15:55:56 pldworkstation NET: Registered protocol family 2
Feb 12 15:55:56 pldworkstation IP: routing cache hash table of 2048 buckets, 16Kbytes
Feb 12 15:55:56 pldworkstation TCP: Hash tables configured (established 16384 bind 32768)
Feb 12 15:55:56 pldworkstation NET: Registered protocol family 1
Feb 12 15:55:56 pldworkstation NET: Registered protocol family 17
Feb 12 15:55:56 pldworkstation ACPI wakeup devices: 
Feb 12 15:55:56 pldworkstation PCI0 UAR1 PS2M PS2K  USB USB1  AC9  MC9 ILAN SLT1 SLT2 SLT3 SLT4 SLT5 SLT6 
Feb 12 15:55:56 pldworkstation ACPI: (supports S0 S1 S4 S5)
Feb 12 15:55:56 pldworkstation RAMDISK: Compressed image found at block 0
Feb 12 15:55:56 pldworkstation VFS: Mounted root (romfs filesystem) readonly.
Feb 12 15:55:56 pldworkstation Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Feb 12 15:55:56 pldworkstation ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Feb 12 15:55:56 pldworkstation VP_IDE: IDE controller at PCI slot 0000:00:11.1
Feb 12 15:55:56 pldworkstation ACPI: PCI interrupt 0000:00:11.1[A]: no GSI
Feb 12 15:55:56 pldworkstation VP_IDE: chipset revision 6
Feb 12 15:55:56 pldworkstation VP_IDE: not 100% native mode: will probe irqs later
Feb 12 15:55:56 pldworkstation VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci0000:00:11.1
Feb 12 15:55:56 pldworkstation ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:pio
Feb 12 15:55:56 pldworkstation ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
Feb 12 15:55:56 pldworkstation Probing IDE interface ide0...
Feb 12 15:55:56 pldworkstation hda: SAMSUNG SV8004H, ATA DISK drive
Feb 12 15:55:56 pldworkstation elevator: using anticipatory as default io scheduler
Feb 12 15:55:56 pldworkstation ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb 12 15:55:56 pldworkstation Probing IDE interface ide1...
Feb 12 15:55:56 pldworkstation hdc: HL-DT-ST GCE-8526B, ATAPI CD/DVD-ROM drive
Feb 12 15:55:56 pldworkstation hdd: HITACHI DVD-ROM GD-2500, ATAPI CD/DVD-ROM drive
Feb 12 15:55:56 pldworkstation ide1 at 0x170-0x177,0x376 on irq 15
Feb 12 15:55:56 pldworkstation SGI XFS with ACLs, security attributes, large block numbers, no debug enabled
Feb 12 15:55:56 pldworkstation SGI XFS Quota Management subsystem
Feb 12 15:55:56 pldworkstation hda: max request size: 128KiB
Feb 12 15:55:56 pldworkstation hda: 156368016 sectors (80060 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
Feb 12 15:55:56 pldworkstation hda: cache flushes supported
Feb 12 15:55:56 pldworkstation /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 > p3 p4
Feb 12 15:55:56 pldworkstation XFS mounting filesystem hda5
Feb 12 15:55:56 pldworkstation Ending clean XFS mount for filesystem: hda5
Feb 12 15:55:56 pldworkstation VFS: Mounted root (xfs filesystem) readonly.
Feb 12 15:55:56 pldworkstation Trying to move old root to /initrd ... okay
Feb 12 15:55:56 pldworkstation Freeing unused kernel memory: 212k freed
Feb 12 15:55:56 pldworkstation Adding 136512k swap on /dev/hda6.  Priority:-1 extents:1
Feb 12 15:55:56 pldworkstation VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...
Feb 12 15:55:56 pldworkstation input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
Feb 12 15:55:56 pldworkstation hdc: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Feb 12 15:55:56 pldworkstation Uniform CD-ROM driver Revision: 3.20
Feb 12 15:55:56 pldworkstation hdd: ATAPI 24X DVD-ROM drive, 512kB Cache, DMA
Feb 12 15:55:56 pldworkstation loop: loaded (max 8 devices)
Feb 12 15:55:56 pldworkstation Linux agpgart interface v0.100 (c) Dave Jones
Feb 12 15:55:56 pldworkstation agpgart: Detected VIA KT266/KY266x/KT333 chipset
Feb 12 15:55:56 pldworkstation agpgart: Maximum main memory to use for agp memory: 203M
Feb 12 15:55:56 pldworkstation agpgart: AGP aperture is 64M @ 0xe0000000
Feb 12 15:55:56 pldworkstation Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Feb 12 15:55:56 pldworkstation NET: Registered protocol family 10
Feb 12 15:55:56 pldworkstation IPv6 over IPv4 tunneling driver
Feb 12 15:55:56 pldworkstation Disabled Privacy Extensions on device c036e3c0(lo)
Feb 12 15:55:56 pldworkstation 8139too Fast Ethernet driver 0.9.27
Feb 12 15:55:56 pldworkstation ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 16 (level, low) -> IRQ 169
Feb 12 15:55:56 pldworkstation eth0: RealTek RTL8139 at 0xd08caf00, 00:50:fc:30:70:31, IRQ 169
Feb 12 15:55:56 pldworkstation eth0:  Identified 8139 chip type 'RTL-8139C'
Feb 12 15:55:56 pldworkstation eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Feb 12 15:55:56 pldworkstation nfs warning: mount version older than kernel
Feb 12 15:55:57 pldworkstation ACPI: Power Button (FF) [PWRF]
Feb 12 15:56:03 pldworkstation eth0: no IPv6 routers present
Feb 12 15:56:06 pldworkstation ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
Feb 12 15:56:06 pldworkstation [drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE]
Feb 12 15:56:06 pldworkstation agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
Feb 12 15:56:06 pldworkstation agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
Feb 12 15:56:06 pldworkstation agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
Feb 12 15:56:24 pldworkstation ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 18 (level, low) -> IRQ 177
Feb 12 15:56:31 pldworkstation radeonfb_pci_register BEGIN
Feb 12 15:56:31 pldworkstation ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
Feb 12 15:56:31 pldworkstation radeonfb: probed SDR SGRAM 65536k videoram
Feb 12 15:56:31 pldworkstation radeonfb: mapped 16384k videoram
Feb 12 15:56:31 pldworkstation radeonfb: Found Intel x86 BIOS ROM Image
Feb 12 15:56:31 pldworkstation radeonfb: Retreived PLL infos from BIOS
Feb 12 15:56:31 pldworkstation radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=155.00 Mhz, System=155.00 MHz
Feb 12 15:56:31 pldworkstation radeonfb: PLL min 12000 max 35000
Feb 12 15:56:31 pldworkstation 1 chips in connector info
Feb 12 15:56:31 pldworkstation - chip 1 has 1 connectors
Feb 12 15:56:31 pldworkstation * connector 0 of type 2 (CRT) : 2300
Feb 12 15:56:31 pldworkstation Starting monitor auto detection...
Feb 12 15:56:32 pldworkstation radeonfb: I2C (port 1) ... not found
Feb 12 15:56:32 pldworkstation radeonfb: I2C (port 2) ... not found
Feb 12 15:56:32 pldworkstation radeonfb: I2C (port 3) ... found TMDS panel
Feb 12 15:56:33 pldworkstation radeonfb: I2C (port 4) ... not found
Feb 12 15:56:33 pldworkstation radeonfb: I2C (port 2) ... not found
Feb 12 15:56:33 pldworkstation radeonfb: I2C (port 4) ... not found
Feb 12 15:56:34 pldworkstation radeonfb: I2C (port 3) ... found CRT display
Feb 12 15:56:34 pldworkstation radeonfb: Monitor 1 type CRT found
Feb 12 15:56:34 pldworkstation radeonfb: EDID probed
Feb 12 15:56:34 pldworkstation radeonfb: Monitor 2 type no found
Feb 12 15:56:34 pldworkstation EDID checksum failed, aborting
Feb 12 15:56:34 pldworkstation EDID checksum failed, aborting
Feb 12 15:56:34 pldworkstation hStart = 664, hEnd = 760, hTotal = 800
Feb 12 15:56:34 pldworkstation vStart = 491, vEnd = 493, vTotal = 525
Feb 12 15:56:34 pldworkstation h_total_disp = 0x4f0063	   hsync_strt_wid = 0x8c02a2
Feb 12 15:56:34 pldworkstation v_total_disp = 0x1df020c	   vsync_strt_wid = 0x8201ea
Feb 12 15:56:34 pldworkstation pixclock = 39721
Feb 12 15:56:34 pldworkstation freq = 2517
Feb 12 15:56:34 pldworkstation freq = 2517, PLL min = 12000, PLL max = 35000
Feb 12 15:56:34 pldworkstation ref_div = 60, ref_clk = 2700, output_freq = 20136
Feb 12 15:56:34 pldworkstation post div = 0x3
Feb 12 15:56:34 pldworkstation fb_div = 0x1bf
Feb 12 15:56:34 pldworkstation ppll_div_3 = 0x301bf
Feb 12 15:56:34 pldworkstation Console: switching to colour frame buffer device 80x30
Feb 12 15:56:34 pldworkstation Unable to handle kernel NULL pointer dereference at virtual address 00000000
Feb 12 15:56:34 pldworkstation printing eip:
Feb 12 15:56:34 pldworkstation c021d31c
Feb 12 15:56:34 pldworkstation *pgd = 0000000009277001
Feb 12 15:56:34 pldworkstation *pmd = 0000000000000000
Feb 12 15:56:34 pldworkstation Oops: 0002 [#1]
Feb 12 15:56:34 pldworkstation PREEMPT 
Feb 12 15:56:34 pldworkstation Modules linked in: radeonfb i2c_algo_bit i2c_core snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec snd_util_mem snd_hwdep radeon button nfs 8139too mii md5 ipv6 ext2 mbcache nfsd exportfs lockd sunrpc via_agp agpgart loop ide_cd cdrom psmouse snd_pcm_oss snd_pcm snd_timer snd_page_alloc snd_mixer_oss snd soundcore ide_disk xfs via82cxxx ide_core
Feb 12 15:56:34 pldworkstation CPU:    0
Feb 12 15:56:34 pldworkstation EIP:    0060:[<c021d31c>]    Not tainted VLI
Feb 12 15:56:34 pldworkstation EFLAGS: 00010246   (2.6.10-0.106.1) 
Feb 12 15:56:34 pldworkstation EIP is at fbsplash_init+0x11c/0x180
Feb 12 15:56:34 pldworkstation eax: c12080cc   ebx: c010dd20   ecx: c032817c   edx: 000000d0
Feb 12 15:56:34 pldworkstation esi: c010dd21   edi: 00000000   ebp: ca061df4   esp: ca061de0
Feb 12 15:56:34 pldworkstation ds: 007b   es: 007b   ss: 0068
Feb 12 15:56:34 pldworkstation Process modprobe (pid: 4245, threadinfo=ca060000 task=c96b90a0)
Feb 12 15:56:34 pldworkstation Stack: 00000000 c1208000 00000000 00000000 00000000 ca061e04 c021670b 00000001 
Feb 12 15:56:34 pldworkstation 00000000 ca061e18 c021b81a 00000000 ca061e54 00000005 ca061e24 c021b878 
Feb 12 15:56:34 pldworkstation c03672d8 ca061e38 c015ce0a caf0620c 01d00000 caf06000 ca061ea8 c021faa7 
Feb 12 15:56:34 pldworkstation Call Trace:
Feb 12 15:56:34 pldworkstation [<c013a43a>] show_stack+0x7a/0x90
Feb 12 15:56:34 pldworkstation [<c013a5bd>] show_registers+0x14d/0x1b0
Feb 12 15:56:34 pldworkstation [<c013a7a4>] die+0xe4/0x170
Feb 12 15:56:34 pldworkstation [<c014b23f>] do_page_fault+0x26f/0x761
Feb 12 15:56:34 pldworkstation [<c013a06b>] error_code+0x2b/0x30
Feb 12 15:56:34 pldworkstation [<c021670b>] fbcon_takeover+0x9b/0xb0
Feb 12 15:56:34 pldworkstation [<c021b81a>] fbcon_fb_registered+0x5a/0x70
Feb 12 15:56:34 pldworkstation [<c021b878>] fbcon_event_notify+0x48/0x70
Feb 12 15:56:34 pldworkstation [<c015ce0a>] notifier_call_chain+0x1a/0x30
Feb 12 15:56:34 pldworkstation [<c021faa7>] register_framebuffer+0x107/0x190
Feb 12 15:56:34 pldworkstation [<d0bea825>] radeonfb_pci_register+0x3a5/0x7d0 [radeonfb]
Feb 12 15:56:34 pldworkstation [<c01f7bc7>] pci_device_probe_static+0x47/0x60
Feb 12 15:56:34 pldworkstation [<c01f7c11>] __pci_device_probe+0x31/0x50
Feb 12 15:56:34 pldworkstation [<c01f7c56>] pci_device_probe+0x26/0x40
Feb 12 15:56:34 pldworkstation [<c02520cc>] driver_probe_device+0x2c/0x70
Feb 12 15:56:34 pldworkstation [<c02521f5>] driver_attach+0x55/0x90
Feb 12 15:56:34 pldworkstation [<c025268b>] bus_add_driver+0x8b/0xb0
Feb 12 15:56:34 pldworkstation [<c0252c2b>] driver_register+0x2b/0x30
Feb 12 15:56:34 pldworkstation [<c01f7e6f>] pci_register_driver+0x5f/0x80
Feb 12 15:56:34 pldworkstation [<c0167978>] sys_init_module+0x148/0x1f0
Feb 12 15:56:34 pldworkstation [<c0138f29>] sysenter_past_esp+0x52/0x79
Feb 12 15:56:34 pldworkstation Code: 10 c0 b9 ff ff ff ff 89 f0 89 df f2 ae f7 d1 49 89 de 8d 41 01 ba d0 00 00 00 e8 40 8d f5 ff 89 c7 8b 45 f0 89 b8 40 01 00 00 ac <aa> 84 c0 75 fa b8 e6 5b 2f c0 31 d2 e8 53 f4 ff ff 85 c0 74 0a 
Feb 12 15:57:50 pldworkstation <4>nfsd: last server has exited
Feb 12 15:57:50 pldworkstation nfsd: unexporting all filesystems
Feb 12 15:58:55 pldworkstation Linux version 2.6.10-0.106.1 (jack@pldworkstation) (gcc version 3.3.5 (PLD Linux)) #1 Sat Feb 12 15:02:20 CET 2005
Feb 12 15:58:55 pldworkstation BIOS-provided physical RAM map:
Feb 12 15:58:55 pldworkstation BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Feb 12 15:58:55 pldworkstation BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Feb 12 15:58:55 pldworkstation BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Feb 12 15:58:55 pldworkstation BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
Feb 12 15:58:55 pldworkstation BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
Feb 12 15:58:55 pldworkstation BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
Feb 12 15:58:55 pldworkstation BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Feb 12 15:58:55 pldworkstation BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Feb 12 15:58:55 pldworkstation BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
Feb 12 15:58:55 pldworkstation 0MB HIGHMEM available.
Feb 12 15:58:55 pldworkstation 255MB LOWMEM available.
Feb 12 15:58:55 pldworkstation found SMP MP-table at 000fb4c0
Feb 12 15:58:55 pldworkstation On node 0 totalpages: 65520
Feb 12 15:58:55 pldworkstation DMA zone: 4096 pages, LIFO batch:1
Feb 12 15:58:55 pldworkstation Normal zone: 61424 pages, LIFO batch:14
Feb 12 15:58:55 pldworkstation HighMem zone: 0 pages, LIFO batch:1
Feb 12 15:58:55 pldworkstation DMI 2.3 present.
Feb 12 15:58:55 pldworkstation ACPI: RSDP (v000 AMI                                   ) @ 0x000fc480
Feb 12 15:58:55 pldworkstation ACPI: RSDT (v001 AMIINT VIA_K7   0x00000011 MSFT 0x00000097) @ 0x0fff0000
Feb 12 15:58:55 pldworkstation ACPI: FADT (v001 AMIINT VIA_K7   0x00000011 MSFT 0x00000097) @ 0x0fff0030
Feb 12 15:58:55 pldworkstation ACPI: MADT (v001 AMIINT          0x00000009 MSFT 0x00000097) @ 0x0fff00b0
Feb 12 15:58:55 pldworkstation ACPI: DSDT (v001    VIA   VIA_K7 0x00001000 MSFT 0x0100000d) @ 0x00000000
Feb 12 15:58:55 pldworkstation ACPI: PM-Timer IO Port: 0x808
Feb 12 15:58:55 pldworkstation ACPI: Local APIC address 0xfee00000
Feb 12 15:58:55 pldworkstation ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Feb 12 15:58:55 pldworkstation Processor #0 6:6 APIC version 16
Feb 12 15:58:55 pldworkstation ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Feb 12 15:58:55 pldworkstation IOAPIC[0]: apic_id 2, version 2, address 0xfec00000, GSI 0-23
Feb 12 15:58:55 pldworkstation ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Feb 12 15:58:55 pldworkstation ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Feb 12 15:58:55 pldworkstation ACPI: IRQ0 used by override.
Feb 12 15:58:55 pldworkstation ACPI: IRQ2 used by override.
Feb 12 15:58:55 pldworkstation ACPI: IRQ9 used by override.
Feb 12 15:58:55 pldworkstation Enabling APIC mode:  Flat.  Using 1 I/O APICs
Feb 12 15:58:55 pldworkstation Using ACPI (MADT) for SMP configuration information
Feb 12 15:58:55 pldworkstation Built 1 zonelists
Feb 12 15:58:55 pldworkstation Kernel command line: BOOT_IMAGE=PLD ro root=305 ide=reverse devfs=nomount pci=routeirq
Feb 12 15:58:55 pldworkstation mapped APIC to ffffd000 (fee00000)
Feb 12 15:58:55 pldworkstation mapped IOAPIC to ffffc000 (fec00000)
Feb 12 15:58:55 pldworkstation Initializing CPU#0
Feb 12 15:58:55 pldworkstation PID hash table entries: 1024 (order: 10, 16384 bytes)
Feb 12 15:58:55 pldworkstation Detected 1467.314 MHz processor.
Feb 12 15:58:55 pldworkstation Using pmtmr for high-res timesource
Feb 12 15:58:55 pldworkstation Console: colour VGA+ 80x25
Feb 12 15:58:55 pldworkstation Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Feb 12 15:58:55 pldworkstation Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Feb 12 15:58:55 pldworkstation Memory: 255196k/262080k available (1701k kernel code, 6320k reserved, 734k data, 212k init, 0k highmem)
Feb 12 15:58:55 pldworkstation Checking if this processor honours the WP bit even in supervisor mode... Ok.
Feb 12 15:58:55 pldworkstation Calibrating delay loop... 2908.16 BogoMIPS (lpj=1454080)
Feb 12 15:58:55 pldworkstation Security Framework v1.0.0 initialized
Feb 12 15:58:55 pldworkstation SELinux:  Initializing.
Feb 12 15:58:55 pldworkstation SELinux:  Starting in permissive mode
Feb 12 15:58:55 pldworkstation Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Feb 12 15:58:55 pldworkstation CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000
Feb 12 15:58:55 pldworkstation CPU: After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000
Feb 12 15:58:55 pldworkstation CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Feb 12 15:58:55 pldworkstation CPU: L2 Cache: 256K (64 bytes/line)
Feb 12 15:58:55 pldworkstation CPU: After all inits, caps: 0383fbff c1c3fbff 00000000 00000020 00000000 00000000
Feb 12 15:58:55 pldworkstation Intel machine check architecture supported.
Feb 12 15:58:55 pldworkstation Intel machine check reporting enabled on CPU#0.
Feb 12 15:58:55 pldworkstation CPU: AMD Athlon(tm) XP 1700+ stepping 02
Feb 12 15:58:55 pldworkstation Enabling fast FPU save and restore... done.
Feb 12 15:58:55 pldworkstation Enabling unmasked SIMD FPU exception support... done.
Feb 12 15:58:55 pldworkstation Checking 'hlt' instruction... OK.
Feb 12 15:58:55 pldworkstation ENABLING IO-APIC IRQs
Feb 12 15:58:55 pldworkstation ..TIMER: vector=0x31 pin1=2 pin2=-1
Feb 12 15:58:55 pldworkstation checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Feb 12 15:58:55 pldworkstation Freeing initrd memory: 490k freed
Feb 12 15:58:55 pldworkstation NET: Registered protocol family 16
Feb 12 15:58:55 pldworkstation PCI: PCI BIOS revision 2.10 entry at 0xfdb31, last bus=1
Feb 12 15:58:55 pldworkstation PCI: Using configuration type 1
Feb 12 15:58:55 pldworkstation mtrr: v2.0 (20020519)
Feb 12 15:58:55 pldworkstation ACPI: Subsystem revision 20041210
Feb 12 15:58:55 pldworkstation ACPI-1138: *** Error: Method execution failed [\MCTH] (Node cffeeec0), AE_AML_BUFFER_LIMIT
Feb 12 15:58:55 pldworkstation ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0._INI] (Node c1273840), AE_AML_BUFFER_LIMIT
Feb 12 15:58:55 pldworkstation ACPI: Interpreter enabled
Feb 12 15:58:55 pldworkstation ACPI: Using IOAPIC for interrupt routing
Feb 12 15:58:55 pldworkstation ACPI: PCI Root Bridge [PCI0] (00:00)
Feb 12 15:58:55 pldworkstation PCI: Probing PCI hardware (bus 00)
Feb 12 15:58:55 pldworkstation PCI: Via IRQ fixup
Feb 12 15:58:55 pldworkstation ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Feb 12 15:58:55 pldworkstation ACPI: Power Resource [URP1] (off)
Feb 12 15:58:55 pldworkstation ACPI: Power Resource [URP2] (off)
Feb 12 15:58:55 pldworkstation ACPI: Power Resource [FDDP] (off)
Feb 12 15:58:55 pldworkstation ACPI: Power Resource [LPTP] (off)
Feb 12 15:58:55 pldworkstation ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Feb 12 15:58:55 pldworkstation ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Feb 12 15:58:55 pldworkstation ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Feb 12 15:58:55 pldworkstation ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Feb 12 15:58:55 pldworkstation Linux Plug and Play Support v0.97 (c) Adam Belay
Feb 12 15:58:55 pldworkstation pnp: PnP ACPI init
Feb 12 15:58:55 pldworkstation pnp: PnP ACPI: found 10 devices
Feb 12 15:58:55 pldworkstation PnPBIOS: Disabled by ACPI
Feb 12 15:58:55 pldworkstation PCI: Using ACPI for IRQ routing
Feb 12 15:58:55 pldworkstation ** Routing PCI interrupts for all devices because "pci=routeirq"
Feb 12 15:58:55 pldworkstation ** was specified.  If this was required to make a driver work,
Feb 12 15:58:55 pldworkstation ** please email the output of "lspci" to bjorn.helgaas@hp.com
Feb 12 15:58:55 pldworkstation ** so I can fix the driver.
Feb 12 15:58:55 pldworkstation ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 18 (level, low) -> IRQ 169
Feb 12 15:58:55 pldworkstation ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 16 (level, low) -> IRQ 177
Feb 12 15:58:55 pldworkstation ACPI: PCI interrupt 0000:00:11.1[A]: no GSI
Feb 12 15:58:55 pldworkstation ACPI: PCI interrupt 0000:00:11.2[D] -> GSI 21 (level, low) -> IRQ 185
Feb 12 15:58:55 pldworkstation ACPI: PCI interrupt 0000:00:11.3[D] -> GSI 21 (level, low) -> IRQ 185
Feb 12 15:58:55 pldworkstation ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 177
Feb 12 15:58:55 pldworkstation Machine check exception polling timer started.
Feb 12 15:58:55 pldworkstation audit: initializing netlink socket (disabled)
Feb 12 15:58:55 pldworkstation audit(1108223908.647:0): initialized
Feb 12 15:58:55 pldworkstation Total HugeTLB memory allocated, 0
Feb 12 15:58:55 pldworkstation VFS: Disk quotas dquot_6.5.1
Feb 12 15:58:55 pldworkstation Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Feb 12 15:58:55 pldworkstation devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
Feb 12 15:58:55 pldworkstation devfs: boot_options: 0x0
Feb 12 15:58:55 pldworkstation SELinux:  Registering netfilter hooks
Feb 12 15:58:55 pldworkstation Initializing Cryptographic API
Feb 12 15:58:55 pldworkstation Real Time Clock Driver v1.12
Feb 12 15:58:55 pldworkstation vesafb: probe of vesafb0 failed with error -6
Feb 12 15:58:55 pldworkstation isapnp: Scanning for PnP cards...
Feb 12 15:58:55 pldworkstation isapnp: No Plug & Play device found
Feb 12 15:58:55 pldworkstation serio: i8042 AUX port at 0x60,0x64 irq 12
Feb 12 15:58:55 pldworkstation serio: i8042 KBD port at 0x60,0x64 irq 1
Feb 12 15:58:55 pldworkstation Serial: 8250/16550 driver $Revision: 1.90 $ 52 ports, IRQ sharing enabled
Feb 12 15:58:55 pldworkstation ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Feb 12 15:58:55 pldworkstation ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Feb 12 15:58:55 pldworkstation ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Feb 12 15:58:55 pldworkstation ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Feb 12 15:58:55 pldworkstation io scheduler noop registered
Feb 12 15:58:55 pldworkstation io scheduler anticipatory registered
Feb 12 15:58:55 pldworkstation io scheduler deadline registered
Feb 12 15:58:55 pldworkstation io scheduler cfq registered
Feb 12 15:58:55 pldworkstation RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Feb 12 15:58:55 pldworkstation mice: PS/2 mouse device common for all mice
Feb 12 15:58:55 pldworkstation input: AT Translated Set 2 keyboard on isa0060/serio0
Feb 12 15:58:55 pldworkstation NET: Registered protocol family 2
Feb 12 15:58:55 pldworkstation IP: routing cache hash table of 2048 buckets, 16Kbytes
Feb 12 15:58:55 pldworkstation TCP: Hash tables configured (established 16384 bind 32768)
Feb 12 15:58:55 pldworkstation NET: Registered protocol family 1
Feb 12 15:58:55 pldworkstation NET: Registered protocol family 17
Feb 12 15:58:55 pldworkstation ACPI wakeup devices: 
Feb 12 15:58:55 pldworkstation PCI0 UAR1 PS2M PS2K  USB USB1  AC9  MC9 ILAN SLT1 SLT2 SLT3 SLT4 SLT5 SLT6 
Feb 12 15:58:55 pldworkstation ACPI: (supports S0 S1 S4 S5)
Feb 12 15:58:55 pldworkstation RAMDISK: Compressed image found at block 0
Feb 12 15:58:55 pldworkstation VFS: Mounted root (romfs filesystem) readonly.
Feb 12 15:58:55 pldworkstation Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Feb 12 15:58:55 pldworkstation ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Feb 12 15:58:55 pldworkstation VP_IDE: IDE controller at PCI slot 0000:00:11.1
Feb 12 15:58:55 pldworkstation ACPI: PCI interrupt 0000:00:11.1[A]: no GSI
Feb 12 15:58:55 pldworkstation VP_IDE: chipset revision 6
Feb 12 15:58:55 pldworkstation VP_IDE: not 100% native mode: will probe irqs later
Feb 12 15:58:55 pldworkstation VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci0000:00:11.1
Feb 12 15:58:55 pldworkstation ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:pio
Feb 12 15:58:55 pldworkstation ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
Feb 12 15:58:55 pldworkstation Probing IDE interface ide0...
Feb 12 15:58:55 pldworkstation hda: SAMSUNG SV8004H, ATA DISK drive
Feb 12 15:58:55 pldworkstation elevator: using anticipatory as default io scheduler
Feb 12 15:58:55 pldworkstation ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb 12 15:58:55 pldworkstation Probing IDE interface ide1...
Feb 12 15:58:55 pldworkstation hdc: HL-DT-ST GCE-8526B, ATAPI CD/DVD-ROM drive
Feb 12 15:58:55 pldworkstation hdd: HITACHI DVD-ROM GD-2500, ATAPI CD/DVD-ROM drive
Feb 12 15:58:55 pldworkstation ide1 at 0x170-0x177,0x376 on irq 15
Feb 12 15:58:55 pldworkstation SGI XFS with ACLs, security attributes, large block numbers, no debug enabled
Feb 12 15:58:55 pldworkstation SGI XFS Quota Management subsystem
Feb 12 15:58:55 pldworkstation hda: max request size: 128KiB
Feb 12 15:58:55 pldworkstation hda: 156368016 sectors (80060 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
Feb 12 15:58:55 pldworkstation hda: cache flushes supported
Feb 12 15:58:55 pldworkstation /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 > p3 p4
Feb 12 15:58:55 pldworkstation XFS mounting filesystem hda5
Feb 12 15:58:55 pldworkstation Ending clean XFS mount for filesystem: hda5
Feb 12 15:58:55 pldworkstation VFS: Mounted root (xfs filesystem) readonly.
Feb 12 15:58:55 pldworkstation Trying to move old root to /initrd ... okay
Feb 12 15:58:55 pldworkstation Freeing unused kernel memory: 212k freed
Feb 12 15:58:55 pldworkstation Adding 136512k swap on /dev/hda6.  Priority:-1 extents:1
Feb 12 15:58:55 pldworkstation VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...
Feb 12 15:58:55 pldworkstation input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
Feb 12 15:58:55 pldworkstation hdc: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Feb 12 15:58:55 pldworkstation Uniform CD-ROM driver Revision: 3.20
Feb 12 15:58:55 pldworkstation hdd: ATAPI 24X DVD-ROM drive, 512kB Cache, DMA
Feb 12 15:58:55 pldworkstation loop: loaded (max 8 devices)
Feb 12 15:58:55 pldworkstation Linux agpgart interface v0.100 (c) Dave Jones
Feb 12 15:58:55 pldworkstation agpgart: Detected VIA KT266/KY266x/KT333 chipset
Feb 12 15:58:55 pldworkstation agpgart: Maximum main memory to use for agp memory: 203M
Feb 12 15:58:55 pldworkstation agpgart: AGP aperture is 64M @ 0xe0000000
Feb 12 15:58:55 pldworkstation Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Feb 12 15:58:55 pldworkstation NET: Registered protocol family 10
Feb 12 15:58:55 pldworkstation IPv6 over IPv4 tunneling driver
Feb 12 15:58:55 pldworkstation Disabled Privacy Extensions on device c036e3c0(lo)
Feb 12 15:58:55 pldworkstation 8139too Fast Ethernet driver 0.9.27
Feb 12 15:58:55 pldworkstation ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 16 (level, low) -> IRQ 177
Feb 12 15:58:55 pldworkstation eth0: RealTek RTL8139 at 0xd08caf00, 00:50:fc:30:70:31, IRQ 177
Feb 12 15:58:55 pldworkstation eth0:  Identified 8139 chip type 'RTL-8139C'
Feb 12 15:58:55 pldworkstation eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Feb 12 15:58:55 pldworkstation nfs warning: mount version older than kernel
Feb 12 15:58:56 pldworkstation ACPI: Power Button (FF) [PWRF]
Feb 12 15:59:01 pldworkstation eth0: no IPv6 routers present
Feb 12 15:59:05 pldworkstation ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 177
Feb 12 15:59:05 pldworkstation [drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE]
Feb 12 15:59:05 pldworkstation agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
Feb 12 15:59:05 pldworkstation agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
Feb 12 15:59:05 pldworkstation agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
Feb 12 15:59:16 pldworkstation ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 18 (level, low) -> IRQ 169
Feb 12 15:59:31 pldworkstation radeonfb_pci_register BEGIN
Feb 12 15:59:31 pldworkstation ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 177
Feb 12 15:59:31 pldworkstation radeonfb: probed SDR SGRAM 65536k videoram
Feb 12 15:59:32 pldworkstation radeonfb: mapped 16384k videoram
Feb 12 15:59:32 pldworkstation radeonfb: Found Intel x86 BIOS ROM Image
Feb 12 15:59:32 pldworkstation radeonfb: Retreived PLL infos from BIOS
Feb 12 15:59:32 pldworkstation radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=155.00 Mhz, System=155.00 MHz
Feb 12 15:59:32 pldworkstation radeonfb: PLL min 12000 max 35000
Feb 12 15:59:32 pldworkstation 1 chips in connector info
Feb 12 15:59:32 pldworkstation - chip 1 has 1 connectors
Feb 12 15:59:32 pldworkstation * connector 0 of type 2 (CRT) : 2300
Feb 12 15:59:32 pldworkstation Starting monitor auto detection...
Feb 12 15:59:32 pldworkstation radeonfb: I2C (port 1) ... not found
Feb 12 15:59:32 pldworkstation radeonfb: I2C (port 2) ... not found
Feb 12 15:59:32 pldworkstation radeonfb: I2C (port 3) ... found TMDS panel
Feb 12 15:59:33 pldworkstation radeonfb: I2C (port 4) ... not found
Feb 12 15:59:33 pldworkstation radeonfb: I2C (port 2) ... not found
Feb 12 15:59:34 pldworkstation radeonfb: I2C (port 4) ... not found
Feb 12 15:59:34 pldworkstation radeonfb: I2C (port 3) ... found CRT display
Feb 12 15:59:34 pldworkstation radeonfb: Monitor 1 type CRT found
Feb 12 15:59:34 pldworkstation radeonfb: EDID probed
Feb 12 15:59:34 pldworkstation radeonfb: Monitor 2 type no found
Feb 12 15:59:34 pldworkstation EDID checksum failed, aborting
Feb 12 15:59:34 pldworkstation EDID checksum failed, aborting
Feb 12 15:59:34 pldworkstation hStart = 664, hEnd = 760, hTotal = 800
Feb 12 15:59:34 pldworkstation vStart = 491, vEnd = 493, vTotal = 525
Feb 12 15:59:34 pldworkstation h_total_disp = 0x4f0063	   hsync_strt_wid = 0x8c02a2
Feb 12 15:59:34 pldworkstation v_total_disp = 0x1df020c	   vsync_strt_wid = 0x8201ea
Feb 12 15:59:34 pldworkstation pixclock = 39721
Feb 12 15:59:34 pldworkstation freq = 2517
Feb 12 15:59:34 pldworkstation freq = 2517, PLL min = 12000, PLL max = 35000
Feb 12 15:59:34 pldworkstation ref_div = 60, ref_clk = 2700, output_freq = 20136
Feb 12 15:59:34 pldworkstation post div = 0x3
Feb 12 15:59:34 pldworkstation fb_div = 0x1bf
Feb 12 15:59:34 pldworkstation ppll_div_3 = 0x301bf
Feb 12 15:59:34 pldworkstation Console: switching to colour frame buffer device 80x30
Feb 12 15:59:34 pldworkstation Unable to handle kernel NULL pointer dereference at virtual address 00000000
Feb 12 15:59:34 pldworkstation printing eip:
Feb 12 15:59:34 pldworkstation c021d31c
Feb 12 15:59:34 pldworkstation *pgd = 000000000a614001
Feb 12 15:59:34 pldworkstation *pmd = 0000000000000000
Feb 12 15:59:34 pldworkstation Oops: 0002 [#1]
Feb 12 15:59:34 pldworkstation PREEMPT 
Feb 12 15:59:34 pldworkstation Modules linked in: radeonfb i2c_algo_bit i2c_core snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec snd_util_mem snd_hwdep radeon button nfs 8139too mii md5 ipv6 ext2 mbcache nfsd exportfs lockd sunrpc via_agp agpgart loop ide_cd cdrom psmouse snd_pcm_oss snd_pcm snd_timer snd_page_alloc snd_mixer_oss snd soundcore ide_disk xfs via82cxxx ide_core
Feb 12 15:59:34 pldworkstation CPU:    0
Feb 12 15:59:34 pldworkstation EIP:    0060:[<c021d31c>]    Not tainted VLI
Feb 12 15:59:34 pldworkstation EFLAGS: 00010246   (2.6.10-0.106.1) 
Feb 12 15:59:34 pldworkstation EIP is at fbsplash_init+0x11c/0x180
Feb 12 15:59:34 pldworkstation eax: c12080cc   ebx: c010dd20   ecx: c032817c   edx: 000000d0
Feb 12 15:59:34 pldworkstation esi: c010dd21   edi: 00000000   ebp: ca7bddf4   esp: ca7bdde0
Feb 12 15:59:34 pldworkstation ds: 007b   es: 007b   ss: 0068
Feb 12 15:59:34 pldworkstation Process modprobe (pid: 4245, threadinfo=ca7bc000 task=cdb08060)
Feb 12 15:59:34 pldworkstation Stack: 00000000 c1208000 00000000 00000000 00000000 ca7bde04 c021670b 00000001 
Feb 12 15:59:34 pldworkstation 00000000 ca7bde18 c021b81a 00000000 ca7bde54 00000005 ca7bde24 c021b878 
Feb 12 15:59:34 pldworkstation c03672d8 ca7bde38 c015ce0a ca62220c 01d00000 ca622000 ca7bdea8 c021faa7 
Feb 12 15:59:34 pldworkstation Call Trace:
Feb 12 15:59:34 pldworkstation [<c013a43a>] show_stack+0x7a/0x90
Feb 12 15:59:34 pldworkstation [<c013a5bd>] show_registers+0x14d/0x1b0
Feb 12 15:59:34 pldworkstation [<c013a7a4>] die+0xe4/0x170
Feb 12 15:59:34 pldworkstation [<c014b23f>] do_page_fault+0x26f/0x761
Feb 12 15:59:34 pldworkstation [<c013a06b>] error_code+0x2b/0x30
Feb 12 15:59:34 pldworkstation [<c021670b>] fbcon_takeover+0x9b/0xb0
Feb 12 15:59:34 pldworkstation [<c021b81a>] fbcon_fb_registered+0x5a/0x70
Feb 12 15:59:34 pldworkstation [<c021b878>] fbcon_event_notify+0x48/0x70
Feb 12 15:59:34 pldworkstation [<c015ce0a>] notifier_call_chain+0x1a/0x30
Feb 12 15:59:34 pldworkstation [<c021faa7>] register_framebuffer+0x107/0x190
Feb 12 15:59:34 pldworkstation [<d0bea825>] radeonfb_pci_register+0x3a5/0x7d0 [radeonfb]
Feb 12 15:59:34 pldworkstation [<c01f7bc7>] pci_device_probe_static+0x47/0x60
Feb 12 15:59:34 pldworkstation [<c01f7c11>] __pci_device_probe+0x31/0x50
Feb 12 15:59:34 pldworkstation [<c01f7c56>] pci_device_probe+0x26/0x40
Feb 12 15:59:34 pldworkstation [<c02520cc>] driver_probe_device+0x2c/0x70
Feb 12 15:59:34 pldworkstation [<c02521f5>] driver_attach+0x55/0x90
Feb 12 15:59:34 pldworkstation [<c025268b>] bus_add_driver+0x8b/0xb0
Feb 12 15:59:34 pldworkstation [<c0252c2b>] driver_register+0x2b/0x30
Feb 12 15:59:34 pldworkstation [<c01f7e6f>] pci_register_driver+0x5f/0x80
Feb 12 15:59:34 pldworkstation [<c0167978>] sys_init_module+0x148/0x1f0
Feb 12 15:59:34 pldworkstation [<c0138f29>] sysenter_past_esp+0x52/0x79
Feb 12 15:59:34 pldworkstation Code: 10 c0 b9 ff ff ff ff 89 f0 89 df f2 ae f7 d1 49 89 de 8d 41 01 ba d0 00 00 00 e8 40 8d f5 ff 89 c7 8b 45 f0 89 b8 40 01 00 00 ac <aa> 84 c0 75 fa b8 e6 5b 2f c0 31 d2 e8 53 f4 ff ff 85 c0 74 0a 
Feb 12 16:00:06 pldworkstation <6>agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
Feb 12 16:00:06 pldworkstation agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
Feb 12 16:00:06 pldworkstation agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode

--Boundary-00=_iMiDCLy0jH8RHCN--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
