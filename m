From: Ploum Ploum <ploum@mitose.net>
Subject: GeForce 4 MX have no working frame buffer at all..
Date: Sat, 21 Aug 2004 12:53:48 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <412729BC.5000102@mitose.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ByTSu-00044d-6a
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 21 Aug 2004 03:51:16 -0700
Received: from outmx004.isp.belgacom.be ([195.238.2.101])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34)
	id 1ByTSt-0001D7-95
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 21 Aug 2004 03:51:16 -0700
Received: from outmx004.isp.belgacom.be (localhost [127.0.0.1])
        by outmx004.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with ESMTP id i7LApAe9009877
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 21 Aug 2004 12:51:10 +0200
        (envelope-from <ploum@mitose.net>)
Received: from mars (43-254.242.81.adsl.skynet.be [81.242.254.43])
        by outmx004.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with ESMTP id i7LAp3qu009830
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 21 Aug 2004 12:51:03 +0200
        (envelope-from <ploum@mitose.net>)
Received: from [127.0.0.1] (mars [127.0.0.1])
	by mars (Postfix) with ESMTP id AACA41ED6A
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 21 Aug 2004 12:53:48 +0200 (CEST)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Hi,

I have a GeForce 4 MX nvidia card and the framebuffer have never worked 
with no kernel  and no distributions.

Since I'm not completely newbie for compiling and configuring the the 
kernel and that even LiveCD have never a framebuffer and that, if I 
change my GeForce 4MX 440 card with a GeForce 4MX 460, the framebuffer 
works, I highly suspect a bug. (Like a serial number not present because 
this card is not so popular or this sort of thing)

Here's the lspci -vvvv output for the card :

0000:02:00.0 VGA compatible controller: nVidia Corporation NV18 
[GeForce4 MX 440 AGP 8x] (rev a2) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-        Status: Cap+ 66MHz+ UDF- 
FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at e4000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=32 ArqSz=2 Cal=0 SBA+ AGP+ GART64- 64bit- 
FW- Rate=x8


Well, I hope that this will help you. Please tell me if you need mor 
informations or testing ( I can surely patch and recompile a kernel ).  
If this mail is not sent to the correct mailing-list, I apologize for 
the disturbing, but.. can you help me to sent it to the correct ML ?

Thank you a lot

Ploum


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
