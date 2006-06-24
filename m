From: Robert Siemer <Robert.Siemer@backsla.sh>
Subject: Re: radeonfb: DDC read wrong?
Date: Sat, 24 Jun 2006 19:47:31 +0200
Message-ID: <20060624174731.GA6091@polar.elf12.net>
References: <20060620140152.GB5414@polar.elf12.net>
	<449D2C02.8010101@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FuCEV-0001Ht-GG for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 24 Jun 2006 10:47:47 -0700
Received: from backsla.sh ([217.160.178.134])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FuCET-0001OY-59
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 24 Jun 2006 10:47:47 -0700
Content-Disposition: inline
In-Reply-To: <449D2C02.8010101@gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 24, 2006 at 08:11:46PM +0800, Antonino A. Daplas wrote:
> Robert Siemer wrote:
> > Hello everybody!
> > 
> > problem: booting kernel overdrives monitor with 200Hz refresh
> > 
> > kernel: 2.6.16
> > kernel which worked fine: 2.6.14
> > 
> > Monitor: EIZO FlexScan F563-T
> > Graphic adapter: ATI Technologies Inc Radeon RV250 If [Radeon 9000]
> >  (from Xorg.log)
> > 
> > I switched to 2.6.16 and booting the kernel overdrove my monitor with
> > 200Hz refresh rate.
> > 
> > As I notice now I have a limit configured in X (I will try it without
> > limitation to see what X is doing...).
> > 
> > The only interesting line so far from X-log:
> > (II) RADEON(0): PLL parameters: rf=2700 rd=12 min=20000 max=40000;
> > xclk=20000
> > 
> > 
> > Any comments?
> 
> Can you change #undef DEBUG to #define DEBUG in drivers/video/fbmon.c
> then post your dmesg?
> 
> If your monitor's EDID block is faulty, we can add it to our
> monitor database for fixups.

Have you read this message from me?
http://marc.theaimsgroup.com/?l=linux-fbdev-devel&m=115096319623635&w=2

The EDID block has a correct checksum as "get-edid | parse-edid" is
saying...

The monitor is a 17", with frequencies H: 30 - 86 kHz, V: 55 - 160 Hz. I
recommand it with 1024x768@100

The dmesg is attached...


Robert

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=dmesg
Content-Transfer-Encoding: quoted-printable

