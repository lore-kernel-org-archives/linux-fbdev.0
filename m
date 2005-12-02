From: Richard Purdie <rpurdie@rpsys.net>
Subject: PCI nvidiafb card init with a broken BIOS?
Date: Fri, 02 Dec 2005 11:39:16 +0000
Message-ID: <1133523556.7994.21.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ei9GJ-0007y9-Kk
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 02 Dec 2005 03:39:35 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1Ei9GI-0002FM-66
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 02 Dec 2005 03:39:35 -0800
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.1/8.12.10) with ESMTP id jB2BdKQw013914
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 2 Dec 2005 11:39:20 GMT
Received: from tim.rpsys.net ([127.0.0.1])
 by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 13817-02 for <linux-fbdev-devel@lists.sourceforge.net>;
 Fri,  2 Dec 2005 11:39:20 +0000 (GMT)
Received: from max.rpnet.com (max.rpnet.com [192.168.1.15])
	(authenticated bits=0)
	by tim.rpsys.net (8.13.1/8.12.10) with ESMTP id jB2BdGX6013908
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 2 Dec 2005 11:39:16 GMT
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
To: FB-Dev <linux-fbdev-devel@lists.sourceforge.net>

Hi,

I have a Dell Poweredge 1600SC which is a Dual P4 Xeon system with an
inbuilt ATI Rage XL. It has a variety of PCI slots and I tried inserting
a PCI XFX Geforce FX 5200 256mb into it to upgrade its graphics
capability as the inbuilt Rage XL can't cope with the resolutions I want
to use.

