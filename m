From: James Simmons <jsimmons@infradead.org>
Subject: [BK FBDEV updates]
Date: Wed, 8 Jan 2003 19:19:29 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.33.0301081042070.9598-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


Linus, please do a

	bk pull http://fbdev.bkbits.net:8080/fbdev-2.5

This will update the following files:

 include/video/font.h            |   24 
 arch/m68k/kernel/m68k_defs.c    |    2 
 drivers/video/Kconfig           |    2 
 drivers/video/Makefile          |    3 
 drivers/video/aty/atyfb_base.c  |    4 
 drivers/video/console/Kconfig   |   14 
 drivers/video/console/fbcon.c   |   90 +-
 drivers/video/console/sticon.c  |  101 +-
 drivers/video/console/sticore.c |  159 ++--
 drivers/video/fbmem.c           |   13 
 drivers/video/fbmon.c           |  369 ++++++++++
 drivers/video/i810/i810.h       |    2 
 drivers/video/i810/i810_accel.c |   11 
 drivers/video/i810/i810_dvt.c   |    2 
 drivers/video/i810/i810_main.c  |   51 -
 drivers/video/i810/i810_main.h  |   79 --
 drivers/video/riva/Makefile     |    2 
 drivers/video/riva/fbdev.c      | 1468 +++++++++++++++++++---------------------
 drivers/video/riva/nv_driver.c  |  212 +++++
 drivers/video/riva/riva_hw.c    |  350 +++++++--
 drivers/video/riva/rivafb.h     |   15 
 drivers/video/sstfb.c           |  711 +++++++++----------
 drivers/video/sstfb.h           |   31 
 drivers/video/sticore.h         |   58 -
 drivers/video/stifb.c           |  103 ++
 include/linux/fb.h              |    4 
 include/linux/font.h            |   30 
 27 files changed, 2337 insertions(+), 1573 deletions(-)

through these ChangeSets:

<jsimmons@maxwell.earthlink.net> (03/01/08 1.887)
   [MONITOR support] GTF support for VESA complaint monitors. Here we calculate the general timings needed so we don't over step the bounds for a monitor.
   
   [fbmem.c cleanup] Name change to make teh code easier to read.

<jsimmons@maxwell.earthlink.net> (03/01/07 1.879.2.95)
   Updates from Helge Deller for the console/fbdev drivers for the PARISC platform. Small fix for clearing the screen and a string typo for the Voodoo 1/2 driver.

<jsimmons@maxwell.earthlink.net> (03/01/06 1.879.2.93)
   [RIVA FBDEV] Driver now uses its own fb_open and fb_release function again. It has no ill effects. The drivers uses strickly hardware acceleration so we don't need cfb_fillrect and cfb_copyarea.
   Cleaned up font.h. Geerts orignal pacth broke them up into a font.h in video and one in  linux. Now I put them back together again in include/linux. The m68k platform has been updated for this change.
   

<jsimmons@maxwell.earthlink.net> (03/01/06 1.879.2.92)
   Added resize support for the framebuffer console. Now you can change the console size via stty. Also support for color palette changing on VC switch is supported.

<jsimmons@maxwell.earthlink.net> (03/01/06 1.879.2.91)
   I810 fbdev updates. Cursor fix for ati mach 64 cards on big endian machines. Buffer over flow fix for fbcon putcs function. C99 initializers for the STI console drivers.Voodoo 1/2 and NVIDIA driver updates.

The diff is located at

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