[4294667.296000] Linux version 2.6.16 (Version: panorama.4) (siemer@panoram=
a) (gcc version 4.1.2 20060613 (prerelease) (Debian 4.1.1-5)) #5 PREEMPT Sa=
t Jun 24 19:19:30 CEST 2006
[4294667.296000] BIOS-provided physical RAM map:
[4294667.296000]  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
[4294667.296000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[4294667.296000]  BIOS-e820: 0000000000100000 - 000000007ffec000 (usable)
[4294667.296000]  BIOS-e820: 000000007ffec000 - 000000007ffef000 (ACPI data)
[4294667.296000]  BIOS-e820: 000000007ffef000 - 000000007ffff000 (reserved)
[4294667.296000]  BIOS-e820: 000000007ffff000 - 0000000080000000 (ACPI NVS)
[4294667.296000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[4294667.296000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[4294667.296000]  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
[4294667.296000] 0MB HIGHMEM available.
[4294667.296000] 2047MB LOWMEM available.
[4294667.296000] On node 0 totalpages: 524268
[4294667.296000]   DMA zone: 4096 pages, LIFO batch:0
[4294667.296000]   DMA32 zone: 0 pages, LIFO batch:0
[4294667.296000]   Normal zone: 520172 pages, LIFO batch:31
[4294667.296000]   HighMem zone: 0 pages, LIFO batch:0
[4294667.296000] DMI 2.3 present.
[4294667.296000] ASUS P4B266 detected: force use of acpi=3Dht
[4294667.296000] ACPI: RSDP (v000 ASUS                                  ) @=
 0x000f7720
[4294667.296000] ACPI: RSDT (v001 ASUS   P4B266   0x42302e31 MSFT 0x3131303=
1) @ 0x7ffec000
[4294667.296000] ACPI: FADT (v001 ASUS   P4B266   0x42302e31 MSFT 0x3131303=
1) @ 0x7ffec100
[4294667.296000] ACPI: BOOT (v001 ASUS   P4B266   0x42302e31 MSFT 0x3131303=
1) @ 0x7ffec040
[4294667.296000] ACPI: MADT (v001 ASUS   P4B266   0x42302e31 MSFT 0x3131303=
1) @ 0x7ffec080
[4294667.296000] ACPI: DSDT (v001   ASUS P4B266   0x00001000 MSFT 0x0100000=
b) @ 0x00000000
[4294667.296000] ACPI: PM-Timer IO Port: 0xe408
[4294667.296000] ACPI: Local APIC address 0xfee00000
[4294667.296000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[4294667.296000] Processor #0 15:2 APIC version 20
[4294667.296000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[4294667.296000] Allocating PCI resources starting at 88000000 (gap: 800000=
00:7ec00000)
[4294667.296000] Built 1 zonelists
[4294667.296000] Kernel command line: BOOT_IMAGE=3D/vmlinuz video=3Dradeonf=
b:1024x768@100 resume=3D/dev/hda3
[4294667.296000] Found and enabled local APIC!
[4294667.296000] mapped APIC to ffffd000 (fee00000)
[4294667.296000] Enabling fast FPU save and restore... done.
[4294667.296000] Enabling unmasked SIMD FPU exception support... done.
[4294667.296000] Initializing CPU#0
[4294667.296000] PID hash table entries: 4096 (order: 12, 65536 bytes)
[4294667.296000] Detected 1816.476 MHz processor.
[4294667.296000] Using pmtmr for high-res timesource
[4294667.296000] Console: colour VGA+ 80x25
[4294667.608000] Dentry cache hash table entries: 524288 (order: 9, 2097152=
 bytes)
[4294667.614000] Inode-cache hash table entries: 262144 (order: 8, 1048576 =
bytes)
[4294667.668000] Memory: 2074136k/2097072k available (1794k kernel code, 22=
472k reserved, 684k data, 140k init, 0k highmem)
[4294667.668000] Checking if this processor honours the WP bit even in supe=
rvisor mode... Ok.
[4294667.728000] Calibrating delay using timer specific routine.. 3637.28 B=
ogoMIPS (lpj=3D1818644)
[4294667.728000] Security Framework v1.0.0 initialized
[4294667.728000] Capability LSM initialized
[4294667.728000] Mount-cache hash table entries: 512
[4294667.728000] CPU: After generic identify, caps: bfebfbff 00000000 00000=
000 00000000 00004400 00000000 00000000
[4294667.728000] CPU: After vendor identify, caps: bfebfbff 00000000 000000=
00 00000000 00004400 00000000 00000000
[4294667.728000] CPU: Trace cache: 12K uops, L1 D cache: 8K
[4294667.728000] CPU: L2 cache: 512K
[4294667.728000] CPU: After all inits, caps: bfebfbff 00000000 00000000 000=
00080 00004400 00000000 00000000
[4294667.728000] Intel machine check architecture supported.
[4294667.728000] Intel machine check reporting enabled on CPU#0.
[4294667.728000] CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
[4294667.728000] CPU0: Thermal monitoring enabled
[4294667.728000] CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 09
[4294667.728000] Checking 'hlt' instruction... OK.
[4294667.834000] NET: Registered protocol family 16
[4294667.835000] PCI: PCI BIOS revision 2.10 entry at 0xf1090, last bus=3D2
[4294667.835000] PCI: Using configuration type 1
[4294667.836000] ACPI: Subsystem revision 20060127
[4294667.836000] ACPI: Interpreter disabled.
[4294667.836000] Linux Plug and Play Support v0.97 (c) Adam Belay
[4294667.836000] pnp: PnP ACPI: disabled
[4294667.836000] SCSI subsystem initialized
[4294667.836000] usbcore: registered new driver usbfs
[4294667.836000] usbcore: registered new driver hub
[4294667.836000] PCI: Probing PCI hardware
[4294667.836000] PCI: Probing PCI hardware (bus 00)
[4294667.837000] PCI quirk: region e400-e47f claimed by ICH4 ACPI/GPIO/TCO
[4294667.837000] PCI quirk: region ec00-ec3f claimed by ICH4 GPIO
[4294667.837000] Boot video device is 0000:01:00.0
[4294667.838000] PCI: Transparent bridge - 0000:00:1e.0
[4294667.839000] PCI: Using IRQ router PIIX/ICH [8086/2440] at 0000:00:1f.0
[4294667.839000] PCI: Found IRQ 5 for device 0000:02:03.0
[4294667.839000] PCI: Sharing IRQ 5 with 0000:02:04.0
[4294667.839000] PCI: Sharing IRQ 5 with 0000:02:09.0
[4294667.839000] PCI: Sharing IRQ 5 with 0000:02:0d.0
[4294667.839000] PCI: Found IRQ 9 for device 0000:02:04.2
[4294667.839000] PCI: Sharing IRQ 9 with 0000:00:1f.4
[4294667.852000] PCI: Bridge: 0000:00:01.0
[4294667.852000]   IO window: d000-dfff
[4294667.852000]   MEM window: e9800000-ea7fffff
[4294667.852000]   PREFETCH window: ec000000-f7ffffff
[4294667.852000] PCI: Bridge: 0000:00:1e.0
[4294667.852000]   IO window: a000-bfff
[4294667.852000]   MEM window: e6000000-e97fffff
[4294667.852000]   PREFETCH window: ea800000-ebffffff
[4294667.852000] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[4294667.852000] Simple Boot Flag at 0x3a set to 0x80
[4294667.852000] Machine check exception polling timer started.
[4294667.853000] audit: initializing netlink socket (disabled)
[4294667.853000] audit(1151170193.852:1): initialized
[4294667.854000] VFS: Disk quotas dquot_6.5.1
[4294667.854000] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[4294667.854000] Initializing Cryptographic API
[4294667.854000] io scheduler noop registered
[4294667.854000] io scheduler anticipatory registered
[4294667.854000] io scheduler deadline registered (default)
[4294667.854000] io scheduler cfq registered
[4294667.855000] radeonfb_pci_register BEGIN
[4294667.855000] PCI: Found IRQ 11 for device 0000:01:00.0
[4294667.855000] radeonfb (0000:01:00.0): Found 65536k of DDR 128 bits wide=
 videoram
[4294667.855000] radeonfb (0000:01:00.0): mapped 16384k videoram
[4294667.855000] radeonfb: Found Intel x86 BIOS ROM Image
[4294667.855000] radeonfb: Retrieved PLL infos from BIOS
[4294667.855000] radeonfb: Reference=3D27.00 MHz (RefDiv=3D12) Memory=3D250=
=2E00 Mhz, System=3D200.00 MHz
[4294667.855000] radeonfb: PLL min 20000 max 40000
[4294667.855000] 1 chips in connector info
[4294667.855000]  - chip 1 has 2 connectors
[4294667.856000]   * connector 0 of type 2 (CRT) : 2300
[4294667.856000]   * connector 1 of type 3 (DVI-I) : 3201
[4294667.856000] Starting monitor auto detection...
[4294668.063000] radeonfb: I2C (port 1) ... not found
[4294668.426000] radeonfb: I2C (port 2) ... not found
[4294668.658000] radeonfb: I2C (port 3) ... found CRT display
[4294669.021000] radeonfb: I2C (port 4) ... not found
[4294669.384000] radeonfb: I2C (port 2) ... not found
[4294669.747000] radeonfb: I2C (port 4) ... not found
[4294669.979000] radeonfb: I2C (port 3) ... found CRT display
[4294669.979000] radeonfb: Monitor 1 type CRT found
[4294669.979000] radeonfb: EDID probed
[4294669.979000] radeonfb: Monitor 2 type no found
[4294669.979000] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[4294669.979000] Display Information (EDID)
[4294669.979000] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[4294669.979000]    EDID Version 1.1
[4294669.979000]    Manufacturer: EIZ
[4294669.979000]    Model: 202
[4294669.979000]    Serial#: 0
[4294669.979000]    Year: 1996 Week 2
[4294669.979000]    ASCII Block: 7=A0=1EV=01=01=01=01=01=01=01=01=01
[4294669.979000]    Display Characteristics:
[4294669.979000]       Monitor Operating Limits:    Detailed Timings
[4294669.979000]       2 MHz 1 2 3 258 1 1 18 258 -HSync -VSync
[4294669.979000]=20
[4294669.980000]       2 MHz 1 2 3 258 1 1 18 258 -HSync -VSync
[4294669.980000]=20
[4294669.980000]       2 MHz 1 2 3 258 1 1 18 258 -HSync -VSync
[4294669.980000]=20
[4294669.980000]    Supported VESA Modes
[4294669.980000]       720x400@70Hz
[4294669.980000]       832x624@75Hz
[4294669.980000]       1280x1024@75Hz
[4294669.980000]       1152x870@75Hz
[4294669.980000]       Manufacturer's mask: 0
[4294669.980000]    Standard Timings
[4294669.980000] Extrapolated
[4294669.980000]            H: 0-80KHz V: 38-75Hz DCLK: 135MHz
[4294669.980000]       Analog Display Input: Input Voltage - 0.700V/0.300V
[4294669.980000]       Sync: Separate Composite Sync on Green=20
[4294669.981000]       Max H-size in cm: 31
[4294669.981000]       Max V-size in cm: 23
[4294669.981000]       Gamma: 1.80
[4294669.981000]       DPMS: Active yes, Suspend yes, Standby yes
[4294669.981000]       RGB Color Display
[4294669.981000]       Chroma
[4294669.981000]          RedX:     0.625 RedY:     0.340
[4294669.981000]          GreenX:   0.275 GreenY:   0.605
[4294669.981000]          BlueX:    0.150 BlueY:    0.065
[4294669.981000]          WhiteX:   0.283 WhiteY:   0.298
[4294669.981000]    Detailed Timings
[4294669.982000]       2 MHz 1 2 3 258 1 1 18 258 -HSync -VSync
[4294669.982000]=20
[4294669.982000]       2 MHz 1 2 3 258 1 1 18 258 -HSync -VSync
[4294669.982000]=20
[4294669.982000]       2 MHz 1 2 3 258 1 1 18 258 -HSync -VSync
[4294669.982000]=20
[4294669.982000]    Supported VESA Modes
[4294669.982000]       720x400@70Hz
[4294669.982000]       832x624@75Hz
[4294669.982000]       1280x1024@75Hz
[4294669.982000]       1152x870@75Hz
[4294669.982000]       Manufacturer's mask: 0
[4294669.982000]    Standard Timings
[4294669.983000] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[4294669.986000] hStart =3D 1217, hEnd =3D 1345, hTotal =3D 1601
[4294669.986000] vStart =3D 865, vEnd =3D 868, vTotal =3D 900
[4294669.986000] h_total_disp =3D 0x8f00c7	   hsync_strt_wid =3D 0x1004cb
[4294669.986000] v_total_disp =3D 0x35f0383	   vsync_strt_wid =3D 0x30360
[4294669.986000] pixclock =3D 9259
[4294669.986000] freq =3D 10800
[4294669.986000] freq =3D 10800, PLL min =3D 20000, PLL max =3D 40000
[4294669.986000] ref_div =3D 12, ref_clk =3D 2700, output_freq =3D 21600
[4294669.986000] ref_div =3D 12, ref_clk =3D 2700, output_freq =3D 21600
[4294669.986000] post div =3D 0x1
[4294669.986000] fb_div =3D 0x60
[4294669.986000] ppll_div_3 =3D 0x10060
[4294670.047000] Console: switching to colour frame buffer device 144x54
[4294670.050000] radeonfb (0000:01:00.0): ATI Radeon If=20
[4294670.050000] radeonfb_pci_register END
[4294670.053000] PNP: No PS/2 controller found. Probing ports directly.
=2E...

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--IJpNTDwzlM2Ie8A6--
