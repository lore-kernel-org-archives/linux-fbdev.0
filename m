From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 4468] New: Upgrade to 2.6.11.6 results in no
 longer being able to turn the lcd backlight off.
Date: Sun, 10 Apr 2005 17:28:43 -0700
Message-ID: <20050410172843.6366ef8a.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DKmnp-0002p4-3U
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 10 Apr 2005 17:29:21 -0700
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DKmnU-0001jJ-N8
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 10 Apr 2005 17:29:20 -0700
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
Cc: klug@blarg.org

Can you test 2.6.12-rc2 please?


Begin forwarded message:

Date: Sun, 10 Apr 2005 17:25:49 -0700
From: bugme-daemon@osdl.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 4468] New: Upgrade to 2.6.11.6 results in no longer being able to turn the lcd backlight off.


http://bugme.osdl.org/show_bug.cgi?id=4468

           Summary: Upgrade to 2.6.11.6 results in no longer being able to
                    turn the lcd backlight off.
    Kernel Version: 2.6.11.6
            Status: NEW
          Severity: normal
             Owner: acpi_other@kernel-bugs.osdl.org
         Submitter: klug@blarg.org


Distribution:

Gentoo 2005.0

Hardware Environment:

Toshiba Satellite 5005-S507

lspci -vvv

0000:00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge and
Memory Controller Hub (rev 04)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f8000000 (32-bit, prefetchable)
	Capabilities: [88] #09 [e104]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3-
Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=x4

