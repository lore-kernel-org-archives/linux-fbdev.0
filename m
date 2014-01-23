From: Mikulas Patocka <mpatocka@redhat.com>
Date: Thu, 23 Jan 2014 19:38:11 +0000
Subject: [PATCH 1/10] matroxfb: set FBINFO_READS_FAST
Message-Id: <alpine.LRH.2.02.1401231437401.7971@file01.intranet.prod.int.rdu2.redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Set FBINFO_READS_FAST so that the console code uses scrolling instead of
rewriting. This improves scrolling speed.

A time to do ls -la /usr/bin:
	original patched
32bpp	5.4	3.6
24bpp	5.1	3.0
16bpp	4.9	2.5
8bpp	4.9	2.0

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/video/matrox/matroxfb_base.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-3.12.1/drivers/video/matrox/matroxfb_base.c
=================================--- linux-3.12.1.orig/drivers/video/matrox/matroxfb_base.c	2013-11-18 18:14:25.000000000 +0100
+++ linux-3.12.1/drivers/video/matrox/matroxfb_base.c	2013-11-23 17:58:47.000000000 +0100
@@ -1773,7 +1773,8 @@ static int initMatrox2(struct matrox_fb_
 				      FBINFO_HWACCEL_FILLRECT |  /* And fillrect */
 				      FBINFO_HWACCEL_IMAGEBLIT | /* And imageblit */
 				      FBINFO_HWACCEL_XPAN |      /* And we support both horizontal */
-				      FBINFO_HWACCEL_YPAN;       /* And vertical panning */
+				      FBINFO_HWACCEL_YPAN |      /* And vertical panning */
+				      FBINFO_READS_FAST;
 	minfo->video.len_usable &= PAGE_MASK;
 	fb_alloc_cmap(&minfo->fbcon.cmap, 256, 1);
 

