From: Miernik <miernik@ctnet.pl>
Subject: long time of switch console->X (fast opposite way)
Date: Thu, 15 Jul 2004 17:10:19 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040715151019.5049.18.NOFFLE%miernik@ctnet.pl.local>
Reply-To: Miernik <miernik@ctnet.pl>
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bl83g-0004e5-0B
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 15 Jul 2004 08:22:04 -0700
Received: from main.gmane.org ([80.91.224.249])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bl83f-0006BK-8t
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 15 Jul 2004 08:22:03 -0700
Received: from root by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1Bl82L-0000cI-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 15 Jul 2004 17:22:01 +0200
Received: from 82.160.30.99 ([82.160.30.99])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 15 Jul 2004 17:20:41 +0200
Received: from miernik by 82.160.30.99 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 15 Jul 2004 17:20:41 +0200
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

I posted this on fbdev.user here:
http://article.gmane.org/gmane.linux.fbdev.user/215
but got no reply, so I'll try here. 

I use the framebuffer with this line in my /boot/grub/menu.lst :
kernel /boot/vmlinuz-2.4.24-1-386 root=/dev/hda1 ro video=sisfb:mode:1152x864x16,rate:70

My video card is (output of lspci -vv):

0000:01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 630/730 PCI/AGP VGA Display Adapter (rev 31) (prog-if 00 [VGA])
        Subsystem: Silicon Integrated Systems [SiS] 630/730 PCI/AGP VGA Display Adapter
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        BIST result: 00
        Region 0: Memory at c0000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at cfee0000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at bc00 [size=128]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] AGP version 2.0
                Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

It's a video card build in a PCChips M810L REV7.0 motherboard.
The CPU is AMD Duron 600 MHz.
Of course I use the fbdev X driver.

The problem I have it takes 6.7 seconds to switch from console to X
with <Alt><F7>. The 6.7 s time is very consistent, every time I
measure it. It's very long and annoying.

The other direction (X->console with <Alt><F1>) its about immediate.

During that 6.7 seconds the a rough outline of what is supposed to be
on the screen is displayed. For example if the Galeon web browser is
on the screen, then it displays the area where Galeon menus and other
controls are in a block of grey, the area of the webpage in a block of
black, and the URL box as a block of white.

What might be the reason, and is there anything to be done about this?

In kern.log doring boot I get:

May 28 18:25:49 jaworz kernel: sisfb: Video ROM found and mapped to c00c0000
May 28 18:25:49 jaworz kernel: sisfb: Framebuffer at 0xc0000000, mapped to 0xe00ab000, size 8192k
May 28 18:25:49 jaworz kernel: sisfb: MMIO at 0xcfee0000, mapped to 0xe08ac000, size 128k
May 28 18:25:49 jaworz kernel: sisfb: Memory heap starting at 4096K
May 28 18:25:49 jaworz kernel: sisfb: CRT1 DDC supported
May 28 18:25:49 jaworz kernel: sisfb: CRT1 DDC level: 2
May 28 18:25:49 jaworz kernel: sisfb: Monitor range H 31-61KHz, V 60-75Hz, Max. dotclock 78MHz
May 28 18:25:49 jaworz kernel: sisfb: WARNING: Refresh rate exceeds monitor specs!
May 28 18:25:49 jaworz kernel: sisfb: Mode is 1152x864x16 (60Hz)
May 28 18:25:49 jaworz kernel: sisfb: Initial vbflags 0x0
May 28 18:25:49 jaworz kernel: Console: switching to colour frame buffer device 144x54
May 28 18:25:49 jaworz kernel: sisfb: Installed SISFB_GET_INFO ioctl (80046ef8)
May 28 18:25:49 jaworz kernel: sisfb: Installed SISFB_GET_VBRSTATUS ioctl (80046ef9)
May 28 18:25:49 jaworz kernel: sisfb: 2D acceleration is enabled, scrolling mode ypan
May 28 18:25:49 jaworz kernel: fb0: SIS 730 frame buffer device, Version 1.6.16
May 28 18:25:49 jaworz kernel: sisfb: (C) 2001-2003 Thomas Winischhofer. All rights reserved.

And then a line like that appears every several minutes all the time
the computer is on:

May 28 18:26:04 jaworz kernel: sisfb: Unsupported rate 60 for 1152x864
May 28 18:26:04 jaworz kernel: sisfb: WARNING: Refresh rate exceeds monitor specs!
May 28 18:26:07 jaworz kernel: sisfb: Unsupported rate 60 for 1152x864
May 28 18:26:07 jaworz kernel: sisfb: WARNING: Refresh rate exceeds monitor specs!
May 28 18:26:27 jaworz kernel: sisfb: Unsupported rate 60 for 1152x864
May 28 18:26:27 jaworz kernel: sisfb: WARNING: Refresh rate exceeds monitor specs!

-- 
    Miernik         _________________________  xmpp:miernik@amessage.info
___________________/__ tel: +48888299997 __/      mailto:miernik@ctnet.pl
http://www.miernik.ctnet.pl/



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
