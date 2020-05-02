From: Fabian Mastenbroek <mail.fabian.m@gmail.com>
Date: Sat, 02 May 2020 12:35:41 +0000
Subject: bug: kernel bug when unbinding EFI framebuffer
Message-Id: <45B8BCE9-2156-4248-8102-58736D02752D@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Apple-Mail=_1C931A90-7CC6-4EFF-8688-0FC5138E82C5"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org


--Apple-Mail=_1C931A90-7CC6-4EFF-8688-0FC5138E82C5
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

Hi,

When I try to unbind the EFI framebuffer via:

	echo -n efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

the process gets stuck and dmesg shows the following:

	WARNING: CPU: 14 PID: 1495 at drivers/video/fbdev/core/fbmem.c:1693
	...
	Call Trace: 
		unregister_framebuffer+0x22/0x40 
		efifb_remove+0x1e/0x40 
		platform_drv_remove+0x29/0x50 
		device_release_driver_internal+0x1ba/0x2d0 
 		device_driver_detach+0x14/0x20 
		unbind_store+0x11b/0x150 
		drv_attr_store+0x24/0x30 
		sysfs_kf_write+0x3f/0x50 
		kernfs_fop_write+0xda/0x1b0 
		x64_sys_write+0x17a/0x2f0 
		do_syscall_64+0x57/0x1b0 
		entry_SYSCALL_64_after_hwframe+0x44/0xa9
	... 
	kernel BUG at mm/slub.c:304!
	...
	Call Trace: 
		? do_invalid_op+0x39/0x140 
		? apic_timer_interrupt+0xa/0x20
		? do_unregister_framebuffer+0x10c/0x150
		kfree+0x231/0x250 
		do_unregister_framebuffer+0x10c/0x150 
		unregister_framebuffer+0x22/0x40
		efifb_remove+0x1e/0x40 
		platform_drv_remove+0x29/0x50
		device_release_driver_internal+0x1ba/0x2d0
		device_driver_detach+0x14/0x20
		unbind_store+0x11b/0x150 
		drv_attr_store+0x24/0x30
		sysfs_kf_write+0x3f/0x50
		kernfs_fop_write+0xda/0x1b0 
		x64_sys_write+0x17a/0x2f0
		do_syscall_64+0x57/0x1b0
		entry_SYSCALL_64_after_hwframe+0x44/0xa9

I have attached the full kernel log as well.

I have tested this issue on Ubuntu-based kernels 5.3, 5.4, 5.5 and 5.6 and
they all seem to give the same error. Oddly enough, it only happens when
I have nouveau enabled. In case I blacklist nouveau, everything works fine.
	

Best regards,

Fabian Mastenbroek


--Apple-Mail=_1C931A90-7CC6-4EFF-8688-0FC5138E82C5
Content-Disposition: attachment;
	filename=dmesg.txt
Content-Type: text/plain;
	x-unix-mode=0644;
	name="dmesg.txt"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Linux version 5.6.8-1-zen2 (github@pve-build-server-1) =
