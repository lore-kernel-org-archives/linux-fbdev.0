From: rami jiossy <sramij@yahoo.com>
Subject: Re: intelfb driver on 945GM chipset
Date: Thu, 28 Dec 2006 05:53:02 -0800 (PST)
Message-ID: <20061228135302.52101.qmail@web90402.mail.mud.yahoo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0723922427=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gzvgz-0000Dy-BT for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Dec 2006 05:53:09 -0800
Received: from web90402.mail.mud.yahoo.com ([216.252.100.154])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Gzvgy-00072z-LF
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Dec 2006 05:53:09 -0800
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
Cc: jsimmons@infradead.org

--===============0723922427==
Content-Type: multipart/alternative; boundary="0-1017390124-1167313982=:51659"

--0-1017390124-1167313982=:51659
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: quoted-printable

Hi;=0Ahere is my dmesg output.=0Aas you can see below intelfb claims no vid=
eo mode configured at boot time inspit is does.=0A=0A=0A[    0.000000] Linu=
x version 2.6.19-intelfb (root@rjiossy-laptop) (gcc version 4.0.3 (Ubuntu 4=
.0.3-1ubuntu5)) #1 SMP Thu Dec 28 15:30:48 IST 2006=0A[    0.000000] BIOS-p=
rovided physical RAM map:=0A[    0.000000]  BIOS-e820: 0000000000000000 - 0=
00000000009fc00 (usable)=0A[    0.000000]  BIOS-e820: 000000000009fc00 - 00=
000000000a0000 (reserved)=0A[    0.000000]  BIOS-e820: 00000000000edb40 - 0=
000000000100000 (reserved)=0A[    0.000000]  BIOS-e820: 0000000000100000 - =
000000001e871000 (usable)=0A[    0.000000]  BIOS-e820: 000000001e871000 - 0=
00000001ea72000 (ACPI NVS)=0A[    0.000000]  BIOS-e820: 000000001ea72000 - =
000000001f6a7000 (ACPI data)=0A[    0.000000]  BIOS-e820: 000000001f6a7000 =
- 000000001f6af000 (reserved)=0A[    0.000000]  BIOS-e820: 000000001f6af000=
 - 000000001f6ba000 (ACPI data)=0A[    0.000000]  BIOS-e820: 000000001f6ba0=
00 - 000000001f6bc000 (ACPI NVS)=0A[    0.000000]  BIOS-e820: 000000001f6bc=
000 - 000000001f6c7000 (ACPI data)=0A[    0.000000]  BIOS-e820: 000000001f6=
c7000 - 000000001f6ef000 (ACPI NVS)=0A[    0.000000]  BIOS-e820: 000000001f=
6ef000 - 000000001f700000 (ACPI data)=0A[    0.000000]  BIOS-e820: 00000000=
1f700000 - 0000000020000000 (reserved)=0A[    0.000000]  BIOS-e820: 0000000=
0e0000000 - 00000000f0000000 (reserved)=0A[    0.000000]  BIOS-e820: 000000=
00fec00000 - 00000000fec01000 (reserved)=0A[    0.000000]  BIOS-e820: 00000=
000fed14000 - 00000000fed1a000 (reserved)=0A[    0.000000]  BIOS-e820: 0000=
0000fed1c000 - 00000000fed20000 (reserved)=0A[    0.000000]  BIOS-e820: 000=
00000fee00000 - 00000000fee01000 (reserved)=0A[    0.000000]  BIOS-e820: 00=
000000fff00000 - 0000000100000000 (reserved)=0A[    0.000000] 0MB HIGHMEM a=
vailable.=0A[    0.000000] 488MB LOWMEM available.=0A[    0.000000] Enterin=
g add_active_range(0, 0, 125041) 0 entries of 256 used=0A[    0.000000] Zon=
e PFN ranges:=0A[    0.000000]   DMA             0 ->     4096=0A[    0.000=
000]   Normal       4096 ->   125041=0A[    0.000000]   HighMem    125041 -=
>   125041=0A[    0.000000] early_node_map[1] active PFN ranges=0A[    0.00=
0000]     0:        0 ->   125041=0A[    0.000000] On node 0 totalpages: 12=
5041=0A[    0.000000]   DMA zone: 32 pages used for memmap=0A[    0.000000]=
   DMA zone: 0 pages reserved=0A[    0.000000]   DMA zone: 4064 pages, LIFO=
 batch:0=0A[    0.000000]   Normal zone: 944 pages used for memmap=0A[    0=
.000000]   Normal zone: 120001 pages, LIFO batch:31=0A[    0.000000]   High=
Mem zone: 0 pages used for memmap=0A[    0.000000] DMI 2.4 present.=0A[    =
0.000000] ACPI: RSDP (v000 INTEL                                 ) @ 0x000f=
e020=0A[    0.000000] ACPI: RSDT (v001 INTEL  Capell00 0x00000056      0x01=
000013) @ 0x1f6fd038=0A[    0.000000] ACPI: FADT (v001 INTEL  Capell00 0x00=
000056 LOHR 0x0000005f) @ 0x1f6fc000=0A[    0.000000] ACPI: HPET (v001 INTE=
L  Capell00 0x00000001 LOHR 0x0000005f) @ 0x1f6fa000=0A[    0.000000] ACPI:=
 MADT (v001 INTEL  Capell00 0x00000001 LOHR 0x0000005f) @ 0x1f6f9000=0A[   =
 0.000000] ACPI: MCFG (v001 INTEL  Capell00 0x00000001 LOHR 0x0000005f) @ 0=
x1f6f8000=0A[    0.000000] ACPI: ASF! (v032 INTEL  Capell00 0x00000001 LOHR=
 0x0000005f) @ 0x1f6f7000=0A[    0.000000] ACPI: SSDT (v001 INTEL   SataPri=
 0x00001000 INTL 0x20060608) @ 0x1f6f0000=0A[    0.000000] ACPI: SSDT (v001=
 INTEL   SataSec 0x00001000 INTL 0x20060608) @ 0x1f6ef000=0A[    0.000000] =
ACPI: SSDT (v001 INTEL     CpuPm 0x00003000 INTL 0x20060608) @ 0x1f6f5000=
=0A[    0.000000] ACPI: DSDT (v001 INTEL  CALISTGA 0x00000001 INTL 0x200606=
08) @ 0x00000000=0A[    0.000000] ACPI: PM-Timer IO Port: 0x408=0A[    0.00=
0000] ACPI: Local APIC address 0xfee00000=0A[    0.000000] ACPI: LAPIC (acp=
i_id[0x00] lapic_id[0x00] enabled)=0A[    0.000000] Processor #0 6:15 APIC =
version 20=0A[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabl=
ed)=0A[    0.000000] Processor #1 6:15 APIC version 20=0A[    0.000000] ACP=
I: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])=0A[    0.000000] ACPI: LAP=
IC_NMI (acpi_id[0x01] high edge lint[0x1])=0A[    0.000000] ACPI: IOAPIC (i=
d[0x01] address[0xfec00000] gsi_base[0])=0A[    0.000000] IOAPIC[0]: apic_i=
d 1, version 32, address 0xfec00000, GSI 0-23=0A[    0.000000] ACPI: INT_SR=
C_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)=0A[    0.000000] ACPI: INT_SRC=
_OVR (bus 0 bus_irq 9 global_irq 9 high level)=0A[    0.000000] ACPI: IRQ0 =
used by override.=0A[    0.000000] ACPI: IRQ2 used by override.=0A[    0.00=
0000] ACPI: IRQ9 used by override.=0A[    0.000000] Enabling APIC mode:  Fl=
at.  Using 1 I/O APICs=0A[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xf=
ed00000=0A[    0.000000] Using ACPI (MADT) for SMP configuration informatio=
n=0A[    0.000000] Allocating PCI resources starting at 30000000 (gap: 2000=
0000:c0000000)=0A[    0.000000] Detected 1666.763 MHz processor.=0A[   40.0=
43790] Built 1 zonelists.  Total pages: 124065=0A[   40.043792] Kernel comm=
and line: root=3D/dev/sda5 ro single video=3Dintelfb:mode=3D1024x768-32@70 =
=0A[   40.043967] mapped APIC to ffffd000 (fee00000)=0A[   40.043969] mappe=
d IOAPIC to ffffc000 (fec00000)=0A[   40.043972] Enabling fast FPU save and=
 restore... done.=0A[   40.043974] Enabling unmasked SIMD FPU exception sup=
port... done.=0A[   40.043977] Initializing CPU#0=0A[   40.044059] PID hash=
 table entries: 2048 (order: 11, 8192 bytes)=0A[   40.045481] Console: colo=
ur VGA+ 80x25=0A[   40.048746] Dentry cache hash table entries: 65536 (orde=
r: 6, 262144 bytes)=0A[   40.048956] Inode-cache hash table entries: 32768 =
(order: 5, 131072 bytes)=0A[   40.054154] Memory: 486992k/500164k available=
 (2091k kernel code, 12644k reserved, 1019k data, 228k init, 0k highmem)=0A=
[   40.054246] virtual kernel memory layout:=0A[   40.054247]     fixmap  :=
 0xfff4f000 - 0xfffff000   ( 704 kB)=0A[   40.054248]     pkmap   : 0xff800=
000 - 0xffc00000   (4096 kB)=0A[   40.054250]     vmalloc : 0xdf800000 - 0x=
ff7fe000   ( 511 MB)=0A[   40.054251]     lowmem  : 0xc0000000 - 0xde871000=
   ( 488 MB)=0A[   40.054252]       .init : 0xc040f000 - 0xc0448000   ( 228=
 kB)=0A[   40.054253]       .data : 0xc030af21 - 0xc0409b70   (1019 kB)=0A[=
   40.054255]       .text : 0xc0100000 - 0xc030af21   (2091 kB)=0A[   40.05=
4746] Checking if this processor honours the WP bit even in supervisor mode=
... Ok.=0A[   40.055017] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0=0A[   40.0=
55241] hpet0: 3 64-bit timers, 14318180 Hz=0A[   40.056307] Using HPET for =
base-timer=0A[   40.115979] Calibrating delay using timer specific routine.=
. 3336.33 BogoMIPS (lpj=3D1668166)=0A[   40.116132] Security Framework v1.0=
.0 initialized=0A[   40.116213] Mount-cache hash table entries: 512=0A[   4=
0.116376] CPU: After generic identify, caps: bfebfbff 20100000 00000000 000=
00000 0000e3bd 00000000 00000001=0A[   40.116384] monitor/mwait feature pre=
sent.=0A[   40.116445] using mwait in idle threads.=0A[   40.116507] CPU: L=
1 I cache: 32K, L1 D cache: 32K=0A[   40.116609] CPU: L2 cache: 4096K=0A[  =
 40.116669] CPU: Physical Processor ID: 0=0A[   40.116729] CPU: Processor C=
ore ID: 0=0A[   40.116788] CPU: After all inits, caps: bfebfbff 20100000 00=
000000 00000940 0000e3bd 00000000 00000001=0A[   40.116807] Checking 'hlt' =
instruction... OK.=0A[   40.120123] Freeing SMP alternatives: 12k freed=0A[=
   40.120185] ACPI: Core revision 20060707=0A[   40.123798] CPU0: Intel(R) =
Pentium(R) M CPU        000  @ 1.66GHz stepping 01=0A[   40.123961] Booting=
 processor 1/1 eip 2000=0A[   40.135423] Initializing CPU#1=0A[   40.194924=
] Calibrating delay using timer specific routine.. 3333.35 BogoMIPS (lpj=3D=
1666676)=0A[   40.194931] CPU: After generic identify, caps: bfebfbff 20100=
000 00000000 00000000 0000e3bd 00000000 00000001=0A[   40.194936] monitor/m=
wait feature present.=0A[   40.194941] CPU: L1 I cache: 32K, L1 D cache: 32=
K=0A[   40.194943] CPU: L2 cache: 4096K=0A[   40.194945] CPU: Physical Proc=
essor ID: 0=0A[   40.194947] CPU: Processor Core ID: 1=0A[   40.194948] CPU=
: After all inits, caps: bfebfbff 20100000 00000000 00000940 0000e3bd 00000=
000 00000001=0A[   40.195616] CPU1: Intel(R) Pentium(R) M CPU        000  @=
 1.66GHz stepping 01=0A[   40.196218] Total of 2 processors activated (6669=
.68 BogoMIPS).=0A[   40.196473] ENABLING IO-APIC IRQs=0A[   40.196728] ..TI=
MER: vector=3D0x31 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1=0A[   40.307851]=
 checking TSC synchronization across 2 CPUs: passed.=0A[    0.000950] Broug=
