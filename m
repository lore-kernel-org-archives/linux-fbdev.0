From: Mirko Parthey <mirko.parthey@informatik.tu-chemnitz.de>
Subject: PROBLEM with i810fb: changing the resolution garbles the screen
Date: Thu, 31 Mar 2005 23:16:43 +0200
Message-ID: <20050331211642.GA4786@stilzchen.informatik.tu-chemnitz.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DH725-0008QV-9g
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 31 Mar 2005 13:16:53 -0800
Received: from lana.hrz.tu-chemnitz.de ([134.109.132.3])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DH71z-0003Sr-BW
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 31 Mar 2005 13:16:53 -0800
Received: from hedwig.hrz.tu-chemnitz.de ([134.109.132.173] helo=mailbox.hrz.tu-chemnitz.de)
	by lana.hrz.tu-chemnitz.de with esmtp (Exim 4.41)
	id 1DH71w-0003ZI-3F
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 31 Mar 2005 23:16:44 +0200
Received: from maximus.informatik.tu-chemnitz.de ([134.109.192.246] ident=mail)
	by mailbox.hrz.tu-chemnitz.de with esmtp (Exim 4.43)
	id 1DH71w-0001vc-1n
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 31 Mar 2005 23:16:44 +0200
Received: from stilzchen.informatik.tu-chemnitz.de ([134.109.192.209] ident=mail)
	by maximus.informatik.tu-chemnitz.de with esmtp (Exim 3.35 #1 (Debian))
	id 1DH71v-00082d-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 31 Mar 2005 23:16:43 +0200
Received: from mpa by stilzchen.informatik.tu-chemnitz.de with local (Exim 3.35 #1 (Debian))
	id 1DH71v-0001GP-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 31 Mar 2005 23:16:43 +0200
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

When loading the modules in the order shown below, the framebuffer console
initializes fine to the default mode allowing for 80x30 characters:
# modprobe agpgart
# modprobe intel-agp
# modprobe i810fb hsync1=30 hsync2=62 vsync1=50 vsync2=85
# modprobe fbcon

However, when using fbset to increase the resolution, only the video
timings get changed, but the kernel doesn't adapt the number of text
columns and lines accordingly:
# fbset 800x600-75
# resize
COLUMNS=80;
LINES=30;
[...]

The characters are printed clearly, but they appear in a rectangle
smaller than the screen.  This "window" is usually offset by 1/3 screen
size from the top, sometimes it even seems to be partially off-screen at
the bottom.
The rest of the screen contains meaningless pixel patterns.

The video timings on the first console were restored simply by switching
to another console and back (I had changed the resolution only on the
first console).  In my opinion, this should not happen either - the
first console should stay at its resolution even when switching between
consoles of different resolutions.

Kernel Versions tested:
2.6.11.6
2.6.12-rc1
using a configuration similar to Debian's 2.6.10 Kernel for 686 processors,
almost everything is built as a module.

CPU: Celeron (Mendocino), 468 MHz

Hardware information:
# lspci -vv
0000:00:00.0 Host bridge: Intel Corp. 82810 GMCH [Graphics Memory Controller Hub] (rev 03)
    Subsystem: Intel Corp. 82810 GMCH [Graphics Memory Controller Hub]
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
    Latency: 0

0000:00:01.0 VGA compatible controller: Intel Corp. 82810 CGC [Chipset Graphics Controller] (rev 03) (prog-if 00 [VGA])
    Subsystem: Micro-Star International Co., Ltd.: Unknown device 2001
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Interrupt: pin A routed to IRQ 12
    Region 0: Memory at d8000000 (32-bit, prefetchable) [size=64M]
    Region 1: Memory at dc100000 (32-bit, non-prefetchable) [size=512K]
    Capabilities: [dc] Power Management version 1
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
[...]

Previously, I was using Kernel 2.4.27 with the i810fb-lite patches,
which did not show the problem described above.

I hope you find my information helpful in fixing this.
I'll be happy to provide further details if necessary.
Should I have made a mistake in using the driver, please point it out to
me.

Thanks for your work,
Mirko


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/info/Sentarus/hamr30
