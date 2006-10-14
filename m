From: Wink Saville <wink@saville.com>
Subject: Patch for nvidia divide by zero error for 7600
	pci-express card
Date: Sat, 14 Oct 2006 12:47:22 -0700
Message-ID: <45313ECA.4070801@saville.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GYpTd-0006Of-QD for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 14 Oct 2006 12:47:21 -0700
Received: from [70.91.206.233] (helo=saville.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GYpTc-0006i7-Nu
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 14 Oct 2006 12:47:21 -0700
Received: from [192.168.0.52] (unknown [192.168.0.52])
	by saville.com (Postfix) with ESMTP id 156885781A
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 14 Oct 2006 12:44:41 -0700 (PDT)
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

Hello,

The following patch resolves the divide by zero error I encountered on my system:

	http://marc.10east.com/?l=linux-fbdev-devel&m=116058257024413&w=2

I accomplished this by merging what I thought was appropriate from:

	http://webcvs.freedesktop.org/xorg/driver/xf86-video-nv/src/

If this is incorrect please give me some guidance and I'll make any
changes that may be needed. One significant item remaining to get the framebuffer
console to work, I must have something wrong with my configuration. Following the
diff I've included my log and configuration.


Regards,

Wink Saville


diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index e34bd03..60df916 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2247,6 +2247,22 @@ static void serial8250_console_putchar(s
 	serial_out(up, UART_TX, ch);
 }
 
+void lldb_wrch(int port_idx, char ch)
+{
+	serial8250_console_putchar((struct uart_port *)&serial8250_ports[port_idx], ch);
+}
+EXPORT_SYMBOL(lldb_wrch);
+
+void lldb_wrstr(int port_idx, const char *str)
+{
+	int	ch;
+
+	while((ch = *str++)) {
+		lldb_wrch(port_idx, ch);	
+	}
+}
+EXPORT_SYMBOL(lldb_wrstr);
+
 /*
  *	Print a string to the serial port trying not to disturb
  *	any possible real use of the port...
diff --git a/drivers/video/nvidia/nv_hw.c b/drivers/video/nvidia/nv_hw.c
index 9ed640d..b2a4521 100644
--- a/drivers/video/nvidia/nv_hw.c
+++ b/drivers/video/nvidia/nv_hw.c
@@ -145,12 +145,18 @@ static void nvGetClocks(struct nvidia_pa
 
 	if (par->Architecture >= NV_ARCH_40) {
 		pll = NV_RD32(par->PMC, 0x4020);
-		P = (pll >> 16) & 0x03;
+		P = (pll >> 16) & 0x07;
 		pll = NV_RD32(par->PMC, 0x4024);
 		M = pll & 0xFF;
 		N = (pll >> 8) & 0xFF;
-		MB = (pll >> 16) & 0xFF;
-		NB = (pll >> 24) & 0xFF;
+		if(((par->Chipset & 0xfff0) == 0x0290) ||
+		((par->Chipset & 0xfff0) == 0x0390)) {
+			MB = 1;
+			NB = 1;
+		} else {
+			MB = (pll >> 16) & 0xFF;
+			NB = (pll >> 24) & 0xFF;
+		}
 		*MClk = ((N * NB * par->CrystalFreqKHz) / (M * MB)) >> P;
 
 		pll = NV_RD32(par->PMC, 0x4000);
diff --git a/drivers/video/nvidia/nv_setup.c b/drivers/video/nvidia/nv_setup.c
index a18a9ae..61dc46f 100644
--- a/drivers/video/nvidia/nv_setup.c
+++ b/drivers/video/nvidia/nv_setup.c
@@ -359,6 +359,7 @@ int NVCommonSetup(struct fb_info *info)
 	case 0x0186:
 	case 0x0187:
 	case 0x018D:
+	case 0x0228:
 	case 0x0286:
 	case 0x028C:
 	case 0x0316:
@@ -382,6 +383,10 @@ int NVCommonSetup(struct fb_info *info)
 	case 0x034C:
 	case 0x0160:
 	case 0x0166:
+	case 0x0169:
+	case 0x016B:
+	case 0x016C:
+	case 0x016D:
 	case 0x00C8:
 	case 0x00CC:
 	case 0x0144:
@@ -639,12 +644,23 @@ int NVCommonSetup(struct fb_info *info)
 		par->fpHeight = NV_RD32(par->PRAMDAC, 0x0800) + 1;
 		par->fpSyncs = NV_RD32(par->PRAMDAC, 0x0848) & 0x30000033;
 
-		printk("Panel size is %i x %i\n", par->fpWidth, par->fpHeight);
+		printk("nvidiafb: Panel size is %i x %i\n", par->fpWidth, par->fpHeight);
 	}
 
 	if (monA)
 		info->monspecs = *monA;
 
+	if (!par->FlatPanel || !par->twoHeads)
+		par->FPDither = 0;
+
+	par->LVDS = 0;
+	if (par->FlatPanel && par->twoHeads) {
+		NV_WR32(par->PRAMDAC0, 0x08B0, 0x00010004);
+		if (par->PRAMDAC0[0x08b4] & 1)
+			par->LVDS = 1;
+		printk("nvidiafb: Panel is %s\n", par->LVDS ? "LVDS" : "TMDS");
+	}
+
 	kfree(edidA);
 	kfree(edidB);
 done:
diff --git a/drivers/video/nvidia/nv_type.h b/drivers/video/nvidia/nv_type.h
index acdc266..86e65de 100644
--- a/drivers/video/nvidia/nv_type.h
+++ b/drivers/video/nvidia/nv_type.h
@@ -129,6 +129,7 @@ struct nvidia_par {
 	int fpHeight;
 	int PanelTweak;
 	int paneltweak;
+	int LVDS;
 	int pm_state;
 	u32 crtcSync_read;
 	u32 fpSyncs;
diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index eb24107..d2839f6 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -1160,20 +1160,20 @@ static u32 __devinit nvidia_get_arch(str
 	case 0x0340:		/* GeForceFX 5700 */
 		arch = NV_ARCH_30;
 		break;
-	case 0x0040:
-	case 0x00C0:
-	case 0x0120:
+	case 0x0040:		/* GeForce 6800 */
+	case 0x00C0:		/* GeForce 6800 */
+	case 0x0120:		/* GeForce 6800 */
 	case 0x0130:
-	case 0x0140:
-	case 0x0160:
-	case 0x01D0:
-	case 0x0090:
-	case 0x0210:
-	case 0x0220:
-	case 0x0230:
-	case 0x0240:
-	case 0x0290:
-	case 0x0390:
+	case 0x0140:		/* GeForce 6600 */
+	case 0x0160:		/* GeForce 6200 */
+	case 0x01D0:		/* GeForce 7200, 7300, 7400 */
+	case 0x0090:		/* GeForce 7800 */
+	case 0x0210:		/* GeForce 6800 */
+	case 0x0220:		/* GeForce 6200 */
+	case 0x0230:		
+	case 0x0240:		/* GeForce 6100 */
+	case 0x0290:		/* GeForce 7900 */
+	case 0x0390:		/* GeForce 7600 */
 		arch = NV_ARCH_40;
 		break;
 	case 0x0020:		/* TNT, TNT2 */


<log>
[    0.000000] Linux version 2.6.19-rc2-w8 (wink@winkc2d1) (gcc version 4.1.2 20060928 (prerelease) (Ubuntu 4.1.1-13ubuntu5)) #18 SMP Sat Oct 14 11:52:12 PDT 2006
[    0.000000] Command line: root=/dev/sda2 ro splash initcall_debug console=tty console=ttyS0,115200n81 video=nvidiafb:nomtrr
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007ff80000 (usable)
[    0.000000]  BIOS-e820: 000000007ff80000 - 000000007ff8e000 (ACPI data)
[    0.000000]  BIOS-e820: 000000007ff8e000 - 000000007ffe0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007ffe0000 - 0000000080000000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
[    0.000000] end_pfn_map = 1048576
[    0.000000] DMI 2.3 present.
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0:        0 ->      159
[    0.000000]     0:      256 ->   524160
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] Processor #1
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Setting APIC routing to flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Nosave address range: 000000000009f000 - 00000000000a0000
[    0.000000] Nosave address range: 00000000000a0000 - 00000000000e4000
[    0.000000] Nosave address range: 00000000000e4000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 88000000 (gap: 80000000:7fb00000)
[    0.000000] PERCPU: Allocating 34048 bytes of per cpu data
[    0.000000] Built 1 zonelists.  Total pages: 515363
[    0.000000] Kernel command line: root=/dev/sda2 ro splash initcall_debug console=tty console=ttyS0,115200n81 video=nvidiafb:nomtrr
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[   93.365502] Console: colour VGA+ 80x25
[   93.635546] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[   93.643383] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   93.650674] Checking aperture...
[   93.674560] Memory: 2058116k/2096640k available (3852k kernel code, 38108k reserved, 1425k data, 236k init)
[   93.763390] Calibrating delay using timer specific routine.. 4811.89 BogoMIPS (lpj=9623787)
[   93.772028] Mount-cache hash table entries: 256
[   93.776784] CPU: L1 I cache: 32K, L1 D cache: 32K
[   93.781646] CPU: L2 cache: 4096K
[   93.784991] using mwait in idle threads.
[   93.789031] CPU: Physical Processor ID: 0
[   93.793154] CPU: Processor Core ID: 0
[   93.796938] CPU0: Thermal monitoring enabled (TM2)
[   93.801856] Freeing SMP alternatives: 40k freed
[   93.806516] ACPI: Core revision 20060707
[   93.867453] Using local APIC timer interrupts.
[   93.913516] result 16695416
[   93.916430] Detected 16.695 MHz APIC timer.
[   93.923113] Booting processor 1/2 APIC 0x1
[   93.937854] Initializing CPU#1
[   94.018838] Calibrating delay using timer specific routine.. 4808.74 BogoMIPS (lpj=9617483)
[   94.018843] CPU: L1 I cache: 32K, L1 D cache: 32K
[   94.018845] CPU: L2 cache: 4096K
[   94.018847] CPU: Physical Processor ID: 0
[   94.018848] CPU: Processor Core ID: 1
[   94.018852] CPU1: Thermal monitoring enabled (TM2)
[   94.019253] Intel(R) Core(TM)2 CPU          6600  @ 2.40GHz stepping 06
[   94.022843] Brought up 2 CPUs
[   94.065371] testing NMI watchdog ... OK.
[   94.109392] time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
[   94.115686] time.c: Detected 2404.140 MHz processor.
[   94.199254] migration_cost=20
[   94.202662] Calling initcall 0xffffffff8074cad5: cpufreq_tsc+0x0/0x6d()
[   94.209471] Calling initcall 0xffffffff80750b69: init_smp_flush+0x0/0x53()
[   94.216545] Calling initcall 0xffffffff80757038: init_elf32_binfmt+0x0/0xc()
[   94.224250] Calling initcall 0xffffffff807587db: helper_init+0x0/0x2f()
[   94.231071] Calling initcall 0xffffffff80758b1d: pm_init+0x0/0x2a()
[   94.237535] Calling initcall 0xffffffff80758f46: ksysfs_init+0x0/0x2a()
[   94.244349] Calling initcall 0xffffffff8075b17d: filelock_init+0x0/0x31()
[   94.251338] Calling initcall 0xffffffff8075bba4: init_misc_binfmt+0x0/0x35()
[   94.258583] Calling initcall 0xffffffff8075bbd9: init_script_binfmt+0x0/0xc()
[   94.265914] Calling initcall 0xffffffff8075bbe5: init_elf_binfmt+0x0/0xc()
[   94.272986] Calling initcall 0xffffffff807661c1: init_cpufreq_transition_notifier_list+0x0/0x14()
[   94.282145] Calling initcall 0xffffffff80767e26: sock_init+0x0/0x5a()
[   94.288800] Calling initcall 0xffffffff807684f8: netlink_proto_init+0x0/0x159()
[   94.296407] NET: Registered protocol family 16
[   94.300970] Calling initcall 0xffffffff8075e311: kobject_uevent_init+0x0/0x3c()
[   94.308581] Calling initcall 0xffffffff8075e454: pcibus_class_init+0x0/0xc()
[   94.315828] Calling initcall 0xffffffff8075ec16: pci_driver_init+0x0/0xc()
[   94.322903] Calling initcall 0xffffffff807604bc: dock_init+0x0/0x46()
[   94.329593] Calling initcall 0xffffffff80761681: tty_class_init+0x0/0x2a()
[   94.336663] Calling initcall 0xffffffff80761fea: vtconsole_class_init+0x0/0xb1()
[   94.344394] Calling initcall 0xffffffff8074fc5f: mtrr_if_init+0x0/0x6c()
[   94.351291] Calling initcall 0xffffffff8075ed56: acpi_pci_init+0x0/0x2e()
[   94.358280] ACPI: bus type pci registered
[   94.362408] Calling initcall 0xffffffff8075fd5d: init_acpi_device_notify+0x0/0x4b()
[   94.370359] Calling initcall 0xffffffff80766ded: pci_access_init+0x0/0x3c()
[   94.377524] PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
[   94.384072] PCI: Not using MMCONFIG.
[   94.387762] PCI: Using configuration type 1
[   94.392060] Calling initcall 0xffffffff8074fade: mtrr_init_finialize+0x0/0x34()
[   94.399666] Calling initcall 0xffffffff807557b5: topology_init+0x0/0x2f()
[   94.406689] Calling initcall 0xffffffff807585ae: param_sysfs_init+0x0/0x187()
[   94.415061] Calling initcall 0xffffffff80247160: pm_sysrq_init+0x0/0x19()
[   94.422048] Calling initcall 0xffffffff8075b80d: init_bio+0x0/0xff()
[   94.428646] Calling initcall 0xffffffff8075e1fb: genhd_device_init+0x0/0x4d()
[   94.436015] Calling initcall 0xffffffff8075edfd: fbmem_init+0x0/0x96()
[   94.442743] Calling initcall 0xffffffff8075fb74: acpi_init+0x0/0x1e9()
[   94.457798] ACPI: Interpreter enabled
[   94.461579] ACPI: Using IOAPIC for interrupt routing
[   94.466700] Calling initcall 0xffffffff8076009f: acpi_ec_init+0x0/0x64()
[   94.473594] Calling initcall 0xffffffff8076077f: acpi_pci_root_init+0x0/0x28()
[   94.481627] Calling initcall 0xffffffff807607c7: acpi_pci_link_init+0x0/0x48()
[   94.489142] Calling initcall 0xffffffff8076094d: acpi_power_init+0x0/0x77()
[   94.496294] Calling initcall 0xffffffff80760ae7: acpi_system_init+0x0/0xc0()
[   94.503541] Calling initcall 0xffffffff80760ba7: acpi_event_init+0x0/0x3d()
[   94.510702] Calling initcall 0xffffffff80760be4: acpi_scan_init+0x0/0x1a8()
[   94.518678] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   94.525253] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[   94.531840] PCI: Transparent bridge - 0000:00:1e.0
[   94.544010] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[   94.551887] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *7 10 11 12 14 15)
[   94.559763] ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 10 11 12 14 15)
[   94.570262] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[   94.578139] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[   94.586017] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[   94.593894] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[   94.603077] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 *6 7 10 11 12 14 15)
[   94.610833] Calling initcall 0xffffffff80760ef6: acpi_cm_sbs_init+0x0/0x3()
[   94.617991] Calling initcall 0xffffffff80760ef9: pnp_init+0x0/0x1f()
[   94.624536] Linux Plug and Play Support v0.97 (c) Adam Belay
[   94.630310] Calling initcall 0xffffffff807610fb: pnpacpi_init+0x0/0x6a()
[   94.637207] pnp: PnP ACPI init
[   94.642729] pnp: PnP ACPI: found 13 devices
[   94.647027] Calling initcall 0xffffffff80761b00: misc_init+0x0/0x80()
[   94.653672] Calling initcall 0xffffffff8049c9db: cn_init+0x0/0xc9()
[   94.660162] Calling initcall 0xffffffff80764d64: init_scsi+0x0/0x82()
[   94.666902] SCSI subsystem initialized
[   94.670765] Calling initcall 0xffffffff8076541b: usb_init+0x0/0x103()
[   94.677439] usbcore: registered new interface driver usbfs
[   94.683059] usbcore: registered new interface driver hub
[   94.688511] usbcore: registered new device driver usb
[   94.693673] Calling initcall 0xffffffff8076575a: serio_init+0x0/0xbd()
[   94.700407] Calling initcall 0xffffffff80765c9d: input_init+0x0/0x116()
[   94.707222] Calling initcall 0xffffffff8076608f: rtc_init+0x0/0x42()
[   94.713776] Calling initcall 0xffffffff807660d1: rtc_sysfs_init+0x0/0xc()
[   94.720760] Calling initcall 0xffffffff807660dd: rtc_proc_init+0x0/0xc()
[   94.727660] Calling initcall 0xffffffff807660e9: rtc_dev_init+0x0/0xa4()
[   94.734952] Calling initcall 0xffffffff8076618d: i2c_init+0x0/0x34()
[   94.741531] Calling initcall 0xffffffff80766864: dma_bus_init+0x0/0x2b()
[   94.748428] Calling initcall 0xffffffff80766e29: pci_acpi_init+0x0/0xa4()
[   94.755411] PCI: Using ACPI for IRQ routing
[   94.759712] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   94.768177] Calling initcall 0xffffffff80766ecd: pci_legacy_init+0x0/0x120()
[   94.775431] Calling initcall 0xffffffff80767364: pcibios_irq_init+0x0/0x4a7()
[   94.782770] Calling initcall 0xffffffff8076780b: pcibios_init+0x0/0x66()
[   94.789713] Calling initcall 0xffffffff80767ed5: proto_init+0x0/0x34()
[   94.796436] Calling initcall 0xffffffff8076801e: net_dev_init+0x0/0x221()
[   94.803428] Calling initcall 0xffffffff80768651: genl_init+0x0/0xa5()
[   94.810066] Calling initcall 0xffffffff8074ce2e: late_hpet_init+0x0/0xb2()
[   94.817138] Calling initcall 0xffffffff8074f38f: pci_iommu_init+0x0/0x12()
[   94.824219] PCI-GART: No AMD northbridge found.
[   94.828860] Calling initcall 0xffffffff8075b110: init_pipe_fs+0x0/0x40()
[   94.835757] Calling initcall 0xffffffff80760dc6: acpi_motherboard_init+0x0/0x130()
[   94.844207] Calling initcall 0xffffffff80761000: pnp_system_init+0x0/0xc()
[   94.851308] pnp: 00:06: ioport range 0x290-0x297 has been reserved
[   94.857609] Calling initcall 0xffffffff807613fc: chr_dev_init+0x0/0x7d()
[   94.864664] Calling initcall 0xffffffff80763aed: firmware_class_init+0x0/0x68()
[   94.872269] Calling initcall 0xffffffff8076626a: cpufreq_gov_performance_init+0x0/0xc()
[   94.880567] Calling initcall 0xffffffff80766282: cpufreq_gov_userspace_init+0x0/0x1f()
[   94.888774] Calling initcall 0xffffffff8076689d: pcibios_assign_resources+0x0/0x80()
[   94.896832] PCI: Bridge: 0000:00:01.0
[   94.900610]   IO window: c000-cfff
[   94.904128]   MEM window: faa00000-feafffff
[   94.908426]   PREFETCH window: cff00000-efefffff
[   94.913157] PCI: Bridge: 0000:00:1c.0
[   94.916933]   IO window: disabled.
[   94.920454]   MEM window: disabled.
[   94.924062]   PREFETCH window: cfe00000-cfefffff
[   94.928794] PCI: Bridge: 0000:00:1c.3
[   94.932570]   IO window: b000-bfff
[   94.936092]   MEM window: fa900000-fa9fffff
[   94.940388]   PREFETCH window: disabled.
[   94.944428] PCI: Bridge: 0000:00:1c.4
[   94.948206]   IO window: a000-afff
[   94.951725]   MEM window: fa800000-fa8fffff
[   94.956023]   PREFETCH window: disabled.
[   94.960062] PCI: Bridge: 0000:00:1e.0
[   94.963839]   IO window: disabled.
[   94.967361]   MEM window: fa700000-fa7fffff
[   94.971659]   PREFETCH window: disabled.
[   94.975705] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
[   94.983365] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
[   94.991398] ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
[   94.999059] ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 16 (level, low) -> IRQ 16
[   95.006719] Calling initcall 0xffffffff80768f4e: inet_init+0x0/0x3d4()
[   95.013464] NET: Registered protocol family 2
[   95.056781] IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
[   95.064162] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[   95.073416] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[   95.080838] TCP: Hash tables configured (established 262144 bind 65536)
[   95.087563] TCP reno registered
[   95.090867] Calling initcall 0xffffffff8020ccf6: time_init_device+0x0/0x23()
[   95.098183] Calling initcall 0xffffffff8074dcc5: i8259A_init_sysfs+0x0/0x24()
[   95.105537] Calling initcall 0xffffffff8074dca2: init_timer_sysfs+0x0/0x23()
[   95.112806] Calling initcall 0xffffffff8074e1c8: vsyscall_init+0x0/0x9b()
[   95.119792] Calling initcall 0xffffffff8074e7a2: sbf_init+0x0/0xd0()
[   95.126342] Calling initcall 0xffffffff8074f36c: i8237A_init_sysfs+0x0/0x23()
[   95.133702] Calling initcall 0xffffffff8074f857: periodic_mcheck_init+0x0/0x27()
[   95.141398] Calling initcall 0xffffffff8074f70a: mce_init_device+0x0/0x14d()
[   95.148706] Calling initcall 0xffffffff8074f98e: thermal_throttle_init_device+0x0/0x73()
[   95.157099] Calling initcall 0xffffffff8075094b: msr_init+0x0/0x10f()
[   95.163778] Calling initcall 0xffffffff80750a5a: cpuid_init+0x0/0x10f()
[   95.170629] Calling initcall 0xffffffff807521f8: init_lapic_sysfs+0x0/0x33()
[   95.177902] Calling initcall 0xffffffff80752cf7: ioapic_init_sysfs+0x0/0xb7()
[   95.185257] Calling initcall 0xffffffff8075566d: audit_classes_init+0x0/0x8d()
[   95.192785] Calling initcall 0xffffffff80755d59: cache_sysfs_init+0x0/0x46()
[   95.200185] Calling initcall 0xffffffff80756270: x8664_sysctl_init+0x0/0x19()
[   95.207517] Calling initcall 0xffffffff80756d0c: aes_init+0x0/0x313()
[   95.214175] Calling initcall 0xffffffff8075701f: ia32_binfmt_init+0x0/0x19()
[   95.221433] Calling initcall 0xffffffff80757044: init_syscall32+0x0/0x5a()
[   95.228509] Calling initcall 0xffffffff8075709e: init_aout_binfmt+0x0/0xc()
[   95.235665] Calling initcall 0xffffffff807579e9: create_proc_profile+0x0/0x258()
[   95.243361] Calling initcall 0xffffffff80757ecc: ioresources_init+0x0/0x42()
[   95.251058] Calling initcall 0xffffffff80758006: timekeeping_init_device+0x0/0x23()
[   95.259030] Calling initcall 0xffffffff8075826c: uid_cache_init+0x0/0x8a()
[   95.266119] Calling initcall 0xffffffff80758735: init_posix_timers+0x0/0xa6()
[   95.273448] Calling initcall 0xffffffff8075880a: init_posix_cpu_timers+0x0/0xc6()
[   95.281228] Calling initcall 0xffffffff80758947: latency_init+0x0/0x23()
[   95.288130] Calling initcall 0xffffffff80758a00: init_clocksource_sysfs+0x0/0x52()
[   95.296021] Calling initcall 0xffffffff80758a52: init_jiffies_clocksource+0x0/0xc()
[   95.303973] Calling initcall 0xffffffff80758a5e: init+0x0/0x63()
[   95.310190] Calling initcall 0xffffffff80758ac1: proc_dma_init+0x0/0x25()
[   95.317178] Calling initcall 0xffffffff8024389b: percpu_modinit+0x0/0x77()
[   95.324250] Calling initcall 0xffffffff80758af5: kallsyms_init+0x0/0x28()
[   95.331238] Calling initcall 0xffffffff80758b47: crash_notes_memory_init+0x0/0x3f()
[   95.339194] Calling initcall 0xffffffff80758cb8: ikconfig_init+0x0/0x3c()
[   95.346180] Calling initcall 0xffffffff80758d66: audit_init+0x0/0x115()
[   95.352986] audit: initializing netlink socket (disabled)
[   95.358509] audit(1160852503.556:1): initialized
[   95.363239] Calling initcall 0xffffffff80758efc: init_kprobes+0x0/0x4a()
[   95.370143] Calling initcall 0xffffffff80759c05: init_per_zone_pages_min+0x0/0x54()
[   95.378100] Calling initcall 0xffffffff8075a90a: pdflush_init+0x0/0x13()
[   95.385017] Calling initcall 0xffffffff8075a938: kswapd_init+0x0/0x1d()
[   95.391840] Calling initcall 0xffffffff8075a955: setup_vmstat+0x0/0x1a()
[   95.398742] Calling initcall 0xffffffff8075a9d4: procswaps_init+0x0/0x25()
[   95.405814] Calling initcall 0xffffffff8075a9f9: init_tmpfs+0x0/0xc6()
[   95.412553] Calling initcall 0xffffffff8075aabf: cpucache_init+0x0/0x2f()
[   95.419539] Calling initcall 0xffffffff8075b150: fasync_init+0x0/0x2d()
[   95.426355] Calling initcall 0xffffffff8075b758: aio_setup+0x0/0x67()
[   95.433017] Calling initcall 0xffffffff8075b986: inotify_setup+0x0/0xd()
[   95.439913] Calling initcall 0xffffffff8075b993: inotify_user_setup+0x0/0xbc()
[   95.447444] Calling initcall 0xffffffff8075ba4f: eventpoll_init+0x0/0xd0()
[   95.454517] Calling initcall 0xffffffff8075bb1f: init_sys32_ioctl+0x0/0x85()
[   95.461778] Calling initcall 0xffffffff8075bbf1: init_mbcache+0x0/0x20()
[   95.468683] Calling initcall 0xffffffff8075bc11: dquot_init+0x0/0xea()
[   95.475410] VFS: Disk quotas dquot_6.5.1
[   95.479462] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[   95.486009] Calling initcall 0xffffffff8075bcfb: dnotify_init+0x0/0x2d()
[   95.492907] Calling initcall 0xffffffff8075c17f: configfs_init+0x0/0x91()
[   95.500335] Calling initcall 0xffffffff8075c210: init_devpts_fs+0x0/0x33()
[   95.507412] Calling initcall 0xffffffff8075c243: init_reiserfs_fs+0x0/0x8e()
[   95.514656] Calling initcall 0xffffffff8075c3e7: init_ext3_fs+0x0/0x63()
[   95.521563] Calling initcall 0xffffffff8075c4fd: journal_init+0x0/0xbd()
[   95.528475] Calling initcall 0xffffffff8075c5ba: init_ext2_fs+0x0/0x63()
[   95.535382] Calling initcall 0xffffffff8075c651: init_cramfs_fs+0x0/0x27()
[   95.542459] Calling initcall 0xffffffff8075c684: init_ramfs_fs+0x0/0xc()
[   95.549355] Calling initcall 0xffffffff8075c6c8: init_fat_fs+0x0/0x48()
[   95.556166] Calling initcall 0xffffffff8075c710: init_msdos_fs+0x0/0xc()
[   95.563063] Calling initcall 0xffffffff8075c71c: init_vfat_fs+0x0/0xc()
[   95.569877] Calling initcall 0xffffffff8075c728: init_iso9660_fs+0x0/0x65()
[   95.577051] Calling initcall 0xffffffff8075c8b5: init_nfs_fs+0x0/0xbe()
[   95.583894] Calling initcall 0xffffffff8075cb27: init_nfsd+0x0/0xa3()
[   95.590534] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   95.597111] Calling initcall 0xffffffff8075cbca: init_nlm+0x0/0x24()
[   95.603666] Calling initcall 0xffffffff8075cbee: init_nls_ascii+0x0/0xc()
[   95.610652] Calling initcall 0xffffffff8075cbfa: init_nls_utf8+0x0/0x1f()
[   95.617639] Calling initcall 0xffffffff8075cc19: init_smb_fs+0x0/0x65()
[   95.624459] Calling initcall 0xffffffff8075cc7e: init_cifs+0x0/0x4e8()
[   95.631239] Calling initcall 0xffffffff8075d166: init_romfs_fs+0x0/0x53()
[   95.640845] Calling initcall 0xffffffff8075d1b9: init_autofs_fs+0x0/0xc()
[   95.647835] Calling initcall 0xffffffff8075d1c5: init_autofs4_fs+0x0/0xc()
[   95.654909] initcall at 0xffffffff8075d1c5: init_autofs4_fs+0x0/0xc(): returned with error code -16
[   95.664254] Calling initcall 0xffffffff8075d220: fuse_init+0x0/0x10a()
[   95.670975] fuse init (API version 7.7)
[   95.674963] Calling initcall 0xffffffff8075d336: init_udf_fs+0x0/0x53()
[   95.681780] Calling initcall 0xffffffff8075d389: init_jfs_fs+0x0/0x1c0()
[   95.688689] JFS: nTxBlock = 8192, nTxLock = 65536
[   95.696765] Calling initcall 0xffffffff8075d6ab: init_xfs_fs+0x0/0x115()
[   95.703672] SGI XFS with ACLs, large block/inode numbers, no debug enabled
[   95.710802] SGI XFS Quota Management subsystem
[   95.715364] Calling initcall 0xffffffff8075d7c0: ipc_init+0x0/0x17()
[   95.721923] Calling initcall 0xffffffff8075da19: init_mqueue_fs+0x0/0xcd()
[   95.729013] Calling initcall 0xffffffff8075dc42: key_proc_init+0x0/0x55()
[   95.735998] Calling initcall 0xffffffff8075dc97: crypto_algapi_init+0x0/0xd()
[   95.743332] Calling initcall 0xffffffff8075dcc7: cryptomgr_init+0x0/0xc()
[   95.750318] Calling initcall 0xffffffff8075dcd3: hmac_module_init+0x0/0xc()
[   95.757901] Calling initcall 0xffffffff8075dcdf: init+0x0/0x53()
[   95.764103] Calling initcall 0xffffffff8075dd32: init+0x0/0xc()
[   95.770225] Calling initcall 0xffffffff8075dd3e: init+0x0/0xc()
[   95.776347] Calling initcall 0xffffffff8075dd4a: init+0x0/0xc()
[   95.782470] Calling initcall 0xffffffff8075dd56: init+0x0/0x35()
[   95.788680] Calling initcall 0xffffffff8075dd8b: aes_init+0x0/0x313()
[   95.795338] Calling initcall 0xffffffff8075e09e: init+0x0/0xc()
[   95.801459] Calling initcall 0xffffffff8075e248: noop_init+0x0/0xc()
[   95.808006] io scheduler noop registered
[   95.812097] Calling initcall 0xffffffff8075e254: as_init+0x0/0xc()
[   95.818478] io scheduler anticipatory registered (default)
[   95.824159] Calling initcall 0xffffffff8075e260: deadline_init+0x0/0xc()
[   95.831051] io scheduler deadline registered
[   95.835480] Calling initcall 0xffffffff8075e26c: cfq_init+0x0/0xa5()
[   95.842043] io scheduler cfq registered
[   95.846037] Calling initcall 0xffffffff8042d06e: pci_init+0x0/0x2b()
[   95.854461] Calling initcall 0xffffffff8075ec22: pci_sysfs_init+0x0/0x34()
[   95.861585] Calling initcall 0xffffffff8075ec56: pci_proc_init+0x0/0x68()
[   95.868584] Calling initcall 0xffffffff8075ecbe: pcie_portdrv_init+0x0/0x3b()
[   95.876000] assign_interrupt_mode Found MSI capability
[   95.881375] assign_interrupt_mode Found MSI capability
[   95.886778] assign_interrupt_mode Found MSI capability
[   95.892154] assign_interrupt_mode Found MSI capability
[   95.897498] Calling initcall 0xffffffff8075ecf9: aer_service_init+0x0/0xc()
[   95.904679] Calling initcall 0xffffffff8075eea7: fb_console_init+0x0/0x11a()
[   95.911954] Calling initcall 0xffffffff80444ad6: nvidiafb_init+0x0/0x2be()
[   95.919025] nvidiafb_init: call fb_get_options
[   95.923586] nvidiafb_init: call nvidiafb_setup options=nomtrr
[   95.929441] nvidiafb_setup START
[   95.932784] nvidiafb_setup END
[   95.935958] nvidiafb_init: call pci_register_driver
[   95.940971] nvidiafb_probe START
[   95.944323] ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[   95.951984] nvidiafb: Device ID: 10de0391
[   95.970820] nvidiafb: CRTC0 analog found
[   95.990866] nvidiafb: CRTC1 analog not found
[   96.011400] nvidiafb: EDID found from BUS1
[   96.130228] nvidiafb: EDID found from BUS2
[   96.134442] nvidiafb: CRTC 0 appears to have a CRT attached
[   96.140122] nvidiafb: Using CRT on CRTC 0
[   96.144248] nvidiafb: monspecs
[   96.144248]  refresh=60
[   96.144249]  xres=1280
[   96.144250]  yres=1024
[   96.144250]  pixclock=9259
[   96.144251]  left_margin=248
[   96.144251]  right_margin=48
[   96.144252]  upper_margin=38
[   96.144253]  lower_margin=1
[   96.144253]  hysnc_len=112
[   96.144254]  vsync_len=3
[   96.144255]  sync=3
[   96.144255]  vmode=0
[   96.144256]  flag=0x11
[   96.182206] nvidia_set_fbinfo START
[   96.185817] nvidia_set_fbinfo END
[   96.189248] nvidiafb_check_var START
[   96.192939] nvidiafb_check_var END
[   96.196459] nvidia_save_vga START
[   96.199972] nvidia_save_vga END
nvGetClocks: arch=0x40 chipset=0x10de0391 p4020=0xa4301000 p4024=0x00005303 M=3 N=83 MB=1 NB=1 P=0
[   96.216461] nvidiafb_set_par START
[   96.224967] nvidia_write_regs START
[   96.225069] nvidia_write_regs END
[   96.225074] nvidiafb_set_par END
[   96.225087] nvidiafb_setcolreg START
[   96.225088] nvidiafb_setcolreg END
[   96.225089] nvidiafb_setcolreg START
[   96.225090] nvidiafb_setcolreg END
[   96.225091] nvidiafb_setcolreg START
[   96.225092] nvidiafb_setcolreg END
[   96.225093] nvidiafb_setcolreg START
[   96.225094] nvidiafb_setcolreg END
[   96.225095] nvidiafb_setcolreg START
[   96.225096] nvidiafb_setcolreg END
[   96.225097] nvidiafb_setcolreg START
[   96.225098] nvidiafb_setcolreg END
[   96.225099] nvidiafb_setcolreg START
[   96.225100] nvidiafb_setcolreg END
[   96.225101] nvidiafb_setcolreg START
[   96.225102] nvidiafb_setcolreg END
[   96.225103] nvidiafb_setcolreg START
[   96.225104] nvidiafb_setcolreg END
[   96.225105] nvidiafb_setcolreg START
[   96.225106] nvidiafb_setcolreg END
[   96.225107] nvidiafb_setcolreg START
[   96.225108] nvidiafb_setcolreg END
[   96.225109] nvidiafb_setcolreg START
[   96.225110] nvidiafb_setcolreg END
[   96.225111] nvidiafb_setcolreg START
[   96.225112] nvidiafb_setcolreg END
[   96.225113] nvidiafb_setcolreg START
[   96.225114] nvidiafb_setcolreg END
[   96.225115] nvidiafb_setcolreg START
[   96.225116] nvidiafb_setcolreg END
[   96.225117] nvidiafb_setcolreg START
[   96.225118] nvidiafb_setcolreg END
[   96.225120] nvidiafb_setcolreg START
[   96.225121] nvidiafb_setcolreg END
[   96.225122] nvidiafb_setcolreg START
[   96.225123] nvidiafb_setcolreg END
[   96.225124] nvidiafb_setcolreg START
[   96.225125] nvidiafb_setcolreg END
[   96.225126] nvidiafb_setcolreg START
[   96.225127] nvidiafb_setcolreg END
[   96.225128] nvidiafb_setcolreg START
[   96.225129] nvidiafb_setcolreg END
[   96.225130] nvidiafb_setcolreg START
[   96.225131] nvidiafb_setcolreg END
[   96.225132] nvidiafb_setcolreg START
[   96.225133] nvidiafb_setcolreg END
[   96.225134] nvidiafb_setcolreg START
[   96.225135] nvidiafb_setcolreg END
[   96.225136] nvidiafb_setcolreg START
[   96.225137] nvidiafb_setcolreg END
[   96.225138] nvidiafb_setcolreg START
[   96.225139] nvidiafb_setcolreg END
[   96.225140] nvidiafb_setcolreg START
[   96.225141] nvidiafb_setcolreg END
[   96.225142] nvidiafb_setcolreg START
[   96.225143] nvidiafb_setcolreg END
[   96.225144] nvidiafb_setcolreg START
[   96.225145] nvidiafb_setcolreg END
[   96.225146] nvidiafb_setcolreg START
[   96.225147] nvidiafb_setcolreg END
[   96.225148] nvidiafb_setcolreg START
[   96.225149] nvidiafb_setcolreg END
[   96.225150] nvidiafb_setcolreg START
[   96.225151] nvidiafb_setcolreg END
[   96.228143] Console: switching to colour frame buffer device 160x64
[   96.228148] nvidiafb_setcolreg START
[   96.228149] nvidiafb_setcolreg END
[   96.228150] nvidiafb_setcolreg START
[   96.228151] nvidiafb_setcolreg END
[   96.228152] nvidiafb_setcolreg START
[   96.228153] nvidiafb_setcolreg END
[   96.228154] nvidiafb_setcolreg START
[   96.228155] nvidiafb_setcolreg END
[   96.228156] nvidiafb_setcolreg START
[   96.228157] nvidiafb_setcolreg END
[   96.228158] nvidiafb_setcolreg START
[   96.228159] nvidiafb_setcolreg END
[   96.228160] nvidiafb_setcolreg START
[   96.228161] nvidiafb_setcolreg END
[   96.228162] nvidiafb_setcolreg START
[   96.228163] nvidiafb_setcolreg END
[   96.228164] nvidiafb_setcolreg START
[   96.228165] nvidiafb_setcolreg END
[   96.228166] nvidiafb_setcolreg START
[   96.228167] nvidiafb_setcolreg END
[   96.228168] nvidiafb_setcolreg START
[   96.228169] nvidiafb_setcolreg END
[   96.228170] nvidiafb_setcolreg START
[   96.228171] nvidiafb_setcolreg END
[   96.228172] nvidiafb_setcolreg START
[   96.228173] nvidiafb_setcolreg END
[   96.228174] nvidiafb_setcolreg START
[   96.228175] nvidiafb_setcolreg END
[   96.228176] nvidiafb_setcolreg START
[   96.228177] nvidiafb_setcolreg END
[   96.228178] nvidiafb_setcolreg START
[   96.228179] nvidiafb_setcolreg END
[   96.231166] nvidiafb_setcolreg START
[   96.231167] nvidiafb_setcolreg END
[   96.231168] nvidiafb_setcolreg START
[   96.231169] nvidiafb_setcolreg END
[   96.231170] nvidiafb_setcolreg START
[   96.231171] nvidiafb_setcolreg END
[   96.231172] nvidiafb_setcolreg START
[   96.231173] nvidiafb_setcolreg END
[   96.231174] nvidiafb_setcolreg START
[   96.231175] nvidiafb_setcolreg END
[   96.231176] nvidiafb_setcolreg START
[   96.231177] nvidiafb_setcolreg END
[   96.231178] nvidiafb_setcolreg START
[   96.231179] nvidiafb_setcolreg END
[   96.231180] nvidiafb_setcolreg START
[   96.231181] nvidiafb_setcolreg END
[   96.231182] nvidiafb_setcolreg START
[   96.231183] nvidiafb_setcolreg END
[   96.231184] nvidiafb_setcolreg START
[   96.231185] nvidiafb_setcolreg END
[   96.231186] nvidiafb_setcolreg START
[   96.231187] nvidiafb_setcolreg END
[   96.231188] nvidiafb_setcolreg START
[   96.231189] nvidiafb_setcolreg END
[   96.231190] nvidiafb_setcolreg START
[   96.231191] nvidiafb_setcolreg END
[   96.231192] nvidiafb_setcolreg START
[   96.231193] nvidiafb_setcolreg END
[   96.231194] nvidiafb_setcolreg START
[   96.231195] nvidiafb_setcolreg END
[   96.231196] nvidiafb_setcolreg START
[   96.231198] nvidiafb_setcolreg END
[   96.741910] nvidiafb: PCI nVidia NV39 framebuffer (64MB @ 0xD0000000)
[   96.741911]  FbMapSize=67108864
[   96.741912]  Architecture=64
[   96.741912]  FbUsableSize=66535424
[   96.741913]  ScratchBufferSize=16384
[   96.741914]  ScratchBufferStart=0x3F70000
[   96.741914]  CursorStart=0x3F7C000
[   96.741915]  screen_base=0xffffc20001680000
[   96.741916]  screen_size=66535424
[   96.741917]  FbStart=0xffffc20001680000
[   96.784822] nvidiafb_probe END
[   96.788395] nvidiafb_init: ret pci_register_driver result=0
[   96.794492] Calling initcall 0xffffffff8075fda8: acpi_ac_init+0x0/0x45()
[   96.801800] Calling initcall 0xffffffff8075fded: acpi_battery_init+0x0/0x45()
[   96.809543] Calling initcall 0xffffffff8075fe32: acpi_button_init+0x0/0x60()
[   96.817210] ACPI: Power Button (FF) [PWRF]
[   96.821895] ACPI: Power Button (CM) [PWRB]
[   96.826570] Calling initcall 0xffffffff8076045c: acpi_fan_init+0x0/0x60()
[   96.834000] Calling initcall 0xffffffff80760502: acpi_video_init+0x0/0x60()
[   96.841664] Calling initcall 0xffffffff80760562: hotkey_init+0x0/0x21d()
[   96.849029] Using specific hotkey driver
[   96.853575] Calling initcall 0xffffffff8076080f: irqrouter_init_sysfs+0x0/0x38()
[   96.861690] Calling initcall 0xffffffff807609c4: acpi_processor_init+0x0/0x80()
[   96.869837] ACPI Error (psparse-0537): Method parse/execution failed [\_PR_.CPU1._PDC] (Node ffff810002f7fab0), AE_BAD_HEADER
[   96.881958] ACPI: Processor [CPU1] (supports 8 throttling states)
[   96.888870] ACPI Error (psparse-0537): Method parse/execution failed [\_PR_.CPU2._PDC] (Node ffff810002f7f9b0), AE_BAD_HEADER
[   96.901047] ACPI: Processor [CPU2] (supports 8 throttling states)
[   96.907991] ACPI: Getting cpuindex for acpiid 0x3
[   96.913511] ACPI: Getting cpuindex for acpiid 0x4
[   96.919029] Calling initcall 0xffffffff80760a44: acpi_container_init+0x0/0x43()
[   96.928635] Calling initcall 0xffffffff80760a87: acpi_thermal_init+0x0/0x60()
[   96.936678] Calling initcall 0xffffffff80761488: rand_initialize+0x0/0x2c()
[   96.944551] Calling initcall 0xffffffff807614b4: tty_init+0x0/0x1cd()
[   96.950171] Calling initcall 0xffffffff807616d9: pty_init+0x0/0x427()
[   96.962461] Calling initcall 0xffffffff8076209b: lp_init_module+0x0/0x25e()
[   96.970440] lp: driver loaded but no devices found
[   96.976152] Calling initcall 0xffffffff8076241b: rtc_init+0x0/0x1a6()
[   96.983642] Real Time Clock Driver v1.12ac
[   96.988668] Calling initcall 0xffffffff807625c1: hpet_init+0x0/0x62()
[   96.996133] Calling initcall 0xffffffff80762623: nvram_init+0x0/0x80()
[   97.003680] Non-volatile memory driver v1.2
[   97.008832] Calling initcall 0xffffffff807626a3: ppdev_init+0x0/0xa9()
[   97.016422] ppdev: user-space parallel port driver
[   97.022231] Calling initcall 0xffffffff8076274c: agp_init+0x0/0x26()
[   97.029665] Linux agpgart interface v0.101 (c) Dave Jones
[   97.036107] Calling initcall 0xffffffff8076286e: agp_intel_init+0x0/0x1d()
[   97.044131] Calling initcall 0xffffffff8076288b: drm_core_init+0x0/0x146()
[   97.052142] [drm] Initialized drm 1.0.1 20051102
[   97.057855] Calling initcall 0xffffffff807629d1: hangcheck_init+0x0/0x81()
[   97.065896] Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
[   97.075988] Hangcheck: Using monotonic_clock().
[   97.081691] Calling initcall 0xffffffff80762b06: cn_proc_init+0x0/0x33()
[   97.089631] Calling initcall 0xffffffff80762e50: serial8250_init+0x0/0x137()
[   97.097924] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   97.106980] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   97.114410] Calling initcall 0xffffffff8076305a: serial8250_pnp_init+0x0/0xc()
[   97.123150] 00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   97.130041] Calling initcall 0xffffffff80763066: serial8250_pci_init+0x0/0xe()
[   97.138646] Calling initcall 0xffffffff80763568: parport_default_proc_register+0x0/0x1d()
[   97.148202] Calling initcall 0xffffffff8076386c: parport_pc_init+0x0/0x17f()
[   97.156758] Calling initcall 0xffffffff80763b97: topology_sysfs_init+0x0/0x3c()
[   97.165478] Calling initcall 0xffffffff80763c09: rd_init+0x0/0x193()
[   97.173591] RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
[   97.182452] Calling initcall 0xffffffff80763db6: loop_init+0x0/0x2c5()
[   97.190603] loop: loaded (max 8 devices)
[   97.195927] Calling initcall 0xffffffff8076407b: pkt_init+0x0/0xe9()
[   97.203770] Calling initcall 0xffffffff80764164: init_cryptoloop+0x0/0x25()
[   97.212196] Calling initcall 0xffffffff80764189: sky2_init_module+0x0/0xe()
[   97.220667] ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 19 (level, low) -> IRQ 19
[   97.230522] sky2 v1.9 addr 0xfa9fc000 irq 19 Yukon-EC (0xb6) rev 2
[   97.238338] sky2 eth0: addr 00:17:31:e1:ce:a3
[   97.244372] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[   97.253980] sky2 v1.9 addr 0xfa8fc000 irq 16 Yukon-EC (0xb6) rev 2
[   97.261847] sky2 eth1: addr 00:17:31:e1:cd:12
[   97.267707] Calling initcall 0xffffffff807641dd: net_olddevs_init+0x0/0xac()
[   97.276369] Calling initcall 0xffffffff80764313: dummy_init_module+0x0/0xb8()
[   97.285092] Calling initcall 0xffffffff804bb001: init_netconsole+0x0/0x5e()
[   97.293603] netconsole: not configured, aborting
[   97.299728] Calling initcall 0xffffffff807643cb: piix_ide_init+0x0/0xc1()
[   97.308086] Calling initcall 0xffffffff804bba23: siimage_ide_init+0x0/0xe()
[   97.316620] Calling initcall 0xffffffff804bcffe: generic_ide_init+0x0/0xe()
[   97.325142] Calling initcall 0xffffffff807644f0: ide_init+0x0/0x87()
[   97.333064] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   97.340942] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   97.350500] ICH7: IDE controller at PCI slot 0000:00:1f.1
[   97.357435] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 22 (level, low) -> IRQ 22
[   97.366414] ICH7: chipset revision 1
[   97.371534] ICH7: not 100% native mode: will probe irqs later
[   97.378825]     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
[   97.387630]     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
[   98.132307] hda: TSSTcorpCD/DVDW SH-S162L, ATAPI CD/DVD-ROM drive
[   98.812633] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   99.387438] Calling initcall 0xffffffff80764d4c: idedisk_init+0x0/0xc()
[   99.395613] Calling initcall 0xffffffff80764d58: ide_cdrom_init+0x0/0xc()
[   99.409809] hda: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
[   99.419089] Uniform CD-ROM driver Revision: 3.20
[   99.427939] Calling initcall 0xffffffff80764fce: raid_init+0x0/0xc()
[   99.435970] Calling initcall 0xffffffff80764fda: init_this_scsi_driver+0x0/0xe1()
[   99.445073] Calling initcall 0xffffffff807650bb: init_idescsi_module+0x0/0xc()
[   99.453912] Calling initcall 0xffffffff807650c7: init_sd+0x0/0x106()
[   99.461884] Calling initcall 0xffffffff807651cd: init_sg+0x0/0x15e()
[   99.469831] Calling initcall 0xffffffff8076532b: ata_init+0x0/0x78()
[   99.477792] Calling initcall 0xffffffff807653a3: ahci_init+0x0/0xe()
[   99.485750] Calling initcall 0xffffffff807653b1: piix_init+0x0/0x25()
[   99.493780] ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
[   99.656040] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 23 (level, low) -> IRQ 23
[   99.665016] ata1: SATA max UDMA/133 cmd 0xE400 ctl 0xE082 bmdma 0xD880 irq 23
[   99.673694] ata2: SATA max UDMA/133 cmd 0xE000 ctl 0xDC02 bmdma 0xD888 irq 23
[   99.682353] scsi0 : ata_piix
[   99.846190] ata1.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 0/32)
[   99.855413] ata1.00: ata1: dev 0 multi count 16
[   99.862776] ata1.00: configured for UDMA/133
[   99.868604] scsi1 : ata_piix
[  100.535417] ata2.00: ATA-6, max UDMA/133, 640 sectors: LBA
[  100.542498] ata2.00: ata2: dev 0 multi count 1
[  100.548451] ata2.00: Drive reports diagnostics failure. This may indicate a drive
[  100.557467] ata2.00: fault or invalid emulation. Contact drive vendor for information.
[  100.567271] ata2.00: configured for UDMA/133
[  100.573249] scsi 0:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
[  100.582914] SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
[  100.591144] sda: Write Protect is off
[  100.596344] SCSI device sda: drive cache: write back
[  100.602853] SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
[  100.611080] sda: Write Protect is off
[  100.616285] SCSI device sda: drive cache: write back
[  100.622789]  sda: sda1 sda2
[  100.656423] sd 0:0:0:0: Attached scsi disk sda
[  100.662463] sd 0:0:0:0: Attached scsi generic sg0 type 0
[  100.669336] scsi 1:0:0:0: Direct-Access     ATA      Config  Disk     RGL1 PQ: 0 ANSI: 5
[  100.679018] SCSI device sdb: 640 512-byte hdwr sectors (0 MB)
[  100.686332] sdb: Write Protect is off
[  100.691576] SCSI device sdb: drive cache: write through
[  100.698380] SCSI device sdb: 640 512-byte hdwr sectors (0 MB)
[  100.705662] sdb: Write Protect is off
[  100.710866] SCSI device sdb: drive cache: write through
[  100.717610]  sdb: unknown partition table
[  100.723789] sd 1:0:0:0: Attached scsi disk sdb
[  100.729791] sd 1:0:0:0: Attached scsi generic sg1 type 0
[  100.736612] Calling initcall 0xffffffff807653d6: pdc_ata_init+0x0/0xe()
[  100.744819] Calling initcall 0xffffffff807653e4: jmicron_init+0x0/0xe()
[  100.753011] Calling initcall 0xffffffff807653f2: mpiix_init+0x0/0xe()
[  100.761016] Calling initcall 0xffffffff80765400: ata_generic_init+0x0/0xe()
[  100.769542] Calling initcall 0xffffffff8076540e: cdrom_init+0x0/0xd()
[  100.777503] Calling initcall 0xffffffff8076564d: ehci_hcd_init+0x0/0xe()
[  100.785763] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 20 (level, low) -> IRQ 20
[  100.795351] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[  100.802220] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
[  100.811161] ehci_hcd 0000:00:1d.7: debug port 1
[  100.817195] ehci_hcd 0000:00:1d.7: irq 20, io mem 0xfebfbc00
[  100.828205] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[  100.837243] usb usb1: configuration #1 chosen from 1 choice
[  100.844302] hub 1-0:1.0: USB hub found
[  100.849512] hub 1-0:1.0: 8 ports detected
[  100.959602] Calling initcall 0xffffffff8076565b: ohci_hcd_pci_init+0x0/0x38()
[  100.968275] Calling initcall 0xffffffff80765693: uhci_hcd_init+0x0/0x79()
[  100.976568] USB Universal Host Controller Interface driver v3.0
[  100.983955] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 20 (level, low) -> IRQ 20
[  100.992831] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[  100.999530] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[  101.008387] uhci_hcd 0000:00:1d.0: irq 20, io base 0x0000e480
[  101.015655] usb usb2: configuration #1 chosen from 1 choice
[  101.022705] hub 2-0:1.0: USB hub found
[  101.027904] hub 2-0:1.0: 2 ports detected
[  101.135740] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 17
[  101.144644] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[  101.151381] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
[  101.160299] uhci_hcd 0000:00:1d.1: irq 17, io base 0x0000e800
[  101.167889] usb usb3: configuration #1 chosen from 1 choice
[  101.174998] hub 3-0:1.0: USB hub found
[  101.180245] hub 3-0:1.0: 2 ports detected
[  101.288050] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
[  101.296972] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[  101.303726] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
[  101.312639] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000e880
[  101.319949] usb usb4: configuration #1 chosen from 1 choice
[  101.327034] hub 4-0:1.0: USB hub found
[  101.332276] hub 4-0:1.0: 2 ports detected
[  101.380205] usb 1-7: new high speed USB device using ehci_hcd and address 3
[  101.440682] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 19
[  101.449717] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[  101.456469] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
[  101.465392] uhci_hcd 0000:00:1d.3: irq 19, io base 0x0000ec00
[  101.472722] usb usb5: configuration #1 chosen from 1 choice
[  101.479792] hub 5-0:1.0: USB hub found
[  101.485009] hub 5-0:1.0: 2 ports detected
[  101.522162] usb 1-7: configuration #1 chosen from 1 choice
[  101.529355] hub 1-7:1.0: USB hub found
[  101.534803] hub 1-7:1.0: 4 ports detected
[  101.593313] Calling initcall 0xffffffff8076570c: hid_init+0x0/0x40()
[  101.882460] usb 2-2: new low speed USB device using uhci_hcd and address 2
[  102.068358] usb 2-2: configuration #1 chosen from 1 choice
[  102.414242] usb 1-7.3: new high speed USB device using ehci_hcd and address 4
[  102.522216] usb 1-7.3: configuration #1 chosen from 1 choice
[  102.531236] usbcore: registered new interface driver hiddev
[  102.552310] input: Logitech USB-PS/2 Optical Mouse as /class/input/input0
[  102.560558] input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.0-2
[  102.570692] usbcore: registered new interface driver usbhid
[  102.577772] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[  102.585441] Calling initcall 0xffffffff80765817: i8042_init+0x0/0x305()
[  102.593654] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[  102.601335] PNP: PS/2 controller doesn't have AUX irq; using default 12
[  102.611705] serio: i8042 KBD port at 0x60,0x64 irq 1
[  102.618165] serio: i8042 AUX port at 0x60,0x64 irq 12
[  102.624708] Calling initcall 0xffffffff80765b1c: serport_init+0x0/0x2a()
[  102.632970] Calling initcall 0xffffffff80765b46: ct82c710_init+0x0/0x133()
[  102.641398] Calling initcall 0xffffffff80765c79: pcips2_init+0x0/0xe()
[  102.649508] Calling initcall 0xffffffff80765c87: serio_raw_init+0x0/0x16()
[  102.657932] Calling initcall 0xffffffff80765db3: mousedev_init+0x0/0xe9()
[  102.666315] mice: PS/2 mouse device common for all mice
[  102.673013] Calling initcall 0xffffffff80765e9c: evdev_init+0x0/0xc()
[  102.681006] Calling initcall 0xffffffff80765ea8: atkbd_init+0x0/0x16()
[  102.689050] Calling initcall 0xffffffff80765ebe: xtkbd_init+0x0/0x16()
[  102.697087] Calling initcall 0xffffffff80765ed4: psmouse_init+0x0/0x46()
[  102.705320] Calling initcall 0xffffffff807661d5: cpufreq_stats_init+0x0/0x95()
[  102.714048] Calling initcall 0xffffffff80766276: cpufreq_gov_powersave_init+0x0/0xc()<6>input: AT Translated Set 2 keyboard as /class/input/input1
[  102.728695]
[  102.731690] Calling initcall 0xffffffff807662a1: cpufreq_gov_dbs_init+0x0/0xc()
[  102.740546] Calling initcall 0xffffffff807662ad: cpufreq_gov_dbs_init+0x0/0xc()
[  102.749401] Calling initcall 0xffffffff8076688f: ioat_init_module+0x0/0xe()
[  102.757917] Calling initcall 0xffffffff80767b76: oprofile_init+0x0/0x48()
[  102.766243] oprofile: using NMI interrupt.
[  102.771816] Calling initcall 0xffffffff8076836d: flow_cache_init+0x0/0x18b()
[  102.780382] Calling initcall 0xffffffff8076967a: init_syncookies+0x0/0x19()
[  102.788872] Calling initcall 0xffffffff80769693: xfrm4_beet_init+0x0/0x11()
[  102.797328] Calling initcall 0xffffffff807696a4: xfrm4_transport_init+0x0/0x11()
[  102.806202] Calling initcall 0xffffffff807696b5: xfrm4_tunnel_init+0x0/0x11()
[  102.814829] Calling initcall 0xffffffff807696c6: inet_diag_init+0x0/0x60()
[  102.823178] Calling initcall 0xffffffff80769726: tcp_diag_init+0x0/0xc()
[  102.831341] Calling initcall 0xffffffff80769732: cubictcp_register+0x0/0x80()
[  102.839929] TCP cubic registered
[  102.844563] Calling initcall 0xffffffff80769997: af_unix_init+0x0/0x66()
[  102.852740] NET: Registered protocol family 1
[  102.858524] Calling initcall 0xffffffff807699fd: packet_init+0x0/0x53()
[  102.866620] NET: Registered protocol family 17
[  102.872469] Calling initcall 0xffffffff80769a50: ipsec_pfkey_init+0x0/0x8b()
[  102.880970] NET: Registered protocol family 15
[  102.886823] Calling initcall 0xffffffff80769adb: init_sunrpc+0x0/0x36()
[  102.894920] Calling initcall 0xffffffff80769b11: init_rpcsec_gss+0x0/0x2e()
[  102.903345] Calling initcall 0xffffffff80769b3f: init_kerberos_module+0x0/0x25()
[  102.912180] Calling initcall 0xffffffff80769b64: sctp_init+0x0/0x652()
[  102.947082] SCTP: Hash tables configured (established 65536 bind 65536)
[  102.955129] Calling initcall 0xffffffff80752501: init_lapic_nmi_sysfs+0x0/0x38()
[  102.964022] Calling initcall 0xffffffff80754620: centrino_init+0x0/0xbe()
[  102.972271] Calling initcall 0xffffffff807546de: acpi_cpufreq_init+0x0/0xdc()
[  102.981158] Calling initcall 0xffffffff8075896a: clocksource_done_booting+0x0/0xd()
[  102.990506] Calling initcall 0xffffffff80462e08: acpi_poweroff_init+0x0/0x59()
[  102.999483] Calling initcall 0xffffffff80761479: seqgen_init+0x0/0xf()
[  103.007450] Calling initcall 0xffffffff807630ec: early_uart_console_switch+0x0/0x7c()
[  103.016706] Calling initcall 0xffffffff80765f1a: rtc_hctosys+0x0/0x175()
[  103.024816] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[  103.032447] Calling initcall 0xffffffff80541eed: net_random_reseed+0x0/0x64()
[  103.041018] Calling initcall 0xffffffff80769374: tcp_congestion_default+0x0/0xc()
[  103.072370] kjournald starting.  Commit interval 5 seconds
[  103.079257] EXT3-fs: mounted filesystem with ordered data mode.
[  103.086585] VFS: Mounted root (ext3 filesystem) readonly.
[  103.093382] Freeing unused kernel memory: 236k freed
</log>