ht up 2 CPUs=0A[    0.073014] migration_cost=3D48=0A[    0.073275] checking=
 if image is initramfs... it is=0A[    0.515014] Freeing initrd memory: 460=
2k freed=0A[    0.515400] NET: Registered protocol family 16=0A[    0.51553=
9] ACPI: bus type pci registered=0A[    0.515621] PCI: Using MMCONFIG=0A[  =
  0.516411] Setting up standard PCI resources=0A[    0.520353] ACPI: Interp=
reter enabled=0A[    0.520414] ACPI: Using IOAPIC for interrupt routing=0A[=
    0.521478] ACPI: PCI Root Bridge [PCI0] (0000:00)=0A[    0.521544] PCI: =
Probing PCI hardware (bus 00)=0A[    0.521782] ACPI: Assume root bridge [\_=
SB_.PCI0] bus is 0=0A[    0.523577] Boot video device is 0000:00:02.0=0A[  =
  0.524065] PCI quirk: region 0400-047f claimed by ICH6 ACPI/GPIO/TCO=0A[  =
  0.524133] PCI quirk: region 0500-053f claimed by ICH6 GPIO=0A[    0.52424=
6] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2=0A[    0.525344] PCI=
: Transparent bridge - 0000:00:1e.0=0A[    0.525475] ACPI: PCI Interrupt Ro=
uting Table [\_SB_.PCI0._PRT]=0A[    0.535098] ACPI: PCI Interrupt Routing =
Table [\_SB_.PCI0.RP01._PRT]=0A[    0.535367] ACPI: PCI Interrupt Routing T=
able [\_SB_.PCI0.RP02._PRT]=0A[    0.535632] ACPI: PCI Interrupt Routing Ta=
ble [\_SB_.PCI0.RP03._PRT]=0A[    0.535892] ACPI: PCI Interrupt Routing Tab=
le [\_SB_.PCI0.RP04._PRT]=0A[    0.537652] ACPI: PCI Interrupt Routing Tabl=
e [\_SB_.PCI0.PCIB._PRT]=0A[    0.538810] ACPI: PCI Interrupt Link [LNKA] (=
IRQs 1 3 4 5 6 7 10 12 14 15) *11=0A[    0.539669] ACPI: PCI Interrupt Link=
 [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 15) *10=0A[    0.540524] ACPI: PCI Inter=
rupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15) *11=0A[    0.541386] ACPI: =
PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *11 12 14 15)=0A[    0.542192] =
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled=
.=0A[    0.543096] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 =
14 15) *0, disabled.=0A[    0.543997] ACPI: PCI Interrupt Link [LNKG] (IRQs=
 1 3 4 5 6 7 10 12 14 15) *0, disabled.=0A[    0.544901] ACPI: PCI Interrup=
t Link [LNKH] (IRQs 1 3 4 5 6 7 *11 12 14 15)=0A[    0.548535] ACPI: Power =
Resource [FN00] (off)=0A[    0.548778] intel_rng: FWH not detected=0A[    0=
.548952] SCSI subsystem initialized=0A[    0.549041] libata version 2.00 lo=
aded.=0A[    0.549101] PCI: Using ACPI for IRQ routing=0A[    0.549163] PCI=
: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a repo=
rt=0A[    0.549839] PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0=0A[ =
   0.549908] PCI: Bridge: 0000:00:1c.0=0A[    0.549969]   IO window: 5000-6=
fff=0A[    0.550032]   MEM window: 37100000-382fffff=0A[    0.550095]   PRE=
FETCH window: 30000000-30ffffff=0A[    0.550159] PCI: Bridge: 0000:00:1c.1=
=0A[    0.550220]   IO window: 4000-4fff=0A[    0.550282]   MEM window: 361=
00000-370fffff=0A[    0.550346]   PREFETCH window: 31000000-31ffffff=0A[   =
 0.550410] PCI: Bridge: 0000:00:1c.2=0A[    0.550471]   IO window: 3000-3ff=
f=0A[    0.550533]   MEM window: 35100000-360fffff=0A[    0.550603]   PREFE=
TCH window: 32000000-32ffffff=0A[    0.550667] PCI: Bridge: 0000:00:1c.3=0A=
[    0.550728]   IO window: 2000-2fff=0A[    0.550790]   MEM window: 341000=
00-350fffff=0A[    0.550854]   PREFETCH window: 33000000-33ffffff=0A[    0.=
550918] PCI: Bridge: 0000:00:1e.0=0A[    0.550980]   IO window: 1000-1fff=
=0A[    0.551043]   MEM window: 34000000-340fffff=0A[    0.551105]   PREFET=
CH window: disabled.=0A[    0.551189] ACPI: PCI Interrupt 0000:00:1c.0[A] -=
> GSI 17 (level, low) -> IRQ 16=0A[    0.551311] PCI: Setting latency timer=
 of device 0000:00:1c.0 to 64=0A[    0.551330] ACPI: PCI Interrupt 0000:00:=
1c.1[B] -> GSI 16 (level, low) -> IRQ 17=0A[    0.551451] PCI: Setting late=
ncy timer of device 0000:00:1c.1 to 64=0A[    0.551469] ACPI: PCI Interrupt=
 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18=0A[    0.551598] PCI: Set=
ting latency timer of device 0000:00:1c.2 to 64=0A[    0.551616] ACPI: PCI =
Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19=0A[    0.551738]=
 PCI: Setting latency timer of device 0000:00:1c.3 to 64=0A[    0.551749] P=
CI: Setting latency timer of device 0000:00:1e.0 to 64=0A[    0.551771] NET=
: Registered protocol family 2=0A[    0.563578] IP route cache hash table e=
ntries: 4096 (order: 2, 16384 bytes)=0A[    0.563711] TCP established hash =
table entries: 16384 (order: 5, 131072 bytes)=0A[    0.563857] TCP bind has=
h table entries: 8192 (order: 4, 65536 bytes)=0A[    0.563964] TCP: Hash ta=
bles configured (established 16384 bind 8192)=0A[    0.564030] TCP reno reg=
istered=0A[    0.564525] audit: initializing netlink socket (disabled)=0A[ =
   0.564602] audit(1167313619.013:1): initialized=0A[    0.564809] VFS: Dis=
k quotas dquot_6.5.1=0A[    0.564888] Dquot-cache hash table entries: 1024 =
(order 0, 4096 bytes)=0A[    0.564997] io scheduler noop registered=0A[    =
0.565098] io scheduler anticipatory registered (default)=0A[    0.565241] i=
o scheduler deadline registered=0A[    0.565351] io scheduler cfq registere=
d=0A[    0.565642] PCI: Setting latency timer of device 0000:00:1c.0 to 64=
=0A[    0.565688] assign_interrupt_mode Found MSI capability=0A[    0.56579=
5] Allocate Port Service[0000:00:1c.0:pcie00]=0A[    0.565826] Allocate Por=
t Service[0000:00:1c.0:pcie02]=0A[    0.565859] Allocate Port Service[0000:=
00:1c.0:pcie03]=0A[    0.565951] PCI: Setting latency timer of device 0000:=
00:1c.1 to 64=0A[    0.565997] assign_interrupt_mode Found MSI capability=
=0A[    0.566094] Allocate Port Service[0000:00:1c.1:pcie00]=0A[    0.56612=
6] Allocate Port Service[0000:00:1c.1:pcie02]=0A[    0.566154] Allocate Por=
t Service[0000:00:1c.1:pcie03]=0A[    0.566243] PCI: Setting latency timer =
of device 0000:00:1c.2 to 64=0A[    0.566289] assign_interrupt_mode Found M=
SI capability=0A[    0.566386] Allocate Port Service[0000:00:1c.2:pcie00]=
=0A[    0.566419] Allocate Port Service[0000:00:1c.2:pcie02]=0A[    0.56644=
7] Allocate Port Service[0000:00:1c.2:pcie03]=0A[    0.566549] PCI: Setting=
 latency timer of device 0000:00:1c.3 to 64=0A[    0.566598] assign_interru=
pt_mode Found MSI capability=0A[    0.566696] Allocate Port Service[0000:00=
:1c.3:pcie00]=0A[    0.566725] Allocate Port Service[0000:00:1c.3:pcie02]=
=0A[    0.566754] Allocate Port Service[0000:00:1c.3:pcie03]=0A[    0.56692=
6] ACPI: AC Adapter [ADP1] (on-line)=0A[    0.567129] ACPI: Battery Slot [B=
AT0] (battery present)=0A[    0.567253] ACPI: Battery Slot [BAT1] (battery =
absent)=0A[    0.567374] ACPI: Battery Slot [BAT2] (battery absent)=0A[    =
0.567461] ACPI: Power Button (FF) [PWRF]=0A[    0.567529] ACPI: Lid Switch =
[LID0]=0A[    0.567600] ACPI: Power Button (CM) [PWRB]=0A[    0.567742] ACP=
I: Transitioning device [FAN0] to D3=0A[    0.568586] ACPI: Transitioning d=
evice [FAN0] to D3=0A[    0.568649] ACPI: Fan [FAN0] (off)=0A[    0.569323]=
 ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)=0A[    0.56=
9490] Using specific hotkey driver=0A[    0.570129] ACPI (exconfig-0455): D=
ynamic SSDT Load - OemId [INTEL ] OemTableId [ Cpu0Ist] [20060707]=0A[    0=
.570525] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [INTEL ] OemTableI=
d [ Cpu0Cst] [20060707]=0A[    0.570971] ACPI: CPU0 (power states: C1[C1] C=
2[C2])=0A[    0.571157] ACPI: Processor [CPU0] (supports 8 throttling state=
s)=0A[    0.571824] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [INTEL =
] OemTableId [ Cpu1Ist] [20060707]=0A[    0.572203] ACPI (exconfig-0455): D=
ynamic SSDT Load - OemId [INTEL ] OemTableId [ Cpu1Cst] [20060707]=0A[    0=
.572698] ACPI: CPU1 (power states: C1[C1] C2[C2])=0A[    0.572882] ACPI: Pr=
ocessor [CPU1] (supports 8 throttling states)=0A[    0.576200] ACPI: Therma=
l Zone [TZ00] (42 C)=0A[    0.577015] ACPI: Thermal Zone [TZ01] (42 C)=0A[ =
   0.754000] Linux agpgart interface v0.101 (c) Dave Jones=0A[    0.754000]=
 agpgart: Detected an Intel 945GM Chipset.=0A[    0.757000] agpgart: Detect=
