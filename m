From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 4323] New: no cursor in console with intelfb
Date: Thu, 10 Mar 2005 12:26:57 -0800
Message-ID: <20050310122657.5d28ea7b.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9UFk-0002bW-RO
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 10 Mar 2005 12:27:28 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D9UFi-0005rA-QL
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 10 Mar 2005 12:27:28 -0800
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
Cc: phil@systemausfall.org



Begin forwarded message:

Date: Thu, 10 Mar 2005 10:15:05 -0800
From: bugme-daemon@osdl.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 4323] New: no cursor in console with intelfb


http://bugme.osdl.org/show_bug.cgi?id=4323

           Summary: no cursor in console with intelfb
    Kernel Version: 2.6.11
            Status: NEW
          Severity: normal
             Owner: jsimmons@infradead.org
         Submitter: phil@systemausfall.org


Distribution: Debian 3.0 testing
Hardware Environment: Asus S5200N, Intel 855GME and ICH4-M Chipset
Software Environment:
Problem Description:

When using the intelfb there's no cursor displayed in console.

I added the kernel parameter: video=intelfb:1024x768-16@60 vga=791
vga=791 because the first parameter (1024x768...) didn't change the video mode.


The output from syslog:

intelfb: Framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G chipsets
intelfb: Version 0.9.2
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 169
intelfb: 00:02.0: Intel(R) 855GME, aperture size 128MB, stolen memory 8060kB
intelfb: Non-CRT device is enabled ( LVDS port ).  Disabling mode switching.
intelfb: Initial video mode is 1024x768-16@60.
intelfb: Changing the video mode is not supported.


From my kernel configuration:

Device Drivers --> Graphics Support
  [*] Support for frame buffer devices
  <*> Intel 830M/845G/852GM/855GM/865G support

Device Drivers --> Graphics Support --> Console display driver support
  <M> Framebuffer Console support

I didn't enable standard vesafb.


lsmod

Module                  Size  Used by
i830                   28928  1 
drm                    68116  2 i830
ipv6                  270848  10 
pcmcia                 25992  4 
dm_mod                 61180  0 
sd_mod                 17936  0 
sg                     40352  0 
sr_mod                 18084  0 
scsi_mod              139336  3 sd_mod,sg,sr_mod
cdrom                  41888  1 sr_mod
thermal                13576  0 
fan                     4612  0 
button                  6800  0 
ac                      4996  0 
battery                10244  0 
pcspkr                  3940  0 
ipw2100               152772  0 
firmware_class         10752  1 ipw2100
ieee80211              41380  1 ipw2100
ieee80211_crypt         6472  2 ipw2100,ieee80211
8139too                25984  0 
mii                     5248  1 8139too
ohci1394               35972  0 
ieee1394              321716  1 ohci1394
yenta_socket           23432  2 
rsrc_nonstatic          9472  1 yenta_socket
pcmcia_core            50596  3 pcmcia,yenta_socket,rsrc_nonstatic
8250_pci               18688  0 
8250                   25192  1 8250_pci
serial_core            23808  1 8250
usbhid                 35008  0 
snd_intel8x0           34112  1 
snd_ac97_codec         78968  1 snd_intel8x0
snd_pcm_oss            54560  0 
snd_mixer_oss          20736  1 snd_pcm_oss
snd_pcm                97160  3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd_timer              26756  1 snd_pcm
snd                    55780  8
snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore              10464  1 snd
snd_page_alloc         10244  2 snd_intel8x0,snd_pcm
ehci_hcd               35848  0 
uhci_hcd               33552  0 
usbcore               126072  4 usbhid,ehci_hcd,uhci_hcd
nls_cp437               5888  1 
vfat                   14464  1 
fat                    41884  1 vfat
nls_cp850               4992  0 
nls_utf8                2176  0 
evdev                   9600  1 
nls_iso8859_1           4224  1 
nls_iso8859_15          4736  0 
nls_base                7936  7
nls_cp437,vfat,fat,nls_cp850,nls_utf8,nls_iso8859_1,nls_iso8859_15
psmouse                29960  0 
cpufreq_userspace       4572  0 
cpufreq_powersave       1920  1 
speedstep_centrino      8020  1 
processor              23220  2 thermal,speedstep_centrino
freq_table              4612  1 speedstep_centrino
asus_acpi              11924  0 
cpuid                   3460  0 
genrtc                 10248  0 
unix                   30132  297


lspci -vvv

0000:00:00.0 Host bridge: Intel Corp. 82852/855GM Host Bridge (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 1821
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at <unassigned> (32-bit, prefetchable)
	Capabilities: [40] #09 [8105]

0000:00:00.1 System peripheral: Intel Corp. 855GM/GME GMCH Memory I/O Control
Registers (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 182a
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0

0000:00:00.3 System peripheral: Intel Corp. 855GM/GME GMCH Configuration Process
Registers (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 182b
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0

0000:00:02.0 VGA compatible controller: Intel Corp. 82852/855GM Integrated
Graphics Device (rev 02) (prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc.: Unknown device 1712
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 169
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at feb00000 (32-bit, non-prefetchable) [size=512K]
	Region 2: I/O ports at dc00 [size=8]
	Capabilities: [d0] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.1 Display controller: Intel Corp. 82852/855GM Integrated Graphics
Device (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 1712
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at fea80000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [d0] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
USB UHCI Controller #1 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 1828
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 169
	Region 4: I/O ports at d480 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
USB UHCI Controller #2 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 1828
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 185
	Region 4: I/O ports at d800 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
USB UHCI Controller #3 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 1828
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 177
	Region 4: I/O ports at d880 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI
Controller (rev 03) (prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 1829
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 193
	Region 0: Memory at febff800 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [2080]

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 83) (prog-if 00
[Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fe700000-fe8fffff
	Prefetchable memory behind bridge: de500000-de6fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 03)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage
Controller (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 1828
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 177
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at ffa0 [size=16]
	Region 5: Memory at 1f800000 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
	Subsystem: Asustek Computer, Inc.: Unknown device 1803
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 201
	Region 0: I/O ports at e000 [size=256]
	Region 1: I/O ports at e100 [size=64]
	Region 2: Memory at 1f800400 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at 1f800600 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Modem
Controller (rev 03) (prog-if 00 [Generic])
	Subsystem: Asustek Computer, Inc.: Unknown device 1826
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 201
	Region 0: I/O ports at e200 [size=256]
	Region 1: I/O ports at e300 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:03.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ac)
	Subsystem: Asustek Computer, Inc.: Unknown device 1824
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 201
	Region 0: Memory at 1f801000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=01, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 1fc00000-1ffff000 (prefetchable)
	Memory window 1: 20000000-203ff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

0000:01:03.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ac)
	Subsystem: Asustek Computer, Inc.: Unknown device 1824
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin B routed to IRQ 177
	Region 0: Memory at 1f802000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=01, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 20400000-207ff000 (prefetchable)
	Memory window 1: 20800000-20bff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

0000:01:03.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev
04) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 1827
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin C routed to IRQ 169
	Region 0: Memory at fe8ff000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME+

0000:01:04.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Asustek Computer, Inc.: Unknown device 1045
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 169
	Region 0: I/O ports at c800 [size=256]
	Region 1: Memory at fe8ff800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:05.0 Network controller: Intel Corp. PRO/Wireless LAN 2100 3B Mini PCI
Adapter (rev 04)
	Subsystem: Intel Corp. MIM2000/Centrino
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 8500ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 177
	Region 0: Memory at fe8fe000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-




Steps to reproduce:

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
