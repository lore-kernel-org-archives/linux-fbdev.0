From: Miles Lane <miles@megapathdsl.net>
Subject: rivafb problems with 2.5.24 + latest fbdev.diff patch
Date: Fri, 21 Jun 2002 00:53:11 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3D12DB67.4010007@megapathdsl.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from front2.mail.megapathdsl.net ([66.80.60.30])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17LJHv-0006bz-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 21 Jun 2002 00:56:59 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: James Simmons <jsimmons@transvirtual.com>, Fbdev <linux-fbdev-devel@lists.sourceforge.net>

Problems:

1)  When I boot, when the rivafb is activated, I don't see Tux.  
Instead, where Tux should be, there are about four or five text 
rows that are completely white.  The scrolling boot information
does appear below the white rectangle.

2)  After booting, running the command "fbset -a 1600x1200-76"
causes the machine to lock up.  This same command worked fine
with 2.5.22.

3)  After starting up XFree86, when I switch to one of the 
VTs, all characters are reversed!  The lines are not reversed,
but each character is displayed flipped on its vertical axis.

4)  Lastly, I have not yet figured out how to get rivafb
in the 2.5 series to boot directly into 1600x1200x16 @ 76Hz.
Thus far, running "fbset -a 1600x1200-76" has worked.
I tried  using video=riva:1600x1200-76 and that partly worked.
It got me the resolution I wanted, but the colors were wrong
and the frequency was off:

mode "1600x1200-60"
    # D: 162.022 MHz, H: 75.010 kHz, V: 60.008 Hz
    geometry 1600 1200 1600 1200 16
    timings 6172 304 64 46 1 192 3
    hsync high
    vsync high
    accel true
    rgba 5/11,6/5,5/0,0/0
endmode

Running "fbset -a 1600x1200-76" has been giving me:

mode "1600x1200-76"
    # D: 197.981 MHz, H: 95.183 kHz, V: 76.146 Hz
    geometry 1600 1200 1600 1200 8
    timings 5051 304 40 42 3 136 5
    accel true
    rgba 8/0,8/0,8/0,0/0
endmode

I was then informed that I should use "video=riva:1600x1200@75-16",
since there is no 76Hz entry in linux/drivers/video/modedb.c.

Here's the modedb.c entry I am trying to use:
	/* 1600x1200 @ 75 Hz, 93.75 kHz hsync */
	NULL, 75, 1600, 1200, 4938, 304, 64, 46, 1, 192, 3,
	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED

Boot command:
kernel /vmlinuz ro root=/dev/hda6 hdd=ide-scsi console=ttyS0,38400 console=tty0 pci=noacpi video=riva:1600x1200@75-16

Kernel log section showing console setup:
Jun 21 00:03:48 turbulence kernel: rivafb: RIVA MTRR set to ON
Jun 21 00:03:48 turbulence kernel: Console: switching to colour frame buffer device 80x25
Jun 21 00:03:48 turbulence kernel: rivafb: PCI nVidia NV10 framebuffer ver 0.9.3 (nVidiaGeForce-DD, 32MB @ 0xE8000000)

Portions of lspci output that may pertain:

01:05.0 VGA compatible controller: nVidia Corporation GeForce 256 DDR (rev 10) (prog-if 00 [VGA])
	Subsystem: VISIONTEK: Unknown device 000b
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at feaf0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] System Controller (rev 25)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at fc9ff000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at ffe4 [disabled] [size=4]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] AGP Bridge (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fca00000-feafffff
	Prefetchable memory behind bridge: e4800000-f48fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ACPI (rev 03)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

.config info:

CONFIG_MK7=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_RIVA=y
CONFIG_FBCON_ACCEL=y





-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
