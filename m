From: jurriaan <thunder7@xs4all.nl>
Subject: framebuffer with nvidia 7600GS shows corrupt
	screen
Date: Wed, 23 May 2007 20:18:26 +0200
Message-ID: <20070523181826.GA4331@amd64.of.nowhere>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HqvQC-0005da-Jt for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 23 May 2007 11:18:52 -0700
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HqvQA-0003Jj-SY
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 23 May 2007 11:18:52 -0700
Received: from rivierenland.xs4all.nl (zeeotter.xs4all.nl [80.126.31.149])
	by smtp-vbr6.xs4all.nl (8.13.8/8.13.8) with ESMTP id l4NIIkZK084731
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 23 May 2007 20:18:46 +0200 (CEST)
	(envelope-from jurriaan@rivierenland.xs4all.nl)
Content-Disposition: inline
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
Cc: adaplas@pol.net

I've swapped my nvidia 6600 for a 7600GS, because it has dual-link DVI
output. That broke my framebuffer!

If I boot like this:

Command line: root=/dev/md2 video=nvidiafb:640x480-32@60 atkbd.softrepeat=1

I see this:

nvidiafb: Device ID: 10de0392 
nvidiafb: CRTC0 analog found
nvidiafb: CRTC1 analog not found
nvidiafb: EDID found from BUS1
i2c-adapter i2c-1: unable to read EDID block.
i2c-adapter i2c-1: unable to read EDID block.
i2c-adapter i2c-1: unable to read EDID block.
nvidiafb: CRTC 0 appears to have a CRT attached
nvidiafb: Using CRT on CRTC 0
nvidiafb: MTRR set to ON
Console: switching to colour frame buffer device 64x26
nvidiafb: PCI nVidia NV39 framebuffer (64MB @ 0xC0000000)

But the screen is unreably corrupted. I can describe the corruption as
follows:

The two penguins I normally see are about the correct size, but shown in
dark grey lines on a black background. All characters are also composed
of these dark grey lines - with black lines inbetween. The entire screen
is very faintly visible, all is dark grey on black.

The monitor does receive the correct signal (my Eizo's on-screen menu
shows a 60 Hz signal coming in).

In case anybody is wondering about the resolution - normally I boot
1600x1200, but that also doesn't work. Xorg works fine, so it must be
something in the framebuffer, right?

xorg's version:
ii  xserver-xorg-video-nv 1:2.0.2-1 X.Org X server -- NV display driver

output of lspci:

01:00.0 VGA compatible controller: nVidia Corporation G70 [GeForce 7600 GS] (rev a1) (prog-if 00 [VGA])
	Subsystem: Micro-Star International Co., Ltd. Unknown device 0413
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at c0000000 (64-bit, prefetchable) [size=256M]
	Region 3: Memory at d1000000 (64-bit, non-prefetchable) [size=16M]
	Region 5: I/O ports at a000 [size=128]
	[virtual] Expansion ROM at d2000000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Express Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <1us, L1 <4us
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
		Link: Latency L0s <1us, L1 <4us
		Link: ASPM Disabled RCB 128 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x16
	Capabilities: [100] Virtual Channel
	Capabilities: [128] Power Budgeting

output of fbset:


(C) Copyright 1995-1999 by Geert Uytterhoeven

Opening frame buffer device `/dev/fb0'
Using current video mode from `/dev/fb0'

mode "640x480-60"
    # D: 25.200 MHz, H: 31.500 kHz, V: 60.001 Hz
    geometry 640 480 640 25990 32
    timings 39682 48 16 33 10 96 2
    accel true
    rgba 8/16,8/8,8/0,8/24
endmode

Any hints on what to do? The mainboard is an Asus A8N-SLI, with X2 4600
processor and 4 Gb ram - not too uncommon.

Kind regards,
Jurriaan
-- 
There are 3 kinds of people: those who can count & those who can't.
	Unknown source
Debian (Unstable) GNU/Linux 2.6.21-mm2 2x2010 bogomips load 0.40
the Jack Vance Integral Edition: http://www.integralarchive.org

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
