From: David J Ring Jr <n1ea@arrl.net>
Date: Mon, 14 Nov 2011 21:50:37 +0000
Subject: Re: Getting FB to work in Console
Message-Id: <alpine.DEB.2.00.1111142146520.8842@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8323328-132040354-1321325380=:8842"
List-Id: <linux-fbdev.vger.kernel.org>
References: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
In-Reply-To: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
To: linux-fbdev@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-132040354-1321325380=:8842
Content-Type: TEXT/PLAIN; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Hello Bruno and Anatolij -- and everyone who is helping or reading!

Anatolij,  I forgot to say I did run sudo update-grub, but still no=20
framebuffer.

Bruno, there is nothing in GRUB when I edit the commandline that has=20
anythhing to do with video or nomodeset.

Here is my kernel log for the last boot.

I am using a USB stick only - it is /dev/sda and it has / on /dev/sda1 and =

/home on /dev/sda2

Nov 14 21:30:57 vinux kernel: imklog 4.6.4, log source =3D /proc/kmsg start=
ed.
Nov 14 21:30:57 vinux kernel: [    0.000000] Initializing cgroup subsys cpu=
set
Nov 14 21:30:57 vinux kernel: [    0.000000] Initializing cgroup subsys cpu
Nov 14 21:30:57 vinux kernel: [    0.000000] Linux version 2.6.32-5-686 (De=
bian 2.6.32-38) (ben@decadent.org.uk) (gcc version 4.3.5 (Debian 4.3.5-4) )=
 #1 SMP Mon Oct 3 04:15:24 UTC 2011
Nov 14 21:30:57 vinux kernel: [    0.000000] KERNEL supported cpus:
Nov 14 21:30:57 vinux kernel: [    0.000000]   Intel GenuineIntel
Nov 14 21:30:57 vinux kernel: [    0.000000]   AMD AuthenticAMD
Nov 14 21:30:57 vinux kernel: [    0.000000]   NSC Geode by NSC
Nov 14 21:30:57 vinux kernel: [    0.000000]   Cyrix CyrixInstead
Nov 14 21:30:57 vinux kernel: [    0.000000]   Centaur CentaurHauls
Nov 14 21:30:57 vinux kernel: [    0.000000]   Transmeta GenuineTMx86
Nov 14 21:30:57 vinux kernel: [    0.000000]   Transmeta TransmetaCPU
Nov 14 21:30:57 vinux kernel: [    0.000000]   UMC UMC UMC UMC
Nov 14 21:30:57 vinux kernel: [    0.000000] BIOS-provided physical RAM map:
Nov 14 21:30:57 vinux kernel: [    0.000000]  BIOS-e820: 0000000000000000 -=
 000000000009f400 (usable)
Nov 14 21:30:57 vinux kernel: [    0.000000]  BIOS-e820: 000000000009f400 -=
 00000000000a0000 (reserved)
Nov 14 21:30:57 vinux kernel: [    0.000000]  BIOS-e820: 00000000000d2000 -=
 00000000000d4000 (reserved)
Nov 14 21:30:57 vinux kernel: [    0.000000]  BIOS-e820: 00000000000dc000 -=
 0000000000100000 (reserved)
Nov 14 21:30:57 vinux kernel: [    0.000000]  BIOS-e820: 0000000000100000 -=
 00000000bd6b3000 (usable)
Nov 14 21:30:57 vinux kernel: [    0.000000]  BIOS-e820: 00000000bd6b3000 -=
 00000000bd6b9000 (reserved)
Nov 14 21:30:57 vinux kernel: [    0.000000]  BIOS-e820: 00000000bd6b9000 -=
 00000000bd7b2000 (usable)
Nov 14 21:30:57 vinux kernel: [    0.000000]  BIOS-e820: 00000000bd7b2000 -=
 00000000bd80f000 (reserved)
Nov 14 21:30:57 vinux kernel: [    0.000000]  BIOS-e820: 00000000bd80f000 -=
 00000000bd907000 (usable)
Nov 14 21:30:57 vinux kernel: [    0.000000]  BIOS-e820: 00000000bd907000 -=
 00000000bdb0f000 (reserved)
Nov 14 21:30:57 vinux kernel: [    0.000000]  BIOS-e820: 00000000bdb0f000 -=
 00000000bdb18000 (usable)
Nov 14 21:30:57 vinux kernel: [    0.000000]  BIOS-e820: 00000000bdb18000 -=
 00000000bdb1f000 (reserved)
Nov 14 21:30:57 vinux kernel: [    0.000000]  BIOS-e820: 00000000bdb1f000 -=
 00000000bdb63000 (usable)
Nov 14 21:30:57 vinux kernel: [    0.000000]  BIOS-e820: 00000000bdb63000 -=
 00000000bdb9f000 (ACPI NVS)
Nov 14 21:30:57 vinux kernel: [    0.000000]  BIOS-e820: 00000000bdb9f000 -=
 00000000bdc00000 (ACPI data)
Nov 14 21:30:57 vinux kernel: [    0.000000]  BIOS-e820: 0000000100000000 -=
 0000000140000000 (usable)
Nov 14 21:30:57 vinux kernel: [    0.000000] DMI present.
Nov 14 21:30:57 vinux kernel: [    0.000000] last_pfn =3D 0xbdb63 max_arch_=
pfn =3D 0x100000
Nov 14 21:30:57 vinux kernel: [    0.000000] MTRR default type: uncachable
Nov 14 21:30:57 vinux kernel: [    0.000000] MTRR fixed ranges enabled:
Nov 14 21:30:57 vinux kernel: [    0.000000]   00000-9FFFF write-back
Nov 14 21:30:57 vinux kernel: [    0.000000]   A0000-BFFFF uncachable
Nov 14 21:30:57 vinux kernel: [    0.000000]   C0000-FFFFF write-protect
Nov 14 21:30:57 vinux kernel: [    0.000000] MTRR variable ranges enabled:
Nov 14 21:30:57 vinux kernel: [    0.000000]   0 base 0C0000000 mask FC0000=
000 uncachable
Nov 14 21:30:57 vinux kernel: [    0.000000]   1 base 000000000 mask F00000=
000 write-back
Nov 14 21:30:57 vinux kernel: [    0.000000]   2 base 100000000 mask FC0000=
000 write-back
Nov 14 21:30:57 vinux kernel: [    0.000000]   3 base 0BDC00000 mask FFFC00=
000 uncachable
Nov 14 21:30:57 vinux kernel: [    0.000000]   4 disabled
Nov 14 21:30:57 vinux kernel: [    0.000000]   5 disabled
Nov 14 21:30:57 vinux kernel: [    0.000000]   6 disabled
Nov 14 21:30:57 vinux kernel: [    0.000000]   7 disabled
Nov 14 21:30:57 vinux kernel: [    0.000000] x86 PAT enabled: cpu 0, old 0x=
7040600070406, new 0x7010600070106
Nov 14 21:30:57 vinux kernel: [    0.000000] e820 update range: 00000000bdc=
00000 - 00000000be000000 (usable) =3D=3D> (reserved)
Nov 14 21:30:57 vinux kernel: [    0.000000] e820 update range: 00000000c00=
00000 - 0000000100000000 (usable) =3D=3D> (reserved)
Nov 14 21:30:57 vinux kernel: [    0.000000] initial memory mapped : 0 - 01=
800000
Nov 14 21:30:57 vinux kernel: [    0.000000] init_memory_mapping: 000000000=
0000000-00000000373fe000
Nov 14 21:30:57 vinux kernel: [    0.000000]  0000000000 - 0000400000 page =
4k
Nov 14 21:30:57 vinux kernel: [    0.000000]  0000400000 - 0037000000 page =
2M
Nov 14 21:30:57 vinux kernel: [    0.000000]  0037000000 - 00373fe000 page =
4k
Nov 14 21:30:57 vinux kernel: [    0.000000] kernel direct mapping tables u=
p to 373fe000 @ 7000-d000
Nov 14 21:30:57 vinux kernel: [    0.000000] RAMDISK: 3759a000 - 37fef5a8
Nov 14 21:30:57 vinux kernel: [    0.000000] Allocated new RAMDISK: 0010000=
0 - 00b555a8
Nov 14 21:30:57 vinux kernel: [    0.000000] Move RAMDISK from 000000003759=
a000 - 0000000037fef5a7 to 00100000 - 00b555a7
Nov 14 21:30:57 vinux kernel: [    0.000000] ACPI: RSDP 000f7190 00024 (v02=
 LENOVO)
Nov 14 21:30:57 vinux kernel: [    0.000000] ACPI: XSDT bdbf6067 0006C (v01=
 LENOVO TP-6G    00000000  LTP 00000000)
Nov 14 21:30:57 vinux kernel: [    0.000000] ACPI: FACP bdbe8000 000F4 (v03=
 LENOVO TP-6G    00000001 ALAN 00000001)
Nov 14 21:30:57 vinux kernel: [    0.000000] ACPI: DSDT bdbe9000 06B23 (v02=
 LENOVO TP-6G    00000001 INTL 20050624)
Nov 14 21:30:57 vinux kernel: [    0.000000] ACPI: FACS bdb9efc0 00040
Nov 14 21:30:57 vinux kernel: [    0.000000] ACPI: HPET bdbfcd86 00038 (v01=
 LENOVO TP-6G    00000001 LOHR 0000005A)
Nov 14 21:30:57 vinux kernel: [    0.000000] ACPI: MCFG bdbfcdbe 0003C (v01=
 LENOVO TP-6G    00000001 LOHR 0000005A)
Nov 14 21:30:57 vinux kernel: [    0.000000] ACPI: SLIC bdbfcdfa 00176 (v01=
 LENOVO TP-6G    00000001 TBD  00000001)
Nov 14 21:30:57 vinux kernel: [    0.000000] ACPI: APIC bdbfcf70 00068 (v01=
 PTLTD  ? APIC   00000000  LTP 00000000)
Nov 14 21:30:57 vinux kernel: [    0.000000] ACPI: BOOT bdbfcfd8 00028 (v01=
 PTLTD  $SBFTBL$ 00000000  LTP 00000001)
Nov 14 21:30:57 vinux kernel: [    0.000000] ACPI: SSDT bdbe7000 00655 (v01=
  PmRef    CpuPm 00003000 INTL 20050624)
Nov 14 21:30:57 vinux kernel: [    0.000000] ACPI: SSDT bdbe6000 00259 (v01=
  PmRef  Cpu0Tst 00003000 INTL 20050624)
Nov 14 21:30:57 vinux kernel: [    0.000000] ACPI: SSDT bdbe5000 0020F (v01=
  PmRef    ApTst 00003000 INTL 20050624)
Nov 14 21:30:57 vinux kernel: [    0.000000] ACPI: Local APIC address 0xfee=
00000
Nov 14 21:30:57 vinux kernel: [    0.000000] 2151MB HIGHMEM available.
Nov 14 21:30:57 vinux kernel: [    0.000000] 883MB LOWMEM available.
Nov 14 21:30:57 vinux kernel: [    0.000000]   mapped low ram: 0 - 373fe000
Nov 14 21:30:57 vinux kernel: [    0.000000]   low ram: 0 - 373fe000
Nov 14 21:30:57 vinux kernel: [    0.000000]   node 0 low ram: 00000000 - 3=
73fe000
Nov 14 21:30:57 vinux kernel: [    0.000000]   node 0 bootmap 00009000 - 00=
00fe80
Nov 14 21:30:57 vinux kernel: [    0.000000] (9 early reservations) =3D=3D>=
 bootmem [0000000000 - 00373fe000]
Nov 14 21:30:57 vinux kernel: [    0.000000]   #0 [0000000000 - 0000001000]=
   BIOS data page =3D=3D> [0000000000 - 0000001000]
Nov 14 21:30:57 vinux kernel: [    0.000000]   #1 [0000001000 - 0000002000]=
    EX TRAMPOLINE =3D=3D> [0000001000 - 0000002000]
Nov 14 21:30:57 vinux kernel: [    0.000000]   #2 [0000006000 - 0000007000]=
       TRAMPOLINE =3D=3D> [0000006000 - 0000007000]
Nov 14 21:30:57 vinux kernel: [    0.000000]   #3 [0001000000 - 00014cccf4]=
    TEXT DATA BSS =3D=3D> [0001000000 - 00014cccf4]
Nov 14 21:30:57 vinux kernel: [    0.000000]   #4 [000009f400 - 0000100000]=
    BIOS reserved =3D=3D> [000009f400 - 0000100000]
Nov 14 21:30:57 vinux kernel: [    0.000000]   #5 [00014cd000 - 00014d3184]=
              BRK =3D=3D> [00014cd000 - 00014d3184]
Nov 14 21:30:57 vinux kernel: [    0.000000]   #6 [0000007000 - 0000009000]=
          PGTABLE =3D=3D> [0000007000 - 0000009000]
