From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
Subject: [PATCH] - tridentfbc-warning-fix v2.
Date: Fri, 30 Apr 2004 14:54:21 -0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040430175421.GB575@lorien.prodam>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJcEc-0003z0-V2
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 30 Apr 2004 10:55:38 -0700
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJcEc-00085G-KR
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 30 Apr 2004 10:55:38 -0700
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net


 Andrew,

 This is the tridentfbc-warning-fix.patch version 2, I added the
missing EXPERIMENTAL in drivers/video/Kconfig.

 drivers/video/Kconfig     |    8 ++++++++
 drivers/video/tridentfb.c |   13 ++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)


diff -X dontdiff -Nparu a/drivers/video/Kconfig a~/drivers/video/Kconfig
--- a/drivers/video/Kconfig	2004-04-30 14:33:59.000000000 -0300
+++ a~/drivers/video/Kconfig	2004-04-30 14:34:59.000000000 -0300
@@ -799,6 +799,14 @@ config FB_TRIDENT
 	  To compile this driver as a module, choose M here: the
 	  module will be called tridentfb.
 
+config FB_TRIDENT_ACCEL
+	bool "Trident Acceleration functions (EXPERIMENTAL)"
+	depends on FB_TRIDENT && EXPERIMENTAL
+	---help---
+	This will compile the Trident frame buffer device with
+	acceleration functions.
+
+
 config FB_PM3
 	tristate "Permedia3 support"
 	depends on FB && PCI && BROKEN
diff -X dontdiff -Nparu a/drivers/video/tridentfb.c a~/drivers/video/tridentfb.c
--- a/drivers/video/tridentfb.c	2004-04-30 14:33:59.000000000 -0300
+++ a~/drivers/video/tridentfb.c	2004-04-30 12:54:25.000000000 -0300
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
-- 
Luiz Fernando N. Capitulino
<http://www.telecentros.sp.gov.br>


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
