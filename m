From: Matt Nanney <matt@ifox.com>
Subject: vesafb and too much RAM?
Date: Sat, 11 Jan 2003 12:57:02 -0700 (MST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301111150160.10295-100000@ie>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from interneteffects.com ([63.226.86.4] helo=ie)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18XRlO-0003VZ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 11 Jan 2003 11:57:50 -0800
Received: from matt (helo=localhost)
	by ie with local-esmtp (Exim 3.36 #1 (Debian))
	id 18XRkc-0003nE-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 11 Jan 2003 12:57:02 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

I was running debian with a 2.4.20(-3 I believe) with vesafb with no
problems with 512MB ram. I upgraded to 1GB and immediately I could not
boot. I get as far as the LILO prompt, but as soon as I hit enter the
screen goes black, the caps lock and scroll lock keyboard LEDs flash, and
nothing save hitting the reset switch has any affect.

I can append 'mem=768M' to the kernel command line and everything boots
like normal except of course that then it think I have only 768MB RAM. If
I tell the kernel not to use vesafb by removing the 'vga=' line in my
lilo.conf then everything boot fine and my RAM is recognized.

I also have a second install of debian with kernel 2.4.19 on the same
machine. With this kernel it actually boots, however the screen stays
black. I can log in blindly and issue commands and dmesg reported the
following:

"vesafb: abort, cannot ioremap video memory 0x8000000 @ 0xd8000000"

This kernel also behaves normally if I specify 'mem=768M' on the kernel
command line or if I specify vga=normal (overriding my normal vga=792 from
lilo.conf). With 'mem=768M' set dmesg shows:

 vesafb: framebuffer at 0xd8000000, mapped to 0xf080e000, size 131072k
 vesafb: mode is 1024x768x32, linelength=4096, pages=1
 vesafb: protected mode interface info at c000:e350
 vesafb: scrolling: redraw
 vesafb: directcolor: size=8:8:8:8, shift=24:16:8:0
 Console: switching to colour frame buffer device 128x48
 fb0: VESA VGA frame buffer device

with 2.4.20 and 'mem=768M'

 vesafb: framebuffer at 0xd8000000, mapped to 0xf0800000, size 131072k
 vesafb: mode is 1024x768x32, linelength=4096, pages=1
 vesafb: protected mode interface info at c000:e350
 vesafb: scrolling: redraw
 vesafb: directcolor: size=8:8:8:8, shift=24:16:8:0
 Console: switching to colour frame buffer device 128x48
 fb0: VESA VGA frame buffer device

In testing I have found that I can go as high as 'mem=880M' with no
problem but 'mem=881M' ends in the same results as described above.

I don't know if this is a bug or something I may have overlooked or failed
to do. Hope someone can understand whats happening.

Thanks and regards,
Matt N.



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