<config>
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.19-rc2
# Sat Oct 14 11:07:51 2006
#
CONFIG_X86_64=y
CONFIG_64BIT=y
CONFIG_X86=y
CONFIG_ZONE_DMA32=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_MMU=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_CMPXCHG=y
CONFIG_EARLY_PRINTK=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_ARCH_POPULATES_NODE_MAP=y
CONFIG_DMI=y
CONFIG_AUDIT_ARCH=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION="-w8"
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_IPC_NS is not set
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set
# CONFIG_UTS_NS is not set
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_CPUSETS=y
CONFIG_RELAY=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
# CONFIG_EMBEDDED is not set
CONFIG_UID16=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_SLAB=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_RT_MUTEXES=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y

#
# Block layer
#
CONFIG_BLOCK=y
CONFIG_LBD=y
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_LSF is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_AS=y
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="anticipatory"

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VSMP is not set
# CONFIG_MK8 is not set
CONFIG_MPSC=y
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_L1_CACHE_BYTES=128
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_INTERNODE_CACHE_BYTES=128
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_HT=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_MTRR=y
CONFIG_SMP=y
# CONFIG_SCHED_SMT is not set
CONFIG_SCHED_MC=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_BKL=y
# CONFIG_NUMA is not set
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_RESOURCES_64BIT=y
CONFIG_NR_CPUS=4
# CONFIG_HOTPLUG_CPU is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_HPET_TIMER=y
# CONFIG_HPET_EMULATE_RTC is not set
CONFIG_IOMMU=y
# CONFIG_CALGARY_IOMMU is not set
CONFIG_SWIOTLB=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_INTEL=y
# CONFIG_X86_MCE_AMD is not set
CONFIG_KEXEC=y
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x200000
CONFIG_SECCOMP=y
# CONFIG_CC_STACKPROTECTOR is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
# CONFIG_REORDER is not set
CONFIG_K8_NB=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_ISA_DMA_API=y
CONFIG_GENERIC_PENDING_IRQ=y

