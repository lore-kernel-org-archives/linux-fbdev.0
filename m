From: David J Ring Jr <n1ea@arrl.net>
Date: Sun, 13 Nov 2011 22:48:58 +0000
Subject: Re: Getting FB to work in Console
Message-Id: <alpine.DEB.2.00.1111132242170.2152@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8323328-373814776-1321242484=:2152"
List-Id: <linux-fbdev.vger.kernel.org>
References: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
In-Reply-To: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
To: linux-fbdev@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-373814776-1321242484=:2152
Content-Type: TEXT/PLAIN; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable

I get these drivers:


arcfb.ko
arkfb.ko
aty
backlight
cirrusfb.ko
console
cyber2000fb.ko
display
fb_ddc.ko
fb_sys_fops.ko
geode
hecubafb.ko
hgafb.ko
i810
kyro
macmodes.ko
matrox
mb862xx
metronomefb.ko
n411.ko
neofb.ko
nvidia
output.ko
pm2fb.ko
pm3fb.ko
s1d13xxxfb.ko
s3fb.ko
savage
sis
sm501fb.ko
sstfb.ko
svgalib.ko
syscopyarea.ko
sysfillrect.ko
sysimgblt.ko
tdfxfb.ko
tridentfb.ko
uvesafb.ko
vermilion
vfb.ko
vga16fb.ko
vgastate.ko
via
vt8623fb.ko

Is there a universal driver?

Here is the output of dmesg:


[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.32-5-686 (Debian 2.6.32-38) (ben@decadent.=
org.uk) (gcc version 4.3.5 (Debian 4.3.5-4) ) #1 SMP Mon Oct 3 04:15:24 UTC=
 2011
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   NSC Geode by NSC
[    0.000000]   Cyrix CyrixInstead
[    0.000000]   Centaur CentaurHauls
[    0.000000]   Transmeta GenuineTMx86
[    0.000000]   Transmeta TransmetaCPU
[    0.000000]   UMC UMC UMC UMC
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
[    0.000000]  BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
[    0.000000]  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000bd6b3000 (usable)
[    0.000000]  BIOS-e820: 00000000bd6b3000 - 00000000bd6b9000 (reserved)
[    0.000000]  BIOS-e820: 00000000bd6b9000 - 00000000bd7b2000 (usable)
[    0.000000]  BIOS-e820: 00000000bd7b2000 - 00000000bd80f000 (reserved)
[    0.000000]  BIOS-e820: 00000000bd80f000 - 00000000bd907000 (usable)
[    0.000000]  BIOS-e820: 00000000bd907000 - 00000000bdb0f000 (reserved)
[    0.000000]  BIOS-e820: 00000000bdb0f000 - 00000000bdb18000 (usable)
[    0.000000]  BIOS-e820: 00000000bdb18000 - 00000000bdb1f000 (reserved)
[    0.000000]  BIOS-e820: 00000000bdb1f000 - 00000000bdb63000 (usable)
[    0.000000]  BIOS-e820: 00000000bdb63000 - 00000000bdb9f000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bdb9f000 - 00000000bdc00000 (ACPI data)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
[    0.000000] DMI present.
[    0.000000] last_pfn =3D 0xbdb63 max_arch_pfn =3D 0x100000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0C0000000 mask FC0000000 uncachable
[    0.000000]   1 base 000000000 mask F00000000 write-back
[    0.000000]   2 base 100000000 mask FC0000000 write-back
[    0.000000]   3 base 0BDC00000 mask FFFC00000 uncachable
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x701060007=
0106
[    0.000000] e820 update range: 00000000bdc00000 - 00000000be000000 (usab=
le) =3D=3D> (reserved)
[    0.000000] e820 update range: 00000000c0000000 - 0000000100000000 (usab=
le) =3D=3D> (reserved)
[    0.000000] initial memory mapped : 0 - 01800000
[    0.000000] init_memory_mapping: 0000000000000000-00000000373fe000
[    0.000000]  0000000000 - 0000400000 page 4k
[    0.000000]  0000400000 - 0037000000 page 2M
[    0.000000]  0037000000 - 00373fe000 page 4k
[    0.000000] kernel direct mapping tables up to 373fe000 @ 7000-d000
[    0.000000] RAMDISK: 3759a000 - 37fef5a8
[    0.000000] Allocated new RAMDISK: 00100000 - 00b555a8
[    0.000000] Move RAMDISK from 000000003759a000 - 0000000037fef5a7 to 001=
00000 - 00b555a7
[    0.000000] ACPI: RSDP 000f7190 00024 (v02 LENOVO)
[    0.000000] ACPI: XSDT bdbf6067 0006C (v01 LENOVO TP-6G    00000000  LTP=
 00000000)
[    0.000000] ACPI: FACP bdbe8000 000F4 (v03 LENOVO TP-6G    00000001 ALAN=
 00000001)
[    0.000000] ACPI: DSDT bdbe9000 06B23 (v02 LENOVO TP-6G    00000001 INTL=
 20050624)
[    0.000000] ACPI: FACS bdb9efc0 00040
[    0.000000] ACPI: HPET bdbfcd86 00038 (v01 LENOVO TP-6G    00000001 LOHR=
 0000005A)
[    0.000000] ACPI: MCFG bdbfcdbe 0003C (v01 LENOVO TP-6G    00000001 LOHR=
 0000005A)
[    0.000000] ACPI: SLIC bdbfcdfa 00176 (v01 LENOVO TP-6G    00000001 TBD =
 00000001)
[    0.000000] ACPI: APIC bdbfcf70 00068 (v01 PTLTD  ? APIC   00000000  LTP=
 00000000)
[    0.000000] ACPI: BOOT bdbfcfd8 00028 (v01 PTLTD  $SBFTBL$ 00000000  LTP=
 00000001)
[    0.000000] ACPI: SSDT bdbe7000 00655 (v01  PmRef    CpuPm 00003000 INTL=
 20050624)
[    0.000000] ACPI: SSDT bdbe6000 00259 (v01  PmRef  Cpu0Tst 00003000 INTL=
 20050624)
[    0.000000] ACPI: SSDT bdbe5000 0020F (v01  PmRef    ApTst 00003000 INTL=
 20050624)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] 2151MB HIGHMEM available.