0000:00:01.0 PCI bridge: Intel Corporation 82815 815 Chipset AGP Bridge (rev 04)
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fd000000-fdffffff
	Prefetchable memory behind bridge: eff00000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 05) (prog-if 00
[Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=04, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fce00000-fcefffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corporation 82801BA ISA Bridge (LPC) (rev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0

0000:00:1f.1 IDE interface: Intel Corporation 82801BA IDE U100 (rev 05) (prog-if
80 [Master])
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at cff0 [size=16]

0000:00:1f.2 USB Controller: Intel Corporation 82801BA/BAM USB (Hub #1) (rev 05)
(prog-if 00 [UHCI])
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at cf80 [size=32]

0000:00:1f.4 USB Controller: Intel Corporation 82801BA/BAM USB (Hub #2) (rev 05)
(prog-if 00 [UHCI])
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 10
	Region 4: I/O ports at 1000 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corporation 82801BA/BAM AC'97
Audio (rev 05)
	Subsystem: Toshiba America Info Systems: Unknown device 0002
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at 1400
	Region 1: I/O ports at 1040 [size=64]

0000:00:1f.6 Modem: Intel Corporation 82801BA/BAM AC'97 Modem (rev 05) (prog-if
00 [Generic])
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 255
	Region 0: I/O ports at 1800 [disabled]
	Region 1: I/O ports at 1080 [disabled] [size=128]

0000:01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 440
Go] (rev a3) (prog-if 00 [VGA])
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at fd000000 (32-bit, non-prefetchable)
	Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Region 2: Memory at eff80000 (32-bit, prefetchable) [size=512K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit- FW+ AGP3-
Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=x4

0000:02:07.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000
Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 255
	Region 0: Memory at 20000000 (32-bit, non-prefetchable) [disabled]
	Region 1: Memory at 20004000 (32-bit, non-prefetchable) [disabled] [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D3 PME-Enable- DSel=0 DScale=0 PME-

0000:02:08.0 Ethernet controller: Intel Corporation 82801BA/BAM/CA/CAM Ethernet
Controller (rev 03)
	Subsystem: Toshiba America Info Systems PRO/100 VE Network Connection
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at fceff000 (32-bit, non-prefetchable)
	Region 1: I/O ports at df40 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

0000:02:0b.0 CardBus bridge: Toshiba America Info Systems ToPIC100 PCI to
Cardbus Bridge with ZV Support (rev 32)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 255
	Region 0: Memory at 20001000 (32-bit, non-prefetchable) [disabled]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=0
	Memory window 0: 00000000-00000000 [disabled]
	Memory window 1: 00000000-00000000 [disabled]
	I/O window 0: 00000000-00000003 [disabled]
	I/O window 1: 00000000-00000003 [disabled]
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite-
	16-bit legacy interface ports at 0001

0000:02:0b.1 CardBus bridge: Toshiba America Info Systems ToPIC100 PCI to
Cardbus Bridge with ZV Support (rev 32)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 255
	Region 0: Memory at 20002000 (32-bit, non-prefetchable) [disabled]
	Bus: primary=02, secondary=07, subordinate=0a, sec-latency=0
	Memory window 0: 00000000-00000000 [disabled]
	Memory window 1: 00000000-00000000 [disabled]
	I/O window 0: 00000000-00000003 [disabled]
	I/O window 1: 00000000-00000003 [disabled]
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite-
	16-bit legacy interface ports at 0001

0000:02:0c.0 System peripheral: Toshiba America Info Systems TC6371AF SmartMedia
Controller (rev 03)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 255
	Region 0: Memory at 20000800 (32-bit, non-prefetchable) [disabled]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D3 PME-Enable- DSel=0 DScale=0 PME-

0000:02:0d.0 System peripheral: Toshiba America Info Systems SD TypA Controller
(rev 03)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 255
	Region 0: Memory at 20000a00 (32-bit, non-prefetchable) [disabled]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D3 PME-Enable- DSel=0 DScale=0 PME-

/proc/cpuinfo

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 10
cpu MHz		: 1096.759
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx
fxsr sse
bogomips	: 2170.88

/proc/ioports

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vesafb
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-101f : 0000:00:1f.4
  1000-101f : uhci_hcd
1040-107f : 0000:00:1f.5
  1040-107f : Intel 82801BA-ICH2
1080-10ff : 0000:00:1f.6
1400-14ff : 0000:00:1f.5
  1400-14ff : Intel 82801BA-ICH2
1800-18ff : 0000:00:1f.6
cf80-cf9f : 0000:00:1f.2
  cf80-cf9f : uhci_hcd
cff0-cfff : 0000:00:1f.1
  cff0-cff7 : ide0
  cff8-cfff : ide1
df40-df7f : 0000:02:08.0
  df40-df7f : eepro100
e000-e07f : motherboard
e080-e0ff : motherboard
e400-e47f : motherboard
e480-e4ff : motherboard
e800-e87f : motherboard
e880-e8ff : motherboard
ec00-ec7f : motherboard
ec80-ecff : motherboard
ee00-ee7f : 0000:00:1f.0
  ee00-ee7f : motherboard
    ee00-ee03 : PM1a_EVT_BLK
    ee04-ee05 : PM1a_CNT_BLK
    ee08-ee0b : PM_TMR
    ee10-ee15 : ACPI CPU throttle
    ee20-ee20 : PM2_CNT_BLK
    ee28-ee2b : GPE0_BLK
ee80-ee8f : motherboard
ee90-ee9f : motherboard
eeac-eeac : motherboard
eec0-eeff : 0000:00:1f.0
  eec0-eeff : motherboard

/proc/iomem

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cffff : Video ROM
000e0000-000eedff : reserved
000eee00-000eefff : ACPI Non-volatile Storage
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-0033ac75 : Kernel code
  0033ac76-00411d5f : Kernel data
1fff0000-1fffffff : ACPI Tables
20000000-200007ff : 0000:02:07.0
20000800-2000081f : 0000:02:0c.0
20000a00-20000bff : 0000:02:0d.0
20001000-20001fff : 0000:02:0b.0
20002000-20002fff : 0000:02:0b.1
20004000-20007fff : 0000:02:07.0
eff00000-f7ffffff : PCI Bus #01
  eff80000-efffffff : 0000:01:00.0
  f0000000-f7ffffff : 0000:01:00.0
    f0000000-f1ffffff : vesafb
f8000000-fbffffff : 0000:00:00.0
fceff000-fcefffff : 0000:02:08.0
  fceff000-fcefffff : eepro100
fd000000-fdffffff : PCI Bus #01
  fd000000-fdffffff : 0000:01:00.0
feea0000-feebffff : reserved
ffb80000-ffbfffff : reserved
fff80000-ffffffff : reserved

no modules, and no scsi

Software Environment:

note: I am using UNPATCHED kernel sources directly from kernel.org, not patched
sources from gentoo's portage tree. 

gcc version 3.3.5 (Gentoo Linux 3.3.5-r1, ssp-3.3.2-3, pie-8.7.7.1)

Problem Description:

Previous to my 2.6.11.6 upgrade I was running 2.6.9. With all unpatched 2.6
kernel versions up to and including 2.6.9, I could turn the lcd backlight off by
running "echo lcd_out:0 > /proc/acpi/toshiba/video" as root. I upgraded directly
from 2.6.9 to 2.6.11.6. With the upgrade I am no longer able to turn the lcd
backlight off. There is no effect after running "echo lcd_out:0 >
/proc/acpi/toshiba/video" and the /proc/acpi/toshiba/video lcd_out option
remains unchanged as 1. I recompiled the 2.6.11.6 kernel with the new option
CONFIG_BACKLIGHT_LCD_SUPPORT=y. Enabling this option did not allow the command
(echo lcd_out:0 > /proc/acpi/toshiba/video) to turn the lcd backlight off, or
change the lcd_out option to 0. However, I do get the following entry in my
kernel logs after running the command while running 2.6.11.6, "[kernel] video
bus notify". Previous to the upgrade, there was no entry in my kernel logs after
running the command. 

Steps to reproduce:

build 2.6.11.6 with

CONFIG_TOSHIBA=y

CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
# CONFIG_ACPI_SLEEP is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
CONFIG_ACPI_TOSHIBA=y
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_X86_PM_TIMER is not set
# CONFIG_ACPI_CONTAINER is not set

note: enabling the CONFIG_BACKLIGHT_LCD_SUPPORT option does not change anything.

and run, echo lcd_out:0 > /proc/acpi/toshiba/video

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