#
# Power management options
#
CONFIG_PM=y
CONFIG_PM_LEGACY=y
# CONFIG_PM_DEBUG is not set
# CONFIG_PM_SYSFS_DEPRECATED is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_HOTKEY=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_SBS is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=y
CONFIG_CPU_FREQ_DEBUG=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_STAT_DETAILS=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y

#
# CPUFreq processor drivers
#
# CONFIG_X86_POWERNOW_K8 is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=y
CONFIG_X86_ACPI_CPUFREQ=y

#
# shared options
#
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
# CONFIG_X86_SPEEDSTEP_LIB is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCIEPORTBUS=y
CONFIG_PCIEAER=y
CONFIG_PCI_MSI=y
# CONFIG_PCI_MULTITHREAD_PROBE is not set
# CONFIG_PCI_DEBUG is not set
CONFIG_HT_IRQ=y

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_IA32_EMULATION=y
CONFIG_IA32_AOUT=y
CONFIG_COMPAT=y
CONFIG_SYSVIPC_COMPAT=y

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
# CONFIG_NETDEBUG is not set
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_IPV6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
CONFIG_NETWORK_SECMARK=y
# CONFIG_NETFILTER is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IP_SCTP=y
# CONFIG_SCTP_DBG_MSG is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_HMAC_NONE is not set
# CONFIG_SCTP_HMAC_SHA1 is not set
CONFIG_SCTP_HMAC_MD5=y

