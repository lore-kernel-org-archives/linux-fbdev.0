From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
Subject: Re: [PATCH] - video/tridentfb.c warning fix.
Date: Fri, 16 Apr 2004 15:21:09 -0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040416152109.5bdbe325.lcapitulino@prefeitura.sp.gov.br>
References: <20040413164729.2eba2e6e.lcapitulino@prefeitura.sp.gov.br>
	<Pine.LNX.4.44.0404141906060.13481-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BEXzI-0007Ei-Aa
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 16 Apr 2004 11:22:52 -0700
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BEXzH-0005eh-RS
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 16 Apr 2004 11:22:52 -0700
In-Reply-To: <Pine.LNX.4.44.0404141906060.13481-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: benh@kernel.crashing.org, linux-fbdev-devel@lists.sf.net

Em Wed, 14 Apr 2004 19:06:28 +0100 (BST)
James Simmons <jsimmons@infradead.org> escreveu:

| I meant ow about someone test and fix the acceleration code. Unfortunely I 
| don't hvae this card.

 Hi again,

 Here is my sugestion for the problem:

 drivers/video/Kconfig     |    7 +++++++
 drivers/video/tridentfb.c |   10 +++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)


diff -X dontdiff -Nparu a/drivers/video/Kconfig a~/drivers/video/Kconfig
--- a/drivers/video/Kconfig	2004-04-16 15:02:28.000000000 -0300
+++ a~/drivers/video/Kconfig	2004-04-16 14:46:48.000000000 -0300
@@ -772,6 +772,13 @@ config FB_TRIDENT
 	  To compile this driver as a module, choose M here: the
 	  module will be called tridentfb.
 
+config FB_TRIDENT_ACCEL
+	bool "Trident Acceleration functions (EXPERIMENTAL)"
+	depends on FB_TRIDENT
+	---help---
+	This will compile FB_TRIDENT with acceleration functions.
+
+
 config FB_PM3
 	tristate "Permedia3 support"
 	depends on FB && PCI && BROKEN
diff -X dontdiff -Nparu a/drivers/video/tridentfb.c a~/drivers/video/tridentfb.c
--- a/drivers/video/tridentfb.c	2004-04-16 15:02:36.000000000 -0300
+++ a~/drivers/video/tridentfb.c	2004-04-16 14:36:00.000000000 -0300
@@ -450,7 +450,7 @@ static struct accel_switch accel_image =
 /*
  * Accel functions called by the upper layers
  */
-
+#ifdef FB_TRIDENT_ACCEL
 static void tridentfb_fillrect(struct fb_info * info, const struct fb_fillrect *fr)
 {
 	int bpp = info->var.bits_per_pixel;
@@ -474,6 +474,7 @@ static void tridentfb_copyarea(struct fb
 	acc->copy_rect(ca->sx,ca->sy,ca->dx,ca->dy,ca->width,ca->height);
 	acc->wait_engine();
 }
+#endif
 
 /*
  * Hardware access functions
@@ -1265,10 +1266,13 @@ static struct fb_ops tridentfb_ops = {
 	.fb_blank = tridentfb_blank,
 	.fb_check_var = tridentfb_check_var,
 	.fb_set_par = tridentfb_set_par,
-//	.fb_fillrect = tridentfb_fillrect,
-//	.fb_copyarea= tridentfb_copyarea,
+#ifdef FB_TRIDENT_ACCEL
+	.fb_fillrect = tridentfb_fillrect,
+	.fb_copyarea= tridentfb_copyarea,
+#else
 	.fb_fillrect = cfb_fillrect,
 	.fb_copyarea= cfb_copyarea,
+#endif /* FB_TRIDENT_ACCEL */
 	.fb_imageblit = cfb_imageblit,
 	.fb_cursor = soft_cursor,
 };

 I don't know if it is good, but It will be temporary anyway,
(just util the code is tested). The warning is gone, and the code
can be tested.

 If it is not too bad, I can do that for video/hgafb.c, and
comment the code with #if 0 / #endif for video/imsttfb.c.

-- 
Luiz Fernando N. Capitulino
<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