Nov 14 21:30:57 vinux kernel: [    0.000000]   #7 [0000100000 - 0000b555a8]=
      NEW RAMDISK =3D=3D> [0000100000 - 0000b555a8]
Nov 14 21:30:57 vinux kernel: [    0.000000]   #8 [0000009000 - 0000010000]=
          BOOTMAP =3D=3D> [0000009000 - 0000010000]
Nov 14 21:30:57 vinux kernel: [    0.000000] found SMP MP-table at [c00f723=
0] f7230
Nov 14 21:30:57 vinux kernel: [    0.000000] Zone PFN ranges:
Nov 14 21:30:57 vinux kernel: [    0.000000]   DMA      0x00000000 -> 0x000=
01000
Nov 14 21:30:57 vinux kernel: [    0.000000]   Normal   0x00001000 -> 0x000=
373fe
Nov 14 21:30:57 vinux kernel: [    0.000000]   HighMem  0x000373fe -> 0x000=
bdb63
Nov 14 21:30:57 vinux kernel: [    0.000000] Movable zone start PFN for eac=
h node
Nov 14 21:30:57 vinux kernel: [    0.000000] early_node_map[6] active PFN r=
anges
Nov 14 21:30:57 vinux kernel: [    0.000000]     0: 0x00000000 -> 0x0000009f
Nov 14 21:30:57 vinux kernel: [    0.000000]     0: 0x00000100 -> 0x000bd6b3
Nov 14 21:30:57 vinux kernel: [    0.000000]     0: 0x000bd6b9 -> 0x000bd7b2
Nov 14 21:30:57 vinux kernel: [    0.000000]     0: 0x000bd80f -> 0x000bd907
Nov 14 21:30:57 vinux kernel: [    0.000000]     0: 0x000bdb0f -> 0x000bdb18
Nov 14 21:30:57 vinux kernel: [    0.000000]     0: 0x000bdb1f -> 0x000bdb63
Nov 14 21:30:57 vinux kernel: [    0.000000] On node 0 totalpages: 776336
Nov 14 21:30:57 vinux kernel: [    0.000000] free_area_init_node: node 0, p=
gdat c13b4860, node_mem_map c14d5000
Nov 14 21:30:57 vinux kernel: [    0.000000]   DMA zone: 32 pages used for =
memmap
Nov 14 21:30:57 vinux kernel: [    0.000000]   DMA zone: 0 pages reserved
Nov 14 21:30:57 vinux kernel: [    0.000000]   DMA zone: 3967 pages, LIFO b=
atch:0
Nov 14 21:30:57 vinux kernel: [    0.000000]   Normal zone: 1736 pages used=
 for memmap
Nov 14 21:30:57 vinux kernel: [    0.000000]   Normal zone: 220470 pages, L=
IFO batch:31
Nov 14 21:30:57 vinux kernel: [    0.000000]   HighMem zone: 4303 pages use=
d for memmap
Nov 14 21:30:57 vinux kernel: [    0.000000]   HighMem zone: 545828 pages, =
LIFO batch:31
Nov 14 21:30:57 vinux kernel: [    0.000000] Using APIC driver default
Nov 14 21:30:57 vinux kernel: [    0.000000] ACPI: PM-Timer IO Port: 0x408
Nov 14 21:30:57 vinux kernel: [    0.000000] ACPI: Local APIC address 0xfee=
00000
Nov 14 21:30:57 vinux kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x00] lap=
ic_id[0x00] enabled)
Nov 14 21:30:57 vinux kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x01] lap=
ic_id[0x01] enabled)
Nov 14 21:30:57 vinux kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00]=
 high edge lint[0x1])
Nov 14 21:30:57 vinux kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01]=
 high edge lint[0x1])
Nov 14 21:30:57 vinux kernel: [    0.000000] ACPI: IOAPIC (id[0x02] address=
[0xfec00000] gsi_base[0])
Nov 14 21:30:57 vinux kernel: [    0.000000] IOAPIC[0]: apic_id 2, version =
32, address 0xfec00000, GSI 0-23
Nov 14 21:30:57 vinux kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_i=
rq 0 global_irq 2 high edge)
Nov 14 21:30:57 vinux kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_i=
rq 9 global_irq 9 high level)
Nov 14 21:30:57 vinux kernel: [    0.000000] ACPI: IRQ0 used by override.
Nov 14 21:30:57 vinux kernel: [    0.000000] ACPI: IRQ2 used by override.
Nov 14 21:30:57 vinux kernel: [    0.000000] ACPI: IRQ9 used by override.
Nov 14 21:30:57 vinux kernel: [    0.000000] Using ACPI (MADT) for SMP conf=
iguration information
Nov 14 21:30:57 vinux kernel: [    0.000000] ACPI: HPET id: 0x8086a201 base=
: 0xfed00000
Nov 14 21:30:57 vinux kernel: [    0.000000] SMP: Allowing 2 CPUs, 0 hotplu=
g CPUs
Nov 14 21:30:57 vinux kernel: [    0.000000] nr_irqs_gsi: 24
Nov 14 21:30:57 vinux kernel: [    0.000000] PM: Registered nosave memory: =
000000000009f000 - 00000000000a0000
Nov 14 21:30:57 vinux kernel: [    0.000000] PM: Registered nosave memory: =
00000000000a0000 - 00000000000d2000
Nov 14 21:30:57 vinux kernel: [    0.000000] PM: Registered nosave memory: =
00000000000d2000 - 00000000000d4000
Nov 14 21:30:57 vinux kernel: [    0.000000] PM: Registered nosave memory: =
00000000000d4000 - 00000000000dc000
Nov 14 21:30:57 vinux kernel: [    0.000000] PM: Registered nosave memory: =
00000000000dc000 - 0000000000100000
Nov 14 21:30:57 vinux kernel: [    0.000000] Allocating PCI resources start=
ing at bdc00000 (gap: bdc00000:42400000)
Nov 14 21:30:57 vinux kernel: [    0.000000] Booting paravirtualized kernel=
 on bare hardware
Nov 14 21:30:57 vinux kernel: [    0.000000] NR_CPUS:32 nr_cpumask_bits:32 =
nr_cpu_ids:2 nr_node_ids:1
Nov 14 21:30:57 vinux kernel: [    0.000000] PERCPU: Embedded 14 pages/cpu =
@c3000000 s34328 r0 d23016 u2097152
Nov 14 21:30:57 vinux kernel: [    0.000000] pcpu-alloc: s34328 r0 d23016 u=
2097152 alloc=3D1*4194304
Nov 14 21:30:57 vinux kernel: [    0.000000] pcpu-alloc: [0] 0 1=20
Nov 14 21:30:57 vinux kernel: [    0.000000] Built 1 zonelists in Zone orde=
r, mobility grouping on.  Total pages: 770265
Nov 14 21:30:57 vinux kernel: [    0.000000] Kernel command line: BOOT_IMAG=
E=3D/boot/vmlinuz-2.6.32-5-686 root=3DUUID=3Dcb1268f1-4e20-4409-87b1-3d882c=
14102c ro
Nov 14 21:30:57 vinux kernel: [    0.000000] PID hash table entries: 4096 (=
order: 2, 16384 bytes)
Nov 14 21:30:57 vinux kernel: [    0.000000] Dentry cache hash table entrie=
s: 131072 (order: 7, 524288 bytes)
Nov 14 21:30:57 vinux kernel: [    0.000000] Inode-cache hash table entries=
: 65536 (order: 6, 262144 bytes)
Nov 14 21:30:57 vinux kernel: [    0.000000] Enabling fast FPU save and res=
tore... done.
Nov 14 21:30:57 vinux kernel: [    0.000000] Enabling unmasked SIMD FPU exc=
eption support... done.
Nov 14 21:30:57 vinux kernel: [    0.000000] Initializing CPU#0
Nov 14 21:30:57 vinux kernel: [    0.000000] Initializing HighMem for node =
0 (000373fe:000bdb63)
Nov 14 21:30:57 vinux kernel: [    0.000000] Memory: 3063500k/3108236k avai=
lable (2504k kernel code, 40824k reserved, 1328k data, 380k init, 2200524k =
highmem)
Nov 14 21:30:57 vinux kernel: [    0.000000] virtual kernel memory layout:
Nov 14 21:30:57 vinux kernel: [    0.000000]     fixmap  : 0xffd56000 - 0xf=
ffff000   (2724 kB)
Nov 14 21:30:57 vinux kernel: [    0.000000]     pkmap   : 0xff400000 - 0xf=
f800000   (4096 kB)
Nov 14 21:30:57 vinux kernel: [    0.000000]     vmalloc : 0xf7bfe000 - 0xf=
f3fe000   ( 120 MB)
Nov 14 21:30:57 vinux kernel: [    0.000000]     lowmem  : 0xc0000000 - 0xf=
73fe000   ( 883 MB)
Nov 14 21:30:57 vinux kernel: [    0.000000]       .init : 0xc13bf000 - 0xc=
141e000   ( 380 kB)
Nov 14 21:30:57 vinux kernel: [    0.000000]       .data : 0xc12721f1 - 0xc=
13be480   (1328 kB)
Nov 14 21:30:57 vinux kernel: [    0.000000]       .text : 0xc1000000 - 0xc=
12721f1   (2504 kB)
Nov 14 21:30:57 vinux kernel: [    0.000000] Checking if this processor hon=
ours the WP bit even in supervisor mode...Ok.
Nov 14 21:30:57 vinux kernel: [    0.000000] SLUB: Genslabs=3D13, HWalign=
=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D2, Nodes=3D1
Nov 14 21:30:57 vinux kernel: [    0.000000] Hierarchical RCU implementatio=
n.
Nov 14 21:30:57 vinux kernel: [    0.000000] NR_IRQS:1280
Nov 14 21:30:57 vinux kernel: [    0.000000] Extended CMOS year: 2000
Nov 14 21:30:57 vinux kernel: [    0.000000] Console: colour VGA+ 80x25
Nov 14 21:30:57 vinux kernel: [    0.000000] console [tty0] enabled
Nov 14 21:30:57 vinux kernel: [    0.000000] hpet clockevent registered
Nov 14 21:30:57 vinux kernel: [    0.000000] Fast TSC calibration using PIT
Nov 14 21:30:57 vinux kernel: [    0.000000] Detected 2161.220 MHz processo=
r.
Nov 14 21:30:57 vinux kernel: [    0.004004] Calibrating delay loop (skippe=
d), value calculated using timer frequency.. 4322.44 BogoMIPS (lpj=3D864488=
0)
Nov 14 21:30:57 vinux kernel: [    0.004139] Security Framework initialized
Nov 14 21:30:57 vinux kernel: [    0.004202] SELinux:  Disabled at boot.
Nov 14 21:30:57 vinux kernel: [    0.004266] Mount-cache hash table entries=
: 512
Nov 14 21:30:57 vinux kernel: [    0.004439] Initializing cgroup subsys ns
Nov 14 21:30:57 vinux kernel: [    0.004501] Initializing cgroup subsys cpu=
acct
Nov 14 21:30:57 vinux kernel: [    0.004563] Initializing cgroup subsys dev=
ices
Nov 14 21:30:57 vinux kernel: [    0.004623] Initializing cgroup subsys fre=
ezer
Nov 14 21:30:57 vinux kernel: [    0.004684] Initializing cgroup subsys net=
_cls
Nov 14 21:30:57 vinux kernel: [    0.004765] CPU: L1 I cache: 32K, L1 D cac=
he: 32K
Nov 14 21:30:57 vinux kernel: [    0.004867] CPU: L2 cache: 1024K
Nov 14 21:30:57 vinux kernel: [    0.004927] CPU: Physical Processor ID: 0
Nov 14 21:30:57 vinux kernel: [    0.004986] CPU: Processor Core ID: 0
Nov 14 21:30:57 vinux kernel: [    0.005048] mce: CPU supports 6 MCE banks
Nov 14 21:30:57 vinux kernel: [    0.005114] CPU0: Thermal monitoring enabl=
ed (TM2)
Nov 14 21:30:57 vinux kernel: [    0.005176] using mwait in idle threads.
Nov 14 21:30:57 vinux kernel: [    0.005240] Performance Events: Core2 even=
ts, Intel PMU driver.
Nov 14 21:30:57 vinux kernel: [    0.005389] ... version:                2
Nov 14 21:30:57 vinux kernel: [    0.005448] ... bit width:              40
Nov 14 21:30:57 vinux kernel: [    0.008005] ... generic registers:      2
Nov 14 21:30:57 vinux kernel: [    0.008064] ... value mask:             00=
0000ffffffffff
Nov 14 21:30:57 vinux kernel: [    0.008126] ... max period:             00=
0000007fffffff
Nov 14 21:30:57 vinux kernel: [    0.008187] ... fixed-purpose events:   3
Nov 14 21:30:57 vinux kernel: [    0.008247] ... event mask:             00=
00000700000003
Nov 14 21:30:57 vinux kernel: [    0.008311] Checking 'hlt' instruction... =
OK.
Nov 14 21:30:57 vinux kernel: [    0.025104] ACPI: Core revision 20090903
Nov 14 21:30:57 vinux kernel: [    0.036059] Enabling APIC mode:  Flat.  Us=
ing 1 I/O APICs
Nov 14 21:30:57 vinux kernel: [    0.036511] ..TIMER: vector=3D0x30 apic1=
=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
Nov 14 21:30:57 vinux kernel: [    0.079757] CPU0: Intel(R) Pentium(R) Dual=
  CPU  T3400  @ 2.16GHz stepping 0d
