From: Miernik <miernik@ctnet.pl>
Subject: vesafb on Savage4
Date: Tue, 3 Aug 2004 10:43:36 +0000 (UTC)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <cenq8o$lkv$1@sea.gmane.org>
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Brwlj-0008QC-MU
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 03 Aug 2004 03:43:43 -0700
Received: from main.gmane.org ([80.91.224.249])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Brwlj-0007Ll-1M
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 03 Aug 2004 03:43:43 -0700
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1Brwlf-0006dw-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 03 Aug 2004 12:43:39 +0200
Received: from citynet-gw.man.poznan.pl ([212.126.28.121])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 03 Aug 2004 12:43:39 +0200
Received: from miernik by citynet-gw.man.poznan.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 03 Aug 2004 12:43:39 +0200
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


I have got a video card which identifies itself (before BIOS boots) as
S3 86C395/396/397. 

My lspci -vv output is:

0000:01:00.0 VGA compatible controller: S3 Inc. Savage 4 (rev 02) (prog-if 00 [VGA])
        Subsystem: S3 Inc. 86C394-397 Savage4
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1000ns min, 63750ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d9000000 (32-bit, non-prefetchable) [size=512K]
        Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [80] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

The kernel is installed from a binary:
http://ftp.pl.debian.org/debian/pool/main/k/kernel-image-2.6.7-i386/kernel-image-2.6.7-1-k7_2.6.7-2_i386.deb

When the system is booted, in /var/log/kern.log there is:

Aug  3 13:52:19 localhost kernel: vesafb: probe of vesafb0 failed with error -6

przehyba:~# modprobe vesafb
przehyba:~# lsmod | grep vesafb
vesafb                  6688  0
cfbcopyarea             3776  1 vesafb
cfbimgblt               3072  1 vesafb
cfbfillrect             3712  1 vesafb
przehyba:~# cat /proc/fb
przehyba:~# fbset
open /dev/fb0: No such device
przehyba:~# ls -l /dev/fb0
crw-rw----  1 root video 29, 0 Aug  2 23:45 /dev/fb0
przehyba:~#

From these posts I can see that vesafb does work on Savage cards:

http://www.directfb.org/mailinglists/directfb-dev/2003/06-2003/msg00007.html
http://www.ussg.iu.edu/hypermail/linux/kernel/0011.0/0263.html

If I try savagefb, I get the same error that is decribed here:

http://www.directfb.org/mailinglists/directfb-dev/2003/09-2003/msg00044.html

How can I get any framebuffer working on this card?

-- 
    Miernik         ________________________   xmpp:miernik@amessage.info
___________________/__ tel: +48888299997 __/      mailto:miernik@ctnet.pl
http://www.miernik.ctnet.pl/                               GPG:0xABC292D1



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
