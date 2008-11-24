From: Karim 'Kasi Mir' Senoucci <lists@tvetc.de>
Subject: Radeon framebuffer not working on MSI K9A2VM-FD
Date: Mon, 24 Nov 2008 09:59:33 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0811240942470.21079@jericho.melzone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <lists@tvetc.de>) id 1L4Xkl-0006OR-6n
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Nov 2008 09:29:11 +0000
Received: from mx1.melzone.de ([81.169.156.183])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1L4Xkg-0000NX-IG
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Nov 2008 09:29:11 +0000
Received: from uucp by mx1.melzone.de with local-rmail (Exim 4.69)
	(envelope-from <lists@tvetc.de>) id 1L4XIo-00004x-IP
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Nov 2008 10:00:18 +0100
Received: by jericho.melzone.de with esmtp (Exim 4.62 #1) id 1L4XI5-0006Y7-OQ 
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Nov 2008 09:59:33 +0100
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev <linux-fbdev-devel@lists.sourceforge.net>

Hello all, 
I cannot get the Radeon kernel framebuffer to work with the above MSI 
mainboard which uses a AMD780V chipset featuring what the call Radeon 
HD 3100 on-board graphics. 

I'm running a Ubuntu server 8.04.1 on the machine and have tried the 
kernel image supplied with the distibution, a self-compiled kernel based
on the Ubuntu sources (both 2.6.24) and a current kernel.org version 
(2.6.27.7). I tried to compile the Radeon framebuffer into the kernel as 
well as compiling it as a module. I can use the vesafb frame buffer 
(which is slow as hell) but the radeon framebuffer driver does not work 
in any of the settings. I don't get any output whatsoever when I load 
the module, not a single line in syslog or via dmesg. I fact, I only
know the module is loaded becaus it is listed with lsmod. 

Below is my lspci output of the grapichs device, if you need anything 
else, feel free to ask:

01:05.0 VGA compatible controller [0300]: ATI Technologies Inc Radeon 3100 Graphics [1002:9611] (prog-if 00 [VGA controller])
        Subsystem: Micro-Star International Co., Ltd. Unknown device [1462:7501]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR+ <PERR-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 7
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=256M]
        Region 1: I/O ports at b000 [size=256]
        Region 2: Memory at fe8f0000 (32-bit, non-prefetchable) [size=64K]
        Region 5: Memory at fe700000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [a0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000


I'm thankful for any help on the matter, as I myself have run out of 
ideas. 

Greetings
Kasi Mir


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