ed 7932K stolen memory.=0A[    0.773000] agpgart: AGP aperture is 256M @ 0x=
20000000=0A[    0.773000] [drm] Initialized drm 1.0.1 20051102=0A[    0.773=
000] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 17=
=0A[    0.773000] [drm] Initialized i915 1.5.0 20060119 on minor 0=0A[    0=
.773000] intelfb: intelfb_init=0A[    0.773000] intelfb: Framebuffer driver=
 for Intel(R) 830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM chipsets=0A[=
    0.773000] intelfb: Version 0.9.4=0A[    0.773000] intelfb: intelfb_setu=
p=0A[    0.773000] intelfb: options: mode=3D1024x768-32@70=0A[    0.773000]=
 intelfb: intelfb_pci_register=0A[    0.773000] intelfb: fb aperture: 0x200=
00000/0x10000000, MMIO region: 0x38380000/0x80000=0A[    0.773000] intelfb:=
 00:02.0: Intel(R) 945GM, aperture size 256MB, stolen memory 7932kB=0A[    =
0.778000] intelfb: fb: 0x20000000(+ 0x0)/0x7bf000 (0xdfa00000)=0A[    0.778=
000] intelfb: MMIO: 0x38380000/0x80000 (0xe3200000)=0A[    0.778000] intelf=
b: ring buffer: 0x23001000/0x10000 (0xe2a01000)=0A[    0.778000] intelfb: H=
W cursor: 0x0/0x0 (0x00000000) (offset 0x0) (phys 0x0)=0A[    0.778000] int=
elfb: options: vram =3D 4, accel =3D 1, hwcursor =3D 0, fixed =3D 0, noinit=
 =3D 0=0A[    0.778000] intelfb: options: mode =3D "1024x768-32@70"=0A[    =
0.778000] intelfb: Non-CRT device is enabled ( LVDS port ).  Disabling mode=
 switching.=0A[    0.778000] intelfb: Video mode must be programmed at boot=
 time.=0A[    0.779000] intelfb: cleanup=0A[    0.783000] Serial: 8250/1655=
0 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled=0A[    0.783000] se=
rial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A=0A[    0.784000] ACPI:=
 PCI Interrupt 0000:01:00.3[C] -> GSI 18 (level, low) -> IRQ 18=0A[    0.78=
4000] 0000:01:00.3: ttyS1 at I/O 0x5030 (irq =3D 18) is a 16550A=0A[    0.7=
85000] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksi=
ze=0A[    0.785000] Compaq SMART2 Driver (v 2.6.0)=0A[    0.785000] Uniform=
 Multi-Platform E-IDE driver Revision: 7.00alpha2=0A[    0.785000] ide: Ass=
uming 33MHz system bus speed for PIO modes; override with idebus=3Dxx=0A[  =
  0.787000] serio: i8042 KBD port at 0x60,0x64 irq 1=0A[    0.787000] serio=
: i8042 AUX port at 0x60,0x64 irq 12=0A[    0.787000] mice: PS/2 mouse devi=
ce common for all mice=0A[    0.788000] TCP cubic registered=0A[    0.78800=
0] NET: Registered protocol family 1=0A[    0.788000] Starting balanced_irq=
=0A[    0.789000] Using IPI Shortcut mode=0A[    0.789000] Freeing unused k=
ernel memory: 228k freed=0A[    0.790000] Time: tsc clocksource has been in=
stalled.=0A[    0.792000] Time: hpet clocksource has been installed.=0A[   =
 0.835000] input: AT Translated Set 2 keyboard as /class/input/input0=0A[  =
  1.247000] ata_piix 0000:00:1f.2: version 2.00ac6=0A[    1.247000] ata_pii=
x 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]=0A[    1.247000] ACPI: PCI Interrupt =
0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19=0A[    1.247000] PCI: Sett=
ing latency timer of device 0000:00:1f.2 to 64=0A[    1.247000] ata1: SATA =
max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x70A0 irq 14=0A[    1.247000] ata2:=
 PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x70A8 irq 15=0A[    1.248000]=
 scsi0 : ata_piix=0A[    1.401000] ata1.00: ATA-7, max UDMA/100, 156301488 =
sectors: LBA48 NCQ (depth 0/32)=0A[    1.401000] ata1.00: ata1: dev 0 multi=
 count 16=0A[    1.404000] ata1.00: configured for UDMA/100=0A[    1.404000=
] scsi1 : ata_piix=0A[    1.813000] ata2.01: ATAPI, max UDMA/33=0A[    1.96=
5000] ata2.01: configured for UDMA/33=0A[    1.965000] scsi 0:0:0:0: Direct=
-Access     ATA      FUJITSU MHT2080B 0000 PQ: 0 ANSI: 5=0A[    1.966000] s=
csi 1:0:1:0: CD-ROM            Slimtype COMBO SOSC-2483K KK0H PQ: 0 ANSI: 5=
=0A[    1.972000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 M=
B)=0A[    1.972000] sda: Write Protect is off=0A[    1.972000] sda: Mode Se=
nse: 00 3a 00 00=0A[    1.972000] SCSI device sda: drive cache: write back=
=0A[    1.972000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 M=
B)=0A[    1.972000] sda: Write Protect is off=0A[    1.972000] sda: Mode Se=
nse: 00 3a 00 00=0A[    1.972000] SCSI device sda: drive cache: write back=
=0A[    1.972000]  sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 >=0A[    2.083=
000] sd 0:0:0:0: Attached scsi disk sda=0A[    2.509000] usbcore: registere=
d new interface driver usbfs=0A[    2.509000] usbcore: registered new inter=
face driver hub=0A[    2.509000] usbcore: registered new device driver usb=
=0A[    2.510000] USB Universal Host Controller Interface driver v3.0=0A[  =
  2.510000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> I=
RQ 20=0A[    2.510000] PCI: Setting latency timer of device 0000:00:1d.0 to=
 64=0A[    2.510000] uhci_hcd 0000:00:1d.0: UHCI Host Controller=0A[    2.5=
10000] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1=
=0A[    2.510000] uhci_hcd 0000:00:1d.0: irq 20, io base 0x00007080=0A[    =
2.510000] usb usb1: configuration #1 chosen from 1 choice=0A[    2.511000] =
hub 1-0:1.0: USB hub found=0A[    2.511000] hub 1-0:1.0: 2 ports detected=
=0A[    2.612000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low=
) -> IRQ 19=0A[    2.612000] PCI: Setting latency timer of device 0000:00:1=
d.1 to 64=0A[    2.612000] uhci_hcd 0000:00:1d.1: UHCI Host Controller=0A[ =
   2.613000] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus nu=
mber 2=0A[    2.613000] uhci_hcd 0000:00:1d.1: irq 19, io base 0x00007060=
=0A[    2.613000] usb usb2: configuration #1 chosen from 1 choice=0A[    2.=
613000] hub 2-0:1.0: USB hub found=0A[    2.613000] hub 2-0:1.0: 2 ports de=
tected=0A[    2.715000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (leve=
l, low) -> IRQ 18=0A[    2.715000] PCI: Setting latency timer of device 000=
0:00:1d.2 to 64=0A[    2.715000] uhci_hcd 0000:00:1d.2: UHCI Host Controlle=
r=0A[    2.715000] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned =
bus number 3=0A[    2.715000] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000=
7040=0A[    2.715000] usb usb3: configuration #1 chosen from 1 choice=0A[  =
  2.716000] hub 3-0:1.0: USB hub found=0A[    2.716000] hub 3-0:1.0: 2 port=
s detected=0A[    2.817000] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (=
level, low) -> IRQ 17=0A[    2.817000] PCI: Setting latency timer of device=
 0000:00:1d.3 to 64=0A[    2.817000] uhci_hcd 0000:00:1d.3: UHCI Host Contr=
oller=0A[    2.818000] uhci_hcd 0000:00:1d.3: new USB bus registered, assig=
ned bus number 4=0A[    2.818000] uhci_hcd 0000:00:1d.3: irq 17, io base 0x=
00007020=0A[    2.818000] usb usb4: configuration #1 chosen from 1 choice=
=0A[    2.818000] hub 4-0:1.0: USB hub found=0A[    2.818000] hub 4-0:1.0: =
2 ports detected=0A[    2.920000] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GS=
I 23 (level, low) -> IRQ 20=0A[    2.920000] PCI: Setting latency timer of =
device 0000:00:1d.7 to 64=0A[    2.920000] ehci_hcd 0000:00:1d.7: EHCI Host=
 Controller=0A[    2.920000] ehci_hcd 0000:00:1d.7: new USB bus registered,=
 assigned bus number 5=0A[    2.920000] ehci_hcd 0000:00:1d.7: debug port 1=
=0A[    2.920000] PCI: cache line size of 32 is not supported by device 000=
0:00:1d.7=0A[    2.920000] ehci_hcd 0000:00:1d.7: irq 20, io mem 0x38440400=
=0A[    2.924000] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver=
 10 Dec 2004=0A[    2.924000] usb usb5: configuration #1 chosen from 1 choi=
ce=0A[    2.924000] hub 5-0:1.0: USB hub found=0A[    2.924000] hub 5-0:1.0=
: 8 ports detected=0A[    3.041000] ide0: I/O resource 0x1F0-0x1F7 not free=
.=0A[    3.041000] ide0: ports already in use, skipping probe=0A[    3.0410=
00] ide1: I/O resource 0x170-0x177 not free.=0A[    3.041000] ide1: ports a=
lready in use, skipping probe=0A[    3.109000] kjournald starting.  Commit =
interval 5 seconds=0A[    3.109000] EXT3-fs: mounted filesystem with ordere=
d data mode.=0A[   10.085000] sr0: scsi3-mmc drive: 0x/24x writer cd/rw xa/=
form2 cdda tray=0A[   10.085000] Uniform CD-ROM driver Revision: 3.20=0A[  =
 10.085000] sr 1:0:1:0: Attached scsi CD-ROM sr0=0A[   10.152000] lp: drive=
r loaded but no devices found=0A[   10.269000] Adding 1020088k swap on /dev=
/sda6.  Priority:-1 extents:1 across:1020088k=0A[   10.348000] EXT3 FS on s=
da5, internal journal=0A[   10.995000] input: PS/2 Generic Mouse as /class/=
input/input1=0A[   11.024000] Intel(R) PRO/1000 Network Driver - version 7.=
2.9-k4=0A[   11.024000] Copyright (c) 1999-2006 Intel Corporation.=0A[   11=
.025000] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ =
17=0A[   11.025000] PCI: Setting latency timer of device 0000:01:00.0 to 64=
=0A[   11.028000] input: PC Speaker as /class/input/input2=0A[   11.068000]=
 e1000: 0000:01:00.0: e1000_probe: (PCI Express:2.5Gb/s:32-bit) 00:0e:0c:72=