[    0.000000] 883MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 373fe000
[    0.000000]   low ram: 0 - 373fe000
[    0.000000]   node 0 low ram: 00000000 - 373fe000
[    0.000000]   node 0 bootmap 00009000 - 0000fe80
[    0.000000] (9 early reservations) =3D=3D> bootmem [0000000000 - 00373fe=
000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page =3D=3D> [000=
0000000 - 0000001000]
[    0.000000]   #1 [0000001000 - 0000002000]    EX TRAMPOLINE =3D=3D> [000=
0001000 - 0000002000]
[    0.000000]   #2 [0000006000 - 0000007000]       TRAMPOLINE =3D=3D> [000=
0006000 - 0000007000]
[    0.000000]   #3 [0001000000 - 00014cccf4]    TEXT DATA BSS =3D=3D> [000=
1000000 - 00014cccf4]
[    0.000000]   #4 [000009f400 - 0000100000]    BIOS reserved =3D=3D> [000=
009f400 - 0000100000]
[    0.000000]   #5 [00014cd000 - 00014d3184]              BRK =3D=3D> [000=
14cd000 - 00014d3184]
[    0.000000]   #6 [0000007000 - 0000009000]          PGTABLE =3D=3D> [000=
0007000 - 0000009000]
[    0.000000]   #7 [0000100000 - 0000b555a8]      NEW RAMDISK =3D=3D> [000=
0100000 - 0000b555a8]
[    0.000000]   #8 [0000009000 - 0000010000]          BOOTMAP =3D=3D> [000=
0009000 - 0000010000]
[    0.000000] found SMP MP-table at [c00f7230] f7230
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00001000
[    0.000000]   Normal   0x00001000 -> 0x000373fe
[    0.000000]   HighMem  0x000373fe -> 0x000bdb63
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[6] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x0000009f
[    0.000000]     0: 0x00000100 -> 0x000bd6b3
[    0.000000]     0: 0x000bd6b9 -> 0x000bd7b2
[    0.000000]     0: 0x000bd80f -> 0x000bd907
[    0.000000]     0: 0x000bdb0f -> 0x000bdb18
[    0.000000]     0: 0x000bdb1f -> 0x000bdb63
[    0.000000] On node 0 totalpages: 776336
[    0.000000] free_area_init_node: node 0, pgdat c13b4860, node_mem_map c1=
4d5000
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3967 pages, LIFO batch:0
[    0.000000]   Normal zone: 1736 pages used for memmap
[    0.000000]   Normal zone: 220470 pages, LIFO batch:31
[    0.000000]   HighMem zone: 4303 pages used for memmap
[    0.000000]   HighMem zone: 545828 pages, LIFO batch:31
[    0.000000] Using APIC driver default
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-=
23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 24
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000=
a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000=
d2000
[    0.000000] PM: Registered nosave memory: 00000000000d2000 - 00000000000=
d4000
[    0.000000] PM: Registered nosave memory: 00000000000d4000 - 00000000000=
dc000
[    0.000000] PM: Registered nosave memory: 00000000000dc000 - 00000000001=
00000
[    0.000000] Allocating PCI resources starting at bdc00000 (gap: bdc00000=
:42400000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] NR_CPUS:32 nr_cpumask_bits:32 nr_cpu_ids:2 nr_node_ids:1
[    0.000000] PERCPU: Embedded 14 pages/cpu @c3000000 s34328 r0 d23016 u20=
97152
[    0.000000] pcpu-alloc: s34328 r0 d23016 u2097152 alloc=3D1*4194304
[    0.000000] pcpu-alloc: [0] 0 1=20
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 770265
[    0.000000] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-2.6.32-5-686=
 root=3DUUID=3Dcb1268f1-4e20-4409-87b1-3d882c14102c ro nomodeset
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 by=
tes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 byte=
s)
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] Initializing HighMem for node 0 (000373fe:000bdb63)
[    0.000000] Memory: 3063500k/3108236k available (2504k kernel code, 4082=
4k reserved, 1328k data, 380k init, 2200524k highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xffd56000 - 0xfffff000   (2724 kB)
[    0.000000]     pkmap   : 0xff400000 - 0xff800000   (4096 kB)
[    0.000000]     vmalloc : 0xf7bfe000 - 0xff3fe000   ( 120 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf73fe000   ( 883 MB)
[    0.000000]       .init : 0xc13bf000 - 0xc141e000   ( 380 kB)
[    0.000000]       .data : 0xc12721f1 - 0xc13be480   (1328 kB)
[    0.000000]       .text : 0xc1000000 - 0xc12721f1   (2504 kB)
[    0.000000] Checking if this processor honours the WP bit even in superv=
isor mode...Ok.
[    0.000000] SLUB: Genslabs=3D13, HWalign=3D64, Order=3D0-3, MinObjects=
=3D0, CPUs=3D2, Nodes=3D1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:1280
[    0.000000] Extended CMOS year: 2000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 2161.581 MHz processor.
[    0.004003] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 4323.16 BogoMIPS (lpj=3D8646324)
[    0.004139] Security Framework initialized
[    0.004201] SELinux:  Disabled at boot.
[    0.004265] Mount-cache hash table entries: 512
[    0.004438] Initializing cgroup subsys ns
[    0.004500] Initializing cgroup subsys cpuacct
[    0.004563] Initializing cgroup subsys devices
[    0.004624] Initializing cgroup subsys freezer
[    0.004684] Initializing cgroup subsys net_cls
[    0.004765] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.004868] CPU: L2 cache: 1024K
[    0.004928] CPU: Physical Processor ID: 0
[    0.004987] CPU: Processor Core ID: 0
[    0.005049] mce: CPU supports 6 MCE banks
[    0.005114] CPU0: Thermal monitoring enabled (TM2)
[    0.005177] using mwait in idle threads.
[    0.005241] Performance Events: Core2 events, Intel PMU driver.
[    0.005391] ... version:                2
[    0.005450] ... bit width:              40
[    0.005510] ... generic registers:      2
[    0.005569] ... value mask:             000000ffffffffff
[    0.005631] ... max period:             000000007fffffff
[    0.005693] ... fixed-purpose events:   3
[    0.005753] ... event mask:             0000000700000003
[    0.005816] Checking 'hlt' instruction... OK.
[    0.021105] ACPI: Core revision 20090903
[    0.032058] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.032510] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.074335] CPU0: Intel(R) Pentium(R) Dual  CPU  T3400  @ 2.16GHz steppi=
ng 0d
[    0.076001] Booting processor 1 APIC 0x1 ip 0x6000
[    0.008000] Initializing CPU#1
[    0.008000] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.008000] CPU: L2 cache: 1024K
[    0.008000] CPU: Physical Processor ID: 0
[    0.008000] CPU: Processor Core ID: 1
[    0.008000] CPU1: Thermal monitoring enabled (TM2)
[    0.160096] CPU1: Intel(R) Pentium(R) Dual  CPU  T3400  @ 2.16GHz steppi=
ng 0d
[    0.160599] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    0.164047] Brought up 2 CPUs
[    0.164107] Total of 2 processors activated (8645.66 BogoMIPS).
[    0.164739] CPU0 attaching sched-domain:
[    0.164743]  domain 0: span 0-1 level MC
[    0.164745]   groups: group c3003778 cpus 0 group c3203778 cpus 1
[    0.164751] CPU1 attaching sched-domain:
[    0.164753]  domain 0: span 0-1 level MC
[    0.164755]   groups: group c3203778 cpus 1 group c3003778 cpus 0
[    0.164807] devtmpfs: initialized
[    0.164966] regulator: core version 0.5
[    0.164966] NET: Registered protocol family 16
[    0.164966] ACPI: bus type pci registered
[    0.164966] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 -=
 255
