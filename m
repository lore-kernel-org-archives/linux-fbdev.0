From: Adam Kropelin <akropel1@rochester.rr.com>
Subject: [PATCH] sbusfb: Initialize cmap.transp in FBIOPUTCMAP_SPARC
Date: Sun, 6 Jun 2004 01:06:29 -0400
Sender: sparclinux-owner@vger.kernel.org
Message-ID: <20040606010629.A23517@mail.kroptech.com>
Mime-Version: 1.0
Return-path: <sparclinux-owner@vger.kernel.org>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Cc: jsimmons@infradead.org

When handling FBIOPUTCMAP_SPARC, sbusfb fails to initialize cmap.transp,
which quickly leads to an oops when fb_set_cmap() dereferences it.

First encountered in Aurora Wombat kernels and seems to afflict mainline
as well. Patch is against 2.6.7-rc2. xorg still fails to actually get
anything to display on my CG6, but at least it no longer oopses the kernel.

Signed-off-by: Adam Kropelin <akropel1@rochester.rr.com>

--- linux-2.6.7-rc2/drivers/video/sbuslib.c	2004-05-09 22:32:27.000000000 -0400
+++ linux-2.6.7-rc2-adk/drivers/video/sbuslib.c	2004-06-06 04:10:52.682928000 -0400
@@ -122,6 +122,7 @@
 		cmap.red = &red;
 		cmap.green = &green;
 		cmap.blue = &blue;
+		cmap.transp = NULL;
 		for (i = 0; i < count; i++) {
 			int err;
 