:bc:74=0A[   11.130000] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network=
 Connection=0A[   12.454000] NTFS driver 2.1.27 [Flags: R/O MODULE].=0A[   =
12.785000] NET: Registered protocol family 17=0A[   12.960000] NTFS volume =
version 3.1.=0A[   13.630000] e1000: eth0: e1000_watchdog: NIC Link is Up 1=
00 Mbps Full Duplex=0A[   13.630000] e1000: eth0: e1000_watchdog: 10/100 sp=
eed: disabling TSO=0A=0A=0AThanks=0A=0A----- Original Message ----=0AFrom: =
James Simmons <jsimmons@infradead.org>=0ATo: linux-fbdev-devel@lists.source=
forge.net=0ASent: Wednesday, December 27, 2006 10:46:41 PM=0ASubject: Re: [=
Linux-fbdev-devel] intelfb driver on 945GM chipset=0A=0A=0A> actually i tri=
ed video=3Dintelfb:mode=3D1024x768-16@75 instead and it didn't work for me.=
=0AThanks=0A=0ACan we see your dmesg ? Is it going to the default 640x480 m=
ode ?=0A=0A----------------------------------------------------------------=
---------=0ATake Surveys. Earn Cash. Influence the Future of IT=0AJoin Sour=
ceForge.net's Techsay panel and you'll get the chance to share your=0Aopini=
ons on IT & business topics through brief surveys - and earn cash=0Ahttp://=
www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDEVDEV=0A=
_______________________________________________=0ALinux-fbdev-devel mailing=
 list=0ALinux-fbdev-devel@lists.sourceforge.net=0Ahttps://lists.sourceforge=
.net/lists/listinfo/linux-fbdev-devel=0A=0A________________________________=
__________________=0ADo You Yahoo!?=0ATired of spam?  Yahoo! Mail has the b=
est spam protection around =0Ahttp://mail.yahoo.com 
--0-1017390124-1167313982=:51659
Content-Type: text/html; charset=ascii
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman=
, new york, times, serif">Hi;</DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-F=
AMILY: times new roman, new york, times, serif">here is my dmesg output.</D=
IV>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york=
, times, serif">as you can see below intelfb claims no video mode configure=
d at boot time inspit is does.</DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-=
FAMILY: times new roman, new york, times, serif">&nbsp;</DIV>=0A<DIV style=
=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york, times, serif">=
&nbsp;</DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman,=
 new york, times, serif">[&nbsp;&nbsp;&nbsp; 0.000000] Linux version 2.6.19=
-intelfb (<A href=3D"mailto:root@rjiossy-laptop">root@rjiossy-laptop</A>) (=
gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #1 SMP Thu Dec 28 15:30:48 IST 2=
006<BR>[&nbsp;&nbsp;&nbsp; 0.000000] BIOS-provided physical RAM map:<BR>[&n=
bsp;&nbsp;&nbsp; 0.000000]&nbsp; BIOS-e820: 0000000000000000 - 000000000009=
fc00 (usable)<BR>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; BIOS-e820: 00000000000=
9fc00 - 00000000000a0000 (reserved)<BR>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; =
BIOS-e820: 00000000000edb40 - 0000000000100000 (reserved)<BR>[&nbsp;&nbsp;&=
nbsp; 0.000000]&nbsp; BIOS-e820: 0000000000100000 - 000000001e871000 (usabl=
e)<BR>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; BIOS-e820: 000000001e871000 - 000=
000001ea72000 (ACPI NVS)<BR>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; BIOS-e820: =
000000001ea72000 - 000000001f6a7000 (ACPI data)<BR>[&nbsp;&nbsp;&nbsp; 0.00=
0000]&nbsp; BIOS-e820:
 000000001f6a7000 - 000000001f6af000 (reserved)<BR>[&nbsp;&nbsp;&nbsp; 0.00=
0000]&nbsp; BIOS-e820: 000000001f6af000 - 000000001f6ba000 (ACPI data)<BR>[=
&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; BIOS-e820: 000000001f6ba000 - 000000001f=
6bc000 (ACPI NVS)<BR>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; BIOS-e820: 0000000=
01f6bc000 - 000000001f6c7000 (ACPI data)<BR>[&nbsp;&nbsp;&nbsp; 0.000000]&n=
bsp; BIOS-e820: 000000001f6c7000 - 000000001f6ef000 (ACPI NVS)<BR>[&nbsp;&n=
bsp;&nbsp; 0.000000]&nbsp; BIOS-e820: 000000001f6ef000 - 000000001f700000 (=
ACPI data)<BR>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; BIOS-e820: 000000001f7000=
00 - 0000000020000000 (reserved)<BR>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; BIO=
S-e820: 00000000e0000000 - 00000000f0000000 (reserved)<BR>[&nbsp;&nbsp;&nbs=
p; 0.000000]&nbsp; BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved=
)<BR>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; BIOS-e820: 00000000fed14000 - 0000=
0000fed1a000 (reserved)<BR>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; BIOS-e820:
 00000000fed1c000 - 00000000fed20000 (reserved)<BR>[&nbsp;&nbsp;&nbsp; 0.00=
0000]&nbsp; BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)<BR>[&=
nbsp;&nbsp;&nbsp; 0.000000]&nbsp; BIOS-e820: 00000000fff00000 - 00000001000=
00000 (reserved)<BR>[&nbsp;&nbsp;&nbsp; 0.000000] 0MB HIGHMEM available.<BR=
>[&nbsp;&nbsp;&nbsp; 0.000000] 488MB LOWMEM available.<BR>[&nbsp;&nbsp;&nbs=
p; 0.000000] Entering add_active_range(0, 0, 125041) 0 entries of 256 used<=
BR>[&nbsp;&nbsp;&nbsp; 0.000000] Zone PFN ranges:<BR>[&nbsp;&nbsp;&nbsp; 0.=
000000]&nbsp;&nbsp; DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp;&nbsp;&nbsp; 4096<BR>[&nbsp;&nbsp;&=
nbsp; 0.000000]&nbsp;&nbsp; Normal&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4096=
 -&gt;&nbsp;&nbsp; 125041<BR>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; High=
Mem&nbsp;&nbsp;&nbsp; 125041 -&gt;&nbsp;&nbsp; 125041<BR>[&nbsp;&nbsp;&nbsp=
; 0.000000] early_node_map[1] active PFN ranges<BR>[&nbsp;&nbsp;&nbsp;
 0.000000]&nbsp;&nbsp;&nbsp;&nbsp; 0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0 -&gt;&nbsp;&nbsp; 125041<BR>[&nbsp;&nbsp;&nbsp; 0.000000] On node 0 =
totalpages: 125041<BR>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; DMA zone: 3=
2 pages used for memmap<BR>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; DMA zo=
ne: 0 pages reserved<BR>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; DMA zone:=
 4064 pages, LIFO batch:0<BR>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; Norm=
al zone: 944 pages used for memmap<BR>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&n=
bsp; Normal zone: 120001 pages, LIFO batch:31<BR>[&nbsp;&nbsp;&nbsp; 0.0000=
00]&nbsp;&nbsp; HighMem zone: 0 pages used for memmap<BR>[&nbsp;&nbsp;&nbsp=
; 0.000000] DMI 2.4 present.<BR>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: RSDP (v=
000 INTEL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ) @
 0x000fe020<BR>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: RSDT (v001 INTEL&nbsp; C=
apell00 0x00000056&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x01000013) @ 0x1f6fd038<B=
R>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: FADT (v001 INTEL&nbsp; Capell00 0x000=
00056 LOHR 0x0000005f) @ 0x1f6fc000<BR>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: =
HPET (v001 INTEL&nbsp; Capell00 0x00000001 LOHR 0x0000005f) @ 0x1f6fa000<BR=
>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: MADT (v001 INTEL&nbsp; Capell00 0x0000=
0001 LOHR 0x0000005f) @ 0x1f6f9000<BR>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: M=
CFG (v001 INTEL&nbsp; Capell00 0x00000001 LOHR 0x0000005f) @ 0x1f6f8000<BR>=
[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: ASF! (v032 INTEL&nbsp; Capell00 0x00000=
001 LOHR 0x0000005f) @ 0x1f6f7000<BR>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: SS=
DT (v001 INTEL&nbsp;&nbsp; SataPri 0x00001000 INTL 0x20060608) @ 0x1f6f0000=
<BR>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: SSDT (v001 INTEL&nbsp;&nbsp; SataSe=
c 0x00001000 INTL 0x20060608) @ 0x1f6ef000<BR>[&nbsp;&nbsp;&nbsp; 0.000000]=
 ACPI: SSDT
 (v001 INTEL&nbsp;&nbsp;&nbsp;&nbsp; CpuPm 0x00003000 INTL 0x20060608) @ 0x=
1f6f5000<BR>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: DSDT (v001 INTEL&nbsp; CALI=
STGA 0x00000001 INTL 0x20060608) @ 0x00000000<BR>[&nbsp;&nbsp;&nbsp; 0.0000=
00] ACPI: PM-Timer IO Port: 0x408<BR>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: Lo=
cal APIC address 0xfee00000<BR>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: LAPIC (a=
cpi_id[0x00] lapic_id[0x00] enabled)<BR>[&nbsp;&nbsp;&nbsp; 0.000000] Proce=
ssor #0 6:15 APIC version 20<BR>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: LAPIC (=
acpi_id[0x01] lapic_id[0x01] enabled)<BR>[&nbsp;&nbsp;&nbsp; 0.000000] Proc=
essor #1 6:15 APIC version 20<BR>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: LAPIC_=
NMI (acpi_id[0x00] high edge lint[0x1])<BR>[&nbsp;&nbsp;&nbsp; 0.000000] AC=
PI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])<BR>[&nbsp;&nbsp;&nbsp; 0.=
000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])<BR>[&nbsp;&=
nbsp;&nbsp; 0.000000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000,=
 GSI
 0-23<BR>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 g=
lobal_irq 2 dfl dfl)<BR>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: INT_SRC_OVR (bu=
s 0 bus_irq 9 global_irq 9 high level)<BR>[&nbsp;&nbsp;&nbsp; 0.000000] ACP=
I: IRQ0 used by override.<BR>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: IRQ2 used =
by override.<BR>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: IRQ9 used by override.<=
BR>[&nbsp;&nbsp;&nbsp; 0.000000] Enabling APIC mode:&nbsp; Flat.&nbsp; Usin=
g 1 I/O APICs<BR>[&nbsp;&nbsp;&nbsp; 0.000000] ACPI: HPET id: 0x8086a201 ba=
se: 0xfed00000<BR>[&nbsp;&nbsp;&nbsp; 0.000000] Using ACPI (MADT) for SMP c=
onfiguration information<BR>[&nbsp;&nbsp;&nbsp; 0.000000] Allocating PCI re=
sources starting at 30000000 (gap: 20000000:c0000000)<BR>[&nbsp;&nbsp;&nbsp=
; 0.000000] Detected 1666.763 MHz processor.<BR>[&nbsp;&nbsp; 40.043790] Bu=
ilt 1 zonelists.&nbsp; Total pages: 124065<BR>[&nbsp;&nbsp; 40.043792] Kern=
el command line: root=3D/dev/sda5 ro single video=3Dintelfb:mode=3D1024x768=
-32@70
 <BR>[&nbsp;&nbsp; 40.043967] mapped APIC to ffffd000 (fee00000)<BR>[&nbsp;=
&nbsp; 40.043969] mapped IOAPIC to ffffc000 (fec00000)<BR>[&nbsp;&nbsp; 40.=
043972] Enabling fast FPU save and restore... done.<BR>[&nbsp;&nbsp; 40.043=
974] Enabling unmasked SIMD FPU exception support... done.<BR>[&nbsp;&nbsp;=
 40.043977] Initializing CPU#0<BR>[&nbsp;&nbsp; 40.044059] PID hash table e=
