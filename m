From: Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH] Disable mach64 accelerator if stride is
	not multiple of 64
Date: Wed, 17 Jun 2009 06:02:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0906170600590.30231@hs20-bc2-1.build.redhat.com>
References: <Pine.LNX.4.64.0906170559040.30231@hs20-bc2-1.build.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpatocka@redhat.com>) id 1MGsBt-0006i5-5Z
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Jun 2009 10:16:25 +0000
Received: from mx1.redhat.com ([66.187.233.31])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MGsBr-0006Yg-HM for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Jun 2009 10:16:25 +0000
In-Reply-To: <Pine.LNX.4.64.0906170559040.30231@hs20-bc2-1.build.redhat.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: paulus@samba.org
Cc: linux-fbdev-devel@lists.sourceforge.net

On my card, the accelerator corrupts display if its line length is not
multiple of 64 bytes.

Misaligned lines in the drawn recrangle are shifted left, as if the accelerator
thought that every line begins on 64-byte boundary. For example, in 800x600x8
(scanlines are aligned on 32 bytes) every odd scanline is drawn shifted by
32 bytes to the left.

The card is ATI Technologies Inc 3D Rage Pro 215GP (rev 5c) onboard on
Sparc64 Ultra 5.

This patch disables accelerator if scanline is not multiple of 64 bytes.

I don't have any other cards to test. If someone tests that his card doesn't
have this bug, he can whitelist it.

(note: if you find a better place where to disable the accelerator on 
non-conforming modes, do it there)

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com

---
 drivers/video/aty/mach64_accel.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

Index: linux-2.6.30-fast/drivers/video/aty/mach64_accel.c
===================================================================
--- linux-2.6.30-fast.orig/drivers/video/aty/mach64_accel.c	2009-06-17 08:49:01.000000000 +0200
+++ linux-2.6.30-fast/drivers/video/aty/mach64_accel.c	2009-06-17 10:46:03.000000000 +0200
@@ -35,6 +35,14 @@ static u32 rotation24bpp(u32 dx, u32 dir
 	return ((rotation << 8) | DST_24_ROTATION_ENABLE);
 }
 
+static inline int no_accel(struct fb_info *info)
+{
+	/*
+	 * The lines must be aligned on 64-byte boundary.
+	 */
+	return (info->var.xres_virtual * ((info->var.bits_per_pixel + 7) >> 3)) & 63;
+}
+
 void aty_reset_engine(const struct atyfb_par *par)
 {
 	/* reset engine */
@@ -199,7 +207,7 @@ void atyfb_copyarea(struct fb_info *info
 		return;
 	if (!area->width || !area->height)
 		return;
-	if (!par->accel_flags) {
+	if (!par->accel_flags || no_accel(info)) {
 		cfb_copyarea(info, area);
 		return;
 	}
@@ -245,7 +253,7 @@ void atyfb_fillrect(struct fb_info *info
 		return;
 	if (!rect->width || !rect->height)
 		return;
-	if (!par->accel_flags) {
+	if (!par->accel_flags || no_accel(info)) {
 		cfb_fillrect(info, rect);
 		return;
 	}
@@ -285,7 +293,7 @@ void atyfb_imageblit(struct fb_info *inf
 		return;
 	if (!image->width || !image->height)
 		return;
-	if (!par->accel_flags ||
+	if (!par->accel_flags || no_accel(info) ||
 	    (image->depth != 1 && info->var.bits_per_pixel != image->depth)) {
 		cfb_imageblit(info, image);
 		return;


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