#
# TIPC Configuration (EXPERIMENTAL)
#
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_TCPPROBE is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
CONFIG_FW_LOADER=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_SYS_HYPERVISOR is not set

#
# Connector - unified userspace <-> kernelspace linker
#
CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_PNPACPI=y

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=y
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=8192
CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
CONFIG_BLK_DEV_INITRD=y
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_IDE_TASK_IOCTL=y

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPNP=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
CONFIG_BLK_DEV_SIIMAGE=y
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_RAID_ATTRS=y
CONFIG_SCSI=y
# CONFIG_SCSI_NETLINK is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
CONFIG_SCSI_EATA=y
CONFIG_SCSI_EATA_TAGGED_QUEUE=y
CONFIG_SCSI_EATA_LINKED_COMMANDS=y
CONFIG_SCSI_EATA_MAX_TAGS=16
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_DEBUG is not set

#
# Serial ATA (prod) and Parallel ATA (experimental) drivers
#
CONFIG_ATA=y
CONFIG_SATA_AHCI=y
# CONFIG_SATA_SVW is not set
CONFIG_ATA_PIIX=y
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
CONFIG_SATA_PROMISE=y
# CONFIG_SATA_SX4 is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIL24 is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set
CONFIG_SATA_INTEL_COMBINED=y
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CS5520 is not set
# CONFIG_PATA_CS5530 is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_ATA_GENERIC=y
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT821X is not set
CONFIG_PATA_JMICRON=y
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_MPIIX=y
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RZ1000 is not set
# CONFIG_PATA_SC1200 is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
CONFIG_SKY2=y
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set
# CONFIG_QLA3XXX is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set
# CONFIG_MYRI10GE is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
CONFIG_NETCONSOLE=y
CONFIG_NETPOLL=y
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
CONFIG_NET_POLL_CONTROLLER=y

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_FF_MEMLESS is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1024
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
CONFIG_KEYBOARD_XTKBD=y
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
# CONFIG_SERIO_PARKBD is not set
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=y
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=y
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_VIA is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_I915 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
# CONFIG_MWAVE is not set
# CONFIG_PC8736x_GPIO is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
# CONFIG_HPET_RTC_IRQ is not set
CONFIG_HPET_MMAP=y
CONFIG_HANGCHECK_TIMER=y

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_I2C_CHARDEV is not set

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
# CONFIG_HWMON is not set
# CONFIG_HWMON_VID is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set
# CONFIG_TIFM_CORE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set
# CONFIG_USB_DABUSB is not set