ntries: 2048 (order: 11, 8192 bytes)<BR>[&nbsp;&nbsp; 40.045481] Console: c=
olour VGA+ 80x25<BR>[&nbsp;&nbsp; 40.048746] Dentry cache hash table entrie=
s: 65536 (order: 6, 262144 bytes)<BR>[&nbsp;&nbsp; 40.048956] Inode-cache h=
ash table entries: 32768 (order: 5, 131072 bytes)<BR>[&nbsp;&nbsp; 40.05415=
4] Memory: 486992k/500164k available (2091k kernel code, 12644k reserved, 1=
019k data, 228k init, 0k highmem)<BR>[&nbsp;&nbsp; 40.054246] virtual kerne=
l memory layout:<BR>[&nbsp;&nbsp; 40.054247]&nbsp;&nbsp;&nbsp;&nbsp; fixmap=
&nbsp; : 0xfff4f000 - 0xfffff000&nbsp;&nbsp; ( 704 kB)<BR>[&nbsp;&nbsp;
 40.054248]&nbsp;&nbsp;&nbsp;&nbsp; pkmap&nbsp;&nbsp; : 0xff800000 - 0xffc0=
0000&nbsp;&nbsp; (4096 kB)<BR>[&nbsp;&nbsp; 40.054250]&nbsp;&nbsp;&nbsp;&nb=
sp; vmalloc : 0xdf800000 - 0xff7fe000&nbsp;&nbsp; ( 511 MB)<BR>[&nbsp;&nbsp=
; 40.054251]&nbsp;&nbsp;&nbsp;&nbsp; lowmem&nbsp; : 0xc0000000 - 0xde871000=
&nbsp;&nbsp; ( 488 MB)<BR>[&nbsp;&nbsp; 40.054252]&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; .init : 0xc040f000 - 0xc0448000&nbsp;&nbsp; ( 228 kB)<BR>[&nbsp=
;&nbsp; 40.054253]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .data : 0xc030af21 -=
 0xc0409b70&nbsp;&nbsp; (1019 kB)<BR>[&nbsp;&nbsp; 40.054255]&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; .text : 0xc0100000 - 0xc030af21&nbsp;&nbsp; (2091 kB=
)<BR>[&nbsp;&nbsp; 40.054746] Checking if this processor honours the WP bit=
 even in supervisor mode... Ok.<BR>[&nbsp;&nbsp; 40.055017] hpet0: at MMIO =
0xfed00000, IRQs 2, 8, 0<BR>[&nbsp;&nbsp; 40.055241] hpet0: 3 64-bit timers=
, 14318180 Hz<BR>[&nbsp;&nbsp; 40.056307] Using HPET for base-timer<BR>[&nb=
sp;&nbsp;
 40.115979] Calibrating delay using timer specific routine.. 3336.33 BogoMI=
PS (lpj=3D1668166)<BR>[&nbsp;&nbsp; 40.116132] Security Framework v1.0.0 in=
itialized<BR>[&nbsp;&nbsp; 40.116213] Mount-cache hash table entries: 512<B=
R>[&nbsp;&nbsp; 40.116376] CPU: After generic identify, caps: bfebfbff 2010=
0000 00000000 00000000 0000e3bd 00000000 00000001<BR>[&nbsp;&nbsp; 40.11638=
4] monitor/mwait feature present.<BR>[&nbsp;&nbsp; 40.116445] using mwait i=
n idle threads.<BR>[&nbsp;&nbsp; 40.116507] CPU: L1 I cache: 32K, L1 D cach=
e: 32K<BR>[&nbsp;&nbsp; 40.116609] CPU: L2 cache: 4096K<BR>[&nbsp;&nbsp; 40=
.116669] CPU: Physical Processor ID: 0<BR>[&nbsp;&nbsp; 40.116729] CPU: Pro=
cessor Core ID: 0<BR>[&nbsp;&nbsp; 40.116788] CPU: After all inits, caps: b=
febfbff 20100000 00000000 00000940 0000e3bd 00000000 00000001<BR>[&nbsp;&nb=
sp; 40.116807] Checking 'hlt' instruction... OK.<BR>[&nbsp;&nbsp; 40.120123=
] Freeing SMP alternatives: 12k freed<BR>[&nbsp;&nbsp; 40.120185] ACPI: Cor=
e revision
 20060707<BR>[&nbsp;&nbsp; 40.123798] CPU0: Intel(R) Pentium(R) M CPU&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 000&nbsp; @ 1.66GHz stepping 01<BR>[&n=
bsp;&nbsp; 40.123961] Booting processor 1/1 eip 2000<BR>[&nbsp;&nbsp; 40.13=
5423] Initializing CPU#1<BR>[&nbsp;&nbsp; 40.194924] Calibrating delay usin=
g timer specific routine.. 3333.35 BogoMIPS (lpj=3D1666676)<BR>[&nbsp;&nbsp=
; 40.194931] CPU: After generic identify, caps: bfebfbff 20100000 00000000 =
00000000 0000e3bd 00000000 00000001<BR>[&nbsp;&nbsp; 40.194936] monitor/mwa=
it feature present.<BR>[&nbsp;&nbsp; 40.194941] CPU: L1 I cache: 32K, L1 D =
cache: 32K<BR>[&nbsp;&nbsp; 40.194943] CPU: L2 cache: 4096K<BR>[&nbsp;&nbsp=
; 40.194945] CPU: Physical Processor ID: 0<BR>[&nbsp;&nbsp; 40.194947] CPU:=
 Processor Core ID: 1<BR>[&nbsp;&nbsp; 40.194948] CPU: After all inits, cap=
s: bfebfbff 20100000 00000000 00000940 0000e3bd 00000000 00000001<BR>[&nbsp=
;&nbsp; 40.195616] CPU1: Intel(R) Pentium(R) M
 CPU&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 000&nbsp; @ 1.66GHz stepping=
 01<BR>[&nbsp;&nbsp; 40.196218] Total of 2 processors activated (6669.68 Bo=
goMIPS).<BR>[&nbsp;&nbsp; 40.196473] ENABLING IO-APIC IRQs<BR>[&nbsp;&nbsp;=
 40.196728] ..TIMER: vector=3D0x31 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1<=
BR>[&nbsp;&nbsp; 40.307851] checking TSC synchronization across 2 CPUs: pas=
sed.<BR>[&nbsp;&nbsp;&nbsp; 0.000950] Brought up 2 CPUs<BR>[&nbsp;&nbsp;&nb=
sp; 0.073014] migration_cost=3D48<BR>[&nbsp;&nbsp;&nbsp; 0.073275] checking=
 if image is initramfs... it is<BR>[&nbsp;&nbsp;&nbsp; 0.515014] Freeing in=
itrd memory: 4602k freed<BR>[&nbsp;&nbsp;&nbsp; 0.515400] NET: Registered p=
rotocol family 16<BR>[&nbsp;&nbsp;&nbsp; 0.515539] ACPI: bus type pci regis=
tered<BR>[&nbsp;&nbsp;&nbsp; 0.515621] PCI: Using MMCONFIG<BR>[&nbsp;&nbsp;=
&nbsp; 0.516411] Setting up standard PCI resources<BR>[&nbsp;&nbsp;&nbsp; 0=
.520353] ACPI: Interpreter enabled<BR>[&nbsp;&nbsp;&nbsp; 0.520414] ACPI: U=
sing IOAPIC for interrupt
 routing<BR>[&nbsp;&nbsp;&nbsp; 0.521478] ACPI: PCI Root Bridge [PCI0] (000=
0:00)<BR>[&nbsp;&nbsp;&nbsp; 0.521544] PCI: Probing PCI hardware (bus 00)<B=
R>[&nbsp;&nbsp;&nbsp; 0.521782] ACPI: Assume root bridge [\_SB_.PCI0] bus i=
s 0<BR>[&nbsp;&nbsp;&nbsp; 0.523577] Boot video device is 0000:00:02.0<BR>[=
&nbsp;&nbsp;&nbsp; 0.524065] PCI quirk: region 0400-047f claimed by ICH6 AC=
PI/GPIO/TCO<BR>[&nbsp;&nbsp;&nbsp; 0.524133] PCI quirk: region 0500-053f cl=
aimed by ICH6 GPIO<BR>[&nbsp;&nbsp;&nbsp; 0.524246] PCI: Ignoring BAR0-3 of=
 IDE controller 0000:00:1f.2<BR>[&nbsp;&nbsp;&nbsp; 0.525344] PCI: Transpar=
ent bridge - 0000:00:1e.0<BR>[&nbsp;&nbsp;&nbsp; 0.525475] ACPI: PCI Interr=
upt Routing Table [\_SB_.PCI0._PRT]<BR>[&nbsp;&nbsp;&nbsp; 0.535098] ACPI: =
PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]<BR>[&nbsp;&nbsp;&nbsp; 0=
.535367] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]<BR>[&nbsp=
;&nbsp;&nbsp; 0.535632] ACPI: PCI Interrupt Routing Table
 [\_SB_.PCI0.RP03._PRT]<BR>[&nbsp;&nbsp;&nbsp; 0.535892] ACPI: PCI Interrup=
t Routing Table [\_SB_.PCI0.RP04._PRT]<BR>[&nbsp;&nbsp;&nbsp; 0.537652] ACP=
I: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]<BR>[&nbsp;&nbsp;&nbsp=
; 0.538810] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 14 15) =
*11<BR>[&nbsp;&nbsp;&nbsp; 0.539669] ACPI: PCI Interrupt Link [LNKB] (IRQs =
1 3 4 5 6 7 11 12 14 15) *10<BR>[&nbsp;&nbsp;&nbsp; 0.540524] ACPI: PCI Int=
errupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15) *11<BR>[&nbsp;&nbsp;&nbsp=
; 0.541386] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *11 12 14 15)=
<BR>[&nbsp;&nbsp;&nbsp; 0.542192] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3=
 4 5 6 7 10 12 14 15) *0, disabled.<BR>[&nbsp;&nbsp;&nbsp; 0.543096] ACPI: =
PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.<BR>[=
&nbsp;&nbsp;&nbsp; 0.543997] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 =
6 7 10 12 14 15) *0, disabled.<BR>[&nbsp;&nbsp;&nbsp; 0.544901] ACPI: PCI I=
nterrupt Link
 [LNKH] (IRQs 1 3 4 5 6 7 *11 12 14 15)<BR>[&nbsp;&nbsp;&nbsp; 0.548535] AC=
PI: Power Resource [FN00] (off)<BR>[&nbsp;&nbsp;&nbsp; 0.548778] intel_rng:=
 FWH not detected<BR>[&nbsp;&nbsp;&nbsp; 0.548952] SCSI subsystem initializ=
