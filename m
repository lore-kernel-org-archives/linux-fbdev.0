From: Fractallyte <fractallyte@csi.com>
Subject: atyfb, console, kernel 2.6.14 & Sony Vaio C1VE
Date: Tue, 21 Feb 2006 20:07:23 +0000
Message-ID: <6f39f5aeb071b20c6b98c2847273d4cb@csi.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v622)
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FBdnQ-0004Eh-6R
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Feb 2006 12:07:40 -0800
Received: from anchor-post-36.mail.demon.net ([194.217.242.86])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FBdnO-0003ga-QP
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Feb 2006 12:07:40 -0800
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Alexander Kern <alex.kern@gmx.de>

Dear List

I'm running Linux with 2.6.14 kernel on a Vaio C1VE laptop.  The LCD 
panel size is 1024x480.  ATI Mach64 framebuffer support is compiled 
into the kernel; however, when booting into the console, the display is 
stretched horizontally to 80 columns, and fbset reports a 640x480 
display.  dmesg reports that the atyfb driver is detecting the correct 
geometry and timings for the panel (tested and working in Xorg), but 
the console insists on 80x30 rather than 128x30.

(For reference) dmesg:

	atyfb: using auxiliary register aperture
	atyfb: 3D RAGE Mobility P/M (Mach64 LR, PCI) [0x4c52 rev 0x64]
	atyfb: Mach64 BIOS is located at c0000, mapped at c00c0000.
	atyfb: BIOS frequency table:
	atyfb: PCLK_min_freq 984, PCLK_max_freq 23600, ref_freq 2950, 
ref_divider 64
	atyfb: MCLK_pwd 4200, MCLK_max_freq 8300, XCLK_max_freq 12500, 
SCLK_freq 5000
	atyfb: BIOS contains driver information table.
	atyfb: colour active matrix monitor detected: Sharp
	atyfb:        id=1, 1024x480 pixels, 262144 colours (LT mode)
	atyfb:        supports refresh rates [60], default 60 Hz
	atyfb:        LCD CRTC parameters: 42.8044  1024 1048 1184 1344  480 
489 495 525
	atyfb:                           : 23618 160 1024 24 136 30 480 9 6
	atyfb: 8M SDRAM (1:1), 29.498928 MHz XTAL, 236 MHz PLL, 83 Mhz MCLK, 
125 MHz XCLK
	Console: switching to colour frame buffer device 80x30
	atyfb: fb0: ATY Mach64 frame buffer device on PCI

Some background information on the C1VE:

Marcel Wijlaars made a patch for the 2.4 kernel 
(http://sourceforge.net/mailarchive/message.php?msg_id=177653 and 
http://www.stack.nl/~marcelw/vaio.html) which allowed for a 1024x480 
console.  This was incorporated into kernel versions up to 2.4.20, but 
later removed by Alan Cox since it crashed some machines.  There's been 
nothing for the 2.6.x kernels specifically for the C1VE, but it seems 
that the Mach64 driver is capable of working correctly with this 
computer.  Alex Kern suggests it could be due to a bug in 
drivers/video/modedb.c

Is anyone able to take a look at this?  I'd be happy to help with 
testing and report back!

Amir



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