#
# Graphics support
#
CONFIG_FIRMWARE_EDID=y
CONFIG_FB=y
# CONFIG_FB_DDC is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_S1D13XXX is not set
CONFIG_FB_NVIDIA=y
CONFIG_FB_NVIDIA_I2C=y
# CONFIG_FB_RIVA is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
CONFIG_VIDEO_SELECT=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
CONFIG_FONTS=y
# CONFIG_FONT_8x8 is not set
CONFIG_FONT_8x16=y
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_7x14 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
# CONFIG_FONT_10x18 is not set

#
# Logo configuration
#
# CONFIG_LOGO is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_SUSPEND=y
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_SPLIT_ISO=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_OHCI_HCD=y
# CONFIG_USB_OHCI_BIG_ENDIAN is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Input Devices
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_USB_HIDINPUT_POWERBOOK is not set
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_TOUCHSCREEN is not set
# CONFIG_USB_YEALINK is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set
# CONFIG_USB_ATI_REMOTE2 is not set
# CONFIG_USB_KEYSPAN_REMOTE is not set
# CONFIG_USB_APPLETOUCH is not set
# CONFIG_USB_TRANCEVIBRATOR is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_MON is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGET is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# LED devices
#
# CONFIG_NEW_LEDS is not set

#
# LED drivers
#