ed<BR>[&nbsp;&nbsp;&nbsp; 0.549041] libata version 2.00 loaded.<BR>[&nbsp;&=
nbsp;&nbsp; 0.549101] PCI: Using ACPI for IRQ routing<BR>[&nbsp;&nbsp;&nbsp=
; 0.549163] PCI: If a device doesn't work, try "pci=3Drouteirq".&nbsp; If i=
t helps, post a report<BR>[&nbsp;&nbsp;&nbsp; 0.549839] PCI: Ignore bogus r=
esource 6 [0:0] of 0000:00:02.0<BR>[&nbsp;&nbsp;&nbsp; 0.549908] PCI: Bridg=
e: 0000:00:1c.0<BR>[&nbsp;&nbsp;&nbsp; 0.549969]&nbsp;&nbsp; IO window: 500=
0-6fff<BR>[&nbsp;&nbsp;&nbsp; 0.550032]&nbsp;&nbsp; MEM window: 37100000-38=
2fffff<BR>[&nbsp;&nbsp;&nbsp; 0.550095]&nbsp;&nbsp; PREFETCH window: 300000=
00-30ffffff<BR>[&nbsp;&nbsp;&nbsp; 0.550159] PCI: Bridge: 0000:00:1c.1<BR>[=
&nbsp;&nbsp;&nbsp; 0.550220]&nbsp;&nbsp; IO window: 4000-4fff<BR>[&nbsp;&nb=
sp;&nbsp;
 0.550282]&nbsp;&nbsp; MEM window: 36100000-370fffff<BR>[&nbsp;&nbsp;&nbsp;=
 0.550346]&nbsp;&nbsp; PREFETCH window: 31000000-31ffffff<BR>[&nbsp;&nbsp;&=
nbsp; 0.550410] PCI: Bridge: 0000:00:1c.2<BR>[&nbsp;&nbsp;&nbsp; 0.550471]&=
nbsp;&nbsp; IO window: 3000-3fff<BR>[&nbsp;&nbsp;&nbsp; 0.550533]&nbsp;&nbs=
p; MEM window: 35100000-360fffff<BR>[&nbsp;&nbsp;&nbsp; 0.550603]&nbsp;&nbs=
p; PREFETCH window: 32000000-32ffffff<BR>[&nbsp;&nbsp;&nbsp; 0.550667] PCI:=
 Bridge: 0000:00:1c.3<BR>[&nbsp;&nbsp;&nbsp; 0.550728]&nbsp;&nbsp; IO windo=
w: 2000-2fff<BR>[&nbsp;&nbsp;&nbsp; 0.550790]&nbsp;&nbsp; MEM window: 34100=
000-350fffff<BR>[&nbsp;&nbsp;&nbsp; 0.550854]&nbsp;&nbsp; PREFETCH window: =
33000000-33ffffff<BR>[&nbsp;&nbsp;&nbsp; 0.550918] PCI: Bridge: 0000:00:1e.=
0<BR>[&nbsp;&nbsp;&nbsp; 0.550980]&nbsp;&nbsp; IO window: 1000-1fff<BR>[&nb=
sp;&nbsp;&nbsp; 0.551043]&nbsp;&nbsp; MEM window: 34000000-340fffff<BR>[&nb=
sp;&nbsp;&nbsp; 0.551105]&nbsp;&nbsp; PREFETCH window: disabled.<BR>[&nbsp;=
&nbsp;&nbsp;
 0.551189] ACPI: PCI Interrupt 0000:00:1c.0[A] -&gt; GSI 17 (level, low) -&=
gt; IRQ 16<BR>[&nbsp;&nbsp;&nbsp; 0.551311] PCI: Setting latency timer of d=
evice 0000:00:1c.0 to 64<BR>[&nbsp;&nbsp;&nbsp; 0.551330] ACPI: PCI Interru=
pt 0000:00:1c.1[B] -&gt; GSI 16 (level, low) -&gt; IRQ 17<BR>[&nbsp;&nbsp;&=
nbsp; 0.551451] PCI: Setting latency timer of device 0000:00:1c.1 to 64<BR>=
[&nbsp;&nbsp;&nbsp; 0.551469] ACPI: PCI Interrupt 0000:00:1c.2[C] -&gt; GSI=
 18 (level, low) -&gt; IRQ 18<BR>[&nbsp;&nbsp;&nbsp; 0.551598] PCI: Setting=
 latency timer of device 0000:00:1c.2 to 64<BR>[&nbsp;&nbsp;&nbsp; 0.551616=
] ACPI: PCI Interrupt 0000:00:1c.3[D] -&gt; GSI 19 (level, low) -&gt; IRQ 1=
9<BR>[&nbsp;&nbsp;&nbsp; 0.551738] PCI: Setting latency timer of device 000=
0:00:1c.3 to 64<BR>[&nbsp;&nbsp;&nbsp; 0.551749] PCI: Setting latency timer=
 of device 0000:00:1e.0 to 64<BR>[&nbsp;&nbsp;&nbsp; 0.551771] NET: Registe=
red protocol family 2<BR>[&nbsp;&nbsp;&nbsp; 0.563578] IP route cache hash =
table
 entries: 4096 (order: 2, 16384 bytes)<BR>[&nbsp;&nbsp;&nbsp; 0.563711] TCP=
 established hash table entries: 16384 (order: 5, 131072 bytes)<BR>[&nbsp;&=
nbsp;&nbsp; 0.563857] TCP bind hash table entries: 8192 (order: 4, 65536 by=
tes)<BR>[&nbsp;&nbsp;&nbsp; 0.563964] TCP: Hash tables configured (establis=
hed 16384 bind 8192)<BR>[&nbsp;&nbsp;&nbsp; 0.564030] TCP reno registered<B=
R>[&nbsp;&nbsp;&nbsp; 0.564525] audit: initializing netlink socket (disable=
d)<BR>[&nbsp;&nbsp;&nbsp; 0.564602] audit(1167313619.013:1): initialized<BR=
>[&nbsp;&nbsp;&nbsp; 0.564809] VFS: Disk quotas dquot_6.5.1<BR>[&nbsp;&nbsp=
;&nbsp; 0.564888] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes=
)<BR>[&nbsp;&nbsp;&nbsp; 0.564997] io scheduler noop registered<BR>[&nbsp;&=
nbsp;&nbsp; 0.565098] io scheduler anticipatory registered (default)<BR>[&n=
bsp;&nbsp;&nbsp; 0.565241] io scheduler deadline registered<BR>[&nbsp;&nbsp=
;&nbsp; 0.565351] io scheduler cfq registered<BR>[&nbsp;&nbsp;&nbsp; 0.5656=
42] PCI:
 Setting latency timer of device 0000:00:1c.0 to 64<BR>[&nbsp;&nbsp;&nbsp; =
0.565688] assign_interrupt_mode Found MSI capability<BR>[&nbsp;&nbsp;&nbsp;=
 0.565795] Allocate Port Service[0000:00:1c.0:pcie00]<BR>[&nbsp;&nbsp;&nbsp=
; 0.565826] Allocate Port Service[0000:00:1c.0:pcie02]<BR>[&nbsp;&nbsp;&nbs=
p; 0.565859] Allocate Port Service[0000:00:1c.0:pcie03]<BR>[&nbsp;&nbsp;&nb=
sp; 0.565951] PCI: Setting latency timer of device 0000:00:1c.1 to 64<BR>[&=
nbsp;&nbsp;&nbsp; 0.565997] assign_interrupt_mode Found MSI capability<BR>[=
&nbsp;&nbsp;&nbsp; 0.566094] Allocate Port Service[0000:00:1c.1:pcie00]<BR>=
[&nbsp;&nbsp;&nbsp; 0.566126] Allocate Port Service[0000:00:1c.1:pcie02]<BR=
>[&nbsp;&nbsp;&nbsp; 0.566154] Allocate Port Service[0000:00:1c.1:pcie03]<B=
R>[&nbsp;&nbsp;&nbsp; 0.566243] PCI: Setting latency timer of device 0000:0=
0:1c.2 to 64<BR>[&nbsp;&nbsp;&nbsp; 0.566289] assign_interrupt_mode Found M=
SI capability<BR>[&nbsp;&nbsp;&nbsp; 0.566386] Allocate Port
 Service[0000:00:1c.2:pcie00]<BR>[&nbsp;&nbsp;&nbsp; 0.566419] Allocate Por=
t Service[0000:00:1c.2:pcie02]<BR>[&nbsp;&nbsp;&nbsp; 0.566447] Allocate Po=
rt Service[0000:00:1c.2:pcie03]<BR>[&nbsp;&nbsp;&nbsp; 0.566549] PCI: Setti=
ng latency timer of device 0000:00:1c.3 to 64<BR>[&nbsp;&nbsp;&nbsp; 0.5665=
98] assign_interrupt_mode Found MSI capability<BR>[&nbsp;&nbsp;&nbsp; 0.566=
696] Allocate Port Service[0000:00:1c.3:pcie00]<BR>[&nbsp;&nbsp;&nbsp; 0.56=
6725] Allocate Port Service[0000:00:1c.3:pcie02]<BR>[&nbsp;&nbsp;&nbsp; 0.5=
66754] Allocate Port Service[0000:00:1c.3:pcie03]<BR>[&nbsp;&nbsp;&nbsp; 0.=
566926] ACPI: AC Adapter [ADP1] (on-line)<BR>[&nbsp;&nbsp;&nbsp; 0.567129] =
ACPI: Battery Slot [BAT0] (battery present)<BR>[&nbsp;&nbsp;&nbsp; 0.567253=
] ACPI: Battery Slot [BAT1] (battery absent)<BR>[&nbsp;&nbsp;&nbsp; 0.56737=
4] ACPI: Battery Slot [BAT2] (battery absent)<BR>[&nbsp;&nbsp;&nbsp; 0.5674=
61] ACPI: Power Button (FF) [PWRF]<BR>[&nbsp;&nbsp;&nbsp; 0.567529] ACPI: L=
id Switch
 [LID0]<BR>[&nbsp;&nbsp;&nbsp; 0.567600] ACPI: Power Button (CM) [PWRB]<BR>=
[&nbsp;&nbsp;&nbsp; 0.567742] ACPI: Transitioning device [FAN0] to D3<BR>[&=
nbsp;&nbsp;&nbsp; 0.568586] ACPI: Transitioning device [FAN0] to D3<BR>[&nb=
sp;&nbsp;&nbsp; 0.568649] ACPI: Fan [FAN0] (off)<BR>[&nbsp;&nbsp;&nbsp; 0.5=
69323] ACPI: Video Device [GFX0] (multi-head: yes&nbsp; rom: no&nbsp; post:=
 no)<BR>[&nbsp;&nbsp;&nbsp; 0.569490] Using specific hotkey driver<BR>[&nbs=
p;&nbsp;&nbsp; 0.570129] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [I=
NTEL ] OemTableId [ Cpu0Ist] [20060707]<BR>[&nbsp;&nbsp;&nbsp; 0.570525] AC=
PI (exconfig-0455): Dynamic SSDT Load - OemId [INTEL ] OemTableId [ Cpu0Cst=
] [20060707]<BR>[&nbsp;&nbsp;&nbsp; 0.570971] ACPI: CPU0 (power states: C1[=
C1] C2[C2])<BR>[&nbsp;&nbsp;&nbsp; 0.571157] ACPI: Processor [CPU0] (suppor=
ts 8 throttling states)<BR>[&nbsp;&nbsp;&nbsp; 0.571824] ACPI (exconfig-045=
5): Dynamic SSDT Load - OemId [INTEL ] OemTableId [ Cpu1Ist]
 [20060707]<BR>[&nbsp;&nbsp;&nbsp; 0.572203] ACPI (exconfig-0455): Dynamic =