Whilst the machine boots with the new card in, I see nothing on any of
the video outputs from the BIOS or Linux. It looks like the BIOS can't
cope with the card. (I've tried the card in each PCI slot).

I've included the Linux bootup below for 2.6.15-rc2. nvidiafb does load
but the video memory size looks wrong and it pauses for a long time
before printing "DMA Get lockup".  Reading Dell's forums, it looks like
the inbuilt card is moved in memory rather than disabled and you can see
this being detected as fb1 but again, no video output from it.

Its a long shot but it there any way I can get Linux to correctly init
the PCI card and undo any damage done by the broken BIOS? Would
disabling ACPI help or is there anything else I can try?

Dell's response on the issue is that they don't support graphics cards
in the machine.

Richard

Linux version 2.6.15-rc2 (richard@sam) (gcc version 4.0.2 20050808 (prerelease) (Ubuntu 4.0.1-4ubuntu9)) #5 SMP Fri Dec 2 10:08:45 GMT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 0000000000100000 - 00000000bffe0000 (usable)
 BIOS-e820: 00000000bffe0000 - 00000000bffefc00 (ACPI data)
 BIOS-e820: 00000000bffefc00 - 00000000bffff000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
2175MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fe710
On node 0 totalpages: 786400
  DMA zone: 4096 pages, LIFO batch:2
  DMA32 zone: 0 pages, LIFO batch:2
  Normal zone: 225280 pages, LIFO batch:64
  HighMem zone: 557024 pages, LIFO batch:64
DMI 2.3 present.
ACPI: RSDP (v000 DELL                                  ) @ 0x000fdc40
ACPI: RSDT (v001 DELL   PE1600SC 0x00000001 MSFT 0x0100000a) @ 0x000fdc54
ACPI: FADT (v001 DELL   PE1600SC 0x00000001 MSFT 0x0100000a) @ 0x000fdc84
ACPI: MADT (v001 DELL   PE1600SC 0x00000001 MSFT 0x0100000a) @ 0x000fdcf8
ACPI: SPCR (v001 DELL   PE1600SC 0x00000001 MSFT 0x0100000a) @ 0x000fdd80
ACPI: DSDT (v001 DELL   PE1600SC 0x00000001 MSFT 0x0100000a) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
Processor #7 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 17, address 0xfec00000, GSI 0-15
ACPI: IOAPIC (id[0x09] address[0xfec01000] gsi_base[16])
IOAPIC[1]: apic_id 9, version 17, address 0xfec01000, GSI 16-31
ACPI: IOAPIC (id[0x0a] address[0xfec02000] gsi_base[32])
IOAPIC[2]: apic_id 10, version 17, address 0xfec02000, GSI 32-47
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at c0000000 (gap: bffff000:3ec01000)
Built 1 zonelists
Kernel command line: root=/dev/hda1 ro splash console=ttyS0,9600 debug
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec01000)
mapped IOAPIC to ffffa000 (fec02000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2791.325 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 3104088k/3145600k available (2445k kernel code, 39612k reserved, 712k data, 232k init, 2228096k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5588.05 BogoMIPS (lpj=11176100)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbf7 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5581.96 BogoMIPS (lpj=11163935)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbf7 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
Booting processor 2/6 eip 2000
Initializing CPU#2
Calibrating delay using timer specific routine.. 5581.94 BogoMIPS (lpj=11163894)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
CPU: After all inits, caps: bfebfbf7 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#2.
CPU2: Intel P4/Xeon Extended MCE MSRs (12) available
CPU2: Thermal monitoring enabled
CPU2: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
Booting processor 3/7 eip 2000
Initializing CPU#3
Calibrating delay using timer specific routine.. 5581.92 BogoMIPS (lpj=11163842)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
CPU: After all inits, caps: bfebfbf7 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#3.
CPU3: Intel P4/Xeon Extended MCE MSRs (12) available
CPU3: Thermal monitoring enabled
CPU3: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
Total of 4 processors activated (22333.88 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=0 apic2=-1 pin2=-1
checking TSC synchronization across 4 CPUs: passed.
Brought up 4 CPUs
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:0f.1
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Root Bridge [PCI1] (0000:01)
PCI: Probing PCI hardware (bus 01)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1._PRT]
ACPI: PCI Root Bridge [PCI2] (0000:02)
PCI: Probing PCI hardware (bus 02)
Boot video device is 0000:02:02.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI2._PRT]
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 9 10 *11 12 14)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 *6 7 9 10 11 12 14)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 *5 6 7 9 10 11 12 14)
ACPI: PCI Interrupt Link [LNK6] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LNK7] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LNK8] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LNK9] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LN10] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LN11] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LN12] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LN13] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LN14] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LN15] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LN16] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LN17] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LN18] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LN19] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LN1A] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LN1B] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LN1C] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LN1D] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LN1E] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LN1F] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LUSB] (IRQs 3 4 5 6 7 *10 11 12 14)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:09: ioport range 0x814-0x85b could not be reserved
pnp: 00:09: ioport range 0x820-0x83f has been reserved
pnp: 00:09: ioport range 0x8a0-0x8af has been reserved
pnp: 00:09: ioport range 0xc00-0xcd7 has been reserved
pnp: 00:09: ioport range 0xf50-0xf58 has been reserved
pnp: 00:09: ioport range 0x800-0x819 could not be reserved
pnp: 00:09: ioport range 0x880-0x89f has been reserved
pnp: 00:09: ioport range 0x8c0-0x8c3 has been reserved
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
audit: initializing netlink socket (disabled)
audit(1133519028.348:1): initialized
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
PCI: MSI quirk detected. pci_msi_quirk set.
PCI: MSI quirk detected. pci_msi_quirk set.
rivafb_setup START
ACPI: PCI Interrupt 0000:02:02.0[A] -> GSI 21 (level, low) -> IRQ 16
nvidiafb: nVidia device/chipset 10DE0322
nvidiafb: CRTC0 analog found
nvidiafb: CRTC1 analog not found
nvidiafb: CRTC 0 appears to have a CRT attached
nvidiafb: Using CRT on CRTC 0
nvidiafb: MTRR set to ON
DMA Get lockup
Console: switching to colour frame buffer device 80x30
nvidiafb: PCI nVidia NV32 framebuffer (2MB @ 0xE0000000)
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
fb1: VGA16 VGA frame buffer device
ACPI: Power Button (FF) [PWRF]



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