[    0.164966] PCI: Not using MMCONFIG.
[    0.164966] PCI: PCI BIOS revision 3.00 entry at 0xfde11, last bus=3D8
[    0.165017] PCI: Using configuration type 1 for base access
[    0.168023] bio: create slab <bio-0> at 0
[    0.168830] ACPI: EC: Look up EC in DSDT
[    0.172270] ACPI: BIOS _OSI(Linux) query ignored
[    0.173667] ACPI: Interpreter enabled
[    0.173728] ACPI: (supports S0 S3 S4 S5)
[    0.173973] ACPI: Using IOAPIC for interrupt routing
[    0.174080] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 -=
 255
[    0.212432] PCI: MCFG area at e0000000 reserved in ACPI motherboard reso=
urces
[    0.212497] PCI: Using MMCONFIG for extended config space
[    0.254855] ACPI: EC: GPE =3D 0x1c, I/O: command/status =3D 0x66, data =
=3D 0x62
[    0.255220] ACPI: No dock devices found.
[    0.255750] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.255864] DMAR: Forcing write-buffer flush capability
[    0.255926] DMAR: Disabling IOMMU for graphics on this chipset
[    0.256035] pci 0000:00:02.0: reg 10 64bit mmio: [0xf4000000-0xf43fffff]
[    0.256042] pci 0000:00:02.0: reg 18 64bit mmio pref: [0xd0000000-0xdfff=
ffff]
[    0.256047] pci 0000:00:02.0: reg 20 io port: [0x1800-0x1807]
[    0.256089] pci 0000:00:02.1: reg 10 64bit mmio: [0xf4400000-0xf44fffff]
[    0.256217] pci 0000:00:1a.0: reg 20 io port: [0x1820-0x183f]
[    0.256315] pci 0000:00:1a.1: reg 20 io port: [0x1840-0x185f]
[    0.256412] pci 0000:00:1a.2: reg 20 io port: [0x1860-0x187f]
[    0.256510] pci 0000:00:1a.7: reg 10 32bit mmio: [0xf4a04800-0xf4a04bff]
[    0.256581] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.256648] pci 0000:00:1a.7: PME# disabled
[    0.256765] pci 0000:00:1b.0: reg 10 64bit mmio: [0xf4a00000-0xf4a03fff]
[    0.256828] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.256895] pci 0000:00:1b.0: PME# disabled
[    0.257051] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.257117] pci 0000:00:1c.0: PME# disabled
[    0.257275] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.257342] pci 0000:00:1c.1: PME# disabled
[    0.257499] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.257566] pci 0000:00:1c.2: PME# disabled
[    0.257724] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.257791] pci 0000:00:1c.3: PME# disabled
[    0.257951] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.258017] pci 0000:00:1c.5: PME# disabled
[    0.258155] pci 0000:00:1d.0: reg 20 io port: [0x1880-0x189f]
[    0.258254] pci 0000:00:1d.1: reg 20 io port: [0x18a0-0x18bf]
[    0.258352] pci 0000:00:1d.2: reg 20 io port: [0x18c0-0x18df]
[    0.258449] pci 0000:00:1d.7: reg 10 32bit mmio: [0xf4a04c00-0xf4a04fff]
[    0.258520] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.258587] pci 0000:00:1d.7: PME# disabled
[    0.258914] pci 0000:00:1f.2: reg 10 io port: [0x1818-0x181f]
[    0.258922] pci 0000:00:1f.2: reg 14 io port: [0x180c-0x180f]
[    0.258930] pci 0000:00:1f.2: reg 18 io port: [0x1810-0x1817]
[    0.258939] pci 0000:00:1f.2: reg 1c io port: [0x1808-0x180b]
[    0.258947] pci 0000:00:1f.2: reg 20 io port: [0x18e0-0x18ff]
[    0.258955] pci 0000:00:1f.2: reg 24 32bit mmio: [0xf4a04000-0xf4a047ff]
[    0.259004] pci 0000:00:1f.2: PME# supported from D3hot
[    0.259069] pci 0000:00:1f.2: PME# disabled
[    0.259171] pci 0000:00:1f.3: reg 10 64bit mmio: [0x000000-0x0000ff]
[    0.259191] pci 0000:00:1f.3: reg 20 io port: [0x1c00-0x1c1f]
[    0.259297] pci 0000:02:00.0: reg 10 32bit mmio: [0xf4500000-0xf45000ff]
[    0.259375] pci 0000:02:00.0: reg 30 32bit mmio pref: [0x000000-0x00ffff]
[    0.259542] pci 0000:02:00.2: reg 10 32bit mmio: [0xf4500400-0xf45004ff]
[    0.259778] pci 0000:02:00.3: reg 10 32bit mmio: [0xf4500800-0xf45008ff]
[    0.268236] pci 0000:00:1c.0: bridge 32bit mmio: [0xf4500000-0xf45fffff]
[    0.268516] pci 0000:04:00.0: reg 10 64bit mmio: [0xf4700000-0xf4703fff]
[    0.268737] pci 0000:04:00.0: supports D1 D2
[    0.268739] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    0.268847] pci 0000:04:00.0: PME# disabled
[    0.269437] pci 0000:00:1c.2: bridge 32bit mmio: [0xf4700000-0xf47fffff]
[    0.269504] pci 0000:00:1c.3: bridge io port: [0x2000-0x2fff]
[    0.269509] pci 0000:00:1c.3: bridge 32bit mmio: [0xf0000000-0xf3ffffff]
[    0.269518] pci 0000:00:1c.3: bridge 64bit mmio pref: [0xf6000000-0xf7ff=
ffff]
[    0.269741] pci 0000:07:00.0: reg 10 64bit mmio: [0xf4600000-0xf460ffff]
[    0.269982] pci 0000:07:00.0: PME# supported from D3hot D3cold
[    0.270088] pci 0000:07:00.0: PME# disabled
[    0.270691] pci 0000:00:1c.5: bridge 32bit mmio: [0xf4600000-0xf46fffff]
[    0.270765] pci 0000:00:1e.0: transparent bridge
[    0.270875] pci_bus 0000:00: on NUMA node 0
[    0.270880] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.271015] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[    0.271102] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[    0.271205] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
[    0.271268] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
[    0.271339] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
[    0.271405] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP06._PRT]
[    0.283764] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 *5 6 7 10 12 14 =
15)
[    0.284408] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *11 12 14 =
15)
[    0.285068] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 *3 4 5 6 7 10 12 14 =
15)
[    0.285725] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 1=
5) *10
[    0.286436] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 *7 10 12 14 =
15)
[    0.287094] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 *11 12 14 =
15)
[    0.287752] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 *10 12 14 =
15)
[    0.288445] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 *4 5 6 7 11 12 14 =
15)
[    0.289101] vgaarb: device added: PCI:0000:00:02.0,decodes=3Dio+mem,owns=
=3Dio+mem,locks=3Dnone
[    0.289192] vgaarb: loaded
[    0.289263] PCI: Using ACPI for IRQ routing
[    0.289263] HPET: 4 timers in total, 0 timers will be used for per-cpu t=
imer
[    0.289263] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    0.289263] hpet0: 4 comparators, 64-bit 14.318180 MHz counter
[    0.296019] Switching to clocksource tsc
[    0.297233] pnp: PnP ACPI init
[    0.297302] ACPI: bus type pnp registered
[    0.315852] pnp: PnP ACPI: found 10 devices
[    0.315915] ACPI: ACPI bus type pnp unregistered
[    0.315977] PnPBIOS: Disabled by ACPI PNP
[    0.316046] system 00:03: iomem range 0xfed00000-0xfed003ff has been res=
erved
[    0.316117] system 00:05: ioport range 0x680-0x69f has been reserved
[    0.316182] system 00:05: ioport range 0xffff-0xffff has been reserved
[    0.316247] system 00:05: ioport range 0xffff-0xffff has been reserved
[    0.316312] system 00:05: ioport range 0xffff-0xffff has been reserved
[    0.316377] system 00:05: ioport range 0x400-0x47f has been reserved
[    0.316442] system 00:05: ioport range 0x480-0x48f has been reserved
[    0.316507] system 00:05: ioport range 0x1180-0x11ff has been reserved
[    0.316571] system 00:05: ioport range 0x164e-0x164f has been reserved
[    0.316636] system 00:05: ioport range 0xfe00-0xfe00 has been reserved
[    0.316701] system 00:05: ioport range 0xff00-0xff7f has been reserved
[    0.316770] system 00:09: iomem range 0xfed1c000-0xfed1ffff has been res=
erved
[    0.316836] system 00:09: iomem range 0xfed10000-0xfed13fff has been res=
erved
[    0.316902] system 00:09: iomem range 0xfed18000-0xfed18fff has been res=
erved
[    0.316968] system 00:09: iomem range 0xfed19000-0xfed19fff has been res=
erved
[    0.317034] system 00:09: iomem range 0xe0000000-0xefffffff has been res=
erved
[    0.317100] system 00:09: iomem range 0xfed20000-0xfed3ffff has been res=
erved
[    0.317166] system 00:09: iomem range 0xfed40000-0xfed44fff has been res=
erved
[    0.317232] system 00:09: iomem range 0xfed45000-0xfed8ffff has been res=
erved
[    0.352087] pci 0000:00:1c.0: PCI bridge, secondary bus 0000:02
[    0.352152] pci 0000:00:1c.0:   IO window: 0x3000-0x3fff
[    0.352220] pci 0000:00:1c.0:   MEM window: 0xf4500000-0xf45fffff
[    0.352287] pci 0000:00:1c.0:   PREFETCH window: 0xc0000000-0xc01fffff
[    0.352357] pci 0000:00:1c.1: PCI bridge, secondary bus 0000:03
[    0.352423] pci 0000:00:1c.1:   IO window: 0x4000-0x4fff
[    0.352489] pci 0000:00:1c.1:   MEM window: 0xc0200000-0xc03fffff
[    0.352556] pci 0000:00:1c.1:   PREFETCH window: 0x000000c0400000-0x0000=
00c05fffff
[    0.352640] pci 0000:00:1c.2: PCI bridge, secondary bus 0000:04
[    0.352704] pci 0000:00:1c.2:   IO window: 0x5000-0x5fff
[    0.352771] pci 0000:00:1c.2:   MEM window: 0xf4700000-0xf47fffff
[    0.352838] pci 0000:00:1c.2:   PREFETCH window: 0x000000c0600000-0x0000=
00c07fffff
[    0.352921] pci 0000:00:1c.3: PCI bridge, secondary bus 0000:05
[    0.352986] pci 0000:00:1c.3:   IO window: 0x2000-0x2fff
[    0.353053] pci 0000:00:1c.3:   MEM window: 0xf0000000-0xf3ffffff
[    0.353119] pci 0000:00:1c.3:   PREFETCH window: 0x000000f6000000-0x0000=
00f7ffffff
[    0.353202] pci 0000:00:1c.5: PCI bridge, secondary bus 0000:07
[    0.353267] pci 0000:00:1c.5:   IO window: 0x6000-0x6fff
[    0.353334] pci 0000:00:1c.5:   MEM window: 0xf4600000-0xf46fffff
[    0.353401] pci 0000:00:1c.5:   PREFETCH window: 0x000000c0800000-0x0000=
00c09fffff
[    0.353484] pci 0000:00:1e.0: PCI bridge, secondary bus 0000:08
[    0.353547] pci 0000:00:1e.0:   IO window: disabled
[    0.353613] pci 0000:00:1e.0:   MEM window: disabled
[    0.353677] pci 0000:00:1e.0:   PREFETCH window: disabled
[    0.353758] pci 0000:00:1c.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    0.353827] pci 0000:00:1c.0: setting latency timer to 64
[    0.353838] pci 0000:00:1c.1: PCI INT B -> GSI 16 (level, low) -> IRQ 16
[    0.353906] pci 0000:00:1c.1: setting latency timer to 64
[    0.353917] pci 0000:00:1c.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    0.353984] pci 0000:00:1c.2: setting latency timer to 64
[    0.353995] pci 0000:00:1c.3: PCI INT D -> GSI 19 (level, low) -> IRQ 19
[    0.354063] pci 0000:00:1c.3: setting latency timer to 64
[    0.354073] pci 0000:00:1c.5: PCI INT B -> GSI 16 (level, low) -> IRQ 16
[    0.354140] pci 0000:00:1c.5: setting latency timer to 64
[    0.354149] pci 0000:00:1e.0: setting latency timer to 64
[    0.354154] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    0.354156] pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffff]
[    0.354159] pci_bus 0000:02: resource 0 io:  [0x3000-0x3fff]
[    0.354161] pci_bus 0000:02: resource 1 mem: [0xf4500000-0xf45fffff]
[    0.354164] pci_bus 0000:02: resource 2 pref mem [0xc0000000-0xc01fffff]
[    0.354166] pci_bus 0000:03: resource 0 io:  [0x4000-0x4fff]
[    0.354169] pci_bus 0000:03: resource 1 mem: [0xc0200000-0xc03fffff]
[    0.354171] pci_bus 0000:03: resource 2 pref mem [0xc0400000-0xc05fffff]
[    0.354174] pci_bus 0000:04: resource 0 io:  [0x5000-0x5fff]
[    0.354176] pci_bus 0000:04: resource 1 mem: [0xf4700000-0xf47fffff]
[    0.354179] pci_bus 0000:04: resource 2 pref mem [0xc0600000-0xc07fffff]
[    0.354181] pci_bus 0000:05: resource 0 io:  [0x2000-0x2fff]
[    0.354183] pci_bus 0000:05: resource 1 mem: [0xf0000000-0xf3ffffff]
[    0.354186] pci_bus 0000:05: resource 2 pref mem [0xf6000000-0xf7ffffff]
[    0.354188] pci_bus 0000:07: resource 0 io:  [0x6000-0x6fff]
[    0.354191] pci_bus 0000:07: resource 1 mem: [0xf4600000-0xf46fffff]
[    0.354193] pci_bus 0000:07: resource 2 pref mem [0xc0800000-0xc09fffff]
[    0.354196] pci_bus 0000:08: resource 3 io:  [0x00-0xffff]
[    0.354198] pci_bus 0000:08: resource 4 mem: [0x000000-0xffffffff]
[    0.354227] NET: Registered protocol family 2
[    0.354366] IP route cache hash table entries: 32768 (order: 5, 131072 b=
ytes)
[    0.354696] TCP established hash table entries: 131072 (order: 8, 104857=
6 bytes)
[    0.355221] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[    0.355572] TCP: Hash tables configured (established 131072 bind 65536)
[    0.355637] TCP reno registered
[    0.355793] NET: Registered protocol family 1
[    0.355875] pci 0000:00:02.0: Boot video device
[    0.356078] Unpacking initramfs...
[    0.633594] Freeing initrd memory: 10581k freed
[    0.640081] Simple Boot Flag at 0x36 set to 0x1
[    0.640429] audit: initializing netlink socket (disabled)
[    0.640505] type=3D2000 audit(1321223886.639:1): initialized
[    0.643795] highmem bounce pool size: 64 pages
[    0.643859] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    0.645179] VFS: Disk quotas dquot_6.5.2
[    0.645289] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.645419] msgmni has been set to 1708
[    0.645640] alg: No test for stdrng (krng)
[    0.645750] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 253)
[    0.645828] io scheduler noop registered
[    0.645888] io scheduler anticipatory registered
[    0.645949] io scheduler deadline registered
[    0.646038] io scheduler cfq registered (default)
[    0.646249] pcieport 0000:00:1c.0: irq 24 for MSI/MSI-X
[    0.646260] pcieport 0000:00:1c.0: setting latency timer to 64
[    0.646420] pcieport 0000:00:1c.1: irq 25 for MSI/MSI-X
[    0.646431] pcieport 0000:00:1c.1: setting latency timer to 64
[    0.646587] pcieport 0000:00:1c.2: irq 26 for MSI/MSI-X
[    0.646598] pcieport 0000:00:1c.2: setting latency timer to 64
[    0.646754] pcieport 0000:00:1c.3: irq 27 for MSI/MSI-X
[    0.646764] pcieport 0000:00:1c.3: setting latency timer to 64
[    0.646920] pcieport 0000:00:1c.5: irq 28 for MSI/MSI-X
[    0.646931] pcieport 0000:00:1c.5: setting latency timer to 64
[    0.647104] isapnp: Scanning for PnP cards...
[    1.001204] isapnp: No Plug & Play device found
[    1.002504] Linux agpgart interface v0.103
[    1.002638] agpgart-intel 0000:00:00.0: Intel Mobile Intel=AE GM45 Expre=
ss Chipset
[    1.003092] agpgart-intel 0000:00:00.0: detected 32764K stolen memory
[    1.034511] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xd0000000
[    1.034648] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.035077] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:MSE0] at 0x60,0x6=
4 irq 1,12
[    1.065945] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.066012] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.066123] mice: PS/2 mouse device common for all mice
[    1.066224] rtc_cmos 00:06: RTC can wake from S4
[    1.066317] rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
[    1.066413] rtc0: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    1.066490] cpuidle: using governor ladder
[    1.066552] cpuidle: using governor menu
[    1.066617] No iBFT detected.
[    1.066986] TCP cubic registered
[    1.067173] NET: Registered protocol family 10
[    1.067880] Mobile IPv6
[    1.067941] NET: Registered protocol family 17
[    1.068027] Using IPI No-Shortcut mode
[    1.068149] PM: Resume from disk failed.
[    1.068160] registered taskstats version 1
[    1.069481] rtc_cmos 00:06: setting system clock to 2011-11-13 22:38:07 =
UTC (1321223887)
[    1.069616] Initalizing network drop monitor service
[    1.069696] Freeing unused kernel memory: 380k freed
[    1.069929] Write protecting the kernel text: 2508k
[    1.070009] Write protecting the kernel read-only data: 920k
[    1.086038] udev[56]: starting version 164
[    1.095307] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input0
[    1.211016] SCSI subsystem initialized
[    1.214423] usbcore: registered new interface driver usbfs
[    1.214510] usbcore: registered new interface driver hub
[    1.215396] usbcore: registered new device driver usb
[    1.226492] ACPI: Invalid active0 threshold
[    1.230595] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.230703] ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 20 (level, low) -> I=
RQ 20
[    1.230792] ehci_hcd 0000:00:1a.7: setting latency timer to 64
[    1.230796] ehci_hcd 0000:00:1a.7: EHCI Host Controller
[    1.230885] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus =
number 1
[    1.231005] ehci_hcd 0000:00:1a.7: debug port 1
[    1.232655] uhci_hcd: USB Universal Host Controller Interface driver
[    1.232844] thermal LNXTHERM:01: registered as thermal_zone0
[    1.232940] ACPI: Thermal Zone [TZ00] (67 C)
[    1.234942] ehci_hcd 0000:00:1a.7: cache line size of 32 is not supported
[    1.235040] ehci_hcd 0000:00:1a.7: irq 20, io mem 0xf4a04800
[    1.239005] sdhci: Secure Digital Host Controller Interface driver
[    1.239070] sdhci: Copyright(c) Pierre Ossman
[    1.248009] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    1.248107] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    1.248172] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.248249] usb usb1: Product: EHCI Host Controller
[    1.248311] usb usb1: Manufacturer: Linux 2.6.32-5-686 ehci_hcd
[    1.248374] usb usb1: SerialNumber: 0000:00:1a.7
[    1.248529] usb usb1: configuration #1 chosen from 1 choice
[    1.248621] hub 1-0:1.0: USB hub found
[    1.248688] hub 1-0:1.0: 6 ports detected
[    1.248819] uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> I=
RQ 16
[    1.248892] uhci_hcd 0000:00:1a.0: setting latency timer to 64
[    1.248896] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    1.248964] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus =
number 2
[    1.249078] uhci_hcd 0000:00:1a.0: irq 16, io base 0x00001820
[    1.249172] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    1.249237] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.249314] usb usb2: Product: UHCI Host Controller
[    1.249375] usb usb2: Manufacturer: Linux 2.6.32-5-686 uhci_hcd
[    1.249439] usb usb2: SerialNumber: 0000:00:1a.0
[    1.249557] usb usb2: configuration #1 chosen from 1 choice
[    1.249644] hub 2-0:1.0: USB hub found
[    1.249709] hub 2-0:1.0: 2 ports detected
[    1.249829] ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> I=
RQ 23
[    1.249913] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[    1.249917] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    1.249984] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus =
number 3
[    1.250096] ehci_hcd 0000:00:1d.7: debug port 1
[    1.252226] libata version 3.00 loaded.
[    1.254042] ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
[    1.254063] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xf4a04c00
[    1.260036] tg3.c:v3.116 (December 3, 2010)
[    1.260164] tg3 0000:07:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    1.260276] tg3 0000:07:00.0: setting latency timer to 64
[    1.260292] sdhci-pci 0000:02:00.0: SDHCI controller found [197b:2382] (=
rev 0)
[    1.260395] sdhci-pci 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> =
IRQ 16
[    1.260633] sdhci-pci 0000:02:00.0: setting latency timer to 64
[    1.260677] Registered led device: mmc0::
[    1.260793] mmc0: SDHCI controller on PCI [0000:02:00.0] using ADMA
[    1.260868] sdhci-pci 0000:02:00.2: SDHCI controller found [197b:2381] (=
rev 0)
[    1.260963] sdhci-pci 0000:02:00.2: PCI INT A -> GSI 16 (level, low) -> =
IRQ 16
[    1.261058] sdhci-pci 0000:02:00.2: Refusing to bind to secondary interf=
ace.
[    1.261129] sdhci-pci 0000:02:00.2: PCI INT A disabled
[    1.268443] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    1.268531] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    1.268597] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.268674] usb usb3: Product: EHCI Host Controller
[    1.268735] usb usb3: Manufacturer: Linux 2.6.32-5-686 ehci_hcd
[    1.268799] usb usb3: SerialNumber: 0000:00:1d.7
[    1.268939] usb usb3: configuration #1 chosen from 1 choice
[    1.269034] hub 3-0:1.0: USB hub found
[    1.269100] hub 3-0:1.0: 6 ports detected
[    1.269230] uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level, low) -> I=
RQ 21
[    1.269306] uhci_hcd 0000:00:1a.1: setting latency timer to 64
[    1.269310] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    1.269383] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus =
number 4
[    1.269500] uhci_hcd 0000:00:1a.1: irq 21, io base 0x00001840
[    1.269597] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    1.269662] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.269739] usb usb4: Product: UHCI Host Controller
[    1.269801] usb usb4: Manufacturer: Linux 2.6.32-5-686 uhci_hcd
[    1.269864] usb usb4: SerialNumber: 0000:00:1a.1
[    1.269990] usb usb4: configuration #1 chosen from 1 choice
[    1.270077] hub 4-0:1.0: USB hub found
[    1.270142] hub 4-0:1.0: 2 ports detected
[    1.270256] ahci 0000:00:1f.2: version 3.0
[    1.270271] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    1.270389] ahci 0000:00:1f.2: irq 29 for MSI/MSI-X
[    1.270435] ahci: SSS flag set, parallel bus scan disabled
[    1.270536] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 4 ports 3 Gbps 0x=
3 impl SATA mode
[    1.270620] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pio=
 slum part ccc ems sxs=20