Nov 14 21:30:57 vinux kernel: [    0.080001] Booting processor 1 APIC 0x1 i=
p 0x6000
Nov 14 21:30:57 vinux kernel: [    0.008000] Initializing CPU#1
Nov 14 21:30:57 vinux kernel: [    0.008000] CPU: L1 I cache: 32K, L1 D cac=
he: 32K
Nov 14 21:30:57 vinux kernel: [    0.008000] CPU: L2 cache: 1024K
Nov 14 21:30:57 vinux kernel: [    0.008000] CPU: Physical Processor ID: 0
Nov 14 21:30:57 vinux kernel: [    0.008000] CPU: Processor Core ID: 1
Nov 14 21:30:57 vinux kernel: [    0.008000] CPU1: Thermal monitoring enabl=
ed (TM2)
Nov 14 21:30:57 vinux kernel: [    0.164086] CPU1: Intel(R) Pentium(R) Dual=
  CPU  T3400  @ 2.16GHz stepping 0d
Nov 14 21:30:57 vinux kernel: [    0.164589] checking TSC synchronization [=
CPU#0 -> CPU#1]: passed.
Nov 14 21:30:57 vinux kernel: [    0.168046] Brought up 2 CPUs
Nov 14 21:30:57 vinux kernel: [    0.168106] Total of 2 processors activate=
d (8644.94 BogoMIPS).
Nov 14 21:30:57 vinux kernel: [    0.168738] CPU0 attaching sched-domain:
Nov 14 21:30:57 vinux kernel: [    0.168742]  domain 0: span 0-1 level MC
Nov 14 21:30:57 vinux kernel: [    0.168744]   groups: group c3003778 cpus =
0 group c3203778 cpus 1
Nov 14 21:30:57 vinux kernel: [    0.168750] CPU1 attaching sched-domain:
Nov 14 21:30:57 vinux kernel: [    0.168752]  domain 0: span 0-1 level MC
Nov 14 21:30:57 vinux kernel: [    0.168754]   groups: group c3203778 cpus =
1 group c3003778 cpus 0
Nov 14 21:30:57 vinux kernel: [    0.168804] devtmpfs: initialized
Nov 14 21:30:57 vinux kernel: [    0.168804] regulator: core version 0.5
Nov 14 21:30:57 vinux kernel: [    0.168804] NET: Registered protocol famil=
y 16
Nov 14 21:30:57 vinux kernel: [    0.169011] ACPI: bus type pci registered
Nov 14 21:30:57 vinux kernel: [    0.169133] PCI: MCFG configuration 0: bas=
e e0000000 segment 0 buses 0 - 255
Nov 14 21:30:57 vinux kernel: [    0.169199] PCI: Not using MMCONFIG.
Nov 14 21:30:57 vinux kernel: [    0.169699] PCI: PCI BIOS revision 3.00 en=
try at 0xfde11, last bus=3D8
Nov 14 21:30:57 vinux kernel: [    0.169763] PCI: Using configuration type =
1 for base access
Nov 14 21:30:57 vinux kernel: [    0.172112] bio: create slab <bio-0> at 0
Nov 14 21:30:57 vinux kernel: [    0.172806] ACPI: EC: Look up EC in DSDT
Nov 14 21:30:57 vinux kernel: [    0.176261] ACPI: BIOS _OSI(Linux) query i=
gnored
Nov 14 21:30:57 vinux kernel: [    0.177657] ACPI: Interpreter enabled
Nov 14 21:30:57 vinux kernel: [    0.177719] ACPI: (supports S0 S3 S4 S5)
Nov 14 21:30:57 vinux kernel: [    0.177962] ACPI: Using IOAPIC for interru=
pt routing
Nov 14 21:30:57 vinux kernel: [    0.178070] PCI: MCFG configuration 0: bas=
e e0000000 segment 0 buses 0 - 255
Nov 14 21:30:57 vinux kernel: [    0.216431] PCI: MCFG area at e0000000 res=
erved in ACPI motherboard resources
Nov 14 21:30:57 vinux kernel: [    0.216497] PCI: Using MMCONFIG for extend=
ed config space
Nov 14 21:30:57 vinux kernel: [    0.258858] ACPI: EC: GPE =3D 0x1c, I/O: c=
ommand/status =3D 0x66, data =3D 0x62
Nov 14 21:30:57 vinux kernel: [    0.259221] ACPI: No dock devices found.
Nov 14 21:30:57 vinux kernel: [    0.259753] ACPI: PCI Root Bridge [PCI0] (=
0000:00)
Nov 14 21:30:57 vinux kernel: [    0.259867] DMAR: Forcing write-buffer flu=
sh capability
Nov 14 21:30:57 vinux kernel: [    0.259929] DMAR: Disabling IOMMU for grap=
hics on this chipset
Nov 14 21:30:57 vinux kernel: [    0.260039] pci 0000:00:02.0: reg 10 64bit=
 mmio: [0xf4000000-0xf43fffff]
Nov 14 21:30:57 vinux kernel: [    0.260046] pci 0000:00:02.0: reg 18 64bit=
 mmio pref: [0xd0000000-0xdfffffff]
Nov 14 21:30:57 vinux kernel: [    0.260052] pci 0000:00:02.0: reg 20 io po=
rt: [0x1800-0x1807]
Nov 14 21:30:57 vinux kernel: [    0.260093] pci 0000:00:02.1: reg 10 64bit=
 mmio: [0xf4400000-0xf44fffff]
Nov 14 21:30:57 vinux kernel: [    0.260222] pci 0000:00:1a.0: reg 20 io po=
rt: [0x1820-0x183f]
Nov 14 21:30:57 vinux kernel: [    0.260320] pci 0000:00:1a.1: reg 20 io po=
rt: [0x1840-0x185f]
Nov 14 21:30:57 vinux kernel: [    0.260417] pci 0000:00:1a.2: reg 20 io po=
rt: [0x1860-0x187f]
Nov 14 21:30:57 vinux kernel: [    0.260515] pci 0000:00:1a.7: reg 10 32bit=
 mmio: [0xf4a04800-0xf4a04bff]
Nov 14 21:30:57 vinux kernel: [    0.260586] pci 0000:00:1a.7: PME# support=
ed from D0 D3hot D3cold
Nov 14 21:30:57 vinux kernel: [    0.260653] pci 0000:00:1a.7: PME# disabled
Nov 14 21:30:57 vinux kernel: [    0.260770] pci 0000:00:1b.0: reg 10 64bit=
 mmio: [0xf4a00000-0xf4a03fff]
Nov 14 21:30:57 vinux kernel: [    0.260833] pci 0000:00:1b.0: PME# support=
ed from D0 D3hot D3cold
Nov 14 21:30:57 vinux kernel: [    0.260899] pci 0000:00:1b.0: PME# disabled
Nov 14 21:30:57 vinux kernel: [    0.261055] pci 0000:00:1c.0: PME# support=
ed from D0 D3hot D3cold
Nov 14 21:30:57 vinux kernel: [    0.261121] pci 0000:00:1c.0: PME# disabled
Nov 14 21:30:57 vinux kernel: [    0.261279] pci 0000:00:1c.1: PME# support=
ed from D0 D3hot D3cold
Nov 14 21:30:57 vinux kernel: [    0.261345] pci 0000:00:1c.1: PME# disabled
Nov 14 21:30:57 vinux kernel: [    0.261503] pci 0000:00:1c.2: PME# support=
ed from D0 D3hot D3cold
Nov 14 21:30:57 vinux kernel: [    0.261569] pci 0000:00:1c.2: PME# disabled
Nov 14 21:30:57 vinux kernel: [    0.261726] pci 0000:00:1c.3: PME# support=
ed from D0 D3hot D3cold
Nov 14 21:30:57 vinux kernel: [    0.261792] pci 0000:00:1c.3: PME# disabled
Nov 14 21:30:57 vinux kernel: [    0.261951] pci 0000:00:1c.5: PME# support=
ed from D0 D3hot D3cold
Nov 14 21:30:57 vinux kernel: [    0.262018] pci 0000:00:1c.5: PME# disabled
Nov 14 21:30:57 vinux kernel: [    0.262157] pci 0000:00:1d.0: reg 20 io po=
rt: [0x1880-0x189f]
Nov 14 21:30:57 vinux kernel: [    0.262254] pci 0000:00:1d.1: reg 20 io po=
rt: [0x18a0-0x18bf]
Nov 14 21:30:57 vinux kernel: [    0.262352] pci 0000:00:1d.2: reg 20 io po=
rt: [0x18c0-0x18df]
Nov 14 21:30:57 vinux kernel: [    0.262450] pci 0000:00:1d.7: reg 10 32bit=
 mmio: [0xf4a04c00-0xf4a04fff]
Nov 14 21:30:57 vinux kernel: [    0.262521] pci 0000:00:1d.7: PME# support=
ed from D0 D3hot D3cold
Nov 14 21:30:57 vinux kernel: [    0.262588] pci 0000:00:1d.7: PME# disabled
Nov 14 21:30:57 vinux kernel: [    0.262916] pci 0000:00:1f.2: reg 10 io po=
rt: [0x1818-0x181f]
Nov 14 21:30:57 vinux kernel: [    0.262924] pci 0000:00:1f.2: reg 14 io po=
rt: [0x180c-0x180f]
Nov 14 21:30:57 vinux kernel: [    0.262932] pci 0000:00:1f.2: reg 18 io po=
rt: [0x1810-0x1817]
Nov 14 21:30:57 vinux kernel: [    0.262940] pci 0000:00:1f.2: reg 1c io po=
rt: [0x1808-0x180b]
Nov 14 21:30:57 vinux kernel: [    0.262948] pci 0000:00:1f.2: reg 20 io po=
rt: [0x18e0-0x18ff]
Nov 14 21:30:57 vinux kernel: [    0.262956] pci 0000:00:1f.2: reg 24 32bit=
 mmio: [0xf4a04000-0xf4a047ff]
Nov 14 21:30:57 vinux kernel: [    0.263005] pci 0000:00:1f.2: PME# support=
ed from D3hot
Nov 14 21:30:57 vinux kernel: [    0.263070] pci 0000:00:1f.2: PME# disabled
Nov 14 21:30:57 vinux kernel: [    0.263172] pci 0000:00:1f.3: reg 10 64bit=
 mmio: [0x000000-0x0000ff]
Nov 14 21:30:57 vinux kernel: [    0.263192] pci 0000:00:1f.3: reg 20 io po=
rt: [0x1c00-0x1c1f]
Nov 14 21:30:57 vinux kernel: [    0.263298] pci 0000:02:00.0: reg 10 32bit=
 mmio: [0xf4500000-0xf45000ff]
Nov 14 21:30:57 vinux kernel: [    0.263378] pci 0000:02:00.0: reg 30 32bit=
 mmio pref: [0x000000-0x00ffff]
Nov 14 21:30:57 vinux kernel: [    0.263543] pci 0000:02:00.2: reg 10 32bit=
 mmio: [0xf4500400-0xf45004ff]
Nov 14 21:30:57 vinux kernel: [    0.263780] pci 0000:02:00.3: reg 10 32bit=
 mmio: [0xf4500800-0xf45008ff]
Nov 14 21:30:57 vinux kernel: [    0.272236] pci 0000:00:1c.0: bridge 32bit=
 mmio: [0xf4500000-0xf45fffff]
Nov 14 21:30:57 vinux kernel: [    0.272516] pci 0000:04:00.0: reg 10 64bit=
 mmio: [0xf4700000-0xf4703fff]
Nov 14 21:30:57 vinux kernel: [    0.272737] pci 0000:04:00.0: supports D1 =
D2
Nov 14 21:30:57 vinux kernel: [    0.272739] pci 0000:04:00.0: PME# support=
ed from D0 D3hot D3cold
Nov 14 21:30:57 vinux kernel: [    0.272847] pci 0000:04:00.0: PME# disabled
Nov 14 21:30:57 vinux kernel: [    0.273433] pci 0000:00:1c.2: bridge 32bit=
 mmio: [0xf4700000-0xf47fffff]
Nov 14 21:30:57 vinux kernel: [    0.273500] pci 0000:00:1c.3: bridge io po=
rt: [0x2000-0x2fff]
Nov 14 21:30:57 vinux kernel: [    0.273505] pci 0000:00:1c.3: bridge 32bit=
 mmio: [0xf0000000-0xf3ffffff]
Nov 14 21:30:57 vinux kernel: [    0.273514] pci 0000:00:1c.3: bridge 64bit=
 mmio pref: [0xf6000000-0xf7ffffff]
Nov 14 21:30:57 vinux kernel: [    0.273738] pci 0000:07:00.0: reg 10 64bit=
 mmio: [0xf4600000-0xf460ffff]
Nov 14 21:30:57 vinux kernel: [    0.273978] pci 0000:07:00.0: PME# support=
ed from D3hot D3cold
Nov 14 21:30:57 vinux kernel: [    0.274084] pci 0000:07:00.0: PME# disabled
Nov 14 21:30:57 vinux kernel: [    0.274686] pci 0000:00:1c.5: bridge 32bit=
 mmio: [0xf4600000-0xf46fffff]
Nov 14 21:30:57 vinux kernel: [    0.274760] pci 0000:00:1e.0: transparent =
bridge
Nov 14 21:30:57 vinux kernel: [    0.274870] pci_bus 0000:00: on NUMA node 0
Nov 14 21:30:57 vinux kernel: [    0.274875] ACPI: PCI Interrupt Routing Ta=
ble [\_SB_.PCI0._PRT]
Nov 14 21:30:57 vinux kernel: [    0.275009] ACPI: PCI Interrupt Routing Ta=
ble [\_SB_.PCI0.P0P1._PRT]
Nov 14 21:30:57 vinux kernel: [    0.275097] ACPI: PCI Interrupt Routing Ta=
ble [\_SB_.PCI0.RP01._PRT]
Nov 14 21:30:57 vinux kernel: [    0.275199] ACPI: PCI Interrupt Routing Ta=
ble [\_SB_.PCI0.RP02._PRT]
Nov 14 21:30:57 vinux kernel: [    0.275262] ACPI: PCI Interrupt Routing Ta=
ble [\_SB_.PCI0.RP03._PRT]
Nov 14 21:30:57 vinux kernel: [    0.275332] ACPI: PCI Interrupt Routing Ta=
ble [\_SB_.PCI0.RP04._PRT]
Nov 14 21:30:57 vinux kernel: [    0.275398] ACPI: PCI Interrupt Routing Ta=
ble [\_SB_.PCI0.RP06._PRT]
Nov 14 21:30:57 vinux kernel: [    0.287616] ACPI: PCI Interrupt Link [LNKA=
] (IRQs 1 3 4 *5 6 7 10 12 14 15)
Nov 14 21:30:57 vinux kernel: [    0.288280] ACPI: PCI Interrupt Link [LNKB=
] (IRQs 1 3 4 5 6 7 *11 12 14 15)
Nov 14 21:30:57 vinux kernel: [    0.288940] ACPI: PCI Interrupt Link [LNKC=
] (IRQs 1 *3 4 5 6 7 10 12 14 15)
Nov 14 21:30:57 vinux kernel: [    0.289598] ACPI: PCI Interrupt Link [LNKD=
] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
Nov 14 21:30:57 vinux kernel: [    0.290310] ACPI: PCI Interrupt Link [LNKE=
] (IRQs 1 3 4 5 6 *7 10 12 14 15)
Nov 14 21:30:57 vinux kernel: [    0.290968] ACPI: PCI Interrupt Link [LNKF=
] (IRQs 1 3 4 5 6 7 *11 12 14 15)
Nov 14 21:30:57 vinux kernel: [    0.291628] ACPI: PCI Interrupt Link [LNKG=
] (IRQs 1 3 4 5 6 7 *10 12 14 15)
Nov 14 21:30:57 vinux kernel: [    0.292276] ACPI: PCI Interrupt Link [LNKH=
] (IRQs 1 3 *4 5 6 7 11 12 14 15)
Nov 14 21:30:57 vinux kernel: [    0.292926] vgaarb: device added: PCI:0000=
:00:02.0,decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
Nov 14 21:30:57 vinux kernel: [    0.293016] vgaarb: loaded
Nov 14 21:30:57 vinux kernel: [    0.293086] PCI: Using ACPI for IRQ routing
Nov 14 21:30:57 vinux kernel: [    0.293086] HPET: 4 timers in total, 0 tim=
ers will be used for per-cpu timer
Nov 14 21:30:57 vinux kernel: [    0.293086] hpet0: at MMIO 0xfed00000, IRQ=
s 2, 8, 0, 0
Nov 14 21:30:57 vinux kernel: [    0.293086] hpet0: 4 comparators, 64-bit 1=
4.318180 MHz counter
Nov 14 21:30:57 vinux kernel: [    0.300019] Switching to clocksource tsc
Nov 14 21:30:57 vinux kernel: [    0.301240] pnp: PnP ACPI init
Nov 14 21:30:57 vinux kernel: [    0.301309] ACPI: bus type pnp registered
Nov 14 21:30:57 vinux kernel: [    0.319871] pnp: PnP ACPI: found 10 devices
Nov 14 21:30:57 vinux kernel: [    0.319932] ACPI: ACPI bus type pnp unregi=
stered
Nov 14 21:30:57 vinux kernel: [    0.319994] PnPBIOS: Disabled by ACPI PNP
Nov 14 21:30:57 vinux kernel: [    0.320063] system 00:03: iomem range 0xfe=
d00000-0xfed003ff has been reserved
Nov 14 21:30:57 vinux kernel: [    0.320134] system 00:05: ioport range 0x6=
80-0x69f has been reserved
Nov 14 21:30:57 vinux kernel: [    0.320199] system 00:05: ioport range 0xf=
fff-0xffff has been reserved
Nov 14 21:30:57 vinux kernel: [    0.320264] system 00:05: ioport range 0xf=
fff-0xffff has been reserved
Nov 14 21:30:57 vinux kernel: [    0.320329] system 00:05: ioport range 0xf=
fff-0xffff has been reserved
Nov 14 21:30:57 vinux kernel: [    0.320394] system 00:05: ioport range 0x4=
00-0x47f has been reserved
Nov 14 21:30:57 vinux kernel: [    0.320459] system 00:05: ioport range 0x4=
80-0x48f has been reserved
Nov 14 21:30:57 vinux kernel: [    0.320524] system 00:05: ioport range 0x1=
180-0x11ff has been reserved
Nov 14 21:30:57 vinux kernel: [    0.320588] system 00:05: ioport range 0x1=
64e-0x164f has been reserved
Nov 14 21:30:57 vinux kernel: [    0.320654] system 00:05: ioport range 0xf=
e00-0xfe00 has been reserved
Nov 14 21:30:57 vinux kernel: [    0.320719] system 00:05: ioport range 0xf=
f00-0xff7f has been reserved
Nov 14 21:30:57 vinux kernel: [    0.320787] system 00:09: iomem range 0xfe=
d1c000-0xfed1ffff has been reserved
Nov 14 21:30:57 vinux kernel: [    0.320853] system 00:09: iomem range 0xfe=
d10000-0xfed13fff has been reserved
Nov 14 21:30:57 vinux kernel: [    0.320919] system 00:09: iomem range 0xfe=
d18000-0xfed18fff has been reserved
Nov 14 21:30:57 vinux kernel: [    0.320985] system 00:09: iomem range 0xfe=
d19000-0xfed19fff has been reserved
Nov 14 21:30:57 vinux kernel: [    0.321051] system 00:09: iomem range 0xe0=
000000-0xefffffff has been reserved
Nov 14 21:30:57 vinux kernel: [    0.321117] system 00:09: iomem range 0xfe=
d20000-0xfed3ffff has been reserved
Nov 14 21:30:57 vinux kernel: [    0.321182] system 00:09: iomem range 0xfe=
d40000-0xfed44fff has been reserved
Nov 14 21:30:57 vinux kernel: [    0.321248] system 00:09: iomem range 0xfe=
d45000-0xfed8ffff has been reserved
Nov 14 21:30:57 vinux kernel: [    0.356108] pci 0000:00:1c.0: PCI bridge, =
secondary bus 0000:02
Nov 14 21:30:57 vinux kernel: [    0.356173] pci 0000:00:1c.0:   IO window:=
 0x3000-0x3fff
Nov 14 21:30:57 vinux kernel: [    0.356241] pci 0000:00:1c.0:   MEM window=
: 0xf4500000-0xf45fffff
Nov 14 21:30:57 vinux kernel: [    0.356308] pci 0000:00:1c.0:   PREFETCH w=
indow: 0xc0000000-0xc01fffff
Nov 14 21:30:57 vinux kernel: [    0.356378] pci 0000:00:1c.1: PCI bridge, =
secondary bus 0000:03
Nov 14 21:30:57 vinux kernel: [    0.356443] pci 0000:00:1c.1:   IO window:=
 0x4000-0x4fff
Nov 14 21:30:57 vinux kernel: [    0.356510] pci 0000:00:1c.1:   MEM window=
: 0xc0200000-0xc03fffff
Nov 14 21:30:57 vinux kernel: [    0.356576] pci 0000:00:1c.1:   PREFETCH w=
indow: 0x000000c0400000-0x000000c05fffff
Nov 14 21:30:57 vinux kernel: [    0.356659] pci 0000:00:1c.2: PCI bridge, =
secondary bus 0000:04
Nov 14 21:30:57 vinux kernel: [    0.356724] pci 0000:00:1c.2:   IO window:=
 0x5000-0x5fff
Nov 14 21:30:57 vinux kernel: [    0.356791] pci 0000:00:1c.2:   MEM window=
: 0xf4700000-0xf47fffff
Nov 14 21:30:57 vinux kernel: [    0.356858] pci 0000:00:1c.2:   PREFETCH w=
indow: 0x000000c0600000-0x000000c07fffff
Nov 14 21:30:57 vinux kernel: [    0.356941] pci 0000:00:1c.3: PCI bridge, =
secondary bus 0000:05
Nov 14 21:30:57 vinux kernel: [    0.357006] pci 0000:00:1c.3:   IO window:=
 0x2000-0x2fff
Nov 14 21:30:57 vinux kernel: [    0.357073] pci 0000:00:1c.3:   MEM window=
: 0xf0000000-0xf3ffffff
Nov 14 21:30:57 vinux kernel: [    0.357139] pci 0000:00:1c.3:   PREFETCH w=
indow: 0x000000f6000000-0x000000f7ffffff
Nov 14 21:30:57 vinux kernel: [    0.357222] pci 0000:00:1c.5: PCI bridge, =
secondary bus 0000:07
Nov 14 21:30:57 vinux kernel: [    0.357287] pci 0000:00:1c.5:   IO window:=
 0x6000-0x6fff
Nov 14 21:30:57 vinux kernel: [    0.357354] pci 0000:00:1c.5:   MEM window=
: 0xf4600000-0xf46fffff
Nov 14 21:30:57 vinux kernel: [    0.357420] pci 0000:00:1c.5:   PREFETCH w=
indow: 0x000000c0800000-0x000000c09fffff
Nov 14 21:30:57 vinux kernel: [    0.357503] pci 0000:00:1e.0: PCI bridge, =
secondary bus 0000:08
Nov 14 21:30:57 vinux kernel: [    0.357566] pci 0000:00:1e.0:   IO window:=
 disabled
Nov 14 21:30:57 vinux kernel: [    0.357631] pci 0000:00:1e.0:   MEM window=
: disabled
Nov 14 21:30:57 vinux kernel: [    0.357696] pci 0000:00:1e.0:   PREFETCH w=
indow: disabled
Nov 14 21:30:57 vinux kernel: [    0.357777] pci 0000:00:1c.0: PCI INT A ->=
 GSI 17 (level, low) -> IRQ 17
Nov 14 21:30:57 vinux kernel: [    0.357846] pci 0000:00:1c.0: setting late=
ncy timer to 64
Nov 14 21:30:57 vinux kernel: [    0.357858] pci 0000:00:1c.1: PCI INT B ->=
 GSI 16 (level, low) -> IRQ 16
Nov 14 21:30:57 vinux kernel: [    0.357925] pci 0000:00:1c.1: setting late=
ncy timer to 64
Nov 14 21:30:57 vinux kernel: [    0.357936] pci 0000:00:1c.2: PCI INT C ->=
 GSI 18 (level, low) -> IRQ 18
Nov 14 21:30:57 vinux kernel: [    0.358003] pci 0000:00:1c.2: setting late=
ncy timer to 64
Nov 14 21:30:57 vinux kernel: [    0.358015] pci 0000:00:1c.3: PCI INT D ->=
 GSI 19 (level, low) -> IRQ 19
Nov 14 21:30:57 vinux kernel: [    0.358082] pci 0000:00:1c.3: setting late=
ncy timer to 64
Nov 14 21:30:57 vinux kernel: [    0.358092] pci 0000:00:1c.5: PCI INT B ->=
 GSI 16 (level, low) -> IRQ 16
Nov 14 21:30:57 vinux kernel: [    0.358159] pci 0000:00:1c.5: setting late=
ncy timer to 64
Nov 14 21:30:57 vinux kernel: [    0.358168] pci 0000:00:1e.0: setting late=
ncy timer to 64
Nov 14 21:30:57 vinux kernel: [    0.358172] pci_bus 0000:00: resource 0 io=
:  [0x00-0xffff]
Nov 14 21:30:57 vinux kernel: [    0.358175] pci_bus 0000:00: resource 1 me=
m: [0x000000-0xffffffff]
Nov 14 21:30:57 vinux kernel: [    0.358178] pci_bus 0000:02: resource 0 io=
:  [0x3000-0x3fff]
Nov 14 21:30:57 vinux kernel: [    0.358180] pci_bus 0000:02: resource 1 me=
m: [0xf4500000-0xf45fffff]
Nov 14 21:30:57 vinux kernel: [    0.358182] pci_bus 0000:02: resource 2 pr=
ef mem [0xc0000000-0xc01fffff]
Nov 14 21:30:57 vinux kernel: [    0.358185] pci_bus 0000:03: resource 0 io=
:  [0x4000-0x4fff]
Nov 14 21:30:57 vinux kernel: [    0.358187] pci_bus 0000:03: resource 1 me=
m: [0xc0200000-0xc03fffff]
Nov 14 21:30:57 vinux kernel: [    0.358190] pci_bus 0000:03: resource 2 pr=
ef mem [0xc0400000-0xc05fffff]
Nov 14 21:30:57 vinux kernel: [    0.358192] pci_bus 0000:04: resource 0 io=
:  [0x5000-0x5fff]
Nov 14 21:30:57 vinux kernel: [    0.358195] pci_bus 0000:04: resource 1 me=
m: [0xf4700000-0xf47fffff]
Nov 14 21:30:57 vinux kernel: [    0.358197] pci_bus 0000:04: resource 2 pr=
ef mem [0xc0600000-0xc07fffff]
Nov 14 21:30:57 vinux kernel: [    0.358200] pci_bus 0000:05: resource 0 io=
:  [0x2000-0x2fff]
Nov 14 21:30:57 vinux kernel: [    0.358202] pci_bus 0000:05: resource 1 me=
m: [0xf0000000-0xf3ffffff]
Nov 14 21:30:57 vinux kernel: [    0.358204] pci_bus 0000:05: resource 2 pr=
ef mem [0xf6000000-0xf7ffffff]
Nov 14 21:30:57 vinux kernel: [    0.358207] pci_bus 0000:07: resource 0 io=
:  [0x6000-0x6fff]
Nov 14 21:30:57 vinux kernel: [    0.358209] pci_bus 0000:07: resource 1 me=
m: [0xf4600000-0xf46fffff]
Nov 14 21:30:57 vinux kernel: [    0.358212] pci_bus 0000:07: resource 2 pr=
ef mem [0xc0800000-0xc09fffff]
Nov 14 21:30:57 vinux kernel: [    0.358214] pci_bus 0000:08: resource 3 io=
:  [0x00-0xffff]
Nov 14 21:30:57 vinux kernel: [    0.358217] pci_bus 0000:08: resource 4 me=
m: [0x000000-0xffffffff]
Nov 14 21:30:57 vinux kernel: [    0.358245] NET: Registered protocol famil=
y 2
Nov 14 21:30:57 vinux kernel: [    0.358378] IP route cache hash table entr=
ies: 32768 (order: 5, 131072 bytes)
Nov 14 21:30:57 vinux kernel: [    0.358712] TCP established hash table ent=
ries: 131072 (order: 8, 1048576 bytes)
Nov 14 21:30:57 vinux kernel: [    0.359232] TCP bind hash table entries: 6=
5536 (order: 7, 524288 bytes)
Nov 14 21:30:57 vinux kernel: [    0.359589] TCP: Hash tables configured (e=
stablished 131072 bind 65536)
Nov 14 21:30:57 vinux kernel: [    0.359655] TCP reno registered
Nov 14 21:30:57 vinux kernel: [    0.359818] NET: Registered protocol famil=
y 1
Nov 14 21:30:57 vinux kernel: [    0.359899] pci 0000:00:02.0: Boot video d=
evice
Nov 14 21:30:57 vinux kernel: [    0.360107] Unpacking initramfs...
Nov 14 21:30:57 vinux kernel: [    0.637581] Freeing initrd memory: 10581k =
freed
Nov 14 21:30:57 vinux kernel: [    0.644068] Simple Boot Flag at 0x36 set t=
o 0x1
Nov 14 21:30:57 vinux kernel: [    0.644417] audit: initializing netlink so=
cket (disabled)
Nov 14 21:30:57 vinux kernel: [    0.644491] type=3D2000 audit(1321306245.6=
43:1): initialized
Nov 14 21:30:57 vinux kernel: [    0.647782] highmem bounce pool size: 64 p=
ages
Nov 14 21:30:57 vinux kernel: [    0.647846] HugeTLB registered 4 MB page s=
ize, pre-allocated 0 pages
Nov 14 21:30:57 vinux kernel: [    0.649170] VFS: Disk quotas dquot_6.5.2
Nov 14 21:30:57 vinux kernel: [    0.649281] Dquot-cache hash table entries=
: 1024 (order 0, 4096 bytes)
Nov 14 21:30:57 vinux kernel: [    0.649412] msgmni has been set to 1708
Nov 14 21:30:57 vinux kernel: [    0.649638] alg: No test for stdrng (krng)
Nov 14 21:30:57 vinux kernel: [    0.649744] Block layer SCSI generic (bsg)=
 driver version 0.4 loaded (major 253)
Nov 14 21:30:57 vinux kernel: [    0.649822] io scheduler noop registered
Nov 14 21:30:57 vinux kernel: [    0.649882] io scheduler anticipatory regi=
stered
Nov 14 21:30:57 vinux kernel: [    0.649943] io scheduler deadline register=
ed
Nov 14 21:30:57 vinux kernel: [    0.650033] io scheduler cfq registered (d=
efault)
Nov 14 21:30:57 vinux kernel: [    0.650245] pcieport 0000:00:1c.0: irq 24 =
for MSI/MSI-X
Nov 14 21:30:57 vinux kernel: [    0.650257] pcieport 0000:00:1c.0: setting=
 latency timer to 64
Nov 14 21:30:57 vinux kernel: [    0.650416] pcieport 0000:00:1c.1: irq 25 =
for MSI/MSI-X
Nov 14 21:30:57 vinux kernel: [    0.650426] pcieport 0000:00:1c.1: setting=
 latency timer to 64
Nov 14 21:30:57 vinux kernel: [    0.650584] pcieport 0000:00:1c.2: irq 26 =
for MSI/MSI-X
Nov 14 21:30:57 vinux kernel: [    0.650595] pcieport 0000:00:1c.2: setting=
 latency timer to 64
Nov 14 21:30:57 vinux kernel: [    0.650750] pcieport 0000:00:1c.3: irq 27 =
for MSI/MSI-X
Nov 14 21:30:57 vinux kernel: [    0.650761] pcieport 0000:00:1c.3: setting=
 latency timer to 64
Nov 14 21:30:57 vinux kernel: [    0.650916] pcieport 0000:00:1c.5: irq 28 =
for MSI/MSI-X
Nov 14 21:30:57 vinux kernel: [    0.650926] pcieport 0000:00:1c.5: setting=
 latency timer to 64
Nov 14 21:30:57 vinux kernel: [    0.651089] isapnp: Scanning for PnP cards=
...
Nov 14 21:30:57 vinux kernel: [    1.005143] isapnp: No Plug & Play device =
found
Nov 14 21:30:57 vinux kernel: [    1.006452] Linux agpgart interface v0.103
Nov 14 21:30:57 vinux kernel: [    1.006583] agpgart-intel 0000:00:00.0: In=
tel Mobile Intel=AE GM45 Express Chipset
Nov 14 21:30:57 vinux kernel: [    1.007017] agpgart-intel 0000:00:00.0: de=
tected 32764K stolen memory
Nov 14 21:30:57 vinux kernel: [    1.038455] agpgart-intel 0000:00:00.0: AG=
P aperture is 256M @ 0xd0000000
Nov 14 21:30:57 vinux kernel: [    1.038593] Serial: 8250/16550 driver, 4 p=
orts, IRQ sharing enabled
Nov 14 21:30:57 vinux kernel: [    1.039021] PNP: PS/2 Controller [PNP0303:=
PS2K,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
Nov 14 21:30:57 vinux kernel: [    1.069998] serio: i8042 KBD port at 0x60,=
0x64 irq 1
Nov 14 21:30:57 vinux kernel: [    1.070065] serio: i8042 AUX port at 0x60,=
0x64 irq 12
Nov 14 21:30:57 vinux kernel: [    1.070174] mice: PS/2 mouse device common=
 for all mice
Nov 14 21:30:57 vinux kernel: [    1.070275] rtc_cmos 00:06: RTC can wake f=
rom S4
Nov 14 21:30:57 vinux kernel: [    1.070370] rtc_cmos 00:06: rtc core: regi=
stered rtc_cmos as rtc0
Nov 14 21:30:57 vinux kernel: [    1.070466] rtc0: alarms up to one month, =
y3k, 242 bytes nvram, hpet irqs
Nov 14 21:30:57 vinux kernel: [    1.070542] cpuidle: using governor ladder
Nov 14 21:30:57 vinux kernel: [    1.070605] cpuidle: using governor menu
Nov 14 21:30:57 vinux kernel: [    1.070668] No iBFT detected.
Nov 14 21:30:57 vinux kernel: [    1.071036] TCP cubic registered
Nov 14 21:30:57 vinux kernel: [    1.071222] NET: Registered protocol famil=
y 10
Nov 14 21:30:57 vinux kernel: [    1.071931] Mobile IPv6
Nov 14 21:30:57 vinux kernel: [    1.071992] NET: Registered protocol famil=
y 17
Nov 14 21:30:57 vinux kernel: [    1.072079] Using IPI No-Shortcut mode
Nov 14 21:30:57 vinux kernel: [    1.072198] PM: Resume from disk failed.
Nov 14 21:30:57 vinux kernel: [    1.072213] registered taskstats version 1
Nov 14 21:30:57 vinux kernel: [    1.073330] rtc_cmos 00:06: setting system=
 clock to 2011-11-14 21:30:47 UTC (1321306247)
Nov 14 21:30:57 vinux kernel: [    1.073464] Initalizing network drop monit=
or service
Nov 14 21:30:57 vinux kernel: [    1.073543] Freeing unused kernel memory: =
380k freed
Nov 14 21:30:57 vinux kernel: [    1.073773] Write protecting the kernel te=
xt: 2508k
Nov 14 21:30:57 vinux kernel: [    1.073854] Write protecting the kernel re=
ad-only data: 920k
Nov 14 21:30:57 vinux kernel: [    1.089978] udev[56]: starting version 164
Nov 14 21:30:57 vinux kernel: [    1.100796] input: AT Translated Set 2 key=
board as /devices/platform/i8042/serio0/input/input0
Nov 14 21:30:57 vinux kernel: [    1.206841] usbcore: registered new interf=
ace driver usbfs
Nov 14 21:30:57 vinux kernel: [    1.207059] usbcore: registered new interf=
ace driver hub
Nov 14 21:30:57 vinux kernel: [    1.207279] usbcore: registered new device=
 driver usb
Nov 14 21:30:57 vinux kernel: [    1.215511] ACPI: Invalid active0 threshold
Nov 14 21:30:57 vinux kernel: [    1.220431] thermal LNXTHERM:01: registere=
d as thermal_zone0
Nov 14 21:30:57 vinux kernel: [    1.221449] ACPI: Thermal Zone [TZ00] (64 =
C)
Nov 14 21:30:57 vinux kernel: [    1.222779] ehci_hcd: USB 2.0 'Enhanced' H=
ost Controller (EHCI) Driver
Nov 14 21:30:57 vinux kernel: [    1.222884] ehci_hcd 0000:00:1a.7: PCI INT=
 C -> GSI 20 (level, low) -> IRQ 20
Nov 14 21:30:57 vinux kernel: [    1.222972] ehci_hcd 0000:00:1a.7: setting=
 latency timer to 64
Nov 14 21:30:57 vinux kernel: [    1.222976] ehci_hcd 0000:00:1a.7: EHCI Ho=
st Controller
Nov 14 21:30:57 vinux kernel: [    1.223062] ehci_hcd 0000:00:1a.7: new USB=
 bus registered, assigned bus number 1
Nov 14 21:30:57 vinux kernel: [    1.223187] ehci_hcd 0000:00:1a.7: debug p=
ort 1
Nov 14 21:30:57 vinux kernel: [    1.227149] ehci_hcd 0000:00:1a.7: cache l=
ine size of 32 is not supported
Nov 14 21:30:57 vinux kernel: [    1.227395] SCSI subsystem initialized
Nov 14 21:30:57 vinux kernel: [    1.231991] ehci_hcd 0000:00:1a.7: irq 20,=
 io mem 0xf4a04800
Nov 14 21:30:57 vinux kernel: [    1.238254] sdhci: Secure Digital Host Con=
troller Interface driver
Nov 14 21:30:57 vinux kernel: [    1.238324] sdhci: Copyright(c) Pierre Oss=
man
Nov 14 21:30:57 vinux kernel: [    1.239687] uhci_hcd: USB Universal Host C=
ontroller Interface driver
Nov 14 21:30:57 vinux kernel: [    1.245045] sdhci-pci 0000:02:00.0: SDHCI =
controller found [197b:2382] (rev 0)
Nov 14 21:30:57 vinux kernel: [    1.245151] sdhci-pci 0000:02:00.0: PCI IN=
T A -> GSI 16 (level, low) -> IRQ 16
Nov 14 21:30:57 vinux kernel: [    1.245275] sdhci-pci 0000:02:00.0: settin=
g latency timer to 64
Nov 14 21:30:57 vinux kernel: [    1.245383] Registered led device: mmc0::
Nov 14 21:30:57 vinux kernel: [    1.245506] mmc0: SDHCI controller on PCI =
[0000:02:00.0] using ADMA
Nov 14 21:30:57 vinux kernel: [    1.245587] sdhci-pci 0000:02:00.2: SDHCI =
controller found [197b:2381] (rev 0)
Nov 14 21:30:57 vinux kernel: [    1.245684] sdhci-pci 0000:02:00.2: PCI IN=
T A -> GSI 16 (level, low) -> IRQ 16
Nov 14 21:30:57 vinux kernel: [    1.245765] sdhci-pci 0000:02:00.2: Refusi=
ng to bind to secondary interface.
Nov 14 21:30:57 vinux kernel: [    1.245836] sdhci-pci 0000:02:00.2: PCI IN=
T A disabled
Nov 14 21:30:57 vinux kernel: [    1.256489] ehci_hcd 0000:00:1a.7: USB 2.0=
 started, EHCI 1.00
Nov 14 21:30:57 vinux kernel: [    1.256589] usb usb1: New USB device found=
, idVendor=3D1d6b, idProduct=3D0002
Nov 14 21:30:57 vinux kernel: [    1.256654] usb usb1: New USB device strin=
gs: Mfr=3D3, Product=3D2, SerialNumber=3D1
Nov 14 21:30:57 vinux kernel: [    1.256731] usb usb1: Product: EHCI Host C=
ontroller
Nov 14 21:30:57 vinux kernel: [    1.256793] usb usb1: Manufacturer: Linux =
2.6.32-5-686 ehci_hcd
Nov 14 21:30:57 vinux kernel: [    1.256856] usb usb1: SerialNumber: 0000:0=
0:1a.7
Nov 14 21:30:57 vinux kernel: [    1.256996] usb usb1: configuration #1 cho=
sen from 1 choice
Nov 14 21:30:57 vinux kernel: [    1.257092] hub 1-0:1.0: USB hub found
Nov 14 21:30:57 vinux kernel: [    1.257161] hub 1-0:1.0: 6 ports detected
Nov 14 21:30:57 vinux kernel: [    1.257299] uhci_hcd 0000:00:1a.0: PCI INT=
 A -> GSI 16 (level, low) -> IRQ 16
Nov 14 21:30:57 vinux kernel: [    1.257379] uhci_hcd 0000:00:1a.0: setting=
 latency timer to 64
Nov 14 21:30:57 vinux kernel: [    1.257383] uhci_hcd 0000:00:1a.0: UHCI Ho=
st Controller
Nov 14 21:30:57 vinux kernel: [    1.257458] uhci_hcd 0000:00:1a.0: new USB=
 bus registered, assigned bus number 2
Nov 14 21:30:57 vinux kernel: [    1.257570] uhci_hcd 0000:00:1a.0: irq 16,=
 io base 0x00001820
Nov 14 21:30:57 vinux kernel: [    1.257674] usb usb2: New USB device found=
, idVendor=3D1d6b, idProduct=3D0001
Nov 14 21:30:57 vinux kernel: [    1.257739] usb usb2: New USB device strin=
gs: Mfr=3D3, Product=3D2, SerialNumber=3D1
Nov 14 21:30:57 vinux kernel: [    1.257816] usb usb2: Product: UHCI Host C=
ontroller
Nov 14 21:30:57 vinux kernel: [    1.257878] usb usb2: Manufacturer: Linux =
2.6.32-5-686 uhci_hcd
Nov 14 21:30:57 vinux kernel: [    1.257941] usb usb2: SerialNumber: 0000:0=
0:1a.0
Nov 14 21:30:57 vinux kernel: [    1.258080] usb usb2: configuration #1 cho=
sen from 1 choice
Nov 14 21:30:57 vinux kernel: [    1.258171] hub 2-0:1.0: USB hub found
Nov 14 21:30:57 vinux kernel: [    1.258237] hub 2-0:1.0: 2 ports detected
Nov 14 21:30:57 vinux kernel: [    1.258364] ehci_hcd 0000:00:1d.7: PCI INT=
 A -> GSI 23 (level, low) -> IRQ 23
Nov 14 21:30:57 vinux kernel: [    1.258448] ehci_hcd 0000:00:1d.7: setting=
 latency timer to 64
Nov 14 21:30:57 vinux kernel: [    1.258451] ehci_hcd 0000:00:1d.7: EHCI Ho=
st Controller
Nov 14 21:30:57 vinux kernel: [    1.258519] ehci_hcd 0000:00:1d.7: new USB=
 bus registered, assigned bus number 3
Nov 14 21:30:57 vinux kernel: [    1.258632] ehci_hcd 0000:00:1d.7: debug p=
ort 1
Nov 14 21:30:57 vinux kernel: [    1.260842] tg3.c:v3.116 (December 3, 2010)
Nov 14 21:30:57 vinux kernel: [    1.260990] tg3 0000:07:00.0: PCI INT A ->=
 GSI 17 (level, low) -> IRQ 17
Nov 14 21:30:57 vinux kernel: [    1.262452] tg3 0000:07:00.0: setting late=
ncy timer to 64
Nov 14 21:30:57 vinux kernel: [    1.262598] ehci_hcd 0000:00:1d.7: cache l=
ine size of 32 is not supported
Nov 14 21:30:57 vinux kernel: [    1.262717] ehci_hcd 0000:00:1d.7: irq 23,=
 io mem 0xf4a04c00
Nov 14 21:30:57 vinux kernel: [    1.263025] libata version 3.00 loaded.
Nov 14 21:30:57 vinux kernel: [    1.276007] ehci_hcd 0000:00:1d.7: USB 2.0=
 started, EHCI 1.00
Nov 14 21:30:57 vinux kernel: [    1.276091] usb usb3: New USB device found=
, idVendor=3D1d6b, idProduct=3D0002
Nov 14 21:30:57 vinux kernel: [    1.276156] usb usb3: New USB device strin=
gs: Mfr=3D3, Product=3D2, SerialNumber=3D1
Nov 14 21:30:57 vinux kernel: [    1.276233] usb usb3: Product: EHCI Host C=
ontroller
Nov 14 21:30:57 vinux kernel: [    1.276295] usb usb3: Manufacturer: Linux =
2.6.32-5-686 ehci_hcd
Nov 14 21:30:57 vinux kernel: [    1.276359] usb usb3: SerialNumber: 0000:0=
0:1d.7
Nov 14 21:30:57 vinux kernel: [    1.276497] usb usb3: configuration #1 cho=
sen from 1 choice
Nov 14 21:30:57 vinux kernel: [    1.276591] hub 3-0:1.0: USB hub found
Nov 14 21:30:57 vinux kernel: [    1.276657] hub 3-0:1.0: 6 ports detected
Nov 14 21:30:57 vinux kernel: [    1.276787] uhci_hcd 0000:00:1a.1: PCI INT=
 B -> GSI 21 (level, low) -> IRQ 21
Nov 14 21:30:57 vinux kernel: [    1.276862] uhci_hcd 0000:00:1a.1: setting=
 latency timer to 64
Nov 14 21:30:57 vinux kernel: [    1.276866] uhci_hcd 0000:00:1a.1: UHCI Ho=
st Controller
Nov 14 21:30:57 vinux kernel: [    1.276937] uhci_hcd 0000:00:1a.1: new USB=
 bus registered, assigned bus number 4
Nov 14 21:30:57 vinux kernel: [    1.277064] uhci_hcd 0000:00:1a.1: irq 21,=
 io base 0x00001840
Nov 14 21:30:57 vinux kernel: [    1.277160] usb usb4: New USB device found=
, idVendor=3D1d6b, idProduct=3D0001
Nov 14 21:30:57 vinux kernel: [    1.277225] usb usb4: New USB device strin=
gs: Mfr=3D3, Product=3D2, SerialNumber=3D1
Nov 14 21:30:57 vinux kernel: [    1.277301] usb usb4: Product: UHCI Host C=
ontroller
Nov 14 21:30:57 vinux kernel: [    1.277363] usb usb4: Manufacturer: Linux =
2.6.32-5-686 uhci_hcd
Nov 14 21:30:57 vinux kernel: [    1.277426] usb usb4: SerialNumber: 0000:0=
0:1a.1
Nov 14 21:30:57 vinux kernel: [    1.277550] usb usb4: configuration #1 cho=
sen from 1 choice
Nov 14 21:30:57 vinux kernel: [    1.277637] hub 4-0:1.0: USB hub found
Nov 14 21:30:57 vinux kernel: [    1.277701] hub 4-0:1.0: 2 ports detected
Nov 14 21:30:57 vinux kernel: [    1.278007] ahci 0000:00:1f.2: version 3.0
Nov 14 21:30:57 vinux kernel: [    1.278022] ahci 0000:00:1f.2: PCI INT B -=
> GSI 19 (level, low) -> IRQ 19
Nov 14 21:30:57 vinux kernel: [    1.278184] ahci 0000:00:1f.2: irq 29 for =
MSI/MSI-X
Nov 14 21:30:57 vinux kernel: [    1.278265] ahci: SSS flag set, parallel b=
us scan disabled
Nov 14 21:30:57 vinux kernel: [    1.278391] ahci 0000:00:1f.2: AHCI 0001.0=
200 32 slots 4 ports 3 Gbps 0x3 impl SATA mode
Nov 14 21:30:57 vinux kernel: [    1.278500] ahci 0000:00:1f.2: flags: 64bi=
t ncq sntf stag pm led clo pio slum part ccc ems sxs=20
Nov 14 21:30:57 vinux kernel: [    1.278622] ahci 0000:00:1f.2: setting lat=
ency timer to 64
Nov 14 21:30:57 vinux kernel: [    1.285066] scsi0 : ahci
Nov 14 21:30:57 vinux kernel: [    1.285314] scsi1 : ahci
Nov 14 21:30:57 vinux kernel: [    1.285492] scsi2 : ahci
Nov 14 21:30:57 vinux kernel: [    1.285672] scsi3 : ahci
Nov 14 21:30:57 vinux kernel: [    1.285794] ata1: SATA max UDMA/133 abar m=
2048@0xf4a04000 port 0xf4a04100 irq 29
Nov 14 21:30:57 vinux kernel: [    1.285915] ata2: SATA max UDMA/133 abar m=
2048@0xf4a04000 port 0xf4a04180 irq 29
Nov 14 21:30:57 vinux kernel: [    1.286018] ata3: DUMMY
Nov 14 21:30:57 vinux kernel: [    1.286098] ata4: DUMMY
Nov 14 21:30:57 vinux kernel: [    1.286318] uhci_hcd 0000:00:1a.2: PCI INT=
 C -> GSI 20 (level, low) -> IRQ 20
Nov 14 21:30:57 vinux kernel: [    1.286417] uhci_hcd 0000:00:1a.2: setting=
 latency timer to 64
Nov 14 21:30:57 vinux kernel: [    1.286420] uhci_hcd 0000:00:1a.2: UHCI Ho=
st Controller
Nov 14 21:30:57 vinux kernel: [    1.286513] uhci_hcd 0000:00:1a.2: new USB=
 bus registered, assigned bus number 5
Nov 14 21:30:57 vinux kernel: [    1.286661] uhci_hcd 0000:00:1a.2: irq 20,=
 io base 0x00001860
Nov 14 21:30:57 vinux kernel: [    1.286786] usb usb5: New USB device found=
, idVendor=3D1d6b, idProduct=3D0001
Nov 14 21:30:57 vinux kernel: [    1.286874] usb usb5: New USB device strin=
gs: Mfr=3D3, Product=3D2, SerialNumber=3D1
Nov 14 21:30:57 vinux kernel: [    1.286979] usb usb5: Product: UHCI Host C=
ontroller
Nov 14 21:30:57 vinux kernel: [    1.287074] usb usb5: Manufacturer: Linux =
2.6.32-5-686 uhci_hcd
Nov 14 21:30:57 vinux kernel: [    1.287162] usb usb5: SerialNumber: 0000:0=
0:1a.2
Nov 14 21:30:57 vinux kernel: [    1.287448] usb usb5: configuration #1 cho=
sen from 1 choice
Nov 14 21:30:57 vinux kernel: [    1.287595] hub 5-0:1.0: USB hub found
Nov 14 21:30:57 vinux kernel: [    1.287680] hub 5-0:1.0: 2 ports detected
Nov 14 21:30:57 vinux kernel: [    1.287823] uhci_hcd 0000:00:1d.0: PCI INT=
 A -> GSI 23 (level, low) -> IRQ 23
Nov 14 21:30:57 vinux kernel: [    1.287924] uhci_hcd 0000:00:1d.0: setting=
 latency timer to 64
Nov 14 21:30:57 vinux kernel: [    1.287931] uhci_hcd 0000:00:1d.0: UHCI Ho=
st Controller
Nov 14 21:30:57 vinux kernel: [    1.288020] uhci_hcd 0000:00:1d.0: new USB=
 bus registered, assigned bus number 6
Nov 14 21:30:57 vinux kernel: [    1.288162] uhci_hcd 0000:00:1d.0: irq 23,=
 io base 0x00001880
Nov 14 21:30:57 vinux kernel: [    1.288287] usb usb6: New USB device found=
, idVendor=3D1d6b, idProduct=3D0001
Nov 14 21:30:57 vinux kernel: [    1.288371] usb usb6: New USB device strin=
gs: Mfr=3D3, Product=3D2, SerialNumber=3D1
Nov 14 21:30:57 vinux kernel: [    1.288476] usb usb6: Product: UHCI Host C=
ontroller
Nov 14 21:30:57 vinux kernel: [    1.288558] usb usb6: Manufacturer: Linux =
2.6.32-5-686 uhci_hcd
Nov 14 21:30:57 vinux kernel: [    1.288655] usb usb6: SerialNumber: 0000:0=
0:1d.0
Nov 14 21:30:57 vinux kernel: [    1.288844] usb usb6: configuration #1 cho=
sen from 1 choice
Nov 14 21:30:57 vinux kernel: [    1.288985] hub 6-0:1.0: USB hub found
Nov 14 21:30:57 vinux kernel: [    1.289096] hub 6-0:1.0: 2 ports detected
Nov 14 21:30:57 vinux kernel: [    1.289232] uhci_hcd 0000:00:1d.1: PCI INT=
 B -> GSI 19 (level, low) -> IRQ 19
Nov 14 21:30:57 vinux kernel: [    1.289328] uhci_hcd 0000:00:1d.1: setting=
 latency timer to 64
Nov 14 21:30:57 vinux kernel: [    1.289336] uhci_hcd 0000:00:1d.1: UHCI Ho=
st Controller
Nov 14 21:30:57 vinux kernel: [    1.289424] uhci_hcd 0000:00:1d.1: new USB=
 bus registered, assigned bus number 7
Nov 14 21:30:57 vinux kernel: [    1.289580] uhci_hcd 0000:00:1d.1: irq 19,=
 io base 0x000018a0
Nov 14 21:30:57 vinux kernel: [    1.289698] usb usb7: New USB device found=
, idVendor=3D1d6b, idProduct=3D0001
Nov 14 21:30:57 vinux kernel: [    1.289782] usb usb7: New USB device strin=
gs: Mfr=3D3, Product=3D2, SerialNumber=3D1
Nov 14 21:30:57 vinux kernel: [    1.289898] usb usb7: Product: UHCI Host C=
ontroller
Nov 14 21:30:57 vinux kernel: [    1.289984] usb usb7: Manufacturer: Linux =
2.6.32-5-686 uhci_hcd
Nov 14 21:30:57 vinux kernel: [    1.290068] usb usb7: SerialNumber: 0000:0=
0:1d.1
Nov 14 21:30:57 vinux kernel: [    1.290252] usb usb7: configuration #1 cho=
sen from 1 choice
Nov 14 21:30:57 vinux kernel: [    1.290392] hub 7-0:1.0: USB hub found
Nov 14 21:30:57 vinux kernel: [    1.290477] hub 7-0:1.0: 2 ports detected
Nov 14 21:30:57 vinux kernel: [    1.290608] uhci_hcd 0000:00:1d.2: PCI INT=
 C -> GSI 18 (level, low) -> IRQ 18
Nov 14 21:30:57 vinux kernel: [    1.290713] uhci_hcd 0000:00:1d.2: setting=
 latency timer to 64
Nov 14 21:30:57 vinux kernel: [    1.290720] uhci_hcd 0000:00:1d.2: UHCI Ho=
st Controller
Nov 14 21:30:57 vinux kernel: [    1.290807] uhci_hcd 0000:00:1d.2: new USB=
 bus registered, assigned bus number 8
Nov 14 21:30:57 vinux kernel: [    1.290959] uhci_hcd 0000:00:1d.2: irq 18,=
 io base 0x000018c0
Nov 14 21:30:57 vinux kernel: [    1.291079] usb usb8: New USB device found=
, idVendor=3D1d6b, idProduct=3D0001
Nov 14 21:30:57 vinux kernel: [    1.291165] usb usb8: New USB device strin=
gs: Mfr=3D3, Product=3D2, SerialNumber=3D1
Nov 14 21:30:57 vinux kernel: [    1.291272] usb usb8: Product: UHCI Host C=
ontroller
Nov 14 21:30:57 vinux kernel: [    1.291355] usb usb8: Manufacturer: Linux =
2.6.32-5-686 uhci_hcd
Nov 14 21:30:57 vinux kernel: [    1.291443] usb usb8: SerialNumber: 0000:0=
0:1d.2
Nov 14 21:30:57 vinux kernel: [    1.291795] usb usb8: configuration #1 cho=
sen from 1 choice
Nov 14 21:30:57 vinux kernel: [    1.291950] hub 8-0:1.0: USB hub found
Nov 14 21:30:57 vinux kernel: [    1.292050] hub 8-0:1.0: 2 ports detected
Nov 14 21:30:57 vinux kernel: [    1.310906] tg3 0000:07:00.0: eth0: Tigon3=
 [partno(BCM95906) rev c002] (PCI Express) MAC address 00:23:5a:17:01:6e
Nov 14 21:30:57 vinux kernel: [    1.310993] tg3 0000:07:00.0: eth0: attach=
ed PHY is 5906 (10/100Base-TX Ethernet) (WireSpeed[0])
Nov 14 21:30:57 vinux kernel: [    1.311072] tg3 0000:07:00.0: eth0: RXcsum=
s[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
Nov 14 21:30:57 vinux kernel: [    1.311151] tg3 0000:07:00.0: eth0: dma_rw=
ctrl[76180000] dma_mask[64-bit]
Nov 14 21:30:57 vinux kernel: [    1.569009] usb 1-6: new high speed USB de=
vice using ehci_hcd and address 2
Nov 14 21:30:57 vinux kernel: [    1.613018] ata1: SATA link down (SStatus =
0 SControl 300)
Nov 14 21:30:57 vinux kernel: [    1.701857] usb 1-6: New USB device found,=
 idVendor=3D0781, idProduct=3D5567
Nov 14 21:30:57 vinux kernel: [    1.701922] usb 1-6: New USB device string=
s: Mfr=3D1, Product=3D2, SerialNumber=3D3
Nov 14 21:30:57 vinux kernel: [    1.701987] usb 1-6: Product: Cruzer Blade
Nov 14 21:30:57 vinux kernel: [    1.702047] usb 1-6: Manufacturer: SanDisk
Nov 14 21:30:57 vinux kernel: [    1.702108] usb 1-6: SerialNumber: 2004351=
3421424F00A4F
Nov 14 21:30:57 vinux kernel: [    1.702252] usb 1-6: configuration #1 chos=
en from 1 choice
Nov 14 21:30:57 vinux kernel: [    1.708889] Initializing USB Mass Storage =
driver...
Nov 14 21:30:57 vinux kernel: [    1.709085] scsi4 : SCSI emulation for USB=
 Mass Storage devices
Nov 14 21:30:57 vinux kernel: [    1.709224] usbcore: registered new interf=
ace driver usb-storage
Nov 14 21:30:57 vinux kernel: [    1.709291] USB Mass Storage support regis=
tered.
Nov 14 21:30:57 vinux kernel: [    1.709357] usb-storage: device found at 2
Nov 14 21:30:57 vinux kernel: [    1.709358] usb-storage: waiting for devic=
e to settle before scanning
Nov 14 21:30:57 vinux kernel: [    1.813010] usb 3-3: new high speed USB de=
vice using ehci_hcd and address 2
Nov 14 21:30:57 vinux kernel: [    1.949023] ata2: SATA link up 1.5 Gbps (S=
Status 113 SControl 300)
Nov 14 21:30:57 vinux kernel: [    1.952813] ata2.00: ATAPI: HL-DT-ST DVDRA=
M GSA-T50N, RV06, max UDMA/133
Nov 14 21:30:57 vinux kernel: [    1.957769] ata2.00: configured for UDMA/1=
33
Nov 14 21:30:57 vinux kernel: [    2.086991] scsi 1:0:0:0: CD-ROM          =
  HL-DT-ST DVDRAM GSA-T50N  RV06 PQ: 0 ANSI: 5
Nov 14 21:30:57 vinux kernel: [    2.099970] usb 3-3: New USB device found,=
 idVendor=3D04f2, idProduct=3Db090
Nov 14 21:30:57 vinux kernel: [    2.100067] usb 3-3: New USB device string=
s: Mfr=3D1, Product=3D2, SerialNumber=3D0
Nov 14 21:30:57 vinux kernel: [    2.100136] usb 3-3: Product: Lenovo EasyC=
amera
Nov 14 21:30:57 vinux kernel: [    2.100949] usb 3-3: Manufacturer: Vimicro=
 Corp.
Nov 14 21:30:57 vinux kernel: [    2.101106] usb 3-3: configuration #1 chos=
en from 1 choice
Nov 14 21:30:57 vinux kernel: [    2.422941] sr0: scsi3-mmc drive: 24x/24x =
writer dvd-ram cd/rw xa/form2 cdda tray
Nov 14 21:30:57 vinux kernel: [    2.423022] Uniform CD-ROM driver Revision=
: 3.20
Nov 14 21:30:57 vinux kernel: [    2.423180] sr 1:0:0:0: Attached scsi CD-R=
OM sr0
Nov 14 21:30:57 vinux kernel: [    2.427234] sr 1:0:0:0: Attached scsi gene=
ric sg0 type 5
Nov 14 21:30:57 vinux kernel: [    6.709201] usb-storage: device scan compl=
ete
Nov 14 21:30:57 vinux kernel: [    6.709822] scsi 4:0:0:0: Direct-Access   =
  SanDisk  Cruzer Blade     1.14 PQ: 0 ANSI: 2
Nov 14 21:30:57 vinux kernel: [    6.710236] scsi 4:0:0:0: Attached scsi ge=
neric sg1 type 0
Nov 14 21:30:57 vinux kernel: [    6.716312] sd 4:0:0:0: [sda] 7821312 512-=
byte logical blocks: (4.00 GB/3.72 GiB)
Nov 14 21:30:57 vinux kernel: [    6.717805] sd 4:0:0:0: [sda] Write Protec=
t is off
Nov 14 21:30:57 vinux kernel: [    6.717867] sd 4:0:0:0: [sda] Mode Sense: =
03 00 00 00
Nov 14 21:30:57 vinux kernel: [    6.717870] sd 4:0:0:0: [sda] Assuming dri=
ve cache: write through
Nov 14 21:30:57 vinux kernel: [    6.720430] sd 4:0:0:0: [sda] Assuming dri=
ve cache: write through
Nov 14 21:30:57 vinux kernel: [    6.720494]  sda: sda1 sda2 sda3
Nov 14 21:30:57 vinux kernel: [    6.724555] sd 4:0:0:0: [sda] Assuming dri=
ve cache: write through
Nov 14 21:30:57 vinux kernel: [    6.724621] sd 4:0:0:0: [sda] Attached SCS=
I removable disk
Nov 14 21:30:57 vinux kernel: [    7.028659] EXT4-fs (sda1): mounted filesy=
stem with ordered data mode
Nov 14 21:30:57 vinux kernel: [    7.675596] udev[423]: starting version 164
Nov 14 21:30:57 vinux kernel: [    7.807298] ACPI: SSDT bdb1ac20 00265 (v01=
  PmRef  Cpu0Ist 00003000 INTL 20050624)
Nov 14 21:30:57 vinux kernel: [    7.827883] ACPI: SSDT bdb18620 00549 (v01=
  PmRef  Cpu0Cst 00003001 INTL 20050624)
Nov 14 21:30:57 vinux kernel: [    7.858295] Monitor-Mwait will be used to =
enter C-1 state
Nov 14 21:30:57 vinux kernel: [    7.888137] Monitor-Mwait will be used to =
enter C-2 state
Nov 14 21:30:57 vinux kernel: [    7.888144] Marking TSC unstable due to TS=
C halts in idle
Nov 14 21:30:57 vinux kernel: [    7.888303] processor LNXCPU:00: registere=
d as cooling_device0
Nov 14 21:30:57 vinux kernel: [    7.888891] ACPI: SSDT bdb19ca0 001CF (v01=
  PmRef    ApIst 00003000 INTL 20050624)
Nov 14 21:30:57 vinux kernel: [    7.889483] ACPI: SSDT bdb19f20 0008D (v01=
  PmRef    ApCst 00003000 INTL 20050624)
Nov 14 21:30:57 vinux kernel: [    7.892044] Switching to clocksource hpet
Nov 14 21:30:57 vinux kernel: [    7.892310] processor LNXCPU:01: registere=
d as cooling_device1
Nov 14 21:30:57 vinux kernel: [    7.906109] lib80211: common routines for =
IEEE802.11 drivers
Nov 14 21:30:57 vinux kernel: [    7.906181] lib80211_crypt: registered alg=
orithm 'NULL'
Nov 14 21:30:57 vinux kernel: [    8.558438] wl: module license 'MIXED/Prop=
rietary' taints kernel.
Nov 14 21:30:57 vinux kernel: [    8.558508] Disabling lock debugging due t=
o kernel taint
Nov 14 21:30:57 vinux kernel: [    8.564650] input: Lid Switch as /devices/=
LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input1
Nov 14 21:30:57 vinux kernel: [    8.564816] ACPI: Lid Switch [LID0]
Nov 14 21:30:57 vinux kernel: [    8.564940] input: Power Button as /device=
s/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input2
Nov 14 21:30:57 vinux kernel: [    8.565027] ACPI: Power Button [PWRB]
Nov 14 21:30:57 vinux kernel: [    8.565162] input: Power Button as /device=
s/LNXSYSTM:00/LNXPWRBN:00/input/input3
Nov 14 21:30:57 vinux kernel: [    8.565245] ACPI: Power Button [PWRF]
Nov 14 21:30:57 vinux kernel: [    8.568882] wl 0000:04:00.0: PCI INT A -> =
GSI 18 (level, low) -> IRQ 18
Nov 14 21:30:57 vinux kernel: [    8.568997] wl 0000:04:00.0: setting laten=
cy timer to 64
Nov 14 21:30:57 vinux kernel: [    8.569334] input: PC Speaker as /devices/=
platform/pcspkr/input/input4
Nov 14 21:30:57 vinux kernel: [    8.583369] i801_smbus 0000:00:1f.3: PCI I=
NT C -> GSI 19 (level, low) -> IRQ 19
Nov 14 21:30:57 vinux kernel: [    8.583452] ACPI: I/O resource 0000:00:1f.=
3 [0x1c00-0x1c1f] conflicts with ACPI region SMBI [0x1c00-0x1c0f]
Nov 14 21:30:57 vinux kernel: [    8.583582] ACPI: If an ACPI driver is ava=
ilable for this device, you should use it instead of the native driver
Nov 14 21:30:57 vinux kernel: [    8.588300] jmb38x_ms 0000:02:00.3: PCI IN=
T A -> GSI 16 (level, low) -> IRQ 16
Nov 14 21:30:57 vinux kernel: [    8.588387] jmb38x_ms 0000:02:00.3: settin=
g latency timer to 64
Nov 14 21:30:57 vinux kernel: [    8.594085] ACPI: AC Adapter [ACAD] (on-li=
ne)
Nov 14 21:30:57 vinux kernel: [    8.615386] lib80211_crypt: registered alg=
orithm 'TKIP'
Nov 14 21:30:57 vinux kernel: [    8.757606] ACPI: Battery Slot [BAT1] (bat=
tery present)
Nov 14 21:30:57 vinux kernel: [    8.758213] eth1: Broadcom BCM4315 802.11 =
Hybrid Wireless Controller 5.60.48.36=20
Nov 14 21:30:57 vinux kernel: [    8.769316] Linux video capture interface:=
 v2.00
Nov 14 21:30:57 vinux kernel: [    8.784857] uvcvideo: Found UVC 1.00 devic=
e Lenovo EasyCamera (04f2:b090)
Nov 14 21:30:57 vinux kernel: [    8.788177] input: Lenovo EasyCamera as /d=
evices/pci0000:00/0000:00:1d.7/usb3/3-3/3-3:1.0/input/input5
Nov 14 21:30:57 vinux kernel: [    8.788320] usbcore: registered new interf=
ace driver uvcvideo
Nov 14 21:30:57 vinux kernel: [    8.788386] USB Video Class driver (v0.1.0)
Nov 14 21:30:57 vinux kernel: [    8.808253] [drm] Initialized drm 1.1.0 20=
060810
Nov 14 21:30:57 vinux kernel: [    8.854048] pci 0000:00:02.0: PCI INT A ->=
 GSI 16 (level, low) -> IRQ 16
Nov 14 21:30:57 vinux kernel: [    8.854122] pci 0000:00:02.0: setting late=
ncy timer to 64
Nov 14 21:30:57 vinux kernel: [    8.860192] mtrr: type mismatch for d00000=
00,10000000 old: write-back new: write-combining
Nov 14 21:30:57 vinux kernel: [    8.860274] [drm] MTRR allocation failed. =
 Graphics performance may suffer.
Nov 14 21:30:57 vinux kernel: [    8.860429] pci 0000:00:02.0: irq 30 for M=
SI/MSI-X
Nov 14 21:30:57 vinux kernel: [    8.887967] acpi device:05: registered as =
cooling_device2
Nov 14 21:30:57 vinux kernel: [    8.916479] acpi device:06: registered as =
cooling_device3
Nov 14 21:30:57 vinux kernel: [    8.937741] acpi device:07: registered as =
cooling_device4
Nov 14 21:30:57 vinux kernel: [    8.948176] HDA Intel 0000:00:1b.0: power =
state changed by ACPI to D0
Nov 14 21:30:57 vinux kernel: [    8.948288] HDA Intel 0000:00:1b.0: power =
state changed by ACPI to D0
Nov 14 21:30:57 vinux kernel: [    8.948363] HDA Intel 0000:00:1b.0: PCI IN=
T A -> GSI 22 (level, low) -> IRQ 22
Nov 14 21:30:57 vinux kernel: [    8.948508] HDA Intel 0000:00:1b.0: irq 31=
 for MSI/MSI-X
Nov 14 21:30:57 vinux kernel: [    8.948537] HDA Intel 0000:00:1b.0: settin=
g latency timer to 64
Nov 14 21:30:57 vinux kernel: [    8.964050] acpi device:08: registered as =
cooling_device5
Nov 14 21:30:57 vinux kernel: [    8.992601] acpi device:09: registered as =
cooling_device6
Nov 14 21:30:57 vinux kernel: [    8.992803] input: Video Bus as /devices/L=
NXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:01/input/input6
Nov 14 21:30:57 vinux kernel: [    8.992932] ACPI: Video Device [GFX0] (mul=
ti-head: yes  rom: no  post: no)
Nov 14 21:30:57 vinux kernel: [    8.993026] [drm] Initialized i915 1.6.0 2=
0080730 for 0000:00:02.0 on minor 0
Nov 14 21:30:57 vinux kernel: [    9.010779] input: HDA Intel Mic as /devic=
es/pci0000:00/0000:00:1b.0/sound/card0/input7
Nov 14 21:30:57 vinux kernel: [    9.010942] input: HDA Intel Mic as /devic=
es/pci0000:00/0000:00:1b.0/sound/card0/input8
Nov 14 21:30:57 vinux kernel: [    9.011081] input: HDA Intel Headphone as =
/devices/pci0000:00/0000:00:1b.0/sound/card0/input9
Nov 14 21:30:57 vinux kernel: [    9.309423] input: PS/2 Mouse as /devices/=
platform/i8042/serio1/input/input10
Nov 14 21:30:57 vinux kernel: [    9.347979] input: AlpsPS/2 ALPS GlidePoin=
t as /devices/platform/i8042/serio1/input/input11
Nov 14 21:30:57 vinux kernel: [    9.564661] Adding 208836k swap on /dev/sd=
a3.  Priority:-1 extents:1 across:208836k=20
Nov 14 21:30:57 vinux kernel: [    9.709959] loop: module loaded
Nov 14 21:30:57 vinux kernel: [    9.730217] input: Speakup as /devices/vir=
tual/input/input12
Nov 14 21:30:57 vinux kernel: [    9.730424] speakup 3.1.5: initialized
Nov 14 21:30:57 vinux kernel: [    9.730495] synth name on entry is: <NULL>
Nov 14 21:30:57 vinux kernel: [    9.730930] initialized device: /dev/synth=
, node (MAJOR 10, MINOR 25)
Nov 14 21:30:57 vinux kernel: [    9.733621] synth probe
Nov 14 21:30:57 vinux kernel: [    9.734065] initialized device: /dev/softs=
ynth, node (MAJOR 10, MINOR 26)
Nov 14 21:30:57 vinux kernel: [    9.877615] EXT4-fs (sda2): mounted filesy=
stem with ordered data mode
Nov 14 21:30:57 vinux kernel: [   10.381844] fuse init (API version 7.13)
Nov 14 21:30:57 vinux kernel: [   10.819860] apm: BIOS not found.
Nov 14 21:30:59 vinux kernel: [   12.665417] input: ACPI Virtual Keyboard D=
evice as /devices/virtual/input/input13
Nov 14 21:30:59 vinux kernel: [   12.890636] Bluetooth: Core ver 2.15
Nov 14 21:30:59 vinux kernel: [   12.890811] NET: Registered protocol famil=
y 31
Nov 14 21:30:59 vinux kernel: [   12.890897] Bluetooth: HCI device and conn=
ection manager initialized
Nov 14 21:30:59 vinux kernel: [   12.890992] Bluetooth: HCI socket layer in=
itialized
Nov 14 21:30:59 vinux kernel: [   12.903506] Bluetooth: L2CAP ver 2.14
Nov 14 21:30:59 vinux kernel: [   12.903597] Bluetooth: L2CAP socket layer =
initialized
Nov 14 21:30:59 vinux kernel: [   12.922900] Bluetooth: BNEP (Ethernet Emul=
ation) ver 1.3
Nov 14 21:30:59 vinux kernel: [   12.923012] Bluetooth: BNEP filters: proto=
col multicast
Nov 14 21:30:59 vinux kernel: [   12.945253] Bridge firewalling registered
Nov 14 21:30:59 vinux kernel: [   12.960072] Bluetooth: SCO (Voice Link) ve=
r 0.6
Nov 14 21:30:59 vinux kernel: [   12.960162] Bluetooth: SCO socket layer in=
itialized
Nov 14 21:30:59 vinux kernel: [   12.979459] lp: driver loaded but no devic=
es found
Nov 14 21:30:59 vinux kernel: [   12.986681] ppdev: user-space parallel por=
t driver
Nov 14 21:31:00 vinux kernel: [   13.661172] tg3 0000:07:00.0: irq 32 for M=
SI/MSI-X
Nov 14 21:31:00 vinux kernel: [   13.693978] ADDRCONF(NETDEV_UP): eth0: lin=
k is not ready
Nov 14 21:31:08 vinux kernel: [   22.036017] eth1: no IPv6 routers present


I don't see a helpful error!

David


On Mon, 14 Nov 2011, Bruno Pr=E9mont wrote:

> On Mon, 14 November 2011 "D.J.J. Ring, Jr." <n1ea@arrl.net> wrote:
>> I am sorry Anatolij,
>>
>> I should have said that I DID run sudo update-grub and then I rebooted.
>>
>> When it rebooted, I still have the "no /dev/fb0" error.
>>
>> I apologize for not being thourough in my words.
>
> Please make sure "nomodeset" is no more present on kernel cmdline and
> if it's gone post your corresponding kernel log (at least the relevant
> parts of it like the few first line including cmdline and anything
> that is related to drm, i915, *fb*, vesa or vga)!
>
> Note, with grub you should also be able to edit the kernel cmdline from
> grubs interface before you tell it to boot the kernel.
> You could even attempt to reboot with kexec (where you can choose kernel
> and cmdline as well) if you can't convince grub.
>
> Bruno
>
--8323328-132040354-1321325380=:8842--
