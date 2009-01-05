From: Karim 'Kasi Mir' Senoucci <lists@tvetc.de>
Subject: Re: Problems with SiS Mirage 1,
	sisfb and DirectFB
Date: Mon, 5 Jan 2009 17:08:14 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0901051336250.24260@jericho.melzone.de>
References: <Pine.LNX.4.61.0812151051090.31840@jericho.melzone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <lists@tvetc.de>) id 1LJs4I-0005JX-Nv
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 Jan 2009 16:12:42 +0000
Received: from mx1.melzone.de ([81.169.156.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LJs4F-0003aN-0m
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 Jan 2009 16:12:41 +0000
Received: from uucp by mx1.melzone.de with local-rmail (Exim 4.69)
	(envelope-from <lists@tvetc.de>) id 1LJs4A-0005rD-HK
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 Jan 2009 17:12:34 +0100
Received: by jericho.melzone.de with esmtp (Exim 4.62 #1) id 1LJrzy-0004Ag-9h 
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 Jan 2009 17:08:14 +0100
In-Reply-To: <Pine.LNX.4.61.0812151051090.31840@jericho.melzone.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

Hello again,
it seems no one has got any experiences with the SIS Mirage 1 chipset. 
:-( Is there anything I can do to find out if that board is _supposed_ 
to work with sisfb at all, or any fb driver apart from vesafb for that 
matter? 

Happy new year
Kasi Mir


On Mon, 15 Dec 2008, Karim 'Kasi Mir' Senoucci wrote:

> Hello all,
> has anyone gotten the SiS Mirage 1 chipset (SiS662/SiS964) that on the 
> Intel D201GLY2 mini-itx board to work with sisfb (and DirectFB)? 
> 
> I'm asking because while I can get perfectly fine 1280x1024x32bit output 
> using the vesafb driver (which, alas, is much too slow to be usable in 
> my DirectFB kiosk application which runs fine on via boards), the sisfb
> driver (while fast enough) produces interferences. Every 50 pixels or so 
> there is a vertical line running from top to bottom of the screen 
> (26 of the im total) which looks like its showing the content of another 
> pixel column. 
> 
> Similary, when running the framebuffer console, the display irregularly 
> repeats parts of the screen so that you see some kind of ghostly echo 
> flickering in the background. So the problem isn't with DirectFB in 
> particular, the sisfb doesn't seem to work correctly here. 
> 
> I've tried toying around with the parameters, but the only thing that 
> works so far is setting the framebuffer console to 8 bit depth which
> gives a clear picture (haven't tested with DirectFB as the apllication 
> I'm using needs true-color graphics). 
> 
> Can this work as all? Or is there no support for the on-board graphics 
> on this Intel board? The chip I'm using is listed via lspci as:
> 
> |01:00.0 VGA compatible controller [0300]: Silicon Integrated Systems 
> |[SiS] 661/741/760 PCI/AGP or 662/761Gx PCIE VGA Display Adapter 
> |[1039:6330] (rev 04) (prog-if 00 [VGA controller])
> |        Subsystem: Intel Corporation Unknown device [8086:d61f]
> |        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> |        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> |        Interrupt: pin A routed to IRQ 10
> |        BIST result: 00
> |        Region 0: Memory at 40000000 (32-bit, prefetchable) [size=128M]
> |        Region 1: Memory at 4a000000 (32-bit, non-prefetchable) [size=128K]
> |        Region 2: I/O ports at 1000 [size=128]
> |        Capabilities: [40] Power Management version 2
> |                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> |                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> |        Capabilities: [50] AGP version 3.0
> |               Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3+ Rate=x4,x8
> |               Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
> |        Kernel driver in use: sisfb
> 
> 
> I'm running Gentoo Linux, but currently with a self-compiled stock 
> kernel 2.6.27.7, I've tried with the Gentoo stock 2.6.26 as well without 
> any difference. I'm running DirectFB 1.2.0 which detects the chipset as:
> 
> | [2008-12-16 10:21:02] (*) DirectFB/Graphics: SiS 315 0.1 (Andreas Oberritter <obi@saftware.de>)
> 
> fbset -i shows:
> 
> | mode "1280x1024-60"
> |     # D: 107.991 MHz, H: 63.976 kHz, V: 60.015 Hz
> |     geometry 1280 1024 1280 2048 32
> |     timings 9260 248 48 38 1 112 3
> |     hsync high
> |     vsync high
> |     rgba 8/16,8/8,8/0,0/0
> | endmode
> | 
> | Frame buffer device information:
> |     Name        : SiS 660
> |     Address     : 0x40000000
> |     Size        : 66486272
> |     Type        : PACKED PIXELS
> |     Visual      : TRUECOLOR
> |     XPanStep    : 1
> |     YPanStep    : 1
> |     YWrapStep   : 0
> |     LineLength  : 5120
> |     MMIO Address: 0x4a000000
> |     MMIO Size   : 131072
> |     Accelerator : Unknown (40)
> 
> The kernel log notes upon boot:
> 
> | pci 0000:01:00.0: Boot video device
> | sisfb: Video ROM found
> | sisfb: Video RAM at 0x40000000, mapped to 0xf8c80000, size 65536k
> | sisfb: MMIO at 0x4a000000, mapped to 0xf8c40000, size 128k
> | sisfb: Memory heap starting at 64928K, size 32K
> | sisfb: CRT1 DDC supported
> | sisfb: CRT1 DDC level: 2
> | sisfb: Monitor range H 31-82KHz, V 56-75Hz, Max. dotclock 140MHz
> | sisfb: Default mode is 1280x1024x32 (60Hz)
> | sisfb: Initial vbflags 0x0
> | Console: switching to colour frame buffer device 160x64
> | sisfb: 2D acceleration is enabled, y-panning enabled (auto-max)
> | fb0: SiS 660 frame buffer device version 1.8.9
> | sisfb: Copyright (C) 2001-2005 Thomas Winischhofer
> 
> after beeing started with the append line:
> 
> | video=sisfb:mode:1280x1024x24,rate:60,mem:16384
> 
> Any help is appreciated. 
> 
> Thanks in advance
> Kasi Mir


------------------------------------------------------------------------------