[    1.270705] ahci 0000:00:1f.2: setting latency timer to 64
[    1.278073] scsi0 : ahci
[    1.278313] scsi1 : ahci
[    1.278491] scsi2 : ahci
[    1.278676] scsi3 : ahci
[    1.278801] ata1: SATA max UDMA/133 abar m2048@0xf4a04000 port 0xf4a0410=
0 irq 29
[    1.278916] ata2: SATA max UDMA/133 abar m2048@0xf4a04000 port 0xf4a0418=
0 irq 29
[    1.279025] ata3: DUMMY
[    1.279127] ata4: DUMMY
[    1.279352] uhci_hcd 0000:00:1a.2: PCI INT C -> GSI 20 (level, low) -> I=
RQ 20
[    1.279462] uhci_hcd 0000:00:1a.2: setting latency timer to 64
[    1.279466] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[    1.279588] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus =
number 5
[    1.279737] uhci_hcd 0000:00:1a.2: irq 20, io base 0x00001860
[    1.279868] usb usb5: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    1.279987] usb usb5: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.280100] usb usb5: Product: UHCI Host Controller
[    1.280193] usb usb5: Manufacturer: Linux 2.6.32-5-686 uhci_hcd
[    1.280287] usb usb5: SerialNumber: 0000:00:1a.2
[    1.280516] usb usb5: configuration #1 chosen from 1 choice
[    1.280670] hub 5-0:1.0: USB hub found
[    1.280766] hub 5-0:1.0: 2 ports detected
[    1.280912] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> I=
RQ 23
[    1.281047] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[    1.281051] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    1.281153] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus =
number 6
[    1.281298] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00001880
[    1.281431] usb usb6: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    1.281499] usb usb6: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.281649] usb usb6: Product: UHCI Host Controller
[    1.281732] usb usb6: Manufacturer: Linux 2.6.32-5-686 uhci_hcd
[    1.281820] usb usb6: SerialNumber: 0000:00:1d.0
[    1.282024] usb usb6: configuration #1 chosen from 1 choice
[    1.282168] hub 6-0:1.0: USB hub found
[    1.282251] hub 6-0:1.0: 2 ports detected
[    1.282397] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> I=
RQ 19
[    1.282490] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[    1.282496] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    1.282585] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus =
number 7
[    1.282887] uhci_hcd 0000:00:1d.1: irq 19, io base 0x000018a0
[    1.283008] usb usb7: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    1.283093] usb usb7: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.283211] usb usb7: Product: UHCI Host Controller
[    1.283294] usb usb7: Manufacturer: Linux 2.6.32-5-686 uhci_hcd
[    1.283379] usb usb7: SerialNumber: 0000:00:1d.1
[    1.283567] usb usb7: configuration #1 chosen from 1 choice
[    1.283722] hub 7-0:1.0: USB hub found
[    1.283809] hub 7-0:1.0: 2 ports detected
[    1.283939] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> I=
RQ 18
[    1.284041] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[    1.284047] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    1.284136] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus =
number 8
[    1.284283] uhci_hcd 0000:00:1d.2: irq 18, io base 0x000018c0
[    1.284407] usb usb8: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    1.284497] usb usb8: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.284597] usb usb8: Product: UHCI Host Controller
[    1.284683] usb usb8: Manufacturer: Linux 2.6.32-5-686 uhci_hcd
[    1.284767] usb usb8: SerialNumber: 0000:00:1d.2
[    1.284957] usb usb8: configuration #1 chosen from 1 choice
[    1.285124] hub 8-0:1.0: USB hub found
[    1.285219] hub 8-0:1.0: 2 ports detected
[    1.309039] tg3 0000:07:00.0: eth0: Tigon3 [partno(BCM95906) rev c002] (=
PCI Express) MAC address 00:23:5a:17:01:6e
[    1.309124] tg3 0000:07:00.0: eth0: attached PHY is 5906 (10/100Base-TX =
Ethernet) (WireSpeed[0])
[    1.309204] tg3 0000:07:00.0: eth0: RXcsums[1] LinkChgREG[0] MIirq[0] AS=
F[0] TSOcap[1]
[    1.309283] tg3 0000:07:00.0: eth0: dma_rwctrl[76180000] dma_mask[64-bit]
[    1.560011] usb 1-6: new high speed USB device using ehci_hcd and addres=
s 2
[    1.604023] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.634280] ata1.00: ATA-8: WDC WD1600BEVT-88ZCT0, 11.01A11, max UDMA/133
[    1.634346] ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32=
), AA
[    1.635794] ata1.00: configured for UDMA/133
[    1.648108] scsi 0:0:0:0: Direct-Access     ATA      WDC WD1600BEVT-8 11=
.0 PQ: 0 ANSI: 5
[    1.692841] usb 1-6: New USB device found, idVendor=3D0781, idProduct=3D=
5567
[    1.692908] usb 1-6: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[    1.692973] usb 1-6: Product: Cruzer Blade
[    1.693034] usb 1-6: Manufacturer: SanDisk
[    1.693094] usb 1-6: SerialNumber: 20043513421424F00A4F
[    1.693220] usb 1-6: configuration #1 chosen from 1 choice
[    1.699899] Initializing USB Mass Storage driver...
[    1.700126] scsi4 : SCSI emulation for USB Mass Storage devices
[    1.700269] usbcore: registered new interface driver usb-storage
[    1.700336] USB Mass Storage support registered.
[    1.700401] usb-storage: device found at 2
[    1.700403] usb-storage: waiting for device to settle before scanning
[    1.808012] usb 3-3: new high speed USB device using ehci_hcd and addres=
s 2
[    2.096917] usb 3-3: New USB device found, idVendor=3D04f2, idProduct=3D=
b090
[    2.097732] usb 3-3: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    2.097798] usb 3-3: Product: Lenovo EasyCamera
[    2.097858] usb 3-3: Manufacturer: Vimicro Corp.
[    2.097990] usb 3-3: configuration #1 chosen from 1 choice
[    2.372024] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.375654] ata2.00: ATAPI: HL-DT-ST DVDRAM GSA-T50N, RV06, max UDMA/133
[    2.380404] ata2.00: configured for UDMA/133
[    2.508133] scsi 1:0:0:0: CD-ROM            HL-DT-ST DVDRAM GSA-T50N  RV=
06 PQ: 0 ANSI: 5
[    2.519189] sd 0:0:0:0: [sda] 312581808 512-byte logical blocks: (160 GB=
/149 GiB)
[    2.519319] sd 0:0:0:0: [sda] Write Protect is off
[    2.519383] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.519414] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    2.519633]  sda: sda1 sda2 < sda5 > sda3
[    2.555050] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.844888] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 =
cdda tray
[    2.844968] Uniform CD-ROM driver Revision: 3.20
[    2.845118] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    2.850772] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.850997] sr 1:0:0:0: Attached scsi generic sg1 type 5
[    6.696097] usb-storage: device scan complete
[    6.696722] scsi 4:0:0:0: Direct-Access     SanDisk  Cruzer Blade     1.=
14 PQ: 0 ANSI: 2
[    6.697289] sd 4:0:0:0: Attached scsi generic sg2 type 0
[    6.699344] sd 4:0:0:0: [sdb] 7821312 512-byte logical blocks: (4.00 GB/=
3.72 GiB)
[    6.700455] sd 4:0:0:0: [sdb] Write Protect is off
[    6.700517] sd 4:0:0:0: [sdb] Mode Sense: 03 00 00 00
[    6.700519] sd 4:0:0:0: [sdb] Assuming drive cache: write through
[    6.703078] sd 4:0:0:0: [sdb] Assuming drive cache: write through
[    6.703144]  sdb: sdb1 sdb2 sdb3
[    6.708590] sd 4:0:0:0: [sdb] Assuming drive cache: write through
[    6.708660] sd 4:0:0:0: [sdb] Attached SCSI removable disk
[    6.995000] EXT4-fs (sdb1): mounted filesystem with ordered data mode
[    7.639960] udev[427]: starting version 164
[    7.763694] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0=
D:00/input/input1
[    7.763865] ACPI: Lid Switch [LID0]
[    7.763986] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input2
[    7.764070] ACPI: Power Button [PWRB]
[    7.764203] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input3
[    7.764285] ACPI: Power Button [PWRF]
[    7.781180] ACPI: SSDT bdb1ac20 00265 (v01  PmRef  Cpu0Ist 00003000 INTL=
 20050624)
