From: Tony Daplas <aadaplas@yahoo.com>
Subject: Fwd: linux-kernel radeonfb: Display corruption with power managment, after a while it goes away automatically
Date: Thu, 17 Mar 2005 15:45:40 -0800 (PST)
Message-ID: <20050317234540.12743.qmail@web53307.mail.yahoo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DC4gZ-0004P0-CB
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Mar 2005 15:45:51 -0800
Received: from web53307.mail.yahoo.com ([206.190.39.236])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DC4gW-00050q-KH
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Mar 2005 15:45:51 -0800
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
Content-Transfer-Encoding: 7bit
To: benh@kernel.crashing.org
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, sebastian_ml@gmx.net


--- Sebastian <sebastian_ml@gmx.net> wrote:

> Date: Thu, 17 Mar 2005 23:07:14 +0100
> From: Sebastian <sebastian_ml@gmx.net>
> To: adaplas@hotpop.com
> Subject: linux-kernel radeonfb: Display corruption
> with power managment, after
>  a while it goes away automatically
> 
> Hello!
> 
> I have a desktop computer with a radeon 9250 agp
> card from connect3d. I
> append radeonfb.default_dynclk=1 when loading the
> kernel or use options
> radeonfb default.dynclk=1 when using modules. I
> understand the power
> managment feature is mostly for mobility cards for
> laptops, but I like
> it very much because my card stays much cooler with
> it.
> The problem is that, no matter if I load the module
> or build it
> statically in the kernel the screen gets garbled
> until init says it's
> "Setting user font".
> 
> After setting the user fonts (exactly at this point
> everytime)
> everything at once is in order. And powermanagment
> works flawlessly.
> I don't get the point why this should have anything
> to do with setting
> user fonts (which are set to lat0-16 btw.).
> 
> I'm on Gentoo kernel 2.6.11. I can't tell how this
> works with earlier
> versions, because the card is only a few days old.
> But if you like I
> could check it out.
> 
> cat /proc/version
> Linux version 2.6.11.2 (root@hal9000) (gcc version
> 3.3.5 (Gentoo Linux
> 3.3.5-r1, ssp-3.3.2-3, pie-8.7.7.1)) #3 Thu Mar 17
> 21:38:23 CET 2005
> 
> /usr/src/linux/scripts/ver_linux
> If some fields are empty or look unusual you may
> have an old version.
> Compare to the current minimal requirements in
> Documentation/Changes.
> 
> Linux hal9000 2.6.11.2 #3 Thu Mar 17 21:38:23 CET
> 2005 i686 AMD
> Athlon(tm) XP 1700+ AuthenticAMD GNU/Linux
> 
> Gnu C                  3.3.5
> Gnu make               3.80
> binutils               2.15.92.0.2
> util-linux             2.12i
> mount                  2.12i
> module-init-tools      3.0
> e2fsprogs              1.35
> reiserfsprogs          line
> reiser4progs           line
> xfsprogs               2.6.25
> Linux C Library        2.3.4
> Dynamic linker (ldd)   2.3.4
> Procps                 3.2.4
> Net-tools              1.60
> Kbd                    1.12
> Sh-utils               5.2.1
> udev                   045
> Modules Loaded         dvb_ttpci dvb_core saa7146_vv
> video_buf saa7146
> ves1820 stv0299 tda8083 stv0297 sp8870 ves1x93
> ttpci_eeprom radeonfb
> cfbcopyarea cfbimgblt cfbfillrect lirc_serial
> lirc_dev
> 
> cat /proc/cpuinfo
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 8
> model name      : AMD Athlon(tm) XP 1700+
> stepping        : 1
> cpu MHz         : 1469.873
> cache size      : 256 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8
> apic sep mtrr pge
> mca cmov pat pse36 mmx fxsr sse pni syscall mmxext
> 3dnowext 3dnow
> bogomips        : 2899.96
> 
> cat /proc/modules
> dvb_ttpci 90856 18 - Live 0xe1981000
> dvb_core 75816 1 dvb_ttpci, Live 0xe094f000
> saa7146_vv 45376 1 dvb_ttpci, Live 0xe092b000
> video_buf 17092 1 saa7146_vv, Live 0xe0910000
> saa7146 15204 2 dvb_ttpci,saa7146_vv, Live
> 0xe0916000
> ves1820 5508 1 dvb_ttpci, Live 0xe090d000
> stv0299 9668 1 dvb_ttpci, Live 0xe08e5000
> tda8083 5700 1 dvb_ttpci, Live 0xe08ed000
> stv0297 8576 1 dvb_ttpci, Live 0xe08e9000
> sp8870 7180 1 dvb_ttpci, Live 0xe08dd000
> ves1x93 6340 1 dvb_ttpci, Live 0xe0816000
> ttpci_eeprom 2304 1 dvb_ttpci, Live 0xe083d000
> radeonfb 61252 1 - Live 0xe08f1000
> cfbcopyarea 3712 1 radeonfb, Live 0xe083b000
> cfbimgblt 2752 1 radeonfb, Live 0xe0839000
> cfbfillrect 3392 1 radeonfb, Live 0xe081d000
> lirc_serial 11488 1 - Live 0xe0835000
> lirc_dev 11532 1 lirc_serial, Live 0xe0831000
> 
> cat /proc/ioports
> 0000-001f : dma1
> 0020-0021 : pic1
> 0040-0043 : timer0
> 0050-0053 : timer1
> 0060-006f : keyboard
> 0070-0077 : rtc
> 0080-008f : dma page reg
> 00a0-00a1 : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 0170-0177 : ide1
> 01f0-01f7 : ide0
> 0376-0376 : ide1
> 03c0-03df : vga+
> 03f6-03f6 : ide0
> 03f8-03ff : lirc_serial
> 0cf8-0cff : PCI conf1
> 4000-407f : motherboard
>    4000-4003 : PM1a_EVT_BLK
>    4004-4005 : PM1a_CNT_BLK
>    4008-400b : PM_TMR
>    4020-4027 : GPE0_BLK
> 4080-40ff : motherboard
> 4200-427f : motherboard
> 4280-42ff : motherboard
> 4400-447f : motherboard
> 4480-44ff : motherboard
>    44a0-44af : GPE1_BLK
> 5000-503f : motherboard
> 5100-513f : motherboard
> d000-dfff : PCI Bus #02
>    d000-d0ff : 0000:02:00.0
>      d000-d0ff : radeonfb
> e000-e007 : 0000:00:04.0
>    e000-e007 : forcedeth
> ec00-ec1f : 0000:00:01.1
> f000-f00f : 0000:00:09.0
>    f000-f007 : ide0
>    f008-f00f : ide1
> 
> cat /proc/iomem
> 00000000-0009ffff : System RAM
> 000a0000-000bffff : Video RAM area
> 000c0000-000ccfff : Video ROM
> 000d0000-000d17ff : Adapter ROM
> 000f0000-000fffff : System ROM
> 00100000-1ffeffff : System RAM
>    00100000-0033a4e9 : Kernel code
>    0033a4ea-004102ff : Kernel data
> 1fff0000-1fff2fff : ACPI Non-volatile Storage
> 1fff3000-1fffffff : ACPI Tables
> d0000000-dfffffff : PCI Bus #02
>    d0000000-dfffffff : 0000:02:00.0
>      d0000000-dfffffff : radeonfb
> e0000000-e1ffffff : 0000:00:00.0
> e2000000-e3ffffff : PCI Bus #02
>    e3000000-e300ffff : 0000:02:00.0
>      e3000000-e300ffff : radeonfb
> e4000000-e4ffffff : PCI Bus #01
>    e4000000-e40001ff : 0000:01:09.0
>      e4000000-e40001ff : saa7146
> e5000000-e5000fff : 0000:00:04.0
>    e5000000-e5000fff : forcedeth
> e5002000-e5002fff : 0000:00:02.0
>    e5002000-e5002fff : ohci_hcd
> e5003000-e5003fff : 0000:00:02.1
>    e5003000-e5003fff : ohci_hcd
> e5004000-e50040ff : 0000:00:02.2
>    e5004000-e50040ff : ehci_hcd
> fec00000-fec00fff : reserved
> fee00000-fee00fff : reserved
> ffff0000-ffffffff : reserved
> 
> cat /proc/fb
> 0 ATI Radeon Y`
> 
> dmesg:
> dmesg
> Linux version 2.6.11.2 (root@hal9000) (gcc version
> 3.3.5 (Gentoo Linux
> 3.3.5-r1, ssp-3.3.2-3, pie-8.7.7.1)) #3 Thu Mar 17
> 21:38:23 CET 2005
> BIOS-provided physical RAM map:
>   BIOS-e820: 0000000000000000 - 00000000000a0000
> (usable)
>   BIOS-e820: 00000000000f0000 - 0000000000100000
> (reserved)
>   BIOS-e820: 0000000000100000 - 000000001fff0000
> (usable)
>   BIOS-e820: 000000001fff0000 - 000000001fff3000
> (ACPI NVS)
>   BIOS-e820: 000000001fff3000 - 0000000020000000
> (ACPI data)
>   BIOS-e820: 00000000fec00000 - 00000000fec01000
> (reserved)
>   BIOS-e820: 00000000fee00000 - 00000000fee01000
> (reserved)
>   BIOS-e820: 00000000ffff0000 - 0000000100000000
> (reserved)
> 511MB LOWMEM available.
> On node 0 totalpages: 131056
>    DMA zone: 4096 pages, LIFO batch:1
>    Normal zone: 126960 pages, LIFO batch:16
>    HighMem zone: 0 pages, LIFO batch:1
> DMI 2.2 present.
> ACPI: RSDP (v000 Nvidia                             
>   ) @ 0x000f6fa0
> ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD
> 0x00000000) @ 0x1fff3000
> ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD
> 0x00000000) @ 0x1fff3040
> ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD
> 0x00000000) @ 0x1fff7880
> ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT
> 0x0100000e) @ 0x00000000
> ACPI: Local APIC address 0xfee00000
> ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> Processor #0 6:8 APIC version 16
> ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> ACPI: IOAPIC (id[0x02] address[0xfec00000]
> gsi_base[0])
> IOAPIC[0]: apic_id 2, version 17, address
> 0xfec00000, GSI 0-23
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl
> dfl)
> ACPI: BIOS IRQ0 pin2 override ignored.
> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high
> level)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14
> high edge)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15
> high edge)
> ACPI: IRQ9 used by override.
> ACPI: IRQ14 used by override.
> ACPI: IRQ15 used by override.
> Enabling APIC mode:  Flat.  Using 1 I/O APICs
> Using ACPI (MADT) for SMP configuration information
> Allocating PCI resources starting at 20000000 (gap:
> 20000000:dec00000)
> Built 1 zonelists
> Kernel command line: auto BOOT_IMAGE=gentoo ro
> root=303
> radeonfb.default_dynclk=1 elevator=deadline
> Unknown boot option `radeonfb.default_dynclk=1':
> ignoring
> mapped APIC to ffffd000 (fee00000)
> mapped IOAPIC to ffffc000 (fec00000)
> Initializing CPU#0
> PID hash table entries: 2048 (order: 11, 32768
> bytes)
> Detected 1469.873 MHz processor.
> Using tsc for high-res timesource
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 131072 (order: 7,
> 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6,
> 262144 bytes)
> Memory: 515168k/524224k available (2281k kernel
> code, 8504k reserved,
> 855k data, 156k init, 0k highmem)
> Checking if this processor honours the WP bit even
> in supervisor mode... Ok.
> Calibrating delay loop... 2899.96 BogoMIPS
> (lpj=1449984)
> Mount-cache hash table entries: 512 (order: 0, 4096
> bytes)
> CPU: After generic identify, caps: 0383fbff c1c3fbff
> 00000000 00000000
> 00000000 00000000 00000000
> CPU: After vendor identify, caps: 0383fbff c1c3fbff
> 00000000 00000000
> 00000000 00000000 00000000
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K
> (64 bytes/line)
> CPU: L2 Cache: 256K (64 bytes/line)
> CPU: After all inits, caps: 0383fbff c1c3fbff
> 00000000 00000020 00000000
> 00000000 00000000
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU: AMD Athlon(tm) XP 1700+ stepping 01
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support...
> done.
> Checking 'hlt' instruction... OK.
> ENABLING IO-APIC IRQs
> ..TIMER: vector=0x31 pin1=0 pin2=-1
> NET: Registered protocol family 16
> PCI: PCI BIOS revision 2.10 entry at 0xfb590, last
> bus=2
> PCI: Using configuration type 1
> mtrr: v2.0 (20020519)
> ACPI: Subsystem revision 20050211
> ACPI: Interpreter enabled
> ACPI: Using IOAPIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (00:00)
> PCI: Probing PCI hardware (bus 00)
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Routing Table
> [\_SB_.PCI0.HUB0._PRT]
> ACPI: PCI Interrupt Routing Table
> [\_SB_.PCI0.AGPB._PRT]
> ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10
> 11 12 14 15) *0,
> disabled.
> ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10
> 11 *12 14 15)
> ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10
> 11 12 14 15) *0,
> disabled.
> ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 *10
> 11 12 14 15)
> ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10
> 11 12 14 15) *0,
> disabled.
> ACPI: PCI Interrupt Link [LUBA] (IRQs *3 4 5 6 7 10
> 11 12 14 15)
> ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 *7 10
> 11 12 14 15)
> ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 10
> *11 12 14 15)
> ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10
> 11 12 14 15) *0,
> disabled.
> ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 10
> 11 12 14 15) *0,
> disabled.
> ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10
> 11 12 14 15) *0,
> disabled.
> ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 10
> *11 12 14 15)
> ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 *5 6 7 10
> 11 12 14 15)
> ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10
> 11 12 14 15) *0,
> disabled.
> ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10
> 11 12 14 15) *0,
> disabled.
> ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10
> 11 12 14 15) *0,
> disabled.
> ACPI: PCI Interrupt Link [APC1] (IRQs *16),
> disabled.
> ACPI: PCI Interrupt Link [APC2] (IRQs *17),
> disabled.
> ACPI: PCI Interrupt Link [APC3] (IRQs *18),
> disabled.
> ACPI: PCI Interrupt Link [APC4] (IRQs *19),
> disabled.
> ACPI: PCI Interrupt Link [APC5] (IRQs *16),
> disabled.
> ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0,
> disabled.
> ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0,
> disabled.
> ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0,
> disabled.
> ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0,
> disabled.
> ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0,
> disabled.
> ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0,
> disabled.
> ACPI: PCI Interrupt Link [APCS] (IRQs *23),
> disabled.
> ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0,
> disabled.
> ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0,
> disabled.
> ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0,
> disabled.
> ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0,
> disabled.
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> PCI: Using ACPI for IRQ routing
> ** PCI interrupts are no longer routed
> automatically.  If this
> ** causes a device to stop working, it is probably
> because the
> ** driver failed to call pci_enable_device().  As a
> temporary
> ** workaround, the "pci=routeirq" argument restores
> the old
> ** behavior.  If this argument makes the device work
> again,
> ** please email the output of "lspci" to
> bjorn.helgaas@hp.com
> ** so I can fix the driver.
> Machine check exception polling timer started.
> SGI XFS with no debug enabled
> ACPI: Power Button (FF) [PWRF]
> ACPI: Sleep Button (CM) [SLPB]
> ACPI: Fan [FAN] (on)
> ACPI: Thermal Zone [THRM] (40 C)
> Real Time Clock Driver v1.12
> Non-volatile memory driver v1.2
> Linux agpgart interface v0.100 (c) Dave Jones
> agpgart: Detected NVIDIA nForce2 chipset
> agpgart: Maximum main memory to use for agp memory:
> 439M
> agpgart: AGP aperture is 32M @ 0xe0000000
> [drm] Initialized drm 1.0.0 20040925
> ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
> ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 19
> (level, high) -> IRQ 19
> [drm] Initialized radeon 1.14.0 20050125 on minor 0:
> ATI Technologies
> Inc RV280 [Radeon 9200 PRO]
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> io scheduler noop registered
> io scheduler deadline registered (default)
> forcedeth.c: Reverse Engineered nForce ethernet
> driver. Version 0.31.
> ACPI: PCI Interrupt Link [APCH] enabled at IRQ 22
> ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 22
> (level, high) -> IRQ 22
> PCI: Setting latency timer of device 0000:00:04.0 to
> 64
> eth0: forcedeth.c: subsystem: 01297:0531 bound to
> 0000:00:04.0
> tun: Universal TUN/TAP device driver, 1.6
> tun: (C) 1999-2004 Max Krasnyansky
> <maxk@qualcomm.com>
> Linux video capture interface: v1.00
> Uniform Multi-Platform E-IDE driver Revision:
> 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes;
> override with idebus=xx
> NFORCE2: IDE controller at PCI slot 0000:00:09.0
> NFORCE2: chipset revision 162
> NFORCE2: not 100% native mode: will probe irqs later
> NFORCE2: BIOS didn't set cable bits correctly.
> Enabling workaround.
> NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
>      ide0: BM-DMA at 0xf000-0xf007, BIOS settings:
> hda:DMA, hdb:DMA
>      ide1: BM-DMA at 0xf008-0xf00f, BIOS settings:
> hdc:DMA, hdd:DMA
> Probing IDE interface ide0...
> hda: SAMSUNG SV1604N, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Probing IDE interface ide1...
> hdc: HL-DT-ST DVDRAM GSA-4082B, ATAPI CD/DVD-ROM
> drive
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: max request size: 1024KiB
> hda: 312581808 sectors (160041 MB) w/2048KiB Cache,
> CHS=19457/255/63,
> UDMA(100)
> hda: cache flushes supported
>   hda: hda1 hda2 hda3 hda4
> hdc: ATAPI 32X DVD-ROM DVD-R-RAM CD-R/RW drive,
> 2048kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
> ACPI: PCI Interrupt Link [APCL] enabled at IRQ 21
> ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 21
> (level, high) -> IRQ 21
> ehci_hcd 0000:00:02.2: nVidia Corporation nForce2
> USB Controller
> PCI: Setting latency timer of device 0000:00:02.2 to
> 64
> ehci_hcd 0000:00:02.2: irq 21, pci mem 0xe5004000
> ehci_hcd 0000:00:02.2: new USB bus registered,
> assigned bus number 1
> PCI: cache line size of 64 is not supported by
> device 0000:00:02.2
> ehci_hcd 0000:00:02.2: park 0
> ehci_hcd 0000:00:02.2: USB 2.0 initialized, EHCI
> 1.00, driver 10 Dec 2004
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 6 ports detected
> ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller
> (OHCI) Driver (PCI)
> ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
> ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 20
> (level, high) -> IRQ 20
> ohci_hcd 0000:00:02.0: nVidia Corporation nForce2
> USB Controller
> PCI: Setting latency timer of device 0000:00:02.0 to
> 64
> ohci_hcd 0000:00:02.0: irq 20, pci mem 0xe5002000
> ohci_hcd 0000:00:02.0: new USB bus registered,
> assigned bus number 2
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 3 ports detected
> ACPI: PCI Interrupt Link [APCG] enabled at IRQ 22
> ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 22
> (level, high) -> IRQ 22
> ohci_hcd 0000:00:02.1: nVidia Corporation nForce2
> USB Controller (#2)
> PCI: Setting latency timer of device 0000:00:02.1 to
> 64
> ohci_hcd 0000:00:02.1: irq 22, pci mem 0xe5003000
> ohci_hcd 0000:00:02.1: new USB bus registered,
> assigned bus number 3
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 3 ports detected
> usbcore: registered new driver usblp
> drivers/usb/class/usblp.c: v0.13: USB Printer Device
> Class driver
> usb 2-1: new low speed USB device using ohci_hcd and
> address 2
> usb 2-2: new full speed USB device using ohci_hcd
> and address 3
> usb 2-3: new full speed USB device using ohci_hcd
> and address 4
> drivers/usb/class/usblp.c: usblp0: USB Bidirectional
> printer dev 4 if 0
> alt 0 proto 2 vid 0x03F0 pid 0x6104
> input: USB HID v1.10 Mouse [Logitech USB-PS/2
> Optical Mouse] on
> usb-0000:00:02.0-1
> input: USB HID v1.00 Device [USB Audio] on
> usb-0000:00:02.0-2
> usbcore: registered new driver usbhid
> drivers/usb/input/hid-core.c: v2.0:USB HID core
> driver
> mice: PS/2 mouse device common for all mice
> usb 3-2: new full speed USB device using ohci_hcd
> and address 2
> usb 3-3: new low speed USB device using ohci_hcd and
> address 3
> Advanced Linux Sound Architecture Driver Version
> 1.0.8 (Thu Jan 13
> 09:39:32 2005 UTC).
> input: USB HID v1.00 Keyboard [046a:0001] on
> usb-0000:00:02.1-3
> usbcore: registered new driver snd-usb-audio
> ALSA device list:
>    #0: USB Audio at usb-0000:00:02.0-2, full speed
> NET: Registered protocol family 2
> IP: routing cache hash table of 4096 buckets,
> 32Kbytes
> TCP established hash table entries: 32768 (order: 6,
> 262144 bytes)
> TCP bind hash table entries: 32768 (order: 5, 131072
> bytes)
> TCP: Hash tables configured (established 32768 bind
> 32768)
> ip_conntrack version 2.1 (4095 buckets, 32760 max) -
> 172 bytes per conntrack
> ip_tables: (C) 2000-2002 Netfilter core team
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> XFS mounting filesystem hda3
> Ending clean XFS mount for filesystem: hda3
> VFS: Mounted root (xfs filesystem) readonly.
> Freeing unused kernel memory: 156k freed
> Adding 996020k swap on /dev/hda2.  Priority:-1
> extents:1
> lirc_dev: IR Remote Control driver registered, at
> major 61
> lirc_serial: auto-detected active low receiver
> lirc_dev: lirc_register_plugin:sample_rate: 0
> ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 19
> (level, high) -> IRQ 19
> radeonfb: Found Intel x86 BIOS ROM Image
> radeonfb: Retreived PLL infos from BIOS
> radeonfb: Reference=27.00 MHz (RefDiv=12)
> Memory=240.00 Mhz,
> System=166.00 MHz
> radeonfb: PLL min 20000 max 40000
> radeonfb: Monitor 1 type DFP found
> radeonfb: EDID probed
> radeonfb: Monitor 2 type no found
> Console: switching to colour frame buffer device
> 160x64
> radeonfb: Dynamic Clock Power Management enabled
> radeonfb (0000:02:00.0): ATI Radeon Y`
> XFS mounting filesystem hda1
> Ending clean XFS mount for filesystem: hda1
> XFS mounting filesystem hda4
> Ending clean XFS mount for filesystem: hda4
> saa7146: register extension 'dvb'.
> ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
> ACPI: PCI interrupt 0000:01:09.0[A] -> GSI 17
> (level, high) -> IRQ 17
> saa7146: found saa7146 @ mem e091c000 (revision 1,
> irq 17) (0x13c2,0x0000).
> DVB: registering new adapter (Technotrend/Hauppauge
> WinTV DVB-S rev1.X).
> adapter has MAC addr = 00:d0:5c:03:2a:84
> dvb-ttpci: gpioirq unknown type=0 len=0
> dvb-ttpci: info @ card 0: firm f0240009, rtsl
> b0250018, vid 71010068,
> app 8000261d
> dvb-ttpci: firmware @ card 0 supports CI link layer
> interface
> dvb-ttpci: Crystal audio DAC @ card 0 detected
> saa7146_vv: saa7146 (0): registered device video0
> [v4l2]
> DVB: registering frontend 0 (ST STV0299 DVB-S)...
> dvb-ttpci: found av7110-0.
> agpgart: Found an AGP 3.0 compliant device at
> 0000:00:00.0.
> agpgart: X passes broken AGP3 flags (1f00420f).
> Fixed.
> agpgart: Putting AGP V3 device at 0000:00:00.0 into
> 8x mode
> agpgart: Putting AGP V3 device at 0000:02:00.0 into
> 8x mode
> [drm] Loading R200 Microcode
> agpgart: Found an AGP 3.0 compliant device at
> 0000:00:00.0.
> agpgart: X passes broken AGP3 flags (1f00420f).
> Fixed.
> agpgart: Putting AGP V3 device at 0000:00:00.0 into
> 8x mode
> agpgart: Putting AGP V3 device at 0000:02:00.0 into
> 8x mode
> [drm] Loading R200 Microcode
> agpgart: Found an AGP 3.0 compliant device at
> 0000:00:00.0.
> agpgart: X passes broken AGP3 flags (1f00420f).
> Fixed.
> agpgart: Putting AGP V3 device at 0000:00:00.0 into
> 8x mode
> agpgart: Putting AGP V3 device at 0000:02:00.0 into
> 8x mode
> [drm] Loading R200 Microcode
> 
> lspci -vvv
> 0000:00:00.0 Host bridge: nVidia Corporation nForce2
> AGP (different
> version?) (rev c1)
>          Control: I/O- Mem+ BusMaster+ SpecCycle-
> MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>          Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr-
> DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>          Latency: 0
>          Region 0: Memory at e0000000 (32-bit,
> prefetchable)
>          Capabilities: [40] AGP version 3.0
>                  Status: RQ=32 Iso- ArqSz=2 Cal=0
> SBA+ ITACoh- GART64-
> HTrans- 64bit- FW- AGP3+ Rate=x4,x8
>                  Command: RQ=1 ArqSz=0 Cal=0 SBA+
> AGP+ GART64- 64bit-
> FW- Rate=x8        Capabilities: [60] #08 [2001]
> 
> 0000:00:00.1 RAM memory: nVidia Corporation nForce2
> Memory Controller 1
> (rev c1)        Subsystem: Holco Enterprise Co,
> Ltd/Shuttle Computer:
> Unknown device 0531
>          Control: I/O- Mem- BusMaster- SpecCycle-
> MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>          Status: Cap- 66Mhz+ UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 
> 0000:00:00.2 RAM memory: nVidia Corporation nForce2
> Memory Controller 4
> (rev c1)        Subsystem: Holco Enterprise Co,
> Ltd/Shuttle Computer:
> Unknown device 0531
>          Control: I/O- Mem- BusMaster- SpecCycle-
> MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>          Status: Cap- 66Mhz+ UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 
> 0000:00:00.3 RAM memory: nVidia Corporation nForce2
> Memory Controller 3
> (rev c1)        Subsystem: Holco Enterprise Co,
> Ltd/Shuttle Computer:
> Unknown device 0531
>          Control: I/O- Mem- BusMaster- SpecCycle-
> MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>          Status: Cap- 66Mhz+ UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 
> 0000:00:00.4 RAM memory: nVidia Corporation nForce2
> Memory Controller 2
> (rev c1)        Subsystem: Holco Enterprise Co,
> Ltd/Shuttle Computer:
> Unknown device 0531
>          Control: I/O- Mem- BusMaster- SpecCycle-
> MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>          Status: Cap- 66Mhz+ UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 
> 0000:00:00.5 RAM memory: nVidia Corporation nForce2
> Memory Controller 5
> (rev c1)        Subsystem: Holco Enterprise Co,
> Ltd/Shuttle Computer:
> Unknown device 0531
>          Control: I/O- Mem- BusMaster- SpecCycle-
> MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>          Status: Cap- 66Mhz+ UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 
> 0000:00:01.0 ISA bridge: nVidia Corporation nForce2
> ISA Bridge (rev a4)
>          Subsystem: Holco Enterprise Co, Ltd/Shuttle
> Computer: Unknown
> device 0531
>          Control: I/O+ Mem+ BusMaster+ SpecCycle+
> MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>          Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr-
> DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>          Latency: 0
>          Capabilities: [48] #08 [01e1]
> 
> 0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus
> (MCP) (rev a2)
>          Subsystem: Holco Enterprise Co, Ltd/Shuttle
> Computer: Unknown
> device 0531
>          Control: I/O+ Mem- BusMaster- SpecCycle-
> MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>          Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr-
> DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>          Interrupt: pin A routed to IRQ 11
>          Region 0: I/O ports at ec00
>          Capabilities: [44] Power Management version
> 2
>                  Flags: PMEClk- DSI- D1- D2-
> AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot+,D3cold+)
>                  Status: D0 PME-Enable- DSel=0
> DScale=0 PME-
> 
> 0000:00:02.0 USB Controller: nVidia Corporation
> nForce2 USB Controller
> (rev a4) (prog-if 10 [OHCI])
>          Subsystem: Holco Enterprise Co, Ltd/Shuttle
> Computer: Unknown
> device 0531
>          Control: I/O+ Mem+ BusMaster+ SpecCycle-
> MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>          Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr-
> DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>          Latency: 0 (750ns min, 250ns max)
>          Interrupt: pin A routed to IRQ 20
>          Region 0: Memory at e5002000 (32-bit,
> non-prefetchable)
>          Capabilities: [44] Power Management version
> 2
>                  Flags: PMEClk- DSI- D1+ D2+
> AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                  Status: D0 PME-Enable- DSel=0
> DScale=0 PME-
> 
> 0000:00:02.1 USB Controller: nVidia Corporation
> nForce2 USB Controller
> (rev a4) (prog-if 10 [OHCI])
>          Subsystem: Holco Enterprise Co, Ltd/Shuttle
> Computer: Unknown
> device 0531
>          Control: I/O+ Mem+ BusMaster+ SpecCycle-
> MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>          Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr-
> DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>          Latency: 0 (750ns min, 250ns max)
>          Interrupt: pin B routed to IRQ 22
>          Region 0: Memory at e5003000 (32-bit,
> non-prefetchable)
>          Capabilities: [44] Power Management version
> 2
>                  Flags: PMEClk- DSI- D1+ D2+
> AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                  Status: D0 PME-Enable- DSel=0
> DScale=0 PME-
> 
> 0000:00:02.2 USB Controller: nVidia Corporation
> nForce2 USB Controller
> (rev a4) (prog-if 20 [EHCI])
>          Subsystem: Holco Enterprise Co, Ltd/Shuttle
> Computer: Unknown
> device 0531
>          Control: I/O- Mem+ BusMaster+ SpecCycle-
> MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>          Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr-
> DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>          Latency: 0 (750ns min, 250ns max)
>          Interrupt: pin C routed to IRQ 21
>          Region 0: Memory at e5004000 (32-bit,
> non-prefetchable)
>          Capabilities: [44] #0a [2080]
>          Capabilities: [80] Power Management version
> 2
>                  Flags: PMEClk- DSI- D1+ D2+
> AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                  Status: D0 PME-Enable- DSel=0
> DScale=0 PME-
> 
> 0000:00:04.0 Ethernet controller: nVidia Corporation
> nForce2 Ethernet
> Controller (rev a1)
>          Subsystem: Holco Enterprise Co, Ltd/Shuttle
> Computer: Unknown
> device 0531
>          Control: I/O+ Mem+ BusMaster+ SpecCycle-
> MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>          Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr-
> DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>          Latency: 0 (250ns min, 5000ns max)
>          Interrupt: pin A routed to IRQ 22
>          Region 0: Memory at e5000000 (32-bit,
> non-prefetchable)
>          Region 1: I/O ports at e000 [size=8]
>          Capabilities: [44] Power Management version
> 2
>                  Flags: PMEClk- DSI- D1+ D2+
> AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                  Status: D0 PME-Enable+ DSel=0
> DScale=0 PME-
> 
> 0000:00:08.0 PCI bridge: nVidia Corporation nForce2
> External PCI Bridge
> (rev a3) (prog-if 00 [Normal decode])
>          Control: I/O+ Mem+ BusMaster+ SpecCycle-
> MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>          Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr-
> DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>          Latency: 0
>          Bus: primary=00, secondary=01,
> subordinate=01, sec-latency=32
>          I/O behind bridge: 0000f000-00000fff
>          Memory behind bridge: e4000000-e4ffffff
>          Prefetchable memory behind bridge:
> fff00000-000fffff
>          BridgeCtl: Parity- SERR+ NoISA- VGA-
> MAbort- >Reset- FastB2B-
> 
> 0000:00:09.0 IDE interface: nVidia Corporation
> nForce2 IDE (rev a2)
> (prog-if 8a [Master SecP PriP])
>          Subsystem: Holco Enterprise Co, Ltd/Shuttle
> Computer: Unknown
> device 0531
>          Control: I/O+ Mem- BusMaster+ SpecCycle-
> MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>          Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr-
> DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>          Latency: 0 (750ns min, 250ns max)
>          Region 4: I/O ports at f000 [size=16]
>          Capabilities: [44] Power Management version
> 2
>                  Flags: PMEClk- DSI- D1- D2-
> AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                  Status: D0 PME-Enable- DSel=0
> DScale=0 PME-
> 
> 0000:00:1e.0 PCI bridge: nVidia Corporation nForce2
> AGP (rev c1)
> (prog-if 00 [Normal decode])
>          Control: I/O+ Mem+ BusMaster+ SpecCycle-
> MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>          Status: Cap- 66Mhz+ UDF- FastB2B- ParErr-
> DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>          Latency: 32
>          Bus: primary=00, secondary=02,
> subordinate=02, sec-latency=32
>          I/O behind bridge: 0000d000-0000dfff
>          Memory behind bridge: e2000000-e3ffffff
>          Prefetchable memory behind bridge:
> d0000000-dfffffff
>          Expansion ROM at 0000d000 [disabled]
> [size=4K]
>          BridgeCtl: Parity- SERR+ NoISA- VGA+
> MAbort- >Reset- FastB2B-
> 
> 0000:01:09.0 Multimedia controller: Philips
> Semiconductors SAA7146 (rev 01)
>          Subsystem: Technotrend Systemtechnik GmbH
> Siemens/Technotrend/Hauppauge DVB card rev1.3 or
> rev1.5
>          Control: I/O- Mem+ BusMaster+ SpecCycle-
> MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>          Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
> DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>          Latency: 32 (3750ns min, 9500ns max)
>          Interrupt: pin A routed to IRQ 17
>          Region 0: Memory at e4000000 (32-bit,
> non-prefetchable)
> 
> 0000:02:00.0 VGA compatible controller: ATI
> Technologies Inc RV280
> [Radeon 9200 PRO] (rev 01) (prog-if 00 [VGA])
>          Subsystem: Connect Components Ltd: Unknown
> device 2801
>          Control: I/O+ Mem+ BusMaster+ SpecCycle-
> MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>          Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr-
> DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>          Latency: 32 (2000ns min), cache line size
> 08
>          Interrupt: pin A routed to IRQ 19
>          Region 0: Memory at d0000000 (32-bit,
> prefetchable)
>          Region 1: I/O ports at d000 [size=256]
>          Region 2: Memory at e3000000 (32-bit,
> non-prefetchable) [size=64K]
>          Capabilities: [58] AGP version 3.0
>                  Status: RQ=256 Iso- ArqSz=0 Cal=0
> SBA+ ITACoh- GART64-
> HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
>                  Command: RQ=32 ArqSz=2 Cal=0 SBA+
> AGP+ GART64- 64bit-
> FW- Rate=x8
>          Capabilities: [50] Power Management version
> 2
>                  Flags: PMEClk- DSI- D1+ D2+
> AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                  Status: D0 PME-Enable- DSel=0
> DScale=0 PME-
> 
> Thank you very much!
> 
> Sebastian
> 
> 
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
