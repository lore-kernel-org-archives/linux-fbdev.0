From: Rui Santos <rsantos@grupopie.com>
Subject: Garbled data on radeon KMS
Date: Tue, 01 Sep 2009 16:52:14 +0100
Message-ID: <4A9D432E.3030901@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rsantos@grupopie.com>) id 1MiVfS-0000vE-J8
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 01 Sep 2009 15:53:10 +0000
Received: from bipbip.grupopie.com ([195.23.16.24])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MiVfO-0008Ur-5A for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 01 Sep 2009 15:53:10 +0000
Received: from server-rd.grupopie.com (195-23-94-106.static.net.novis.pt
	[195.23.94.106])
	by bipbip.grupopie.com (Postfix) with ESMTP id 1F4902CAC27D
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue,  1 Sep 2009 16:52:15 +0100 (WEST)
Received: from [192.168.0.13] (rsantos.grupopie.com [192.168.0.13])
	by server-rd.grupopie.com (Postfix) with ESMTP id 5315F37B01DE
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue,  1 Sep 2009 16:52:14 +0100 (WEST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux FB-Devel <linux-fbdev-devel@lists.sourceforge.net>

Hi all,

    I'm trying to setup a secondary video card through radeon KMS
driver. I'm only using fbcon, no X.
    Every time I change to a console belonging to /dev/fb1 the kernel
crashes. I've setup a netconsole but I get no extra info from it. Just a
crash...
    Here is the drm output:

    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] Initialized drm 1.1.0
    20060810
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] radeon default to
    kernel modesetting.
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] radeon kernel
    modesetting enabled.
    Sep  1 15:42:54 ws1t1 user.info kernel: radeon 0000:01:0c.0:
    enabling device (0080 -> 0083)
    Sep  1 15:42:54 ws1t1 user.info kernel: radeon 0000:01:0c.0: PCI INT
    A -> GSI 18 (level, low) -> IRQ 18
    Sep  1 15:42:54 ws1t1 user.debug kernel: radeon 0000:01:0c.0:
    setting latency timer to 64
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] radeon: Initializing
    kernel modesetting.
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] register mmio base:
    0xFDEE0000
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] register mmio size: 65536
    Sep  1 15:42:54 ws1t1 user.debug kernel: Switched to high resolution
    mode on CPU 0
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] GPU reset succeed
    (RBBM_STATUS=0x00000140)
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] GPU not posted.
    posting now...
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] Clocks initialized !
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] Detected VRAM RAM=32M,
    BAR=128M
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] RAM width 32bits DDR
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] radeon: VRAM 32M
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] radeon: VRAM from
    0x00000000 to 0x03FFFFFF
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] radeon: VRAM less than
    aperture workaround enabled
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] radeon: GTT 512M
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] radeon: GTT from
    0x20000000 to 0x3FFFFFFF
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] radeon: irq initialized.
    Sep  1 15:42:54 ws1t1 user.info kernel: [TTM] TTM available graphics
    memory: 247 MiB
    Sep  1 15:42:54 ws1t1 user.info kernel: [TTM] TTM available object
    memory: 247 MiB
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] radeon: 32M of VRAM
    memory ready
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] radeon: 512M of GTT
    memory ready.
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] GART: num cpu pages
    131072, num gpu pages 131072
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] radeon: cp idle
    (0x00008080)
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] Loading R100 Microcode
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] radeon: ring at
    0x0000000020000000
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] ring test succeeded in
    1 usecs
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] radeon: ib pool ready.
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] ib test succeeded in 0
    usecs
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] Radeon Display Connectors
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] Connector 0:
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm]   VGA
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm]   DDC: 0x60 0x60 0x60
    0x60 0x60 0x60 0x60 0x60
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm]   Encoders:
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm]     CRT1: INTERNAL_DAC1
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] fb mappable at 0xD8040000
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] vram apper at 0xD8000000
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] size 5242880
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] fb depth is 24
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm]    pitch is 5120
    Sep  1 15:42:54 ws1t1 user.info kernel: fb1: radeondrmfb frame
    buffer device
    Sep  1 15:42:54 ws1t1 user.info kernel: registered panic notifier
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] radeon: kernel
    modesetting successfully initialized.
    Sep  1 15:42:54 ws1t1 user.info kernel: [drm] Initialized radeon
    2.0.0 20080528 for 0000:01:0c.0 on minor 0

    lspci -vvv:

01:0c.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY
[Radeon 7000/VE] (prog-if 00 [VGA controller])
        Subsystem: ATI Technologies Inc Device 013b
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64 (2000ns min), Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at dc00 [size=256]
        Region 2: Memory at fdee0000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at fde00000 [disabled] [size=128K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: radeon
        Kernel modules: radeonfb

    Can anyone help me with some debug or, maybe I'm not just doing it
right... I also found little documentation on the subject...

Thanks for you help,
Rui Santos


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
