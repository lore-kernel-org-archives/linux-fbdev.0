From: James Simmons <jsimmons@infradead.org>
Subject: Much better framebuffer fixes.
Date: Thu, 27 Mar 2003 00:18:57 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0303270017180.25001-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Okay. Here are more framebuffer fixes. Please try these fixes and let me 
know how they work out for you.

The diff is at 

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

 Documentation/devices.txt       |    7 -
 arch/ppc/syslib/prom_init.c     |    2 
 drivers/video/aty/aty128fb.c    |   16 +-
 drivers/video/cfbimgblt.c       |    4 
 drivers/video/console/fbcon.c   |  246 +++++++++++++++++++++-------------------
 drivers/video/controlfb.c       |   18 --
 drivers/video/fbmem.c           |   76 ++++--------
 drivers/video/i810/i810.h       |    6 
 drivers/video/i810/i810_accel.c |  140 +++++++++++-----------
 drivers/video/i810/i810_dvt.c   |    3 
 drivers/video/i810/i810_gtf.c   |    7 -
 drivers/video/i810/i810_main.c  |  135 +++++++++------------
 drivers/video/i810/i810_main.h  |    4 
 drivers/video/logo/logo.c       |   69 +++++------
 drivers/video/platinumfb.c      |   28 +---
 drivers/video/radeonfb.c        |   10 +
 drivers/video/riva/fbdev.c      |    2 
 drivers/video/softcursor.c      |   95 ++++-----------
 drivers/video/tdfxfb.c          |   18 +-
 drivers/video/tgafb.c           |    2 
 drivers/video/vga16fb.c         |    4 
 include/linux/fb.h              |    4 
 include/linux/linux_logo.h      |    2 
 23 files changed, 403 insertions(+), 495 deletions(-)
