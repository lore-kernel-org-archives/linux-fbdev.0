From: Jesper Juhl <juhl-lkml@dif.dk>
Subject: [PATCH] remove pointless <0 comparisons in drivers/video/fbmem.c
Date: Mon, 22 Nov 2004 00:45:50 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0411220034040.3423@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261848AbUKUXgx@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Antonino Daplas <adaplas@pol.net>, linux-kernel <linux-kernel@vger.kernel.org>


The "console" and "framebuffer" members of struct fb_con2fbmap are both 
unsigned, so it makes no sense to compare them for being <0. Patch to 
remove the pointless comparisons below.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc2-bk6-orig/drivers/video/fbmem.c linux-2.6.10-rc2-bk6/drivers/video/fbmem.c
--- linux-2.6.10-rc2-bk6-orig/drivers/video/fbmem.c	2004-11-21 21:49:10.000000000 +0100
+++ linux-2.6.10-rc2-bk6/drivers/video/fbmem.c	2004-11-22 00:32:49.000000000 +0100
@@ -826,9 +826,9 @@ fb_ioctl(struct inode *inode, struct fil
 	case FBIOPUT_CON2FBMAP:
 		if (copy_from_user(&con2fb, argp, sizeof(con2fb)))
 			return - EFAULT;
-		if (con2fb.console < 0 || con2fb.console > MAX_NR_CONSOLES)
+		if (con2fb.console > MAX_NR_CONSOLES)
 		    return -EINVAL;
-		if (con2fb.framebuffer < 0 || con2fb.framebuffer >= FB_MAX)
+		if (con2fb.framebuffer >= FB_MAX)
 		    return -EINVAL;
 #ifdef CONFIG_KMOD
 		if (!registered_fb[con2fb.framebuffer])



Please CC me on relies from linux-fbdev-devel
