From: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
Subject: radeon 7000 support
Date: Thu, 25 Aug 2005 01:20:19 +0200
Message-ID: <430D00B3.5050204@ribosome.natur.cuni.cz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E84Xv-0007s0-5P
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Aug 2005 16:20:39 -0700
Received: from r3az252.chello.upc.cz
	([213.220.243.252] helo=aquarius.doma ident=qmailr)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E84Xo-0004oD-Th
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Aug 2005 16:20:39 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net

Hi, I get with 2.6.13-rc7 on one server motherboard the following with
ACPI enabled (haven't tried without):

Brought up 2 CPUs
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 3.00 entry at 0xfd663, last bus=9
PCI: Using MMCONFIG
ACPI: Subsystem revision 20050408
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
Boot video device is 0000:08:01.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PE1A._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PE1A.PXHA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PE1A.PXHB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PE2A._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PE2B._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PE3A._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PE3B._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIX._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 6 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 14 15) *9
ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 6 7 *10 11 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0401
pnp: PnP ACPI: found 11 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:01:00.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:01:00.2
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:04.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:05.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:06.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:07.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.0
  IO window: 2000-2fff
  MEM window: d0100000-d01fffff
  PREFETCH window: d8000000-dfffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 3000-3fff
  MEM window: d0200000-d02fffff
  PREFETCH window: d0300000-d03fffff
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:02.0 to 64
PCI: Setting latency timer of device 0000:01:00.0 to 64
PCI: Setting latency timer of device 0000:01:00.2 to 64
ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:04.0 to 64
ACPI: PCI Interrupt 0000:00:05.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:05.0 to 64
ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:06.0 to 64
ACPI: PCI Interrupt 0000:00:07.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:07.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
Simple Boot Flag at 0x3a set to 0x1
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
highmem bounce pool size: 64 pages
SGI XFS with no debug enabled
Initializing Cryptographic API
radeonfb_pci_register BEGIN
ACPI: PCI Interrupt 0000:08:01.0[A] -> GSI 24 (level, low) -> IRQ 17
radeonfb (0000:08:01.0): Found 0k of DDR 32 bits wide videoram
radeonfb (0000:08:01.0): cannot map FB
ACPI: PCI interrupt for device 0000:08:01.0 disabled
radeonfb: probe of 0000:08:01.0 failed with error -5
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: CPU0 (power states: C1[C1])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: CPU1 (power states: C1[C1])
ACPI: Processor [CPU1] (supports 8 throttling states)
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using monotonic_clock().
PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12


Is this known? Please Cc: me in replies. ;)

0000:00:00.0 Host bridge: Intel Corporation E7520 Memory Controller Hub (rev 0c)
0000:00:00.1 Class ff00: Intel Corporation E7525/E7520 Error Reporting Registers (rev 0c)00GHz GenuineIntel GNU/Linux
0000:00:01.0 System peripheral: Intel Corporation E7520 DMA Controller (rev 0c)
0000:00:02.0 PCI bridge: Intel Corporation E7525/E7520/E7320 PCI Express Port A (rev 0c)
0000:00:04.0 PCI bridge: Intel Corporation E7525/E7520 PCI Express Port B (rev 0c)
0000:00:05.0 PCI bridge: Intel Corporation E7520 PCI Express Port B1 (rev 0c)
0000:00:06.0 PCI bridge: Intel Corporation E7520 PCI Express Port C (rev 0c)
0000:00:07.0 PCI bridge: Intel Corporation E7520 PCI Express Port C1 (rev 0c)
0000:00:1c.0 PCI bridge: Intel Corporation 6300ESB 64-bit PCI-X Bridge (rev 02)
0000:00:1d.0 USB Controller: Intel Corporation 6300ESB USB Universal Host Controller (rev 02)
0000:00:1d.1 USB Controller: Intel Corporation 6300ESB USB Universal Host Controller (rev 02)
0000:00:1d.4 System peripheral: Intel Corporation 6300ESB Watchdog Timer (rev 02)
0000:00:1d.5 PIC: Intel Corporation 6300ESB I/O Advanced Programmable Interrupt Controller (rev 02)
0000:00:1d.7 USB Controller: Intel Corporation 6300ESB USB2 Enhanced Host Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 0a)
0000:00:1f.0 ISA bridge: Intel Corporation 6300ESB LPC Interface Controller (rev 02)
0000:00:1f.1 IDE interface: Intel Corporation 6300ESB PATA Storage Controller (rev 02)
0000:00:1f.2 IDE interface: Intel Corporation 6300ESB SATA Storage Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corporation 6300ESB SMBus Controller (rev 02)
0000:01:00.0 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI Bridge A (rev 09)
0000:01:00.2 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI Bridge B (rev 09)
0000:08:01.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE]
0000:08:02.0 Ethernet controller: Intel Corporation 82541GI/PI Gigabit Ethernet Controller
0000:08:03.0 Ethernet controller: Intel Corporation 82541GI/PI Gigabit Ethernet Controller
0000:09:01.0 Ethernet controller: Intel Corporation 82541PI Gigabit Ethernet Controller (rev 05)


http://www.msicomputer.com/product/p_spec.asp?model=E7520_Master-S2M&class=spd
BIOS is 1.20
M.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
