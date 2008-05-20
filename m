From: Ben Dooks <ben-fbdev@fluff.org>
Subject: [patch 4/5] S3C2410: Clean out changelog header
	and tidy
Date: Tue, 20 May 2008 13:49:58 +0100
Message-ID: <20080520125030.532066121@fluff.org.uk>
References: <20080520124954.001898813@fluff.org.uk>
Content-Type: multipart/mixed; boundary="===============1463033760=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JyRIn-0004T8-Vd for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 May 2008 05:50:50 -0700
Received: from 87-194-8-8.bethere.co.uk ([87.194.8.8] helo=kira.home.fluff.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JyRIm-0006Hs-Vo
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 May 2008 05:50:49 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@linux-foundation.org, Ben Dooks <ben-linux@fluff.org>, arnaud.patard@rtp-net.org

--===============1463033760==
Content-Disposition: inline;
	filename=simtec/simtec-drivers-fb-s3c2410-hdrcleanup.patch

Remove the old changelog entries which are now out of date
and should be extractable from git anyway. Also tidy up the
copyright for the driver.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.26-rc3-quilt1/drivers/video/s3c2410fb.c
===================================================================
--- linux-2.6.26-rc3-quilt1.orig/drivers/video/s3c2410fb.c	2008-05-20 10:25:15.000000000 +0100
+++ linux-2.6.26-rc3-quilt1/drivers/video/s3c2410fb.c	2008-05-20 10:26:45.000000000 +0100
@@ -1,75 +1,15 @@
-/*
- * linux/drivers/video/s3c2410fb.c
- *	Copyright (c) Arnaud Patard, Ben Dooks
+/* linux/drivers/video/s3c2410fb.c
+ *	Copyright (c) 2004,2005 Arnaud Patard
+ *	Copyright (c) 2004-2008 Ben Dooks
+ *
+ * S3C2410 LCD Framebuffer Driver
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file COPYING in the main directory of this archive for
  * more details.
  *
- *	    S3C2410 LCD Controller Frame Buffer Driver
- *	    based on skeletonfb.c, sa1100fb.c and others
- *
- * ChangeLog
- * 2005-04-07: Arnaud Patard <arnaud.patard@rtp-net.org>
- *      - u32 state -> pm_message_t state
- *      - S3C2410_{VA,SZ}_LCD -> S3C24XX
- *
- * 2005-03-15: Arnaud Patard <arnaud.patard@rtp-net.org>
- *      - Removed the ioctl
- *      - use readl/writel instead of __raw_writel/__raw_readl
- *
- * 2004-12-04: Arnaud Patard <arnaud.patard@rtp-net.org>
- *      - Added the possibility to set on or off the
- *      debugging messages
- *      - Replaced 0 and 1 by on or off when reading the
- *      /sys files
- *
- * 2005-03-23: Ben Dooks <ben-linux@fluff.org>
- *	- added non 16bpp modes
- *	- updated platform information for range of x/y/bpp
- *	- add code to ensure palette is written correctly
- *	- add pixel clock divisor control
- *
- * 2004-11-11: Arnaud Patard <arnaud.patard@rtp-net.org>
- *	- Removed the use of currcon as it no more exists
- *	- Added LCD power sysfs interface
- *
- * 2004-11-03: Ben Dooks <ben-linux@fluff.org>
- *	- minor cleanups
- *	- add suspend/resume support
- *	- s3c2410fb_setcolreg() not valid in >8bpp modes
- *	- removed last CONFIG_FB_S3C2410_FIXED
- *	- ensure lcd controller stopped before cleanup
- *	- added sysfs interface for backlight power
- *	- added mask for gpio configuration
- *	- ensured IRQs disabled during GPIO configuration
- *	- disable TPAL before enabling video
- *
- * 2004-09-20: Arnaud Patard <arnaud.patard@rtp-net.org>
- *      - Suppress command line options
- *
- * 2004-09-15: Arnaud Patard <arnaud.patard@rtp-net.org>
- *	- code cleanup
- *
- * 2004-09-07: Arnaud Patard <arnaud.patard@rtp-net.org>
- *	- Renamed from h1940fb.c to s3c2410fb.c
- *	- Add support for different devices
- *	- Backlight support
- *
- * 2004-09-05: Herbert P������tzl <herbert@13thfloor.at>
- *	- added clock (de-)allocation code
- *	- added fixem fbmem option
- *
- * 2004-07-27: Arnaud Patard <arnaud.patard@rtp-net.org>
- *	- code cleanup
- *	- added a forgotten return in h1940fb_init
- *
- * 2004-07-19: Herbert P������tzl <herbert@13thfloor.at>
- *	- code cleanup and extended debugging
- *
- * 2004-07-15: Arnaud Patard <arnaud.patard@rtp-net.org>
- *	- First version
- */
+ * Driver based on skeletonfb.c, sa1100fb.c and others.
+*/
 
 #include <linux/module.h>
 #include <linux/kernel.h>
Index: linux-2.6.26-rc3-quilt1/drivers/video/s3c2410fb.h
===================================================================
--- linux-2.6.26-rc3-quilt1.orig/drivers/video/s3c2410fb.h	2008-05-20 10:25:15.000000000 +0100
+++ linux-2.6.26-rc3-quilt1/drivers/video/s3c2410fb.h	2008-05-20 10:28:32.000000000 +0100
@@ -1,26 +1,14 @@
 /*
  * linux/drivers/video/s3c2410fb.h
- * Copyright (c) Arnaud Patard
+ *	Copyright (c) 2004 Arnaud Patard
+ *
+ *  S3C2410 LCD Framebuffer Driver
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file COPYING in the main directory of this archive for
  * more details.
  *
- *	    S3C2410 LCD Controller Frame Buffer Driver
- *	    based on skeletonfb.c, sa1100fb.h
- *
- * ChangeLog
- *
- * 2004-12-04: Arnaud Patard <arnaud.patard@rtp-net.org>
- *      - Moved dprintk to s3c2410fb.c
- *
- * 2004-09-07: Arnaud Patard <arnaud.patard@rtp-net.org>
- * 	- Renamed from h1940fb.h to s3c2410fb.h
- * 	- Changed h1940 to s3c2410
- *
- * 2004-07-15: Arnaud Patard <arnaud.patard@rtp-net.org>
- *	- First version
- */
+*/
 
 #ifndef __S3C2410FB_H
 #define __S3C2410FB_H

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'


--===============1463033760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1463033760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1463033760==--