(gcc version 10.0.1 20200411 (experimental) [master revision =
bb87d5cc77d:75961caccb7:f883c46b4877f637e0fa5025b4d6b5c9040ec566] =
(Ubuntu 10-20200411-0ubuntu1)) #1 SMP 5.6.8-1-zen2 (Thu, 30 Apr 2020 =
18:41:30 +0200)
[    0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-5.6.8-1-zen2 =
root=3D/dev/mapper/pve-root ro amd_iommu=3Don mitigations=3Doff
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai =20
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating =
point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 =
bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] =
usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] =
reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009d81fff] =
usable
[    0.000000] BIOS-e820: [mem 0x0000000009d82000-0x0000000009ffffff] =
reserved
[    0.000000] BIOS-e820: [mem 0x000000000a000000-0x000000000a1fffff] =
usable
[    0.000000] BIOS-e820: [mem 0x000000000a200000-0x000000000a20bfff] =
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000000a20c000-0x000000000affffff] =
usable
[    0.000000] BIOS-e820: [mem 0x000000000b000000-0x000000000b01ffff] =
reserved
[    0.000000] BIOS-e820: [mem 0x000000000b020000-0x00000000db4f1fff] =
usable
[    0.000000] BIOS-e820: [mem 0x00000000db4f2000-0x00000000db705fff] =
reserved
[    0.000000] BIOS-e820: [mem 0x00000000db706000-0x00000000dbb8bfff] =
usable
[    0.000000] BIOS-e820: [mem 0x00000000dbb8c000-0x00000000dbcb1fff] =
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000dbcb2000-0x00000000dc9f5fff] =
reserved
[    0.000000] BIOS-e820: [mem 0x00000000dc9f6000-0x00000000dca9bfff] =
type 20
[    0.000000] BIOS-e820: [mem 0x00000000dca9c000-0x00000000deffffff] =
usable
[    0.000000] BIOS-e820: [mem 0x00000000df000000-0x00000000dfffffff] =
reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] =
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fd000000-0x00000000ffffffff] =
reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000101f2fffff] =
usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.70 by American Megatrends
[    0.000000] efi:  ACPI 2.0=3D0xdbc2f000  ACPI=3D0xdbc2f000  =
SMBIOS=3D0xdc8e0000  MEMATTR=3D0xd7ebc018  ESRT=3D0xd7ec2f98=20
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: Micro-Star International Co., Ltd MS-7C02/B450 =
TOMAHAWK MAX (MS-7C02), BIOS 3.60 04/22/2020
[    0.000000] tsc: Fast TSC calibration failed
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> =
reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] last_pfn =3D 0x101f300 max_arch_pfn =3D 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF write-through
[    0.000000]   C0000-DFFFF uncachable
[    0.000000]   E0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
[    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.000000]   2 base 0000C0000000 mask FFFFE0000000 write-back
[    0.000000]   3 base 0000DC0B0000 mask FFFFFFFF0000 uncachable
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] TOM2: 0000001020000000 aka 66048M
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- =
WT =20
[    0.000000] total RAM covered: 3583M
[    0.000000] Found optimal setting for mtrr clean up
[    0.000000]  gran_size: 64K 	chunk_size: 64M 	num_reg: 4  	=
lose cover RAM: 0G
[    0.000000] e820: update [mem 0xdc0b0000-0xdc0bffff] usable =3D=3D> =
reserved
[    0.000000] e820: update [mem 0xe0000000-0xffffffff] usable =3D=3D> =
reserved
[    0.000000] last_pfn =3D 0xdf000 max_arch_pfn =3D 0x400000000
[    0.000000] esrt: Reserving ESRT space from 0x00000000d7ec2f98 to =
0x00000000d7ec2fd0.
[    0.000000] e820: update [mem 0xd7ec2000-0xd7ec2fff] usable =3D=3D> =
reserved
[    0.000000] check: Scanning 1 areas for low memory corruption
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x9e2a01000, 0x9e2a01fff] PGTABLE
[    0.000000] BRK [0x9e2a02000, 0x9e2a02fff] PGTABLE
[    0.000000] BRK [0x9e2a03000, 0x9e2a03fff] PGTABLE
[    0.000000] BRK [0x9e2a04000, 0x9e2a04fff] PGTABLE
[    0.000000] BRK [0x9e2a05000, 0x9e2a05fff] PGTABLE
[    0.000000] BRK [0x9e2a06000, 0x9e2a06fff] PGTABLE
[    0.000000] BRK [0x9e2a07000, 0x9e2a07fff] PGTABLE
[    0.000000] BRK [0x9e2a08000, 0x9e2a08fff] PGTABLE
[    0.000000] BRK [0x9e2a09000, 0x9e2a09fff] PGTABLE
[    0.000000] BRK [0x9e2a0a000, 0x9e2a0afff] PGTABLE
[    0.000000] BRK [0x9e2a0b000, 0x9e2a0bfff] PGTABLE
[    0.000000] BRK [0x9e2a0c000, 0x9e2a0cfff] PGTABLE
[    0.000000] Secure boot could not be determined
[    0.000000] RAMDISK: [mem 0x33199000-0x358c3fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000DBC2F000 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x00000000DBC2F0A0 0000BC (v01 ALASKA A M I    =
01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x00000000DBC36C98 000114 (v06 ALASKA A M I    =
01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 0x00000000DBC2F1F0 007AA3 (v02 ALASKA A M I    =
01072009 INTL 20120913)
[    0.000000] ACPI: FACS 0x00000000DBC9BE00 000040
[    0.000000] ACPI: APIC 0x00000000DBC36DB0 00015E (v03 ALASKA A M I    =
01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x00000000DBC36F10 000044 (v01 ALASKA A M I    =
01072009 AMI  00010013)
[    0.000000] ACPI: FIDT 0x00000000DBC36F58 00009C (v01 ALASKA A M I    =
01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x00000000DBC36FF8 0001CC (v02 ALASKA CPUSSDT  =
01072009 AMI  01072009)
[    0.000000] ACPI: SSDT 0x00000000DBC371C8 008C98 (v02 AMD    AMD ALIB =
00000002 MSFT 04000000)
[    0.000000] ACPI: SSDT 0x00000000DBC3FE60 003676 (v01 AMD    AMD AOD  =
00000001 INTL 20120913)
[    0.000000] ACPI: MCFG 0x00000000DBC434D8 00003C (v01 ALASKA A M I    =
01072009 MSFT 00010013)
[    0.000000] ACPI: HPET 0x00000000DBC43518 000038 (v01 ALASKA A M I    =
01072009 AMI  00000005)
[    0.000000] ACPI: UEFI 0x00000000DBC43550 000042 (v01 ALASKA A M I    =
00000002      01000013)
[    0.000000] ACPI: IVRS 0x00000000DBC43598 0000D0 (v02 AMD    AMD IVRS =
00000001 AMD  00000000)
[    0.000000] ACPI: PCCT 0x00000000DBC43668 00006E (v01 AMD    AMD PCCT =
00000001 AMD  00000000)
[    0.000000] ACPI: SSDT 0x00000000DBC436D8 007D49 (v01 AMD    AMD CPU  =
00000001 AMD  00000001)
[    0.000000] ACPI: CRAT 0x00000000DBC4B428 001D58 (v01 AMD    AMD CRAT =
00000001 AMD  00000001)
[    0.000000] ACPI: CDIT 0x00000000DBC4D180 000029 (v01 AMD    AMD CDIT =
00000001 AMD  00000001)
[    0.000000] ACPI: BGRT 0x00000000DBC4D1B0 000038 (v01 ALASKA A M I    =
01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x00000000DBC4D1E8 001D4A (v01 AMD    AmdTable =
00000001 INTL 20120913)
[    0.000000] ACPI: SSDT 0x00000000DBC4EF38 0000BF (v01 AMD    AMD PT   =
00001000 INTL 20120913)
[    0.000000] ACPI: WSMT 0x00000000DBC4EFF8 000028 (v01 ALASKA A M I    =
01072009 AMI  00010013)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem =
0x0000000000000000-0x000000101f2fffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x101f2d6000-0x101f2fffff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000101f2fffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x0000000009d81fff]
[    0.000000]   node   0: [mem 0x000000000a000000-0x000000000a1fffff]
[    0.000000]   node   0: [mem 0x000000000a20c000-0x000000000affffff]
[    0.000000]   node   0: [mem 0x000000000b020000-0x00000000db4f1fff]
[    0.000000]   node   0: [mem 0x00000000db706000-0x00000000dbb8bfff]
[    0.000000]   node   0: [mem 0x00000000dca9c000-0x00000000deffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000101f2fffff]
[    0.000000] Zeroed struct page in unavailable ranges: 12591 pages
[    0.000000] Initmem setup node 0 [mem =
0x0000000000001000-0x000000101f2fffff]
[    0.000000] On node 0 totalpages: 16764625
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 30 pages reserved
[    0.000000]   DMA zone: 3999 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14129 pages used for memmap
[    0.000000]   DMA32 zone: 904242 pages, LIFO batch:63
[    0.000000]   Normal zone: 247756 pages used for memmap
[    0.000000]   Normal zone: 15856384 pages, LIFO batch:63
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 33, version 33, address 0xfec00000, =
GSI 0-23
[    0.000000] IOAPIC[1]: apic_id 34, version 33, address 0xfec01000, =
GSI 24-55
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low =
level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    0.000000] e820: update [mem 0xd7e26000-0xd7e82fff] usable =3D=3D> =
reserved
[    0.000000] smpboot: Allowing 32 CPUs, 0 hotplug CPUs
[    0.000000] PM: hibernation: Registered nosave memory: [mem =
0x00000000-0x00000fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem =
0x000a0000-0x000fffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem =
0x09d82000-0x09ffffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem =
0x0a200000-0x0a20bfff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem =
0x0b000000-0x0b01ffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem =
0xd7e26000-0xd7e82fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem =
0xd7ec2000-0xd7ec2fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem =
0xdb4f2000-0xdb705fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem =
0xdbb8c000-0xdbcb1fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem =
0xdbcb2000-0xdc9f5fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem =
0xdc9f6000-0xdca9bfff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem =
0xdf000000-0xdfffffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem =
0xe0000000-0xf7ffffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem =
0xf8000000-0xfbffffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem =
0xfc000000-0xfcffffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem =
0xfd000000-0xffffffff]
[    0.000000] [mem 0xe0000000-0xf7ffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff =
max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:32 =
nr_cpu_ids:32 nr_node_ids:1
[    0.000000] percpu: Embedded 57 pages/cpu s196608 r8192 d28672 =
u262144
[    0.000000] pcpu-alloc: s196608 r8192 d28672 u262144 alloc=3D1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 =
12 13 14 15=20
[    0.000000] pcpu-alloc: [0] 16 17 18 19 20 21 22 23 [0] 24 25 26 27 =
28 29 30 31=20
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: =
16502646
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: =
BOOT_IMAGE=3D/boot/vmlinuz-5.6.8-1-zen2 root=3D/dev/mapper/pve-root ro =
amd_iommu=3Don mitigations=3Doff
[    0.000000] Dentry cache hash table entries: 8388608 (order: 14, =
67108864 bytes, linear)
[    0.000000] Inode-cache hash table entries: 4194304 (order: 13, =
33554432 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:on, heap free:off
[    0.000000] Memory: 65659320K/67058500K available (16388K kernel =
code, 2554K rwdata, 5136K rodata, 2588K init, 4928K bss, 1399180K =
reserved, 0K cma-reserved)
[    0.000000] random: get_random_u64 called from =
__kmem_cache_create+0x42/0x730 with crng_init=3D0
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D32,=
 Nodes=3D1
[    0.000000] ftrace: allocating 42337 entries in 166 pages
[    0.000000] ftrace: allocated 166 pages with 4 groups
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to =
nr_cpu_ids=3D32.
[    0.000000] 	Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay =
is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, =
nr_cpu_ids=3D32
[    0.000000] NR_IRQS: 524544, nr_irqs: 1224, preallocated irqs: 16
[    0.000000] random: crng done (trusting CPU's manufacturer)
[    0.000000] Console: colour dummy device 80x25
[    0.000000] printk: console [tty0] enabled
[    0.000000] ACPI: Core revision 20200110
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: =
0xffffffff, max_idle_ns: 133484873504 ns
[    0.000000] APIC: Switch to symmetric I/O mode setup
[    0.004000] Switched APIC routing to physical flat.
[    0.004000] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 =
pin2=3D-1
[    0.032000] tsc: PIT calibration matches HPET. 2 loops
[    0.032000] tsc: Detected 3500.008 MHz processor
[    0.000002] clocksource: tsc-early: mask: 0xffffffffffffffff =
max_cycles: 0x327358ef10f, max_idle_ns: 440795330581 ns
[    0.000005] Calibrating delay loop (skipped), value calculated using =
timer frequency.. 7000.01 BogoMIPS (lpj=3D14000032)
[    0.000007] pid_max: default: 32768 minimum: 301
[    0.002456] LSM: Security Framework initializing
[    0.002463] Yama: becoming mindful.
[    0.002475] AppArmor: AppArmor initialized
[    0.002556] Mount-cache hash table entries: 131072 (order: 8, 1048576 =
bytes, linear)
[    0.002619] Mountpoint-cache hash table entries: 131072 (order: 8, =
1048576 bytes, linear)
[    0.002631] *** VALIDATE tmpfs ***
[    0.002717] *** VALIDATE proc ***
[    0.002750] *** VALIDATE cgroup ***
[    0.002752] *** VALIDATE cgroup2 ***
[    0.002772] x86/cpu: User Mode Instruction Prevention (UMIP) =
activated
[    0.002817] LVT offset 1 assigned for vector 0xf9
[    0.002927] LVT offset 2 assigned for vector 0xf4
[    0.002958] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
[    0.002959] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, =
1GB 0
[    0.002962] Speculative Store Bypass: Vulnerable
[    0.003108] Freeing SMP alternatives memory: 48K
[    0.114436] smpboot: CPU0: AMD Ryzen 9 3950X 16-Core Processor =
(family: 0x17, model: 0x71, stepping: 0x0)
[    0.114506] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
[    0.114508] ... version:                0
[    0.114509] ... bit width:              48
[    0.114510] ... generic registers:      6
[    0.114511] ... value mask:             0000ffffffffffff
[    0.114512] ... max period:             00007fffffffffff
[    0.114512] ... fixed-purpose events:   0
[    0.114513] ... event mask:             000000000000003f
[    0.114530] rcu: Hierarchical SRCU implementation.
[    0.114851] NMI watchdog: Enabled. Permanently consumes one hw-PMU =
counter.
[    0.114969] smp: Bringing up secondary CPUs ...
[    0.115013] x86: Booting SMP configuration:
[    0.115014] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  =
#8  #9 #10 #11 #12 #13 #14 #15 #16 #17 #18 #19 #20 #21 #22 #23 #24 #25 =
#26 #27 #28 #29 #30 #31
[    0.182191] smp: Brought up 1 node, 32 CPUs
[    0.182191] smpboot: Max logical packages: 1
[    0.182191] smpboot: Total of 32 processors activated (224000.51 =
BogoMIPS)
[    0.185142] devtmpfs: initialized
[    0.185142] x86/mm: Memory block size: 128MB
[    0.188041] PM: Registering ACPI NVS region [mem =
0x0a200000-0x0a20bfff] (49152 bytes)
[    0.188045] PM: Registering ACPI NVS region [mem =
0xdbb8c000-0xdbcb1fff] (1204224 bytes)
[    0.188148] clocksource: jiffies: mask: 0xffffffff max_cycles: =
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.188148] futex hash table entries: 8192 (order: 7, 524288 bytes, =
linear)
[    0.188182] pinctrl core: initialized pinctrl subsystem
[    0.188253] PM: RTC time: 11:47:52, date: 2020-05-02
[    0.188255] thermal_sys: Registered thermal governor 'fair_share'
[    0.188255] thermal_sys: Registered thermal governor 'bang_bang'
[    0.188257] thermal_sys: Registered thermal governor 'step_wise'
[    0.188258] thermal_sys: Registered thermal governor 'user_space'
[    0.188499] NET: Registered protocol family 16
[    0.188552] audit: initializing netlink subsys (disabled)
[    0.188560] audit: type=3D2000 audit(1588420071.220:1): =
state=3Dinitialized audit_enabled=3D0 res=3D1
[    0.188560] EISA bus registered
[    0.188560] cpuidle: using governor ladder
[    0.188560] cpuidle: using governor menu
[    0.188560] Detected 1 PCC Subspaces
[    0.188560] Registering PCC driver as Mailbox controller
[    0.188560] ACPI: bus type PCI registered
[    0.188560] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.188560] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem =
0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.188560] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in =
E820
[    0.188560] PCI: Using configuration type 1 for base access
[    0.196012] HugeTLB registered 1.00 GiB page size, pre-allocated 0 =
pages
[    0.196015] HugeTLB registered 2.00 MiB page size, pre-allocated 0 =
pages
[    0.196049] fbcon: Taking over console
[    0.196098] ACPI: Added _OSI(Module Device)
[    0.196099] ACPI: Added _OSI(Processor Device)
[    0.196100] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.196101] ACPI: Added _OSI(Processor Aggregator Device)
[    0.196103] ACPI: Added _OSI(Linux-Dell-Video)
[    0.196104] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.196105] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.208006] ACPI: 7 ACPI AML tables successfully acquired and loaded
[    0.208034] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.210347] ACPI: Interpreter enabled
[    0.210358] ACPI: (supports S0 S3 S4 S5)
[    0.210359] ACPI: Using IOAPIC for interrupt routing
[    0.210590] PCI: Using host bridge windows from ACPI; if necessary, =
use "pci=3Dnocrs" and report a bug
[    0.210813] ACPI: Enabled 2 GPEs in block 00 to 1F
[    0.216618] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.216622] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM =
ClockPM Segments MSI HPX-Type3]
[    0.216747] acpi PNP0A08:00: _OSC: platform does not support =
[SHPCHotplug PME LTR]
[    0.216864] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug AER =
PCIeCapability]
[    0.216872] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain =
0000 [bus 00-3f] only partially covers this bridge
[    0.217120] PCI host bridge to bus 0000:00
[    0.217122] pci_bus 0000:00: root bus resource [io  0x0000-0x03af =
window]
[    0.217124] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 =
window]
[    0.217125] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df =
window]
[    0.217126] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff =
window]
[    0.217127] pci_bus 0000:00: root bus resource [mem =
0x000a0000-0x000bffff window]
[    0.217129] pci_bus 0000:00: root bus resource [mem =
0x000c0000-0x000dffff window]
[    0.217130] pci_bus 0000:00: root bus resource [mem =
0xe0000000-0xfec2ffff window]
[    0.217132] pci_bus 0000:00: root bus resource [mem =
0xfee00000-0xffffffff window]
[    0.217133] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.217140] pci 0000:00:00.0: [1022:1480] type 00 class 0x060000
[    0.217223] pci 0000:00:00.2: [1022:1481] type 00 class 0x080600
[    0.217312] pci 0000:00:01.0: [1022:1482] type 00 class 0x060000
[    0.217376] pci 0000:00:01.1: [1022:1483] type 01 class 0x060400
[    0.217412] pci 0000:00:01.1: enabling Extended Tags
[    0.217462] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    0.217570] pci 0000:00:01.3: [1022:1483] type 01 class 0x060400
[    0.217606] pci 0000:00:01.3: enabling Extended Tags
[    0.217655] pci 0000:00:01.3: PME# supported from D0 D3hot D3cold
[    0.217757] pci 0000:00:02.0: [1022:1482] type 00 class 0x060000
[    0.217825] pci 0000:00:03.0: [1022:1482] type 00 class 0x060000
[    0.217889] pci 0000:00:03.1: [1022:1483] type 01 class 0x060400
[    0.217973] pci 0000:00:03.1: PME# supported from D0 D3hot D3cold
[    0.218078] pci 0000:00:04.0: [1022:1482] type 00 class 0x060000
[    0.218148] pci 0000:00:05.0: [1022:1482] type 00 class 0x060000
[    0.218215] pci 0000:00:07.0: [1022:1482] type 00 class 0x060000
[    0.218276] pci 0000:00:07.1: [1022:1484] type 01 class 0x060400
[    0.218304] pci 0000:00:07.1: enabling Extended Tags
[    0.218339] pci 0000:00:07.1: PME# supported from D0 D3hot D3cold
[    0.218420] pci 0000:00:08.0: [1022:1482] type 00 class 0x060000
[    0.218482] pci 0000:00:08.1: [1022:1484] type 01 class 0x060400
[    0.218511] pci 0000:00:08.1: enabling Extended Tags
[    0.218549] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.218630] pci 0000:00:08.2: [1022:1484] type 01 class 0x060400
[    0.218660] pci 0000:00:08.2: enabling Extended Tags
[    0.218699] pci 0000:00:08.2: PME# supported from D0 D3hot D3cold
[    0.218779] pci 0000:00:08.3: [1022:1484] type 01 class 0x060400
[    0.218809] pci 0000:00:08.3: enabling Extended Tags
[    0.218847] pci 0000:00:08.3: PME# supported from D0 D3hot D3cold
[    0.218941] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
[    0.219050] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
[    0.219165] pci 0000:00:18.0: [1022:1440] type 00 class 0x060000
[    0.219204] pci 0000:00:18.1: [1022:1441] type 00 class 0x060000
[    0.219244] pci 0000:00:18.2: [1022:1442] type 00 class 0x060000
[    0.219283] pci 0000:00:18.3: [1022:1443] type 00 class 0x060000
[    0.219323] pci 0000:00:18.4: [1022:1444] type 00 class 0x060000
[    0.219363] pci 0000:00:18.5: [1022:1445] type 00 class 0x060000
[    0.219402] pci 0000:00:18.6: [1022:1446] type 00 class 0x060000
[    0.219441] pci 0000:00:18.7: [1022:1447] type 00 class 0x060000
[    0.219528] pci 0000:01:00.0: [144d:a808] type 00 class 0x010802
[    0.219556] pci 0000:01:00.0: reg 0x10: [mem 0xf7900000-0xf7903fff =
64bit]
[    0.219767] pci 0000:00:01.1: PCI bridge to [bus 01]
[    0.219772] pci 0000:00:01.1:   bridge window [mem =
0xf7900000-0xf79fffff]
[    0.219824] pci 0000:03:00.0: [1022:43d5] type 00 class 0x0c0330
[    0.219850] pci 0000:03:00.0: reg 0x10: [mem 0xf76a0000-0xf76a7fff =
64bit]
[    0.219893] pci 0000:03:00.0: enabling Extended Tags
[    0.219948] pci 0000:03:00.0: PME# supported from D3hot D3cold
[    0.220030] pci 0000:03:00.1: [1022:43c8] type 00 class 0x010601
[    0.220085] pci 0000:03:00.1: reg 0x24: [mem 0xf7680000-0xf769ffff]
[    0.220094] pci 0000:03:00.1: reg 0x30: [mem 0xf7600000-0xf767ffff =
pref]
[    0.220101] pci 0000:03:00.1: enabling Extended Tags
[    0.220144] pci 0000:03:00.1: PME# supported from D3hot D3cold
[    0.220199] pci 0000:03:00.2: [1022:43c6] type 01 class 0x060400
[    0.220250] pci 0000:03:00.2: enabling Extended Tags
[    0.220298] pci 0000:03:00.2: PME# supported from D3hot D3cold
[    0.220393] pci 0000:00:01.3: PCI bridge to [bus 03-25]
[    0.220397] pci 0000:00:01.3:   bridge window [io  0xf000-0xffff]
[    0.220399] pci 0000:00:01.3:   bridge window [mem =
0xf7500000-0xf76fffff]
[    0.220480] pci 0000:20:00.0: [1022:43c7] type 01 class 0x060400
[    0.220536] pci 0000:20:00.0: enabling Extended Tags
[    0.220596] pci 0000:20:00.0: PME# supported from D3hot D3cold
[    0.220676] pci 0000:20:01.0: [1022:43c7] type 01 class 0x060400
[    0.220733] pci 0000:20:01.0: enabling Extended Tags
[    0.220792] pci 0000:20:01.0: PME# supported from D3hot D3cold
[    0.220879] pci 0000:20:04.0: [1022:43c7] type 01 class 0x060400
[    0.220935] pci 0000:20:04.0: enabling Extended Tags
[    0.220995] pci 0000:20:04.0: PME# supported from D3hot D3cold
[    0.221089] pci 0000:03:00.2: PCI bridge to [bus 20-25]
[    0.221095] pci 0000:03:00.2:   bridge window [io  0xf000-0xffff]
[    0.221098] pci 0000:03:00.2:   bridge window [mem =
0xf7500000-0xf75fffff]
[    0.221140] pci 0000:20:00.0: PCI bridge to [bus 21]
[    0.221205] pci 0000:22:00.0: [10ec:8168] type 00 class 0x020000
[    0.221245] pci 0000:22:00.0: reg 0x10: [io  0xf000-0xf0ff]
[    0.221276] pci 0000:22:00.0: reg 0x18: [mem 0xf7504000-0xf7504fff =
64bit]
[    0.221295] pci 0000:22:00.0: reg 0x20: [mem 0xf7500000-0xf7503fff =
64bit]
[    0.221440] pci 0000:22:00.0: supports D1 D2
[    0.221441] pci 0000:22:00.0: PME# supported from D0 D1 D2 D3hot =
D3cold
[    0.221642] pci 0000:20:01.0: PCI bridge to [bus 22]
[    0.221647] pci 0000:20:01.0:   bridge window [io  0xf000-0xffff]
[    0.221651] pci 0000:20:01.0:   bridge window [mem =
0xf7500000-0xf75fffff]
[    0.221692] pci 0000:20:04.0: PCI bridge to [bus 25]
[    0.221762] pci 0000:26:00.0: [10de:1e84] type 00 class 0x030000
[    0.221789] pci 0000:26:00.0: reg 0x10: [mem 0xf6000000-0xf6ffffff]
[    0.221801] pci 0000:26:00.0: reg 0x14: [mem 0xe0000000-0xefffffff =
64bit pref]
[    0.221813] pci 0000:26:00.0: reg 0x1c: [mem 0xf0000000-0xf1ffffff =
64bit pref]
[    0.221822] pci 0000:26:00.0: reg 0x24: [io  0xe000-0xe07f]
[    0.221830] pci 0000:26:00.0: reg 0x30: [mem 0xf7000000-0xf707ffff =
pref]
[    0.221845] pci 0000:26:00.0: BAR 1: assigned to efifb
[    0.221896] pci 0000:26:00.0: PME# supported from D0 D3hot D3cold
[    0.221966] pci 0000:26:00.0: 32.000 Gb/s available PCIe bandwidth, =
limited by 2.5 GT/s x16 link at 0000:00:03.1 (capable of 126.016 Gb/s =
with 8 GT/s x16 link)
[    0.221991] pci 0000:26:00.1: [10de:10f8] type 00 class 0x040300
[    0.222007] pci 0000:26:00.1: reg 0x10: [mem 0xf7080000-0xf7083fff]
[    0.222126] pci 0000:26:00.2: [10de:1ad8] type 00 class 0x0c0330
[    0.222149] pci 0000:26:00.2: reg 0x10: [mem 0xf2000000-0xf203ffff =
64bit pref]
[    0.222169] pci 0000:26:00.2: reg 0x1c: [mem 0xf2040000-0xf204ffff =
64bit pref]
[    0.222229] pci 0000:26:00.2: PME# supported from D0 D3hot D3cold
[    0.222275] pci 0000:26:00.3: [10de:1ad9] type 00 class 0x0c8000
[    0.222291] pci 0000:26:00.3: reg 0x10: [mem 0xf7084000-0xf7084fff]
[    0.222366] pci 0000:26:00.3: PME# supported from D0 D3hot D3cold
[    0.222459] pci 0000:00:03.1: PCI bridge to [bus 26]
[    0.222462] pci 0000:00:03.1:   bridge window [io  0xe000-0xefff]
[    0.222465] pci 0000:00:03.1:   bridge window [mem =
0xf6000000-0xf70fffff]
[    0.222469] pci 0000:00:03.1:   bridge window [mem =
0xe0000000-0xf20fffff 64bit pref]
[    0.222500] pci 0000:27:00.0: [1022:148a] type 00 class 0x130000
[    0.222533] pci 0000:27:00.0: enabling Extended Tags
[    0.222637] pci 0000:00:07.1: PCI bridge to [bus 27]
[    0.222682] pci 0000:28:00.0: [1022:1485] type 00 class 0x130000
[    0.222722] pci 0000:28:00.0: enabling Extended Tags
[    0.222819] pci 0000:28:00.1: [1022:1486] type 00 class 0x108000
[    0.222840] pci 0000:28:00.1: reg 0x18: [mem 0xf7300000-0xf73fffff]
[    0.222851] pci 0000:28:00.1: reg 0x24: [mem 0xf7408000-0xf7409fff]
[    0.222860] pci 0000:28:00.1: enabling Extended Tags
[    0.222947] pci 0000:28:00.3: [1022:149c] type 00 class 0x0c0330
[    0.222965] pci 0000:28:00.3: reg 0x10: [mem 0xf7200000-0xf72fffff =
64bit]
[    0.222994] pci 0000:28:00.3: enabling Extended Tags
[    0.223037] pci 0000:28:00.3: PME# supported from D0 D3hot D3cold
[    0.223092] pci 0000:28:00.4: [1022:1487] type 00 class 0x040300
[    0.223106] pci 0000:28:00.4: reg 0x10: [mem 0xf7400000-0xf7407fff]
[    0.223131] pci 0000:28:00.4: enabling Extended Tags
[    0.223171] pci 0000:28:00.4: PME# supported from D0 D3hot D3cold
[    0.223252] pci 0000:00:08.1: PCI bridge to [bus 28]
[    0.223257] pci 0000:00:08.1:   bridge window [mem =
0xf7200000-0xf74fffff]
[    0.223293] pci 0000:30:00.0: [1022:7901] type 00 class 0x010601
[    0.223334] pci 0000:30:00.0: reg 0x24: [mem 0xf7800000-0xf78007ff]
[    0.223344] pci 0000:30:00.0: enabling Extended Tags
[    0.223395] pci 0000:30:00.0: PME# supported from D3hot D3cold
[    0.223480] pci 0000:00:08.2: PCI bridge to [bus 30]
[    0.223485] pci 0000:00:08.2:   bridge window [mem =
0xf7800000-0xf78fffff]
[    0.223520] pci 0000:31:00.0: [1022:7901] type 00 class 0x010601
[    0.223562] pci 0000:31:00.0: reg 0x24: [mem 0xf7700000-0xf77007ff]
[    0.223572] pci 0000:31:00.0: enabling Extended Tags
[    0.223623] pci 0000:31:00.0: PME# supported from D3hot D3cold
[    0.223709] pci 0000:00:08.3: PCI bridge to [bus 31]
[    0.223713] pci 0000:00:08.3:   bridge window [mem =
0xf7700000-0xf77fffff]
[    0.223985] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 5 7 10 11 14 15) =
*0
[    0.224028] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 5 7 10 11 14 15) =
*0
[    0.224063] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 5 7 10 11 14 15) =
*0
[    0.224106] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 5 7 10 11 14 15) =
*0
[    0.224144] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 5 7 10 11 14 15) =
*0
[    0.224178] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 7 10 11 14 15) =
*0
[    0.224209] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 5 7 10 11 14 15) =
*0
[    0.224240] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 7 10 11 14 15) =
*0
[    0.224594] iommu: Default domain type: Translated=20
[    0.224594] pci 0000:26:00.0: vgaarb: VGA device added: =
decodes=3Dio+mem,owns=3Dnone,locks=3Dnone
[    0.224594] pci 0000:26:00.0: vgaarb: bridge control possible
[    0.224594] pci 0000:26:00.0: vgaarb: setting as boot device
[    0.224594] vgaarb: loaded
[    0.224594] SCSI subsystem initialized
[    0.224594] libata version 3.00 loaded.
[    0.224594] ACPI: bus type USB registered
[    0.224594] usbcore: registered new interface driver usbfs
[    0.224594] usbcore: registered new interface driver hub
[    0.224594] usbcore: registered new device driver usb
[    0.224594] pps_core: LinuxPPS API ver. 1 registered
[    0.224594] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 =
Rodolfo Giometti <giometti@linux.it>
[    0.224594] PTP clock support registered
[    0.224594] EDAC MC: Ver: 3.0.0
[    0.224594] Registered efivars operations
[    0.224594] PCI: Using ACPI for IRQ routing
[    0.225707] PCI: pci_cache_line_size set to 64 bytes
[    0.225773] Expanded resource Reserved due to conflict with PCI Bus =
0000:00
[    0.225775] e820: reserve RAM buffer [mem 0x09d82000-0x0bffffff]
[    0.225775] e820: reserve RAM buffer [mem 0x0a200000-0x0bffffff]
[    0.225776] e820: reserve RAM buffer [mem 0x0b000000-0x0bffffff]
[    0.225776] e820: reserve RAM buffer [mem 0xd7e26000-0xd7ffffff]
[    0.225776] e820: reserve RAM buffer [mem 0xd7ec2000-0xd7ffffff]
[    0.225777] e820: reserve RAM buffer [mem 0xdb4f2000-0xdbffffff]
[    0.225777] e820: reserve RAM buffer [mem 0xdbb8c000-0xdbffffff]
[    0.225777] e820: reserve RAM buffer [mem 0xdf000000-0xdfffffff]
[    0.225778] e820: reserve RAM buffer [mem 0x101f300000-0x101fffffff]
[    0.225833] NetLabel: Initializing
[    0.225834] NetLabel:  domain hash size =3D 128
[    0.225835] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.225844] NetLabel:  unlabeled traffic allowed by default
[    0.228048] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.228051] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.230084] clocksource: Switched to clocksource tsc-early
[    0.234877] *** VALIDATE bpf ***
[    0.234948] VFS: Disk quotas dquot_6.6.0
[    0.234962] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 =
bytes)
[    0.234978] *** VALIDATE ramfs ***
[    0.234981] *** VALIDATE hugetlbfs ***
[    0.235023] AppArmor: AppArmor Filesystem Enabled
[    0.235036] pnp: PnP ACPI init
[    0.235140] system 00:00: [mem 0xf8000000-0xfbffffff] has been =
reserved
[    0.235144] system 00:00: Plug and Play ACPI device, IDs PNP0c01 =
(active)
[    0.235203] system 00:01: [mem 0xfd000000-0xfd0fffff] has been =
reserved
[    0.235205] system 00:01: Plug and Play ACPI device, IDs PNP0c02 =
(active)
[    0.235234] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 =
(active)
[    0.235363] system 00:03: [io  0x0a00-0x0a0f] has been reserved
[    0.235364] system 00:03: [io  0x0a10-0x0a1f] has been reserved
[    0.235365] system 00:03: [io  0x0a20-0x0a2f] has been reserved
[    0.235367] system 00:03: [io  0x0a30-0x0a3f] has been reserved
[    0.235369] system 00:03: Plug and Play ACPI device, IDs PNP0c02 =
(active)
[    0.235557] pnp 00:04: [dma 0 disabled]
[    0.235577] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 =
(active)
[    0.235721] system 00:05: [io  0x04d0-0x04d1] has been reserved
[    0.235722] system 00:05: [io  0x040b] has been reserved
[    0.235724] system 00:05: [io  0x04d6] has been reserved
[    0.235725] system 00:05: [io  0x0c00-0x0c01] has been reserved
[    0.235726] system 00:05: [io  0x0c14] has been reserved
[    0.235727] system 00:05: [io  0x0c50-0x0c51] has been reserved
[    0.235729] system 00:05: [io  0x0c52] has been reserved
[    0.235730] system 00:05: [io  0x0c6c] has been reserved
[    0.235731] system 00:05: [io  0x0c6f] has been reserved
[    0.235732] system 00:05: [io  0x0cd0-0x0cd1] has been reserved
[    0.235733] system 00:05: [io  0x0cd2-0x0cd3] has been reserved
[    0.235734] system 00:05: [io  0x0cd4-0x0cd5] has been reserved
[    0.235736] system 00:05: [io  0x0cd6-0x0cd7] has been reserved
[    0.235737] system 00:05: [io  0x0cd8-0x0cdf] has been reserved
[    0.235738] system 00:05: [io  0x0800-0x089f] has been reserved
[    0.235739] system 00:05: [io  0x0b00-0x0b0f] has been reserved
[    0.235740] system 00:05: [io  0x0b20-0x0b3f] has been reserved
[    0.235742] system 00:05: [io  0x0900-0x090f] has been reserved
[    0.235743] system 00:05: [io  0x0910-0x091f] has been reserved
[    0.235744] system 00:05: [mem 0xfec00000-0xfec00fff] could not be =
reserved
[    0.235746] system 00:05: [mem 0xfec01000-0xfec01fff] could not be =
reserved
[    0.235747] system 00:05: [mem 0xfedc0000-0xfedc0fff] has been =
reserved
[    0.235749] system 00:05: [mem 0xfee00000-0xfee00fff] has been =
reserved
[    0.235750] system 00:05: [mem 0xfed80000-0xfed8ffff] could not be =
reserved
[    0.235751] system 00:05: [mem 0xfec10000-0xfec10fff] has been =
reserved
[    0.235753] system 00:05: [mem 0xff000000-0xffffffff] has been =
reserved
[    0.235755] system 00:05: Plug and Play ACPI device, IDs PNP0c02 =
(active)
[    0.236059] pnp: PnP ACPI: found 6 devices
[    0.241156] clocksource: acpi_pm: mask: 0xffffff max_cycles: =
0xffffff, max_idle_ns: 2085701024 ns
[    0.241181] pci 0000:00:01.1: PCI bridge to [bus 01]
[    0.241185] pci 0000:00:01.1:   bridge window [mem =
0xf7900000-0xf79fffff]
[    0.241191] pci 0000:20:00.0: PCI bridge to [bus 21]
[    0.241202] pci 0000:20:01.0: PCI bridge to [bus 22]
[    0.241204] pci 0000:20:01.0:   bridge window [io  0xf000-0xffff]
[    0.241209] pci 0000:20:01.0:   bridge window [mem =
0xf7500000-0xf75fffff]
[    0.241217] pci 0000:20:04.0: PCI bridge to [bus 25]
[    0.241228] pci 0000:03:00.2: PCI bridge to [bus 20-25]
[    0.241230] pci 0000:03:00.2:   bridge window [io  0xf000-0xffff]
[    0.241234] pci 0000:03:00.2:   bridge window [mem =
0xf7500000-0xf75fffff]
[    0.241242] pci 0000:00:01.3: PCI bridge to [bus 03-25]
[    0.241243] pci 0000:00:01.3:   bridge window [io  0xf000-0xffff]
[    0.241246] pci 0000:00:01.3:   bridge window [mem =
0xf7500000-0xf76fffff]
[    0.241252] pci 0000:00:03.1: PCI bridge to [bus 26]
[    0.241253] pci 0000:00:03.1:   bridge window [io  0xe000-0xefff]
[    0.241256] pci 0000:00:03.1:   bridge window [mem =
0xf6000000-0xf70fffff]
[    0.241259] pci 0000:00:03.1:   bridge window [mem =
0xe0000000-0xf20fffff 64bit pref]
[    0.241263] pci 0000:00:07.1: PCI bridge to [bus 27]
[    0.241269] pci 0000:00:08.1: PCI bridge to [bus 28]
[    0.241272] pci 0000:00:08.1:   bridge window [mem =
0xf7200000-0xf74fffff]
[    0.241276] pci 0000:00:08.2: PCI bridge to [bus 30]
[    0.241279] pci 0000:00:08.2:   bridge window [mem =
0xf7800000-0xf78fffff]
[    0.241283] pci 0000:00:08.3: PCI bridge to [bus 31]
[    0.241286] pci 0000:00:08.3:   bridge window [mem =
0xf7700000-0xf77fffff]
[    0.241291] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.241292] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.241293] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.241294] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.241295] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff =
window]
[    0.241297] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff =
window]
[    0.241298] pci_bus 0000:00: resource 10 [mem 0xe0000000-0xfec2ffff =
window]
[    0.241299] pci_bus 0000:00: resource 11 [mem 0xfee00000-0xffffffff =
window]
[    0.241300] pci_bus 0000:01: resource 1 [mem 0xf7900000-0xf79fffff]
[    0.241302] pci_bus 0000:03: resource 0 [io  0xf000-0xffff]
[    0.241303] pci_bus 0000:03: resource 1 [mem 0xf7500000-0xf76fffff]
[    0.241304] pci_bus 0000:20: resource 0 [io  0xf000-0xffff]
[    0.241305] pci_bus 0000:20: resource 1 [mem 0xf7500000-0xf75fffff]
[    0.241306] pci_bus 0000:22: resource 0 [io  0xf000-0xffff]
[    0.241307] pci_bus 0000:22: resource 1 [mem 0xf7500000-0xf75fffff]
[    0.241309] pci_bus 0000:26: resource 0 [io  0xe000-0xefff]
[    0.241310] pci_bus 0000:26: resource 1 [mem 0xf6000000-0xf70fffff]
[    0.241311] pci_bus 0000:26: resource 2 [mem 0xe0000000-0xf20fffff =
64bit pref]
[    0.241312] pci_bus 0000:28: resource 1 [mem 0xf7200000-0xf74fffff]
[    0.241314] pci_bus 0000:30: resource 1 [mem 0xf7800000-0xf78fffff]
[    0.241315] pci_bus 0000:31: resource 1 [mem 0xf7700000-0xf77fffff]
[    0.241373] NET: Registered protocol family 2
[    0.241509] tcp_listen_portaddr_hash hash table entries: 32768 =
(order: 7, 524288 bytes, linear)
[    0.241724] TCP established hash table entries: 524288 (order: 10, =
4194304 bytes, linear)
[    0.242123] TCP bind hash table entries: 65536 (order: 8, 1048576 =
bytes, linear)
[    0.242168] TCP: Hash tables configured (established 524288 bind =
65536)
[    0.242247] UDP hash table entries: 32768 (order: 8, 1048576 bytes, =
linear)
[    0.242357] UDP-Lite hash table entries: 32768 (order: 8, 1048576 =
bytes, linear)
[    0.242449] NET: Registered protocol family 1
[    0.242452] NET: Registered protocol family 44
[    0.242586] pci 0000:26:00.1: D0 power state depends on 0000:26:00.0
[    0.242597] pci 0000:26:00.2: D0 power state depends on 0000:26:00.0
[    0.242663] pci 0000:26:00.3: D0 power state depends on 0000:26:00.0
[    0.242742] PCI: CLS 64 bytes, default 64
[    0.242769] Trying to unpack rootfs image as initramfs...
[    0.622818] Freeing initrd memory: 40108K
[    0.622838] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters =
supported
[    0.622895] pci 0000:00:01.0: Adding to iommu group 0
[    0.623072] pci 0000:00:01.1: Adding to iommu group 1
[    0.623193] pci 0000:00:01.3: Adding to iommu group 2
[    0.623331] pci 0000:00:02.0: Adding to iommu group 3
[    0.623464] pci 0000:00:03.0: Adding to iommu group 4
[    0.623567] pci 0000:00:03.1: Adding to iommu group 5
[    0.623701] pci 0000:00:04.0: Adding to iommu group 6
[    0.623800] pci 0000:00:05.0: Adding to iommu group 7
[    0.623937] pci 0000:00:07.0: Adding to iommu group 8
[    0.624039] pci 0000:00:07.1: Adding to iommu group 9
[    0.624195] pci 0000:00:08.0: Adding to iommu group 10
[    0.624301] pci 0000:00:08.1: Adding to iommu group 11
[    0.624441] pci 0000:00:08.2: Adding to iommu group 12
[    0.624542] pci 0000:00:08.3: Adding to iommu group 13
[    0.624678] pci 0000:00:14.0: Adding to iommu group 14
[    0.624775] pci 0000:00:14.3: Adding to iommu group 14
[    0.624805] pci 0000:00:18.0: Adding to iommu group 15
[    0.624942] pci 0000:00:18.1: Adding to iommu group 15
[    0.624959] pci 0000:00:18.2: Adding to iommu group 15
[    0.624976] pci 0000:00:18.3: Adding to iommu group 15
[    0.624993] pci 0000:00:18.4: Adding to iommu group 15
[    0.625009] pci 0000:00:18.5: Adding to iommu group 15
[    0.625026] pci 0000:00:18.6: Adding to iommu group 15
[    0.625042] pci 0000:00:18.7: Adding to iommu group 15
[    0.625065] pci 0000:01:00.0: Adding to iommu group 16
[    0.625189] pci 0000:03:00.0: Adding to iommu group 17
[    0.625344] pci 0000:03:00.1: Adding to iommu group 17
[    0.625377] pci 0000:03:00.2: Adding to iommu group 17
[    0.625396] pci 0000:20:00.0: Adding to iommu group 17
[    0.625414] pci 0000:20:01.0: Adding to iommu group 17
[    0.625433] pci 0000:20:04.0: Adding to iommu group 17
[    0.625463] pci 0000:22:00.0: Adding to iommu group 17
[    0.625517] pci 0000:26:00.0: Adding to iommu group 18
[    0.625640] pci 0000:26:00.1: Adding to iommu group 18
[    0.625680] pci 0000:26:00.2: Adding to iommu group 18
[    0.625720] pci 0000:26:00.3: Adding to iommu group 18
[    0.625740] pci 0000:27:00.0: Adding to iommu group 19
[    0.625887] pci 0000:28:00.0: Adding to iommu group 20
[    0.625995] pci 0000:28:00.1: Adding to iommu group 21
[    0.626139] pci 0000:28:00.3: Adding to iommu group 22
[    0.626249] pci 0000:28:00.4: Adding to iommu group 23
[    0.626379] pci 0000:30:00.0: Adding to iommu group 24
[    0.626520] pci 0000:31:00.0: Adding to iommu group 25
[    0.626740] pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
[    0.626742] pci 0000:00:00.2: AMD-Vi: Extended features =
(0x58f77ef22294ade):
[    0.626743]  PPR X2APIC NX GT IA GA PC GA_vAPIC
[    0.626745] AMD-Vi: Interrupt remapping enabled
[    0.626746] AMD-Vi: Virtual APIC enabled
[    0.626746] AMD-Vi: X2APIC enabled
[    0.626838] AMD-Vi: Lazy IO/TLB flushing enabled
[    0.627421] amd_uncore: AMD NB counters detected
[    0.627426] amd_uncore: AMD LLC counters detected
[    0.627931] LVT offset 0 assigned for vector 0x400
[    0.628151] perf: AMD IBS detected (0x000003ff)
[    0.628155] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 =
counters/bank).
[    0.628182] check: Scanning for low memory corruption every 60 =
seconds
[    0.629428] Initialise system trusted keyrings
[    0.629437] Key type blacklist registered
[    0.629466] workingset: timestamp_bits=3D36 max_order=3D24 =
bucket_order=3D0
[    0.630108] zbud: loaded
[    0.630263] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.630364] fuse: init (API version 7.31)
[    0.630373] *** VALIDATE fuseblk ***
[    0.630374] *** VALIDATE fuse ***
[    0.630466] Platform Keyring initialized
[    0.632098] Key type asymmetric registered
[    0.632099] Asymmetric key parser 'x509' registered
[    0.632104] Block layer SCSI generic (bsg) driver version 0.4 loaded =
(major 244)
[    0.632148] io scheduler mq-deadline registered
[    0.632904] pcieport 0000:00:01.1: AER: enabled with IRQ 26
[    0.633029] pcieport 0000:00:01.3: AER: enabled with IRQ 27
[    0.633150] pcieport 0000:00:03.1: AER: enabled with IRQ 28
[    0.633313] pcieport 0000:00:07.1: AER: enabled with IRQ 30
[    0.633416] pcieport 0000:00:08.1: AER: enabled with IRQ 31
[    0.633548] pcieport 0000:00:08.2: AER: enabled with IRQ 32
[    0.633679] pcieport 0000:00:08.3: AER: enabled with IRQ 33
[    0.634181] shpchp: Standard Hot Plug PCI Controller Driver version: =
0.4
[    0.634210] efifb: probing for efifb
[    0.634235] efifb: framebuffer at 0xe0000000, using 3072k, total =
3072k
[    0.634236] efifb: mode is 1024x768x32, linelength=3D4096, pages=3D1
[    0.634237] efifb: scrolling: redraw
[    0.634238] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[    0.634286] Console: switching to colour frame buffer device 128x48
[    0.635345] fb0: EFI VGA frame buffer device
[    0.635418] input: Power Button as =
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.635444] ACPI: Power Button [PWRB]
[    0.635465] input: Power Button as =
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.635496] ACPI: Power Button [PWRF]
[    0.635538] Monitor-Mwait will be used to enter C-1 state
[    0.635541] ACPI: \_PR_.C000: Found 2 idle states
[    0.635644] ACPI: \_PR_.C002: Found 2 idle states
[    0.635700] ACPI: \_PR_.C004: Found 2 idle states
[    0.635795] ACPI: \_PR_.C006: Found 2 idle states
[    0.635867] ACPI: \_PR_.C008: Found 2 idle states
[    0.635937] ACPI: \_PR_.C00A: Found 2 idle states
[    0.636009] ACPI: \_PR_.C00C: Found 2 idle states
[    0.636078] ACPI: \_PR_.C00E: Found 2 idle states
[    0.636235] ACPI: \_PR_.C010: Found 2 idle states
[    0.636329] ACPI: \_PR_.C012: Found 2 idle states
[    0.636419] ACPI: \_PR_.C014: Found 2 idle states
[    0.636518] ACPI: \_PR_.C016: Found 2 idle states
[    0.636671] ACPI: \_PR_.C018: Found 2 idle states
[    0.636825] ACPI: \_PR_.C01A: Found 2 idle states
[    0.636959] ACPI: \_PR_.C01C: Found 2 idle states
[    0.637088] ACPI: \_PR_.C01E: Found 2 idle states
[    0.637193] ACPI: \_PR_.C001: Found 2 idle states
[    0.637299] ACPI: \_PR_.C003: Found 2 idle states
[    0.637622] ACPI: \_PR_.C005: Found 2 idle states
[    0.637960] ACPI: \_PR_.C007: Found 2 idle states
[    0.638268] ACPI: \_PR_.C009: Found 2 idle states
[    0.638606] ACPI: \_PR_.C00B: Found 2 idle states
[    0.638924] ACPI: \_PR_.C00D: Found 2 idle states
[    0.639223] ACPI: \_PR_.C00F: Found 2 idle states
[    0.639589] ACPI: \_PR_.C011: Found 2 idle states
[    0.640031] ACPI: \_PR_.C013: Found 2 idle states
[    0.640418] ACPI: \_PR_.C015: Found 2 idle states
[    0.640804] ACPI: \_PR_.C017: Found 2 idle states
[    0.641164] ACPI: \_PR_.C019: Found 2 idle states
[    0.641465] ACPI: \_PR_.C01B: Found 2 idle states
[    0.641759] ACPI: \_PR_.C01D: Found 2 idle states
[    0.642045] ACPI: \_PR_.C01F: Found 2 idle states
[    0.642498] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.663234] 00:04: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D =
115200) is a 16550A
[    0.664484] Linux agpgart interface v0.103
[    0.668538] loop: module loaded
[    0.668961] nvme nvme0: pci function 0000:01:00.0
[    0.669251] libphy: Fixed MDIO Bus: probed
[    0.669466] tun: Universal TUN/TAP device driver, 1.6
[    0.669706] PPP generic driver version 2.4.2
[    0.669951] VFIO - User Level meta-driver version: 0.3
[    0.670214] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) =
Driver
[    0.670431] ehci-pci: EHCI PCI platform driver
[    0.670649] ehci-platform: EHCI generic platform driver
[    0.670858] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.671062] ohci-pci: OHCI PCI platform driver
[    0.671266] ohci-platform: OHCI generic platform driver
[    0.671463] uhci_hcd: USB Universal Host Controller Interface driver
[    0.671710] xhci_hcd 0000:03:00.0: xHCI Host Controller
[    0.671918] xhci_hcd 0000:03:00.0: new USB bus registered, assigned =
bus number 1
[    0.727427] xhci_hcd 0000:03:00.0: hcc params 0x0200ef81 hci version =
0x110 quirks 0x0000000000000410
[    0.727782] usb usb1: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 5.06
[    0.728028] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    0.728280] usb usb1: Product: xHCI Host Controller
[    0.728539] usb usb1: Manufacturer: Linux 5.6.8-1-zen2 xhci-hcd
[    0.728803] usb usb1: SerialNumber: 0000:03:00.0
[    0.729124] hub 1-0:1.0: USB hub found
[    0.729404] hub 1-0:1.0: 10 ports detected
[    0.729931] xhci_hcd 0000:03:00.0: xHCI Host Controller
[    0.730213] xhci_hcd 0000:03:00.0: new USB bus registered, assigned =
bus number 2
[    0.730507] xhci_hcd 0000:03:00.0: Host supports USB 3.1 Enhanced =
SuperSpeed
[    0.730840] usb usb2: We don't know the algorithms for LPM for this =
host, disabling LPM.
[    0.731159] usb usb2: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 5.06
[    0.731483] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    0.731815] usb usb2: Product: xHCI Host Controller
[    0.732148] usb usb2: Manufacturer: Linux 5.6.8-1-zen2 xhci-hcd
[    0.732493] usb usb2: SerialNumber: 0000:03:00.0
[    0.732884] hub 2-0:1.0: USB hub found
[    0.733240] hub 2-0:1.0: 4 ports detected
[    0.733802] xhci_hcd 0000:26:00.2: xHCI Host Controller
[    0.734165] xhci_hcd 0000:26:00.2: new USB bus registered, assigned =
bus number 3
[    0.735133] xhci_hcd 0000:26:00.2: hcc params 0x0180ff05 hci version =
0x110 quirks 0x0000000000000010
[    0.735599] usb usb3: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 5.06
[    0.735996] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    0.736403] usb usb3: Product: xHCI Host Controller
[    0.736812] usb usb3: Manufacturer: Linux 5.6.8-1-zen2 xhci-hcd
[    0.737227] usb usb3: SerialNumber: 0000:26:00.2
[    0.737689] hub 3-0:1.0: USB hub found
[    0.738114] hub 3-0:1.0: 2 ports detected
[    0.738595] xhci_hcd 0000:26:00.2: xHCI Host Controller
[    0.739021] xhci_hcd 0000:26:00.2: new USB bus registered, assigned =
bus number 4
[    0.739446] xhci_hcd 0000:26:00.2: Host supports USB 3.1 Enhanced =
SuperSpeed
[    0.739882] usb usb4: We don't know the algorithms for LPM for this =
host, disabling LPM.
[    0.740328] usb usb4: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 5.06
[    0.740769] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    0.741209] usb usb4: Product: xHCI Host Controller
[    0.741648] usb usb4: Manufacturer: Linux 5.6.8-1-zen2 xhci-hcd
[    0.742085] usb usb4: SerialNumber: 0000:26:00.2
[    0.742563] hub 4-0:1.0: USB hub found
[    0.742997] hub 4-0:1.0: 4 ports detected
[    0.743531] xhci_hcd 0000:28:00.3: xHCI Host Controller
[    0.743960] xhci_hcd 0000:28:00.3: new USB bus registered, assigned =
bus number 5
[    0.744483] xhci_hcd 0000:28:00.3: hcc params 0x0278ffe5 hci version =
0x110 quirks 0x0000000000000410
[    0.745126] usb usb5: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 5.06
[    0.745571] usb usb5: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    0.746014] usb usb5: Product: xHCI Host Controller
[    0.746460] usb usb5: Manufacturer: Linux 5.6.8-1-zen2 xhci-hcd
[    0.746901] usb usb5: SerialNumber: 0000:28:00.3
[    0.747384] hub 5-0:1.0: USB hub found
[    0.747810] hub 5-0:1.0: 4 ports detected
[    0.748337] xhci_hcd 0000:28:00.3: xHCI Host Controller
[    0.748760] xhci_hcd 0000:28:00.3: new USB bus registered, assigned =
bus number 6
[    0.749183] xhci_hcd 0000:28:00.3: Host supports USB 3.1 Enhanced =
SuperSpeed
[    0.749610] usb usb6: We don't know the algorithms for LPM for this =
host, disabling LPM.
[    0.750047] usb usb6: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 5.06
[    0.750489] usb usb6: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    0.750928] usb usb6: Product: xHCI Host Controller
[    0.751366] usb usb6: Manufacturer: Linux 5.6.8-1-zen2 xhci-hcd
[    0.751806] usb usb6: SerialNumber: 0000:28:00.3
[    0.752284] hub 6-0:1.0: USB hub found
[    0.752713] hub 6-0:1.0: 4 ports detected
[    0.753244] i8042: PNP: No PS/2 controller found.
[    0.753701] mousedev: PS/2 mouse device common for all mice
[    0.754184] rtc_cmos 00:02: RTC can wake from S4
[    0.754733] rtc_cmos 00:02: registered as rtc0
[    0.755157] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes =
nvram, hpet irqs
[    0.755587] i2c /dev entries driver
[    0.756035] device-mapper: uevent: version 1.0.3
[    0.756493] device-mapper: ioctl: 4.42.0-ioctl (2020-02-27) =
initialised: dm-devel@redhat.com
[    0.756930] platform eisa.0: Probing EISA bus 0
[    0.757357] platform eisa.0: EISA: Cannot allocate resource for =
mainboard
[    0.757782] platform eisa.0: Cannot allocate resource for EISA slot 1
[    0.758211] platform eisa.0: Cannot allocate resource for EISA slot 2
[    0.758627] platform eisa.0: Cannot allocate resource for EISA slot 3
[    0.759037] platform eisa.0: Cannot allocate resource for EISA slot 4
[    0.759451] platform eisa.0: Cannot allocate resource for EISA slot 5
[    0.759853] platform eisa.0: Cannot allocate resource for EISA slot 6
[    0.760251] platform eisa.0: Cannot allocate resource for EISA slot 7
[    0.760644] platform eisa.0: Cannot allocate resource for EISA slot 8
[    0.761027] platform eisa.0: EISA: Detected 0 cards
[    0.761740] ledtrig-cpu: registered to indicate activity on CPUs
[    0.762116] EFI Variables Facility v0.08 2004-May-17
[    0.763822] drop_monitor: Initializing network drop monitor service
[    0.764289] NET: Registered protocol family 10
[    0.769324] Segment Routing with IPv6
[    0.769705] NET: Registered protocol family 17
[    0.770087] Bridge firewalling registered
[    0.770510] Key type dns_resolver registered
[    0.772293] RAS: Correctable Errors collector initialized.
[    0.772688] microcode: CPU0: patch_level=3D0x08701021
[    0.773076] microcode: CPU1: patch_level=3D0x08701021
[    0.773441] microcode: CPU2: patch_level=3D0x08701021
[    0.773805] microcode: CPU3: patch_level=3D0x08701021
[    0.774172] microcode: CPU4: patch_level=3D0x08701021
[    0.774524] microcode: CPU5: patch_level=3D0x08701021
[    0.774932] microcode: CPU6: patch_level=3D0x08701021
[    0.775269] microcode: CPU7: patch_level=3D0x08701021
[    0.775664] microcode: CPU8: patch_level=3D0x08701021
[    0.775989] microcode: CPU9: patch_level=3D0x08701021
[    0.776385] microcode: CPU10: patch_level=3D0x08701021
[    0.776773] microcode: CPU11: patch_level=3D0x08701021
[    0.777152] microcode: CPU12: patch_level=3D0x08701021
[    0.777505] microcode: CPU13: patch_level=3D0x08701021
[    0.777846] microcode: CPU14: patch_level=3D0x08701021
[    0.778182] microcode: CPU15: patch_level=3D0x08701021
[    0.778509] microcode: CPU16: patch_level=3D0x08701021
[    0.778776] microcode: CPU17: patch_level=3D0x08701021
[    0.779086] microcode: CPU18: patch_level=3D0x08701021
[    0.779344] microcode: CPU19: patch_level=3D0x08701021
[    0.779644] microcode: CPU20: patch_level=3D0x08701021
[    0.779890] microcode: CPU21: patch_level=3D0x08701021
[    0.780173] microcode: CPU22: patch_level=3D0x08701021
[    0.780407] microcode: CPU23: patch_level=3D0x08701021
[    0.780674] microcode: CPU24: patch_level=3D0x08701021
[    0.780898] microcode: CPU25: patch_level=3D0x08701021
[    0.781155] microcode: CPU26: patch_level=3D0x08701021
[    0.781398] microcode: CPU27: patch_level=3D0x08701021
[    0.781627] microcode: CPU28: patch_level=3D0x08701021
[    0.781841] microcode: CPU29: patch_level=3D0x08701021
[    0.782047] microcode: CPU30: patch_level=3D0x08701021
[    0.782258] microcode: CPU31: patch_level=3D0x08701021
[    0.782483] microcode: Microcode Update Driver: v2.2.
[    0.782914] *** VALIDATE resctrl ***
[    0.783258] resctrl: L3 allocation detected
[    0.783434] resctrl: L3DATA allocation detected
[    0.783615] resctrl: L3CODE allocation detected
[    0.783796] resctrl: MB allocation detected
[    0.783974] resctrl: L3 monitoring detected
[    0.784148] IPI shorthand broadcast: enabled
[    0.784322] sched_clock: Marking stable (814906633, =
-31995850)->(787778309, -4867526)
[    0.784659] registered taskstats version 1
[    0.784840] Loading compiled-in X.509 certificates
[    0.786110] Loaded X.509 cert 'Build time autogenerated kernel key: =
14641697b0321cd3808190b9a832776e273c2387'
[    0.786368] zswap: loaded using pool lzo/zbud
[    0.786764] Key type ._fscrypt registered
[    0.786959] Key type .fscrypt registered
[    0.787149] Key type fscrypt-provisioning registered
[    0.791224] Key type big_key registered
[    0.793280] Key type encrypted registered
[    0.793475] AppArmor: AppArmor sha1 policy hashing enabled
[    0.793784] ima: No TPM chip found, activating TPM-bypass!
[    0.793997] ima: Allocated hash algorithm: sha1
[    0.794216] ima: No architecture policies found
[    0.794439] evm: Initialising EVM extended attributes:
[    0.794666] evm: security.selinux
[    0.794895] evm: security.SMACK64
[    0.795124] evm: security.SMACK64EXEC
[    0.795352] evm: security.SMACK64TRANSMUTE
[    0.795580] evm: security.SMACK64MMAP
[    0.795810] evm: security.apparmor
[    0.796041] evm: security.ima
[    0.796271] evm: security.capability
[    0.796506] evm: HMAC attrs: 0x1
[    0.796993] PM:   Magic number: 4:544:781
[    0.797241] dma_heap system: hash matches
[    0.797535] memory memory483: hash matches
[    0.797885] rtc_cmos 00:02: setting system clock to =
2020-05-02T11:47:52 UTC (1588420072)
[    0.798662] acpi_cpufreq: overriding BIOS provided _PSD data
[    0.883193] nvme nvme0: missing or invalid SUBNQN field.
[    0.883556] nvme nvme0: Shutdown timeout set to 8 seconds
[    0.916934] nvme nvme0: 32/0/0 default/read/poll queues
[    0.924360]  nvme0n1: p1 p2 p3
[    0.925839] Freeing unused decrypted memory: 2040K
[    0.926468] Freeing unused kernel image (initmem) memory: 2588K
[    0.934615] Write protecting the kernel read-only data: 24576k
[    0.935439] Freeing unused kernel image (text/rodata gap) memory: =
2040K
[    0.935951] Freeing unused kernel image (rodata/data gap) memory: =
1008K
[    0.943731] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.944076] Run /init as init process
[    0.944423]   with arguments:
[    0.944423]     /init
[    0.944423]   with environment:
[    0.944424]     HOME=3D/
[    0.944424]     TERM=3Dlinux
[    0.944424]     BOOT_IMAGE=3D/boot/vmlinuz-5.6.8-1-zen2
[    1.015995] gpio_generic: module verification failed: signature =
and/or required key missing - tainting kernel
[    1.019673] acpi PNP0C14:02: duplicate WMI GUID =
05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:01)
[    1.020991] ahci 0000:03:00.1: version 3.0
[    1.021106] ahci 0000:03:00.1: SSS flag set, parallel bus scan =
disabled
[    1.021590] ahci 0000:03:00.1: AHCI 0001.0301 32 slots 8 ports 6 Gbps =
0x33 impl SATA mode
[    1.021606] r8169 0000:22:00.0: enabling device (0000 -> 0003)
[    1.022010] ahci 0000:03:00.1: flags: 64bit ncq sntf stag pm led clo =
only pmp pio slum part sxs deso sadm sds apst=20
[    1.023108] nvidia-gpu 0000:26:00.3: enabling device (0000 -> 0002)
[    1.023341] scsi host0: ahci
[    1.024044] scsi host1: ahci
[    1.024551] scsi host2: ahci
[    1.024579] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, =
revision 0
[    1.025026] scsi host3: ahci
[    1.025463] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus =
port selection
[    1.025964] scsi host4: ahci
[    1.026792] scsi host5: ahci
[    1.027314] scsi host6: ahci
[    1.027871] scsi host7: ahci
[    1.028354] ata1: SATA max UDMA/133 abar m131072@0xf7680000 port =
0xf7680100 irq 86
[    1.028828] ata2: SATA max UDMA/133 abar m131072@0xf7680000 port =
0xf7680180 irq 86
[    1.029235] ata3: DUMMY
[    1.029620] ata4: DUMMY
[    1.030000] ata5: SATA max UDMA/133 abar m131072@0xf7680000 port =
0xf7680300 irq 86
[    1.030409] ata6: SATA max UDMA/133 abar m131072@0xf7680000 port =
0xf7680380 irq 86
[    1.030810] ata7: DUMMY
[    1.031207] ata8: DUMMY
[    1.031730] ahci 0000:30:00.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps =
0x1 impl SATA mode
[    1.032151] ahci 0000:30:00.0: flags: 64bit ncq sntf ilck pm led clo =
only pmp fbs pio slum part=20
[    1.032691] scsi host8: ahci
[    1.033137] ata9: SATA max UDMA/133 abar m2048@0xf7800000 port =
0xf7800100 irq 90
[    1.033665] ahci 0000:31:00.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps =
0x1 impl SATA mode
[    1.034115] ahci 0000:31:00.0: flags: 64bit ncq sntf ilck pm led clo =
only pmp fbs pio slum part=20
[    1.034663] scsi host9: ahci
[    1.035136] ata10: SATA max UDMA/133 abar m2048@0xf7700000 port =
0xf7700100 irq 92
[    1.037178] libphy: r8169: probed
[    1.037770] r8169 0000:22:00.0 eth0: RTL8168h/8111h, =
00:d8:61:c9:6f:ca, XID 541, IRQ 93
[    1.038234] r8169 0000:22:00.0 eth0: jumbo features [frames: 9200 =
bytes, tx checksumming: ko]
[    1.049045] r8169 0000:22:00.0 enp34s0: renamed from eth0
[    1.347311] ata9: SATA link down (SStatus 0 SControl 300)
[    1.354131] ata10: SATA link down (SStatus 0 SControl 300)
[    1.508033] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.510493] ata1.00: supports DRM functions and may not be fully =
accessible
[    1.511922] ata1.00: ATA-11: Samsung SSD 860 PRO 512GB, RVM01B6Q, max =
UDMA/133
[    1.512394] ata1.00: 1000215216 sectors, multi 1: LBA48 NCQ (depth =
32), AA
[    1.515389] ata1.00: supports DRM functions and may not be fully =
accessible
[    1.518993] ata1.00: configured for UDMA/133
[    1.519652] scsi 0:0:0:0: Direct-Access     ATA      Samsung SSD 860  =
1B6Q PQ: 0 ANSI: 5
[    1.520322] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.520339] ata1.00: Enabling discard_zeroes_data
[    1.521396] sd 0:0:0:0: [sda] 1000215216 512-byte logical blocks: =
(512 GB/477 GiB)
[    1.521899] sd 0:0:0:0: [sda] Write Protect is off
[    1.522363] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.522367] sd 0:0:0:0: [sda] Write cache: enabled, read cache: =
enabled, doesn't support DPO or FUA
[    1.536271] ata1.00: Enabling discard_zeroes_data
[    1.537494] ata1.00: Enabling discard_zeroes_data
[    1.538969] sd 0:0:0:0: [sda] supports TCG Opal
[    1.539408] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.632465] tsc: Refined TSC clocksource calibration: 3499.998 MHz
[    1.633011] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: =
0x32734efdd03, max_idle_ns: 440795244944 ns
[    1.633588] clocksource: Switched to clocksource tsc
[    1.996477] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.998460] ata2.00: ATA-9: ST1000DM003-1CH162, CC47, max UDMA/133
[    1.998928] ata2.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth =
32), AA
[    2.000036] ata2.00: configured for UDMA/133
[    2.000678] scsi 1:0:0:0: Direct-Access     ATA      ST1000DM003-1CH1 =
CC47 PQ: 0 ANSI: 5
[    2.001417] sd 1:0:0:0: [sdb] 1953525168 512-byte logical blocks: =
(1.00 TB/932 GiB)
[    2.001487] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    2.002007] sd 1:0:0:0: [sdb] 4096-byte physical blocks
[    2.003020] sd 1:0:0:0: [sdb] Write Protect is off
[    2.003503] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.003508] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: =
enabled, doesn't support DPO or FUA
[    2.025620] sd 1:0:0:0: [sdb] Attached SCSI disk
[    2.112473] usb 1-4: new full-speed USB device number 3 using =
xhci_hcd
[    2.312430] ata5: SATA link down (SStatus 0 SControl 330)
[    2.459193] usb 1-4: New USB device found, idVendor=3D17f6, =
idProduct=3D0824, bcdDevice=3D 3.21
[    2.459719] usb 1-4: New USB device strings: Mfr=3D1, Product=3D2, =
SerialNumber=3D0
[    2.460252] usb 1-4: Product: SpaceSaver M Kbrd v3_21
[    2.460757] usb 1-4: Manufacturer: Unicomp Inc
[    2.488463] hid: raw HID events driver (C) Jiri Kosina
[    2.516407] usbcore: registered new interface driver usbhid
[    2.516999] usbhid: USB HID core driver
[    2.517973] usbcore: registered new interface driver usbkbd
[    2.519197] input: Unicomp Inc SpaceSaver M Kbrd v3_21 as =
/devices/pci0000:00/0000:00:01.3/0000:03:00.0/usb1/1-4/1-4:1.0/0003:17F6:0=
824.0001/input/input2
[    2.580086] hid-generic 0003:17F6:0824.0001: input,hidraw0: USB HID =
v1.11 Keyboard [Unicomp Inc SpaceSaver M Kbrd v3_21] on =
usb-0000:03:00.0-4/input0
[    2.581378] input: Unicomp Inc SpaceSaver M Kbrd v3_21 System Control =
as =
/devices/pci0000:00/0000:00:01.3/0000:03:00.0/usb1/1-4/1-4:1.1/0003:17F6:0=
824.0002/input/input3
[    2.640566] input: Unicomp Inc SpaceSaver M Kbrd v3_21 Consumer =
Control as =
/devices/pci0000:00/0000:00:01.3/0000:03:00.0/usb1/1-4/1-4:1.1/0003:17F6:0=
824.0002/input/input4
[    2.641860] hid-generic 0003:17F6:0824.0002: input,hidraw1: USB HID =
v1.11 Device [Unicomp Inc SpaceSaver M Kbrd v3_21] on =
usb-0000:03:00.0-4/input1
[    2.788479] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.791826] ata6.00: NCQ Send/Recv Log not supported
[    2.792498] ata6.00: ATA-9: Samsung SSD 840 EVO 250GB, EXT0BB0Q, max =
UDMA/133
[    2.793090] ata6.00: 488397168 sectors, multi 16: LBA48 NCQ (depth =
32), AA
[    2.794822] ata6.00: NCQ Send/Recv Log not supported
[    2.795418] ata6.00: configured for UDMA/133
[    2.796122] scsi 5:0:0:0: Direct-Access     ATA      Samsung SSD 840  =
BB0Q PQ: 0 ANSI: 5
[    2.796939] sd 5:0:0:0: Attached scsi generic sg2 type 0
[    2.796961] sd 5:0:0:0: [sdc] 488397168 512-byte logical blocks: (250 =
GB/233 GiB)
[    2.798297] sd 5:0:0:0: [sdc] Write Protect is off
[    2.798899] sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    2.798903] sd 5:0:0:0: [sdc] Write cache: enabled, read cache: =
enabled, doesn't support DPO or FUA
[    2.814279] sd 5:0:0:0: [sdc] Attached SCSI disk
[    3.085140] device-mapper: thin: Data device (dm-1) discard =
unsupported: Disabling discard passdown.
[    4.208558] raid6: avx2x4   gen() 39985 MB/s
[    4.276561] raid6: avx2x4   xor() 12260 MB/s
[    4.344401] raid6: avx2x2   gen() 41015 MB/s
[    4.412016] raid6: avx2x2   xor() 25304 MB/s
[    4.480776] raid6: avx2x1   gen() 34848 MB/s
[    4.548016] raid6: avx2x1   xor() 19176 MB/s
[    4.616564] raid6: sse2x4   gen() 19209 MB/s
[    4.684017] raid6: sse2x4   xor() 10395 MB/s
[    4.752018] raid6: sse2x2   gen() 20994 MB/s
[    4.820550] raid6: sse2x2   xor() 12974 MB/s
[    4.888598] raid6: sse2x1   gen() 16424 MB/s
[    4.956016] raid6: sse2x1   xor()  9784 MB/s
[    4.956539] raid6: using algorithm avx2x2 gen() 41015 MB/s
[    4.957059] raid6: .... xor() 25304 MB/s, rmw enabled
[    4.957571] raid6: using avx2x2 recovery algorithm
[    4.959204] xor: automatically using best checksumming function   avx =
     =20