SSDT Load - OemId [INTEL ] OemTableId [ Cpu1Cst] [20060707]<BR>[&nbsp;&nbsp=
;&nbsp; 0.572698] ACPI: CPU1 (power states: C1[C1] C2[C2])<BR>[&nbsp;&nbsp;=
&nbsp; 0.572882] ACPI: Processor [CPU1] (supports 8 throttling states)<BR>[=
&nbsp;&nbsp;&nbsp; 0.576200] ACPI: Thermal Zone [TZ00] (42 C)<BR>[&nbsp;&nb=
sp;&nbsp; 0.577015] ACPI: Thermal Zone [TZ01] (42 C)<BR>[&nbsp;&nbsp;&nbsp;=
 0.754000] Linux agpgart interface v0.101 (c) Dave Jones<BR>[&nbsp;&nbsp;&n=
bsp; 0.754000] agpgart: Detected an Intel 945GM Chipset.<BR>[&nbsp;&nbsp;&n=
bsp; 0.757000] agpgart: Detected 7932K stolen memory.<BR>[&nbsp;&nbsp;&nbsp=
; 0.773000] agpgart: AGP aperture is 256M @ 0x20000000<BR>[&nbsp;&nbsp;&nbs=
p; 0.773000] [drm] Initialized drm 1.0.1 20051102<BR>[&nbsp;&nbsp;&nbsp; 0.=
773000] ACPI: PCI Interrupt 0000:00:02.0[A] -&gt; GSI 16 (level, low) -&gt;=
 IRQ 17<BR>[&nbsp;&nbsp;&nbsp; 0.773000] [drm] Initialized i915 1.5.0 20060=
119 on minor
 0<BR>[&nbsp;&nbsp;&nbsp; 0.773000] intelfb: intelfb_init<BR>[&nbsp;&nbsp;&=
nbsp; 0.773000] intelfb: Framebuffer driver for Intel(R) 830M/845G/852GM/85=
5GM/865G/915G/915GM/945G/945GM chipsets<BR>[&nbsp;&nbsp;&nbsp; 0.773000] in=
telfb: Version 0.9.4<BR>[&nbsp;&nbsp;&nbsp; 0.773000] intelfb: intelfb_setu=
p<BR>[&nbsp;&nbsp;&nbsp; 0.773000] intelfb: options: <A href=3D"mailto:mode=
=3D1024x768-32@70">mode=3D1024x768-32@70</A><BR>[&nbsp;&nbsp;&nbsp; 0.77300=
0] intelfb: intelfb_pci_register<BR>[&nbsp;&nbsp;&nbsp; 0.773000] intelfb: =
fb aperture: 0x20000000/0x10000000, MMIO region: 0x38380000/0x80000<BR>[&nb=
sp;&nbsp;&nbsp; 0.773000] intelfb: 00:02.0: Intel(R) 945GM, aperture size 2=
56MB, stolen memory 7932kB<BR>[&nbsp;&nbsp;&nbsp; 0.778000] intelfb: fb: 0x=
20000000(+ 0x0)/0x7bf000 (0xdfa00000)<BR>[&nbsp;&nbsp;&nbsp; 0.778000] inte=
lfb: MMIO: 0x38380000/0x80000 (0xe3200000)<BR>[&nbsp;&nbsp;&nbsp; 0.778000]=
 intelfb: ring buffer: 0x23001000/0x10000 (0xe2a01000)<BR>[&nbsp;&nbsp;&nbs=
p; 0.778000]
 intelfb: HW cursor: 0x0/0x0 (0x00000000) (offset 0x0) (phys 0x0)<BR>[&nbsp=
;&nbsp;&nbsp; 0.778000] intelfb: options: vram =3D 4, accel =3D 1, hwcursor=
 =3D 0, fixed =3D 0, noinit =3D 0<BR>[&nbsp;&nbsp;&nbsp; 0.778000] intelfb:=
 options: mode =3D "<A href=3D"mailto:1024x768-32@70">1024x768-32@70</A>"<B=
R>[&nbsp;&nbsp;&nbsp; 0.778000] intelfb: Non-CRT device is enabled ( LVDS p=
ort ).&nbsp; Disabling mode switching.<BR>[&nbsp;&nbsp;&nbsp; 0.778000] int=
elfb: Video mode must be programmed at boot time.<BR>[&nbsp;&nbsp;&nbsp; 0.=
779000] intelfb: cleanup<BR>[&nbsp;&nbsp;&nbsp; 0.783000] Serial: 8250/1655=
0 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled<BR>[&nbsp;&nbsp;&nb=
sp; 0.783000] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A<BR>[&n=
bsp;&nbsp;&nbsp; 0.784000] ACPI: PCI Interrupt 0000:01:00.3[C] -&gt; GSI 18=
 (level, low) -&gt; IRQ 18<BR>[&nbsp;&nbsp;&nbsp; 0.784000] 0000:01:00.3: t=
tyS1 at I/O 0x5030 (irq =3D 18) is a 16550A<BR>[&nbsp;&nbsp;&nbsp; 0.785000=
] RAMDISK driver initialized:
 16 RAM disks of 65536K size 1024 blocksize<BR>[&nbsp;&nbsp;&nbsp; 0.785000=
] Compaq SMART2 Driver (v 2.6.0)<BR>[&nbsp;&nbsp;&nbsp; 0.785000] Uniform M=
ulti-Platform E-IDE driver Revision: 7.00alpha2<BR>[&nbsp;&nbsp;&nbsp; 0.78=
5000] ide: Assuming 33MHz system bus speed for PIO modes; override with ide=
bus=3Dxx<BR>[&nbsp;&nbsp;&nbsp; 0.787000] serio: i8042 KBD port at 0x60,0x6=
4 irq 1<BR>[&nbsp;&nbsp;&nbsp; 0.787000] serio: i8042 AUX port at 0x60,0x64=
 irq 12<BR>[&nbsp;&nbsp;&nbsp; 0.787000] mice: PS/2 mouse device common for=
 all mice<BR>[&nbsp;&nbsp;&nbsp; 0.788000] TCP cubic registered<BR>[&nbsp;&=
nbsp;&nbsp; 0.788000] NET: Registered protocol family 1<BR>[&nbsp;&nbsp;&nb=
sp; 0.788000] Starting balanced_irq<BR>[&nbsp;&nbsp;&nbsp; 0.789000] Using =
IPI Shortcut mode<BR>[&nbsp;&nbsp;&nbsp; 0.789000] Freeing unused kernel me=
mory: 228k freed<BR>[&nbsp;&nbsp;&nbsp; 0.790000] Time: tsc clocksource has=
 been installed.<BR>[&nbsp;&nbsp;&nbsp; 0.792000] Time: hpet clocksource ha=
s been
 installed.<BR>[&nbsp;&nbsp;&nbsp; 0.835000] input: AT Translated Set 2 key=
board as /class/input/input0<BR>[&nbsp;&nbsp;&nbsp; 1.247000] ata_piix 0000=
:00:1f.2: version 2.00ac6<BR>[&nbsp;&nbsp;&nbsp; 1.247000] ata_piix 0000:00=
:1f.2: MAP [ P0 P2 IDE IDE ]<BR>[&nbsp;&nbsp;&nbsp; 1.247000] ACPI: PCI Int=
errupt 0000:00:1f.2[B] -&gt; GSI 19 (level, low) -&gt; IRQ 19<BR>[&nbsp;&nb=
sp;&nbsp; 1.247000] PCI: Setting latency timer of device 0000:00:1f.2 to 64=
<BR>[&nbsp;&nbsp;&nbsp; 1.247000] ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3=
F6 bmdma 0x70A0 irq 14<BR>[&nbsp;&nbsp;&nbsp; 1.247000] ata2: PATA max UDMA=
/100 cmd 0x170 ctl 0x376 bmdma 0x70A8 irq 15<BR>[&nbsp;&nbsp;&nbsp; 1.24800=
0] scsi0 : ata_piix<BR>[&nbsp;&nbsp;&nbsp; 1.401000] ata1.00: ATA-7, max UD=
MA/100, 156301488 sectors: LBA48 NCQ (depth 0/32)<BR>[&nbsp;&nbsp;&nbsp; 1.=
401000] ata1.00: ata1: dev 0 multi count 16<BR>[&nbsp;&nbsp;&nbsp; 1.404000=
] ata1.00: configured for UDMA/100<BR>[&nbsp;&nbsp;&nbsp; 1.404000] scsi1 :
 ata_piix<BR>[&nbsp;&nbsp;&nbsp; 1.813000] ata2.01: ATAPI, max UDMA/33<BR>[=
&nbsp;&nbsp;&nbsp; 1.965000] ata2.01: configured for UDMA/33<BR>[&nbsp;&nbs=
p;&nbsp; 1.965000] scsi 0:0:0:0: Direct-Access&nbsp;&nbsp;&nbsp;&nbsp; ATA&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FUJITSU MHT2080B 0000 PQ: 0 ANSI: 5<BR>[&nbsp=
;&nbsp;&nbsp; 1.966000] scsi 1:0:1:0: CD-ROM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Slimtype COMBO SOSC-2483K KK0H PQ: 0 AN=
SI: 5<BR>[&nbsp;&nbsp;&nbsp; 1.972000] SCSI device sda: 156301488 512-byte =
hdwr sectors (80026 MB)<BR>[&nbsp;&nbsp;&nbsp; 1.972000] sda: Write Protect=
 is off<BR>[&nbsp;&nbsp;&nbsp; 1.972000] sda: Mode Sense: 00 3a 00 00<BR>[&=
nbsp;&nbsp;&nbsp; 1.972000] SCSI device sda: drive cache: write back<BR>[&n=
bsp;&nbsp;&nbsp; 1.972000] SCSI device sda: 156301488 512-byte hdwr sectors=
 (80026 MB)<BR>[&nbsp;&nbsp;&nbsp; 1.972000] sda: Write Protect is off<BR>[=
&nbsp;&nbsp;&nbsp; 1.972000] sda: Mode Sense: 00 3a 00 00<BR>[&nbsp;&nbsp;&=
nbsp;
 1.972000] SCSI device sda: drive cache: write back<BR>[&nbsp;&nbsp;&nbsp; =
1.972000]&nbsp; sda: sda1 sda2 &lt; sda5 sda6 sda7 sda8 sda9 &gt;<BR>[&nbsp=
;&nbsp;&nbsp; 2.083000] sd 0:0:0:0: Attached scsi disk sda<BR>[&nbsp;&nbsp;=
&nbsp; 2.509000] usbcore: registered new interface driver usbfs<BR>[&nbsp;&=
nbsp;&nbsp; 2.509000] usbcore: registered new interface driver hub<BR>[&nbs=
p;&nbsp;&nbsp; 2.509000] usbcore: registered new device driver usb<BR>[&nbs=
p;&nbsp;&nbsp; 2.510000] USB Universal Host Controller Interface driver v3.=
0<BR>[&nbsp;&nbsp;&nbsp; 2.510000] ACPI: PCI Interrupt 0000:00:1d.0[A] -&gt=
; GSI 23 (level, low) -&gt; IRQ 20<BR>[&nbsp;&nbsp;&nbsp; 2.510000] PCI: Se=
tting latency timer of device 0000:00:1d.0 to 64<BR>[&nbsp;&nbsp;&nbsp; 2.5=
10000] uhci_hcd 0000:00:1d.0: UHCI Host Controller<BR>[&nbsp;&nbsp;&nbsp; 2=
.510000] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number=
 1<BR>[&nbsp;&nbsp;&nbsp; 2.510000] uhci_hcd 0000:00:1d.0: irq 20, io base
 0x00007080<BR>[&nbsp;&nbsp;&nbsp; 2.510000] usb usb1: configuration #1 cho=