[    7.781853] ACPI: SSDT bdb18620 00549 (v01  PmRef  Cpu0Cst 00003001 INTL=
 20050624)
[    7.852398] Monitor-Mwait will be used to enter C-1 state
[    7.854611] Monitor-Mwait will be used to enter C-2 state
[    7.854624] Marking TSC unstable due to TSC halts in idle
[    7.854791] processor LNXCPU:00: registered as cooling_device0
[    7.855374] ACPI: SSDT bdb19ca0 001CF (v01  PmRef    ApIst 00003000 INTL=
 20050624)
[    7.855987] ACPI: SSDT bdb19f20 0008D (v01  PmRef    ApCst 00003000 INTL=
 20050624)
[    7.857122] Switching to clocksource hpet
[    7.857306] processor LNXCPU:01: registered as cooling_device1
[    7.858634] lib80211: common routines for IEEE802.11 drivers
[    7.858701] lib80211_crypt: registered algorithm 'NULL'
[    8.562616] wl: module license 'MIXED/Proprietary' taints kernel.
[    8.562685] Disabling lock debugging due to kernel taint
[    8.569048] wl 0000:04:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[    8.569163] wl 0000:04:00.0: setting latency timer to 64
[    8.576218] input: PC Speaker as /devices/platform/pcspkr/input/input4
[    8.593068] i801_smbus 0000:00:1f.3: PCI INT C -> GSI 19 (level, low) ->=
 IRQ 19