[    4.967070] Btrfs loaded, crc32c=3Dcrc32c-intel
[    5.024785] process '/usr/bin/fstype' started with executable stack
[    5.039427] EXT4-fs (dm-4): mounted filesystem with ordered data =
mode. Opts: (null)
[    5.095748] systemd[1]: Inserted module 'autofs4'
[    5.105305] systemd[1]: systemd 241 running in system mode. (+PAM =
+AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP =
+GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN =
-PCRE2 default-hierarchy=3Dhybrid)
[    5.124059] systemd[1]: Detected architecture x86-64.
[    5.158719] systemd[1]: Set hostname to <metal-02>.
[    5.219150] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[    5.220131] systemd[1]: Listening on Journal Socket (/dev/log).
[    5.221030] systemd[1]: Listening on Device-mapper event daemon =
FIFOs.
[    5.223542] systemd[1]: Listening on RPCbind Server Activation =
Socket.
[    5.224480] systemd[1]: Reached target ceph target allowing to =
start/stop all ceph-fuse@.service instances at once.
[    5.225517] systemd[1]: Listening on udev Control Socket.
[    5.226670] systemd[1]: Created slice User and Session Slice.
[    5.241399] RPC: Registered named UNIX socket transport module.
[    5.241400] RPC: Registered udp transport module.
[    5.241400] RPC: Registered tcp transport module.
[    5.241401] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    5.244710] Loading iSCSI transport class v2.0-870.
[    5.247065] iscsi: registered transport (tcp)
[    5.253131] iscsi: registered transport (iser)
[    5.256436] EXT4-fs (dm-4): re-mounted. Opts: errors=3Dremount-ro
[    5.259311] nct6775: Found NCT6797D or compatible chip at 0x4e:0xa20
[    5.260828] spl: loading out-of-tree module taints kernel.
[    5.262272] znvpair: module license 'CDDL' taints kernel.
[    5.262273] Disabling lock debugging due to kernel taint
[    5.288580] systemd-journald[728]: Received request to flush runtime =
journal from PID 1
[    5.322231] ccp 0000:28:00.1: enabling device (0000 -> 0002)
[    5.323018] ccp 0000:28:00.1: ccp: unable to access the device: you =
might be running a broken BIOS.
[    5.324364] input: PC Speaker as =
/devices/platform/pcspkr/input/input5
[    5.328639] cryptd: max_cpu_qlen set to 1000
[    5.332688] AVX2 version of gcm_enc/dec engaged.
[    5.333171] AES CTR mode by8 optimization enabled
[    5.335093] snd_hda_intel 0000:26:00.1: enabling device (0000 -> =
0002)
[    5.335638] snd_hda_intel 0000:26:00.1: Disabling MSI
[    5.336125] snd_hda_intel 0000:26:00.1: Handle vga_switcheroo audio =
client
[    5.336667] snd_hda_intel 0000:28:00.4: enabling device (0000 -> =
0002)
[    5.344284] checking generic (e0000000 300000) vs hw (e0000000 =
10000000)
[    5.344285] fb0: switching to nouveaufb from EFI VGA
[    5.344887] Console: switching to colour dummy device 80x25
[    5.345059] nouveau 0000:26:00.0: NVIDIA TU104 (164000a1)
[    5.349550] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC892: =
line_outs=3D4 (0x14/0x15/0x16/0x17/0x0) type:line
[    5.349554] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=3D0 =
(0x0/0x0/0x0/0x0/0x0)
[    5.349556] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=3D1 =
(0x1b/0x0/0x0/0x0/0x0)
[    5.349558] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=3D0x0
[    5.349559] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[    5.349560] snd_hda_codec_realtek hdaudioC1D0:      Front Mic=3D0x19
[    5.349562] snd_hda_codec_realtek hdaudioC1D0:      Rear Mic=3D0x18
[    5.349563] snd_hda_codec_realtek hdaudioC1D0:      Line=3D0x1a
[    5.351586] input: HDA NVidia HDMI/DP,pcm=3D3 as =
/devices/pci0000:00/0000:00:03.1/0000:26:00.1/sound/card0/input6
[    5.351624] input: HDA NVidia HDMI/DP,pcm=3D7 as =
/devices/pci0000:00/0000:00:03.1/0000:26:00.1/sound/card0/input7
[    5.351655] input: HDA NVidia HDMI/DP,pcm=3D8 as =
/devices/pci0000:00/0000:00:03.1/0000:26:00.1/sound/card0/input8
[    5.351679] input: HDA NVidia HDMI/DP,pcm=3D9 as =
/devices/pci0000:00/0000:00:03.1/0000:26:00.1/sound/card0/input9
[    5.351703] input: HDA NVidia HDMI/DP,pcm=3D10 as =
/devices/pci0000:00/0000:00:03.1/0000:26:00.1/sound/card0/input10
[    5.351727] input: HDA NVidia HDMI/DP,pcm=3D11 as =
/devices/pci0000:00/0000:00:03.1/0000:26:00.1/sound/card0/input11
[    5.351757] input: HDA NVidia HDMI/DP,pcm=3D12 as =
/devices/pci0000:00/0000:00:03.1/0000:26:00.1/sound/card0/input12
[    5.363453] input: HD-Audio Generic Front Mic as =
/devices/pci0000:00/0000:00:08.1/0000:28:00.4/sound/card1/input13
[    5.363485] input: HD-Audio Generic Rear Mic as =
/devices/pci0000:00/0000:00:08.1/0000:28:00.4/sound/card1/input14
[    5.363510] input: HD-Audio Generic Line as =
/devices/pci0000:00/0000:00:08.1/0000:28:00.4/sound/card1/input15
[    5.363536] input: HD-Audio Generic Line Out Front as =
/devices/pci0000:00/0000:00:08.1/0000:28:00.4/sound/card1/input16
[    5.363558] input: HD-Audio Generic Line Out Surround as =
/devices/pci0000:00/0000:00:08.1/0000:28:00.4/sound/card1/input17
[    5.363581] input: HD-Audio Generic Line Out CLFE as =
/devices/pci0000:00/0000:00:08.1/0000:28:00.4/sound/card1/input18
[    5.363603] input: HD-Audio Generic Line Out Side as =
/devices/pci0000:00/0000:00:08.1/0000:28:00.4/sound/card1/input19
[    5.363626] input: HD-Audio Generic Front Headphone as =
/devices/pci0000:00/0000:00:08.1/0000:28:00.4/sound/card1/input20
[    5.461582] nouveau 0000:26:00.0: bios: version 90.04.76.80.3b
[    5.462732] nouveau 0000:26:00.0: gr: failed to load firmware
[    5.463056] nouveau 0000:26:00.0: fb: 8192 MiB GDDR6
[    5.471841] nouveau 0000:26:00.0: fb: VPR locked, but no scrubber =
binary!
[    5.478804] [TTM] Zone  kernel: Available graphics memory: 32938206 =
KiB
[    5.478805] [TTM] Zone   dma32: Available graphics memory: 2097152 =
KiB
[    5.478807] [TTM] Initializing pool allocator
[    5.478809] [TTM] Initializing DMA pool allocator
[    5.478817] nouveau 0000:26:00.0: DRM: VRAM: 8192 MiB
[    5.478818] nouveau 0000:26:00.0: DRM: GART: 536870912 MiB
[    5.478820] nouveau 0000:26:00.0: DRM: BIT table 'A' not found
[    5.478821] nouveau 0000:26:00.0: DRM: BIT table 'L' not found
[    5.478822] nouveau 0000:26:00.0: DRM: TMDS table version 2.0
[    5.478824] nouveau 0000:26:00.0: DRM: DCB version 4.1
[    5.478826] nouveau 0000:26:00.0: DRM: DCB outp 00: 02800f66 04600020
[    5.478827] nouveau 0000:26:00.0: DRM: DCB outp 01: 02000f62 00020020
[    5.478828] nouveau 0000:26:00.0: DRM: DCB outp 02: 02011f52 00020010
[    5.478830] nouveau 0000:26:00.0: DRM: DCB outp 03: 04822f76 04600010
[    5.478831] nouveau 0000:26:00.0: DRM: DCB outp 04: 04022f72 00020010
[    5.478832] nouveau 0000:26:00.0: DRM: DCB outp 05: 01833f46 04600020
[    5.478833] nouveau 0000:26:00.0: DRM: DCB outp 06: 01033f42 00020020
[    5.478834] nouveau 0000:26:00.0: DRM: DCB conn 00: 00020046
[    5.478836] nouveau 0000:26:00.0: DRM: DCB conn 01: 00010161
[    5.478837] nouveau 0000:26:00.0: DRM: DCB conn 02: 01000246
[    5.478838] nouveau 0000:26:00.0: DRM: DCB conn 03: 00002346
[    5.479047] nouveau 0000:26:00.0: DRM: failed to create kernel =
channel, -22
[    5.479218] nouveau 0000:26:00.0: DRM: MM: using COPY for buffer =
copies
[    5.538691] snd_hda_intel 0000:26:00.1: bound 0000:26:00.0 (ops =
nv50_audio_component_bind_ops [nouveau])
[    5.538708] [drm] Supports vblank timestamp caching Rev 2 =
(21.10.2013).
[    5.538709] [drm] Driver supports precise vblank timestamp query.
[    5.972970] nouveau 0000:26:00.0: DRM: allocated 2560x1440 fb: =
0x200000, bo 00000000fd357aee
[    5.973013] fbcon: nouveaudrmfb (fb0) is primary device
[    6.020390] Adding 8388604k swap on /dev/mapper/pve-swap.  =
Priority:-2 extents:1 across:8388604k SSFS
[    6.265427] Console: switching to colour frame buffer device 160x45
[    6.344523] nvidia-gpu 0000:26:00.3: i2c timeout error e0000000
[    6.344526] ucsi_ccg 0-0008: i2c_transfer failed -110
[    6.344528] ucsi_ccg 0-0008: ucsi_ccg_init failed - -110
[    6.344532] ucsi_ccg: probe of 0-0008 failed with error -110
[    6.535129] nouveau 0000:26:00.0: fb0: nouveaudrmfb frame buffer =
device
[    6.547998] kvm: Nested Paging enabled
[    6.548026] SVM: AVIC enabled
[    6.548043] SVM: Virtual VMLOAD VMSAVE supported
[    6.548043] SVM: Virtual GIF supported
[    6.549595] MCE: In-kernel MCE decoding enabled.
[    6.550485] EDAC amd64: F17h_M70h detected (node 0).
[    6.550544] EDAC amd64: Node 0: DRAM ECC disabled.
[    6.668216] [drm] Initialized nouveau 1.3.1 20120801 for 0000:26:00.0 =
on minor 0
[    7.080649] EDAC amd64: F17h_M70h detected (node 0).
[    7.080707] EDAC amd64: Node 0: DRAM ECC disabled.
[    7.188931] ZFS: Loaded module v0.8.3-pve1, ZFS pool version 5000, =
ZFS filesystem version 5
[    7.224703] EDAC amd64: F17h_M70h detected (node 0).
[    7.224765] EDAC amd64: Node 0: DRAM ECC disabled.
[    7.280795] EDAC amd64: F17h_M70h detected (node 0).
[    7.280861] EDAC amd64: Node 0: DRAM ECC disabled.
[    7.344269] EDAC amd64: F17h_M70h detected (node 0).
[    7.344330] EDAC amd64: Node 0: DRAM ECC disabled.
[    7.412651] EDAC amd64: F17h_M70h detected (node 0).
[    7.412720] EDAC amd64: Node 0: DRAM ECC disabled.
[    7.468779] EDAC amd64: F17h_M70h detected (node 0).
[    7.468843] EDAC amd64: Node 0: DRAM ECC disabled.
[    7.524642] EDAC amd64: F17h_M70h detected (node 0).
[    7.524715] EDAC amd64: Node 0: DRAM ECC disabled.
[    7.580686] EDAC amd64: F17h_M70h detected (node 0).
[    7.580754] EDAC amd64: Node 0: DRAM ECC disabled.
[    7.645236] EDAC amd64: F17h_M70h detected (node 0).
[    7.645302] EDAC amd64: Node 0: DRAM ECC disabled.
[    7.704986] EDAC amd64: F17h_M70h detected (node 0).
[    7.705057] EDAC amd64: Node 0: DRAM ECC disabled.
[    7.768732] EDAC amd64: F17h_M70h detected (node 0).
[    7.768797] EDAC amd64: Node 0: DRAM ECC disabled.
[    7.840519] EDAC amd64: F17h_M70h detected (node 0).
[    7.840731] EDAC amd64: Node 0: DRAM ECC disabled.
[    7.896637] EDAC amd64: F17h_M70h detected (node 0).
[    7.896860] EDAC amd64: Node 0: DRAM ECC disabled.
[    7.969289] EDAC amd64: F17h_M70h detected (node 0).
[    7.969351] EDAC amd64: Node 0: DRAM ECC disabled.
[    8.029116] EDAC amd64: F17h_M70h detected (node 0).
[    8.030076] EDAC amd64: Node 0: DRAM ECC disabled.
[    8.092647] EDAC amd64: F17h_M70h detected (node 0).
[    8.093735] EDAC amd64: Node 0: DRAM ECC disabled.
[    8.156787] EDAC amd64: F17h_M70h detected (node 0).
[    8.157873] EDAC amd64: Node 0: DRAM ECC disabled.
[    8.216933] EDAC amd64: F17h_M70h detected (node 0).
[    8.217872] EDAC amd64: Node 0: DRAM ECC disabled.
[    8.280957] EDAC amd64: F17h_M70h detected (node 0).
[    8.282065] EDAC amd64: Node 0: DRAM ECC disabled.
[    8.341297] EDAC amd64: F17h_M70h detected (node 0).
[    8.342190] EDAC amd64: Node 0: DRAM ECC disabled.
[    8.408950] EDAC amd64: F17h_M70h detected (node 0).
[    8.409894] EDAC amd64: Node 0: DRAM ECC disabled.
[    8.453039] EDAC amd64: F17h_M70h detected (node 0).
[    8.453976] EDAC amd64: Node 0: DRAM ECC disabled.
[    8.497035] EDAC amd64: F17h_M70h detected (node 0).
[    8.497992] EDAC amd64: Node 0: DRAM ECC disabled.
[    8.537045] EDAC amd64: F17h_M70h detected (node 0).
[    8.537981] EDAC amd64: Node 0: DRAM ECC disabled.
[    8.569028] EDAC amd64: F17h_M70h detected (node 0).
[    8.569960] EDAC amd64: Node 0: DRAM ECC disabled.
[    8.609093] EDAC amd64: F17h_M70h detected (node 0).
[    8.610001] EDAC amd64: Node 0: DRAM ECC disabled.
[    8.649024] EDAC amd64: F17h_M70h detected (node 0).
[    8.649948] EDAC amd64: Node 0: DRAM ECC disabled.
[    8.685059] EDAC amd64: F17h_M70h detected (node 0).
[    8.685937] EDAC amd64: Node 0: DRAM ECC disabled.
[    8.728939] EDAC amd64: F17h_M70h detected (node 0).
[    8.729851] EDAC amd64: Node 0: DRAM ECC disabled.
[    8.761038] EDAC amd64: F17h_M70h detected (node 0).
[    8.761917] EDAC amd64: Node 0: DRAM ECC disabled.
[    8.797026] EDAC amd64: F17h_M70h detected (node 0).
[    8.797885] EDAC amd64: Node 0: DRAM ECC disabled.
[    8.909570] vmbr0: port 1(enp34s0) entered blocking state
[    8.910299] vmbr0: port 1(enp34s0) entered disabled state
[    8.910349] device enp34s0 entered promiscuous mode
[    8.912963] Generic FE-GE Realtek PHY r8169-2200:00: attached PHY =
driver [Generic FE-GE Realtek PHY] (mii_bus:phy_addr=3Dr8169-2200:00, =
irq=3DIGNORE)
[    8.969294] new mount options do not match the existing superblock, =
will be ignored
[    8.971869] softdog: initialized. soft_noboot=3D0 soft_margin=3D60 =
sec soft_panic=3D0 (nowayout=3D0)
[    9.045163] r8169 0000:22:00.0 enp34s0: Link is Down
[    9.046556] vmbr0: port 1(enp34s0) entered blocking state
[    9.046556] vmbr0: port 1(enp34s0) entered forwarding state
[    9.176910] bpfilter: Loaded bpfilter_umh pid 1178
[    9.177017] Started bpfilter
[    9.195820] audit: type=3D1400 audit(1588420080.891:2): =
apparmor=3D"STATUS" info=3D"failed to unpack end of profile" error=3D-71 =
profile=3D"unconfined" name=3D"/usr/bin/lxc-start" pid=3D1204 =
comm=3D"apparmor_parser" name=3D"/usr/bin/lxc-start" offset=3D147
[    9.200418] audit: type=3D1400 audit(1588420080.899:3): =
apparmor=3D"STATUS" info=3D"failed to unpack end of profile" error=3D-71 =
profile=3D"unconfined" name=3D"/usr/bin/lxc-start" pid=3D1204 =
comm=3D"apparmor_parser" name=3D"/usr/bin/lxc-start" offset=3D147
[    9.206439] audit: type=3D1400 audit(1588420080.903:4): =
apparmor=3D"STATUS" info=3D"failed to unpack end of profile" error=3D-71 =
profile=3D"unconfined" name=3D"lxc-container-default" pid=3D1232 =
comm=3D"apparmor_parser" name=3D"lxc-container-default" offset=3D150
[    9.330606] audit: type=3D1400 audit(1588420081.027:5): =
apparmor=3D"STATUS" info=3D"failed to unpack end of profile" error=3D-71 =
profile=3D"unconfined" name=3D"lxc-container-default" pid=3D1232 =
comm=3D"apparmor_parser" name=3D"lxc-container-default" offset=3D150
[    9.916614] vmbr0: port 1(enp34s0) entered disabled state
[   10.319519] sctp: Hash tables configured (bind 1024/1024)
[   12.264715] r8169 0000:22:00.0 enp34s0: Link is Up - 1Gbps/Full - =
flow control rx/tx
[   12.265873] vmbr0: port 1(enp34s0) entered blocking state
[   12.266926] vmbr0: port 1(enp34s0) entered forwarding state
[   12.268052] IPv6: ADDRCONF(NETDEV_CHANGE): vmbr0: link becomes ready
[   24.499204] ------------[ cut here ]------------
[   24.499227] WARNING: CPU: 14 PID: 1495 at =
drivers/video/fbdev/core/fbmem.c:1693 =
do_unregister_framebuffer+0x1c/0x150
[   24.499253] Modules linked in: tcp_diag(E) inet_diag(E) =
ebtable_filter(E) ebtables(E) ip_set(E) ip6table_raw(E) iptable_raw(E) =
ip6table_filter(E) ip6_tables(E) sctp(E) iptable_filter(E) bpfilter(E) =
softdog(E) nfnetlink_log(E) nfnetlink(E) edac_mce_amd(E) kvm_amd(E) =
kvm(E) zfs(POE) zunicode(POE) zlua(POE) zavl(POE) icp(POE) =
snd_hda_codec_realtek(E) crct10dif_pclmul(E) snd_hda_codec_generic(E) =
crc32_pclmul(E) ledtrig_audio(E) ghash_clmulni_intel(E) =
snd_hda_codec_hdmi(E) nouveau(E) mxm_wmi(E) video(E) ttm(E) =
drm_kms_helper(E) snd_hda_intel(E) cec(E) snd_intel_dspcfg(E) rc_core(E) =
aesni_intel(E) snd_hda_codec(E) crypto_simd(E) drm(E) snd_hda_core(E) =
i2c_algo_bit(E) cryptd(E) snd_hwdep(E) fb_sys_fops(E) syscopyarea(E) =
glue_helper(E) sysfillrect(E) snd_pcm(E) sysimgblt(E) ucsi_ccg(E) =
snd_timer(E) typec_ucsi(E) pcspkr(E) snd(E) typec(E) wmi_bmof(E) =
k10temp(E) ccp(E) soundcore(E) input_leds(E) mac_hid(E) zcommon(POE) =
znvpair(POE) spl(OE) nct6775(E) hwmon_vid(E) vhost_net(E) vhost(E) =
tap(E)
[   24.499275]  ib_iser(E) rdma_cm(E) iw_cm(E) ib_cm(E) ib_core(E) =
iscsi_tcp(E) libiscsi_tcp(E) libiscsi(E) scsi_transport_iscsi(E) =
sunrpc(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) =
blake2b_generic(E) xor(E) zstd_compress(E) raid6_pq(E) dm_thin_pool(E) =
dm_persistent_data(E) dm_bio_prison(E) dm_bufio(E) libcrc32c(E) =
hid_generic(E) usbkbd(E) usbhid(E) hid(E) i2c_piix4(E) i2c_nvidia_gpu(E) =
r8169(E) realtek(E) ahci(E) libahci(E) wmi(E) gpio_amdpt(E) =
gpio_generic(E)
[   24.499574] CPU: 14 PID: 1495 Comm: bash Tainted: P           OE     =
5.6.8-1-zen2 #1
[   24.499591] Hardware name: Micro-Star International Co., Ltd =
MS-7C02/B450 TOMAHAWK MAX (MS-7C02), BIOS 3.60 04/22/2020
[   24.499615] RIP: 0010:do_unregister_framebuffer+0x1c/0x150
[   24.499627] Code: 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 0f 1f 44 =
00 00 55 48 89 e5 41 55 41 54 8b 77 04 49 89 fc 83 fe 1f 0f 86 86 00 00 =
00 <0f> 0b 49 8b bc 24 f0 01 00 00 48 85 ff 74 0f 41 f6 84 24 0c 02 00
[   24.499667] RSP: 0018:ffffbb6841d33d70 EFLAGS: 00010206
[   24.499679] RAX: 0000000000000000 RBX: ffff940dd6918400 RCX: =
0000000000000000
[   24.499695] RDX: ffff940dca82c5c0 RSI: 0000000000000000 RDI: =
ffff940dcbfb4000
[   24.499710] RBP: ffffbb6841d33d80 R08: 0000000000000000 R09: =
ffffffffac03a700
[   24.499725] R10: ffff940dcbf16f00 R11: 0000000000000001 R12: =
ffff940dcbfb4000
[   24.499742] R13: 0000000000000000 R14: ffffffffad59aa80 R15: =
ffffffffad5684e8
[   24.499758] FS:  00007f6523338740(0000) GS:ffff940ddeb80000(0000) =
knlGS:0000000000000000
[   24.499776] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.499788] CR2: 00005583fc40ece8 CR3: 0000000f7a316000 CR4: =
0000000000340ee0
[   24.499804] Call Trace:
[   24.499813]  unregister_framebuffer+0x22/0x40
[   24.499824]  efifb_remove+0x1e/0x40
[   24.499833]  platform_drv_remove+0x29/0x50
[   24.499844]  device_release_driver_internal+0x1ba/0x2d0
[   24.499856]  device_driver_detach+0x14/0x20
[   24.499866]  unbind_store+0x11b/0x150
[   24.499876]  drv_attr_store+0x24/0x30
[   24.499885]  sysfs_kf_write+0x3f/0x50
[   24.499894]  kernfs_fop_write+0xda/0x1b0
[   24.499904]  __x64_sys_write+0x17a/0x2f0
[   24.499916]  do_syscall_64+0x57/0x1b0
[   24.499926]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   24.499938] RIP: 0033:0x7f6523425504
[   24.499946] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f =
80 00 00 00 00 48 8d 05 f9 61 0d 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f =
05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 41 54 49 89 d4 55 48 89 f5 53
[   24.499986] RSP: 002b:00007ffc34ffaad8 EFLAGS: 00000246 ORIG_RAX: =
0000000000000001
[   24.500003] RAX: ffffffffffffffda RBX: 0000000000000011 RCX: =
00007f6523425504
[   24.500018] RDX: 0000000000000011 RSI: 00005583fc40dce0 RDI: =
0000000000000001
[   24.500034] RBP: 00005583fc40dce0 R08: 00007f65234f88c0 R09: =
00007f6523338740
[   24.500049] R10: 00005583fc30d010 R11: 0000000000000246 R12: =
00007f65234f7760
[   24.500065] R13: 0000000000000011 R14: 00007f65234f2760 R15: =
0000000000000011
[   24.500081] ---[ end trace 53f63f13b6dcb819 ]---
[   24.500105] ------------[ cut here ]------------
[   24.500116] kernel BUG at mm/slub.c:304!
[   24.500128] invalid opcode: 0000 [#1] SMP NOPTI
[   24.500140] CPU: 14 PID: 1495 Comm: bash Tainted: P        W  OE     =
5.6.8-1-zen2 #1
[   24.500159] Hardware name: Micro-Star International Co., Ltd =
MS-7C02/B450 TOMAHAWK MAX (MS-7C02), BIOS 3.60 04/22/2020
[   24.500183] RIP: 0010:__slab_free+0x18c/0x450
[   24.500193] Code: 00 48 89 c7 fa 66 0f 1f 44 00 00 f0 49 0f ba 2c 24 =
00 72 69 4d 3b 6c 24 20 74 11 49 0f ba 34 24 00 57 9d 0f 1f 44 00 00 eb =
9f <0f> 0b 49 3b 5c 24 28 75 e8 48 8b 44 24 28 49 89 4c 24 28 49 89 44
[   24.500233] RSP: 0018:ffffbb6841d33c90 EFLAGS: 00010246
[   24.500245] RAX: ffff940dd7ef4000 RBX: 0000000080040003 RCX: =
ffff940dd7ef4000
[   24.500261] RDX: ffff940dd7ef4000 RSI: fffff8747f5fbc00 RDI: =
ffff940dd8406680
[   24.500276] RBP: ffffbb6841d33d30 R08: 0000000000000001 R09: =
ffffffffac2d728c
[   24.500292] R10: ffff940dd7ef4000 R11: 0000000000000001 R12: =
fffff8747f5fbc00
[   24.500308] R13: ffff940dd7ef4000 R14: ffff940dd8406680 R15: =
ffffffffad5684e8
[   24.500323] FS:  00007f6523338740(0000) GS:ffff940ddeb80000(0000) =
knlGS:0000000000000000
[   24.500341] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.500354] CR2: 00005583fc40ece8 CR3: 0000000f7a316000 CR4: =
0000000000340ee0
[   24.500370] Call Trace:
[   24.500378]  ? do_invalid_op+0x39/0x140
[   24.500387]  ? apic_timer_interrupt+0xa/0x20
[   24.500398]  ? do_unregister_framebuffer+0x10c/0x150
[   24.500410]  kfree+0x231/0x250
[   24.500420]  do_unregister_framebuffer+0x10c/0x150
[   24.500432]  unregister_framebuffer+0x22/0x40
[   24.500442]  efifb_remove+0x1e/0x40
[   24.500450]  platform_drv_remove+0x29/0x50
[   24.500461]  device_release_driver_internal+0x1ba/0x2d0
[   24.500473]  device_driver_detach+0x14/0x20
[   24.500483]  unbind_store+0x11b/0x150
[   24.500492]  drv_attr_store+0x24/0x30
[   24.500501]  sysfs_kf_write+0x3f/0x50
[   24.500510]  kernfs_fop_write+0xda/0x1b0
[   24.500519]  __x64_sys_write+0x17a/0x2f0
[   24.500529]  do_syscall_64+0x57/0x1b0
[   24.500538]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   24.500549] RIP: 0033:0x7f6523425504
[   24.500558] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f =
80 00 00 00 00 48 8d 05 f9 61 0d 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f =
05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 41 54 49 89 d4 55 48 89 f5 53
[   24.502019] RSP: 002b:00007ffc34ffaad8 EFLAGS: 00000246 ORIG_RAX: =
0000000000000001
[   24.503489] RAX: ffffffffffffffda RBX: 0000000000000011 RCX: =
00007f6523425504
[   24.504911] RDX: 0000000000000011 RSI: 00005583fc40dce0 RDI: =
0000000000000001
[   24.506289] RBP: 00005583fc40dce0 R08: 00007f65234f88c0 R09: =
00007f6523338740
[   24.507664] R10: 00005583fc30d010 R11: 0000000000000246 R12: =
00007f65234f7760
[   24.509048] R13: 0000000000000011 R14: 00007f65234f2760 R15: =
0000000000000011
[   24.510426] Modules linked in: tcp_diag(E) inet_diag(E) =
ebtable_filter(E) ebtables(E) ip_set(E) ip6table_raw(E) iptable_raw(E) =
ip6table_filter(E) ip6_tables(E) sctp(E) iptable_filter(E) bpfilter(E) =
softdog(E) nfnetlink_log(E) nfnetlink(E) edac_mce_amd(E) kvm_amd(E) =
kvm(E) zfs(POE) zunicode(POE) zlua(POE) zavl(POE) icp(POE) =
snd_hda_codec_realtek(E) crct10dif_pclmul(E) snd_hda_codec_generic(E) =
crc32_pclmul(E) ledtrig_audio(E) ghash_clmulni_intel(E) =
snd_hda_codec_hdmi(E) nouveau(E) mxm_wmi(E) video(E) ttm(E) =
drm_kms_helper(E) snd_hda_intel(E) cec(E) snd_intel_dspcfg(E) rc_core(E) =
aesni_intel(E) snd_hda_codec(E) crypto_simd(E) drm(E) snd_hda_core(E) =
i2c_algo_bit(E) cryptd(E) snd_hwdep(E) fb_sys_fops(E) syscopyarea(E) =
glue_helper(E) sysfillrect(E) snd_pcm(E) sysimgblt(E) ucsi_ccg(E) =
snd_timer(E) typec_ucsi(E) pcspkr(E) snd(E) typec(E) wmi_bmof(E) =
k10temp(E) ccp(E) soundcore(E) input_leds(E) mac_hid(E) zcommon(POE) =
znvpair(POE) spl(OE) nct6775(E) hwmon_vid(E) vhost_net(E) vhost(E) =
tap(E)
[   24.510434]  ib_iser(E) rdma_cm(E) iw_cm(E) ib_cm(E) ib_core(E) =
iscsi_tcp(E) libiscsi_tcp(E) libiscsi(E) scsi_transport_iscsi(E) =
sunrpc(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) =
blake2b_generic(E) xor(E) zstd_compress(E) raid6_pq(E) dm_thin_pool(E) =
dm_persistent_data(E) dm_bio_prison(E) dm_bufio(E) libcrc32c(E) =
hid_generic(E) usbkbd(E) usbhid(E) hid(E) i2c_piix4(E) i2c_nvidia_gpu(E) =
r8169(E) realtek(E) ahci(E) libahci(E) wmi(E) gpio_amdpt(E) =
gpio_generic(E)
[   24.519760] ---[ end trace 53f63f13b6dcb81a ]---
[   24.521368] RIP: 0010:__slab_free+0x18c/0x450
[   24.522911] Code: 00 48 89 c7 fa 66 0f 1f 44 00 00 f0 49 0f ba 2c 24 =
00 72 69 4d 3b 6c 24 20 74 11 49 0f ba 34 24 00 57 9d 0f 1f 44 00 00 eb =
9f <0f> 0b 49 3b 5c 24 28 75 e8 48 8b 44 24 28 49 89 4c 24 28 49 89 44
[   24.524467] RSP: 0018:ffffbb6841d33c90 EFLAGS: 00010246
[   24.525995] RAX: ffff940dd7ef4000 RBX: 0000000080040003 RCX: =
ffff940dd7ef4000
[   24.527474] RDX: ffff940dd7ef4000 RSI: fffff8747f5fbc00 RDI: =
ffff940dd8406680
[   24.528914] RBP: ffffbb6841d33d30 R08: 0000000000000001 R09: =
ffffffffac2d728c
[   24.530344] R10: ffff940dd7ef4000 R11: 0000000000000001 R12: =
fffff8747f5fbc00
[   24.531747] R13: ffff940dd7ef4000 R14: ffff940dd8406680 R15: =
ffffffffad5684e8
[   24.533138] FS:  00007f6523338740(0000) GS:ffff940ddeb80000(0000) =
knlGS:0000000000000000
[   24.534530] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.535884] CR2: 00005583fc40ece8 CR3: 0000000f7a316000 CR4: =
0000000000340ee0

--Apple-Mail=_1C931A90-7CC6-4EFF-8688-0FC5138E82C5--
