From: rwhron@earthlink.net
Subject: stack trace from matrox fb on 2.5.50
Date: Thu, 28 Nov 2002 18:40:24 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021128234024.GA2632@rushmore>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from grebe.mail.pas.earthlink.net ([207.217.120.46])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18HYCh-0000Nk-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 28 Nov 2002 15:36:19 -0800
Received: from user-37kaeca.dialup.mindspring.com ([207.69.57.138] helo=earthlink.net)
	by grebe.mail.pas.earthlink.net with smtp (Exim 3.33 #1)
	id 18HYCg-0002t0-00
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Nov 2002 15:36:18 -0800
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

I saw the call trace below during 2.5.50 boot, but not on:
2.5.44-mm5
2.5.46-mm1
2.5.47-mm1
2.5.47-mm2
2.5.48-mm1
2.5.49
2.5.49-mm1

Invalid vesa mode 0x0000
matroxfb: Matrox G400 (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 1920x1440x8bpp (virtual: 1920x8736)
matroxfb: framebuffer at 0xD4000000, mapped to 0xf8805000, size 33554432
Uninitialised timer!
This is just a warning.  Your computer is OK
function=0xc01c9050, data=0x0
Call Trace:
 [<c011c340>] check_timer_failed+0x40/0x50
 [<c01c9050>] cursor_timer_handler+0x0/0x30
 [<c011c37e>] add_timer+0x2e/0xf0
 [<c01c9383>] fbcon_startup+0x43/0x50
 [<c01a0267>] take_over_console+0x17/0x190
 [<c01c87ec>] register_framebuffer+0x11c/0x150
 [<c01cf441>] initMatrox2+0x8d1/0x9a0
 [<c01cf99d>] matroxfb_probe+0x24d/0x280
 [<c01872b1>] pci_device_probe+0x41/0x60
 [<c018dce7>] bus_match+0x37/0x70
 [<c018ddd3>] driver_attach+0x43/0x70
 [<c018e092>] bus_add_driver+0x92/0xc0
 [<c0117425>] printk+0x105/0x120
 [<c018e444>] driver_register+0x34/0x40
 [<c01873c2>] pci_register_driver+0x42/0x60
 [<c0105030>] init+0x0/0x140
 [<c010504f>] init+0x1f/0x140
 [<c0105030>] init+0x0/0x140
 [<c0106e5d>] kernel_thread_helper+0x5/0x18

Console: switching to colour frame buffer device 240x90
fb0: MATROX VGA frame buffer device

This is what's in .config:
CONFIG_FB=y
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_G450=y
CONFIG_FB_MATROX_G100=y
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_ACCEL=y

lilo append has this:
video=matrox:vesa:depth:8,fh:115,fv:92,xres:1920,yres:1440,left:392,right:124

So far, everything appears to be working okay.

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