#
# LED Triggers
#

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
#
# CONFIG_EDAC is not set

#
# Real Time Clock
#
CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set

#
# RTC drivers
#
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_TEST is not set
# CONFIG_RTC_DRV_V3020 is not set

#
# DMA Engine support
#
CONFIG_DMA_ENGINE=y

#
# DMA Clients
#
CONFIG_NET_DMA=y

#
# DMA Devices
#
CONFIG_INTEL_IOATDMA=y

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
# CONFIG_EXT4DEV_FS is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
CONFIG_JFS_FS=y
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=y
CONFIG_XFS_QUOTA=y
# CONFIG_XFS_SECURITY is not set
CONFIG_XFS_POSIX_ACL=y
# CONFIG_XFS_RT is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
CONFIG_ROMFS_FS=y
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y
CONFIG_AUTOFS_FS=y
CONFIG_AUTOFS4_FS=y
CONFIG_FUSE_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
CONFIG_CONFIGFS_FS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=y
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=y
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=y
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_CIFS=y
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_XATTR is not set
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_EXPERIMENTAL is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
# CONFIG_ACORN_PARTITION_CUMANA is not set
# CONFIG_ACORN_PARTITION_EESOX is not set
CONFIG_ACORN_PARTITION_ICS=y
# CONFIG_ACORN_PARTITION_ADFS is not set
# CONFIG_ACORN_PARTITION_POWERTEC is not set
CONFIG_ACORN_PARTITION_RISCIX=y
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
CONFIG_ATARI_PARTITION=y
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
CONFIG_SGI_PARTITION=y
CONFIG_ULTRIX_PARTITION=y
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y

#
# Distributed Lock Manager
#
# CONFIG_DLM is not set

#
# Instrumentation Support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=y
CONFIG_KPROBES=y

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_PRINTK_TIME=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=15
# CONFIG_DETECT_SOFTLOCKUP is not set
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_LIST is not set
# CONFIG_FRAME_POINTER is not set
# CONFIG_UNWIND_INFO is not set
CONFIG_FORCED_INLINING=y
# CONFIG_HEADERS_CHECK is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_LKDTM is not set
# CONFIG_DEBUG_RODATA is not set
# CONFIG_IOMMU_DEBUG is not set
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_DEBUG_PROC_KEYS=y
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_ECB is not set
# CONFIG_CRYPTO_CBC is not set
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_TWOFISH_X86_64 is not set
# CONFIG_CRYPTO_SERPENT is not set
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_CAST5=y
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#

#
# Library routines
#
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC32=y
CONFIG_LIBCRC32C=y
CONFIG_ZLIB_INFLATE=y
CONFIG_PLIST=y
</config>


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
