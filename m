From: jurriaan <thunder7@xs4all.nl>
Subject: ghosting with nvidia framebuffer (pci-e 6600), 1600x1200 and 12x22 font
Date: Wed, 6 Jul 2005 21:04:56 +0200
Message-ID: <20050706190456.GA20251@amd64.of.nowhere>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.91] (helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DqFDP-0004sg-Ui
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 06 Jul 2005 12:05:47 -0700
Received: from smtp-vbr5.xs4all.nl ([194.109.24.25])
	by sc8-sf-mx1-new.sourceforge.net with esmtp (Exim 4.44)
	id 1DqFDN-0001zV-BA
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 06 Jul 2005 12:05:47 -0700
Received: from zeeotter.xs4all.nl (zeeotter.xs4all.nl [80.126.31.149])
	by smtp-vbr5.xs4all.nl (8.13.3/8.13.3) with ESMTP id j66J5Uxm020635
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 6 Jul 2005 21:05:35 +0200 (CEST)
	(envelope-from jurriaan@rivierenland.xs4all.nl)
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
To: adaplas@hotpop.com, adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net

I've bought myself a fine new s939 motherboard, which meant another
videocard as well. Since I couldn't get an Ati X600 running reliably
under X.org (#@#$*$ FIFO timed out errors are very frustrating, and the
only solution I found was to shut down all acceleration, which didn't
make me happy), I'm now running an Nvidia 6600.

Kernel command line: root=/dev/hda1 video=nvidiafb:1600x1200-32@85 atkbd.softrepeat=1

nvidiafb: nVidia device/chipset 10DE0141
nvidiafb: PCI device 10de:0141 (nVidia Corporation)
nvidiafb: CRTC0 found
nvidiafb: CRTC1 found
nvidiafb: CRTC 0 appears to have a CRT attached
nvidiafb: Using CRT on CRTC 0
nvidiafb: MTRR set to ON
Console: switching to colour frame buffer device 133x54
nvidiafb: PCI nVidia NV14 framebuffer (64MB @ 0xC0000000)

I'm running at 1600x1200 resolution with the 12x22 font, and a
2.6.13-rc1-mm1 kernel.

A strange effect is noticeable: often characters from the left of the
screen are ghosted on the right of the screen. Not all of the pixels
that form a character, but enough to be visible. To my best knowledge,
the ghosting starts at column 85, and 85 * 12 = 1020, which may mean
some sort of erroneous wrap-around at pixel 1024 is taking place?

I can reproduce this almost immediately by pressing <RETURN> on the last
line of the screen, thus scrolling the screen up.

It also happens in other situations, but not often enough to be able to
say what is necessary to reproduce it.


0000:01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0141 (rev a2) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 217
	Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=64M]
	Region 1: Memory at c0000000 (64-bit, prefetchable) [size=256M]
	Region 3: Memory at d4000000 (64-bit, non-prefetchable) [size=16M]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] #10 [0001]

Can you think of anything I can do to resolve this? Where do I start to
look?

Thanks,
Jurriaan
-- 
We have engaged the Borg. The wedding will be Friday.
Debian (Unstable) GNU/Linux 2.6.13-rc1-mm1 4427 bogomips load 0.06


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