[    8.593155] ACPI: I/O resource 0000:00:1f.3 [0x1c00-0x1c1f] conflicts wi=
th ACPI region SMBI [0x1c00-0x1c0f]
[    8.593237] ACPI: If an ACPI driver is available for this device, you sh=
ould use it instead of the native driver
[    8.595752] ACPI: AC Adapter [ACAD] (on-line)
[    8.635487] lib80211_crypt: registered algorithm 'TKIP'
[    8.770035] ACPI: Battery Slot [BAT1] (battery present)
[    8.770506] eth1: Broadcom BCM4315 802.11 Hybrid Wireless Controller 5.6=
0.48.36=20
[    8.779162] Linux video capture interface: v2.00
[    8.781343] jmb38x_ms 0000:02:00.3: PCI INT A -> GSI 16 (level, low) -> =
IRQ 16
[    8.781432] jmb38x_ms 0000:02:00.3: setting latency timer to 64
[    8.825096] [drm] Initialized drm 1.1.0 20060810
[    8.827153] uvcvideo: Found UVC 1.00 device Lenovo EasyCamera (04f2:b090)
[    8.830393] input: Lenovo EasyCamera as /devices/pci0000:00/0000:00:1d.7=
/usb3/3-3/3-3:1.0/input/input5
[    8.830589] usbcore: registered new interface driver uvcvideo
[    8.830712] USB Video Class driver (v0.1.0)
[    8.872716] pci 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    8.872790] pci 0000:00:02.0: setting latency timer to 64
[    8.878968] mtrr: type mismatch for d0000000,10000000 old: write-back ne=
w: write-combining
[    8.879055] [drm] MTRR allocation failed.  Graphics performance may suff=
er.
[    8.879181] pci 0000:00:02.0: irq 30 for MSI/MSI-X
[    8.901986] acpi device:05: registered as cooling_device2
[    8.920841] acpi device:06: registered as cooling_device3
[    8.944990] acpi device:07: registered as cooling_device4
[    8.970986] HDA Intel 0000:00:1b.0: power state changed by ACPI to D0
[    8.971036] acpi device:08: registered as cooling_device5
[    8.971225] HDA Intel 0000:00:1b.0: power state changed by ACPI to D0
[    8.971305] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> =
IRQ 22
[    8.971587] HDA Intel 0000:00:1b.0: irq 31 for MSI/MSI-X
[    8.971617] HDA Intel 0000:00:1b.0: setting latency timer to 64
[    8.990081] acpi device:09: registered as cooling_device6
[    8.990263] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/LNXVIDEO:01/input/input6
[    8.990393] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: n=
o)
[    8.990485] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on mi=
nor 0
[    9.034380] input: HDA Intel Mic as /devices/pci0000:00/0000:00:1b.0/sou=
nd/card0/input7
[    9.034545] input: HDA Intel Mic as /devices/pci0000:00/0000:00:1b.0/sou=
nd/card0/input8
[    9.034689] input: HDA Intel Headphone as /devices/pci0000:00/0000:00:1b=
.0/sound/card0/input9
[    9.284357] input: PS/2 Mouse as /devices/platform/i8042/serio1/input/in=
put10
[    9.322269] input: AlpsPS/2 ALPS GlidePoint as /devices/platform/i8042/s=
erio1/input/input11
[    9.585493] Adding 208836k swap on /dev/sdb3.  Priority:-1 extents:1 acr=
oss:208836k=20
[    9.729444] loop: module loaded
[    9.750931] input: Speakup as /devices/virtual/input/input12
[    9.752709] speakup 3.1.5: initialized
[    9.752785] synth name on entry is: <NULL>
[    9.754372] initialized device: /dev/synth, node (MAJOR 10, MINOR 25)
[    9.756787] synth probe
[    9.756925] initialized device: /dev/softsynth, node (MAJOR 10, MINOR 26)
[    9.898822] EXT4-fs (sdb2): mounted filesystem with ordered data mode
[   10.289660] fuse init (API version 7.13)
[   10.912969] apm: BIOS not found.
[   11.715232] Bluetooth: Core ver 2.15
[   11.715299] NET: Registered protocol family 31
[   11.715301] Bluetooth: HCI device and connection manager initialized
[   11.715304] Bluetooth: HCI socket layer initialized
[   11.735663] input: ACPI Virtual Keyboard Device as /devices/virtual/inpu=
t/input13
[   11.737433] lp: driver loaded but no devices found
[   11.797130] ppdev: user-space parallel port driver
[   11.863763] Bluetooth: L2CAP ver 2.14
[   11.863766] Bluetooth: L2CAP socket layer initialized
[   11.941234] Bluetooth: RFCOMM TTY layer initialized
[   11.941239] Bluetooth: RFCOMM socket layer initialized
[   11.941241] Bluetooth: RFCOMM ver 1.11
[   11.999825] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   11.999924] Bluetooth: BNEP filters: protocol multicast
[   12.057185] Bridge firewalling registered
[   12.268960] Bluetooth: SCO (Voice Link) ver 0.6
[   12.269126] Bluetooth: SCO socket layer initialized
[   12.308601] tg3 0000:07:00.0: irq 32 for MSI/MSI-X
[   12.345810] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   21.928035] eth1: no IPv6 routers present

