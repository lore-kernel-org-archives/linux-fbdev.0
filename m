From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
Subject: [PATCH] - video/tridentfb.c warning fix.
Date: Mon, 19 Apr 2004 16:28:07 -0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040419162807.7ba9c5ec.lcapitulino@prefeitura.sp.gov.br>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BFej4-0002ii-Ir
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 19 Apr 2004 12:46:42 -0700
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BFej4-0005KY-2y
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 19 Apr 2004 12:46:42 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: akpm@osdl.org
Cc: jsimmons@infradead.org, linux-fbdev-devel@lists.sf.net


 Andrew,

 Speaking with frame buffer people, we agree with this
patch to fix the warning:

drivers/video/tridentfb.c:455: warning: `tridentfb_fillrect' defined but not used
drivers/video/tridentfb.c:473: warning: `tridentfb_copyarea' defined but not used

 the patch is here:

 drivers/video/Kconfig     |    8 ++++++++
 drivers/video/tridentfb.c |   13 ++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)


diff -X dontdiff -Nparu a/drivers/video/Kconfig a~/drivers/video/Kconfig
--- a/drivers/video/Kconfig	2004-04-16 20:03:09.000000000 -0300
+++ a~/drivers/video/Kconfig	2004-04-16 20:04:24.000000000 -0300
@@ -772,6 +772,14 @@ config FB_TRIDENT
 	  To compile this driver as a module, choose M here: the
 	  module will be called tridentfb.
 
+config FB_TRIDENT_ACCEL
+	bool "Trident Acceleration functions (EXPERIMENTAL)"
+	depends on FB_TRIDENT
+	---help---
+	This will compile the Trident frame buffer device with
+	acceleration functions.
+
+
 config FB_PM3
 	tristate "Permedia3 support"
 	depends on FB && PCI && BROKEN
diff -X dontdiff -Nparu a/drivers/video/tridentfb.c a~/drivers/video/tridentfb.c
--- a/drivers/video/tridentfb.c	2004-04-16 20:03:29.000000000 -0300
+++ a~/drivers/video/tridentfb.c	2004-04-16 20:42:26.000000000 -0300
@@ -450,7 +450,7 @@ static struct accel_switch accel_image =
 /*
  * Accel functions called by the upper layers
  */
-
+#ifdef CONFIG_FB_TRIDENT_ACCEL
 static void tridentfb_fillrect(struct fb_info * info, const struct fb_fillrect *fr)
 {
 	int bpp = info->var.bits_per_pixel;
@@ -474,6 +474,11 @@ static void tridentfb_copyarea(struct fb
 	acc->copy_rect(ca->sx,ca->sy,ca->dx,ca->dy,ca->width,ca->height);
 	acc->wait_engine();
 }
+#else /* !CONFIG_FB_TRIDENT_ACCEL */
+#define tridentfb_fillrect cfb_fillrect
+#define tridentfb_copyarea cfb_copyarea
+#endif /* CONFIG_FB_TRIDENT_ACCEL */
+
 
 /*
  * Hardware access functions
@@ -1265,10 +1270,8 @@ static struct fb_ops tridentfb_ops = {
 	.fb_blank = tridentfb_blank,
 	.fb_check_var = tridentfb_check_var,
 	.fb_set_par = tridentfb_set_par,
-//	.fb_fillrect = tridentfb_fillrect,
-//	.fb_copyarea= tridentfb_copyarea,
-	.fb_fillrect = cfb_fillrect,
-	.fb_copyarea= cfb_copyarea,
+	.fb_fillrect = tridentfb_fillrect,
+	.fb_copyarea= tridentfb_copyarea,
 	.fb_imageblit = cfb_imageblit,
 	.fb_cursor = soft_cursor,
 };

 The functions: tridentfb_copyarea() and tridentfb_fillrect() can be
used to acceleration, but it is not tested.

 I don't like the idea to comment it because they will be forgoten.

 James agreed to this patch.

PS: I'll send the video/hga.c, it is the some case.

-- 
Luiz Fernando N. Capitulino
<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