sen from 1 choice<BR>[&nbsp;&nbsp;&nbsp; 2.511000] hub 1-0:1.0: USB hub fou=
nd<BR>[&nbsp;&nbsp;&nbsp; 2.511000] hub 1-0:1.0: 2 ports detected<BR>[&nbsp=
;&nbsp;&nbsp; 2.612000] ACPI: PCI Interrupt 0000:00:1d.1[B] -&gt; GSI 19 (l=
evel, low) -&gt; IRQ 19<BR>[&nbsp;&nbsp;&nbsp; 2.612000] PCI: Setting laten=
cy timer of device 0000:00:1d.1 to 64<BR>[&nbsp;&nbsp;&nbsp; 2.612000] uhci=
_hcd 0000:00:1d.1: UHCI Host Controller<BR>[&nbsp;&nbsp;&nbsp; 2.613000] uh=
ci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2<BR>[&nbs=
p;&nbsp;&nbsp; 2.613000] uhci_hcd 0000:00:1d.1: irq 19, io base 0x00007060<=
BR>[&nbsp;&nbsp;&nbsp; 2.613000] usb usb2: configuration #1 chosen from 1 c=
hoice<BR>[&nbsp;&nbsp;&nbsp; 2.613000] hub 2-0:1.0: USB hub found<BR>[&nbsp=
;&nbsp;&nbsp; 2.613000] hub 2-0:1.0: 2 ports detected<BR>[&nbsp;&nbsp;&nbsp=
; 2.715000] ACPI: PCI Interrupt 0000:00:1d.2[C] -&gt; GSI 18 (level, low) -=
&gt; IRQ
 18<BR>[&nbsp;&nbsp;&nbsp; 2.715000] PCI: Setting latency timer of device 0=
000:00:1d.2 to 64<BR>[&nbsp;&nbsp;&nbsp; 2.715000] uhci_hcd 0000:00:1d.2: U=
HCI Host Controller<BR>[&nbsp;&nbsp;&nbsp; 2.715000] uhci_hcd 0000:00:1d.2:=
 new USB bus registered, assigned bus number 3<BR>[&nbsp;&nbsp;&nbsp; 2.715=
000] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00007040<BR>[&nbsp;&nbsp;&nbs=
p; 2.715000] usb usb3: configuration #1 chosen from 1 choice<BR>[&nbsp;&nbs=
p;&nbsp; 2.716000] hub 3-0:1.0: USB hub found<BR>[&nbsp;&nbsp;&nbsp; 2.7160=
00] hub 3-0:1.0: 2 ports detected<BR>[&nbsp;&nbsp;&nbsp; 2.817000] ACPI: PC=
I Interrupt 0000:00:1d.3[D] -&gt; GSI 16 (level, low) -&gt; IRQ 17<BR>[&nbs=
p;&nbsp;&nbsp; 2.817000] PCI: Setting latency timer of device 0000:00:1d.3 =
to 64<BR>[&nbsp;&nbsp;&nbsp; 2.817000] uhci_hcd 0000:00:1d.3: UHCI Host Con=
troller<BR>[&nbsp;&nbsp;&nbsp; 2.818000] uhci_hcd 0000:00:1d.3: new USB bus=
 registered, assigned bus number 4<BR>[&nbsp;&nbsp;&nbsp; 2.818000] uhci_hc=
d
 0000:00:1d.3: irq 17, io base 0x00007020<BR>[&nbsp;&nbsp;&nbsp; 2.818000] =
usb usb4: configuration #1 chosen from 1 choice<BR>[&nbsp;&nbsp;&nbsp; 2.81=
8000] hub 4-0:1.0: USB hub found<BR>[&nbsp;&nbsp;&nbsp; 2.818000] hub 4-0:1=
.0: 2 ports detected<BR>[&nbsp;&nbsp;&nbsp; 2.920000] ACPI: PCI Interrupt 0=
000:00:1d.7[A] -&gt; GSI 23 (level, low) -&gt; IRQ 20<BR>[&nbsp;&nbsp;&nbsp=
; 2.920000] PCI: Setting latency timer of device 0000:00:1d.7 to 64<BR>[&nb=
sp;&nbsp;&nbsp; 2.920000] ehci_hcd 0000:00:1d.7: EHCI Host Controller<BR>[&=
nbsp;&nbsp;&nbsp; 2.920000] ehci_hcd 0000:00:1d.7: new USB bus registered, =
assigned bus number 5<BR>[&nbsp;&nbsp;&nbsp; 2.920000] ehci_hcd 0000:00:1d.=
7: debug port 1<BR>[&nbsp;&nbsp;&nbsp; 2.920000] PCI: cache line size of 32=
 is not supported by device 0000:00:1d.7<BR>[&nbsp;&nbsp;&nbsp; 2.920000] e=
hci_hcd 0000:00:1d.7: irq 20, io mem 0x38440400<BR>[&nbsp;&nbsp;&nbsp; 2.92=
4000] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec
 2004<BR>[&nbsp;&nbsp;&nbsp; 2.924000] usb usb5: configuration #1 chosen fr=
om 1 choice<BR>[&nbsp;&nbsp;&nbsp; 2.924000] hub 5-0:1.0: USB hub found<BR>=
[&nbsp;&nbsp;&nbsp; 2.924000] hub 5-0:1.0: 8 ports detected<BR>[&nbsp;&nbsp=
;&nbsp; 3.041000] ide0: I/O resource 0x1F0-0x1F7 not free.<BR>[&nbsp;&nbsp;=
&nbsp; 3.041000] ide0: ports already in use, skipping probe<BR>[&nbsp;&nbsp=
;&nbsp; 3.041000] ide1: I/O resource 0x170-0x177 not free.<BR>[&nbsp;&nbsp;=
&nbsp; 3.041000] ide1: ports already in use, skipping probe<BR>[&nbsp;&nbsp=
;&nbsp; 3.109000] kjournald starting.&nbsp; Commit interval 5 seconds<BR>[&=
nbsp;&nbsp;&nbsp; 3.109000] EXT3-fs: mounted filesystem with ordered data m=
ode.<BR>[&nbsp;&nbsp; 10.085000] sr0: scsi3-mmc drive: 0x/24x writer cd/rw =
xa/form2 cdda tray<BR>[&nbsp;&nbsp; 10.085000] Uniform CD-ROM driver Revisi=
on: 3.20<BR>[&nbsp;&nbsp; 10.085000] sr 1:0:1:0: Attached scsi CD-ROM sr0<B=
R>[&nbsp;&nbsp; 10.152000] lp: driver loaded but no devices found<BR>[&nbsp=
;&nbsp;
 10.269000] Adding 1020088k swap on /dev/sda6.&nbsp; Priority:-1 extents:1 =
across:1020088k<BR>[&nbsp;&nbsp; 10.348000] EXT3 FS on sda5, internal journ=
al<BR>[&nbsp;&nbsp; 10.995000] input: PS/2 Generic Mouse as /class/input/in=
put1<BR>[&nbsp;&nbsp; 11.024000] Intel(R) PRO/1000 Network Driver - version=
 7.2.9-k4<BR>[&nbsp;&nbsp; 11.024000] Copyright (c) 1999-2006 Intel Corpora=
tion.<BR>[&nbsp;&nbsp; 11.025000] ACPI: PCI Interrupt 0000:01:00.0[A] -&gt;=
 GSI 16 (level, low) -&gt; IRQ 17<BR>[&nbsp;&nbsp; 11.025000] PCI: Setting =
latency timer of device 0000:01:00.0 to 64<BR>[&nbsp;&nbsp; 11.028000] inpu=
t: PC Speaker as /class/input/input2<BR>[&nbsp;&nbsp; 11.068000] e1000: 000=
0:01:00.0: e1000_probe: (PCI Express:2.5Gb/s:32-bit) 00:0e:0c:72:bc:74<BR>[=
&nbsp;&nbsp; 11.130000] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network=
 Connection<BR>[&nbsp;&nbsp; 12.454000] NTFS driver 2.1.27 [Flags: R/O MODU=
LE].<BR>[&nbsp;&nbsp; 12.785000] NET: Registered protocol family 17<BR>[&nb=
sp;&nbsp;
 12.960000] NTFS volume version 3.1.<BR>[&nbsp;&nbsp; 13.630000] e1000: eth=
0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex<BR>[&nbsp;&nbsp; 13.=
630000] e1000: eth0: e1000_watchdog: 10/100 speed: disabling TSO<BR><BR></D=
IV>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york=
, times, serif">Thanks<BR></DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-FAMI=
LY: times new roman, new york, times, serif">----- Original Message ----<BR=
>From: James Simmons &lt;jsimmons@infradead.org&gt;<BR>To: linux-fbdev-deve=
l@lists.sourceforge.net<BR>Sent: Wednesday, December 27, 2006 10:46:41 PM<B=
R>Subject: Re: [Linux-fbdev-devel] intelfb driver on 945GM chipset<BR><BR>=
=0A<DIV>&gt; actually i tried video=3Dintelfb:mode=3D1024x768-16@75 instead=
 and it didn't work for me.<BR>Thanks<BR><BR>Can we see your dmesg ? Is it =
going to the default 640x480 mode ?<BR><BR>--------------------------------=
-----------------------------------------<BR>Take Surveys. Earn Cash. Influ=
ence the Future of IT<BR>Join SourceForge.net's Techsay panel and you'll ge=
t the chance to share your<BR>opinions on IT &amp; business topics through =
brief surveys - and earn cash<BR><A href=3D"http://www.techsay.com/default.=
php?page=3Djoin.php&amp;p=3Dsourceforge&amp;CID=3DDEVDEV" target=3D_blank>h=
ttp://www.techsay.com/default.php?page=3Djoin.php&amp;p=3Dsourceforge&amp;C=
ID=3DDEVDEV</A><BR>_______________________________________________<BR>Linux=
-fbdev-devel mailing list<BR>Linux-fbdev-devel@lists.sourceforge.net<BR><A =
href=3D"https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel" tar=
get=3D_blank>https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel=
</A></DIV></DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new ro=
man, new york, times, serif"><BR></DIV></div><br>__________________________=
________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail h=
as the best spam protection around <br>http://mail.yahoo.com </body></html>
--0-1017390124-1167313982=:51659--


--===============0723922427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0723922427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0723922427==--