Do you find anything, Bruno?

Thank you!

David

On Sun, 13 Nov 2011, Bruno Pr=E9mont wrote:

> On Sun, 13 November 2011 Anatolij Gustschin <agust@denx.de> wrote:
>> On Sun, 13 Nov 2011 21:16:52 -0500 (EST)
>> David J Ring Jr <n1ea@arrl.net> wrote:
>>
>>> OK so how do I get a frame buffer driver loaded?
>>
>> Check if some frame buffer drivers are installed
>> in your system, so e.g. run
>>
>> ls /lib/modules/`uname -r`/kernel/drivers/video
>>
>> to see if there are any frame buffer driver modules
>> installed.
>>
>> Then you have to select the suitable driver for your
>> graphic card and load it by running
>>
>> modprobe drivername
>>
>>> I don't have any backlisted framebuffer drivers, what is stopping me fr=
om
>>> loading a frame buffer driver?
>>>
>>> Does anyone know what I have to do?
>>
>>
>> Usually the driver should be loaded automatically if
>> it is installed. Maybe some error happened while loading
>> the driver. Dump the kernel log messages by running dmesg
>> and check if there was an attempt to load the driver for
>> your graphic card.
>
> The other case might be a mainsteam GPU (radeon, nouveau, intel) and
> KMS support built in (or available as module) but disabled by "nomodeset"
> cmdline option that did show up in a previous post.
>
> Just booting with "vga=3D0x31a" (or another value more appropriate for
> attached screen -- see Documentation/fb/vesafb.txt for list) might
> provide a basic framebuffer device.
>
> lspci for the affected system will certainly help at least indicating
> which driver would be the right one.
>
> Bruno
>
--8323328-373814776-1321242484=:2152--
