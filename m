From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
Subject: [PATCH] - video/tdfxfb.c warning fix.
Date: Fri, 30 Apr 2004 15:04:51 -0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040430180451.GA3119@lorien.prodam>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJcPk-0006Tt-7v
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 30 Apr 2004 11:07:08 -0700
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJcPj-0002Fl-P9
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 30 Apr 2004 11:07:07 -0700
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
Cc: James Simmons <jsimmons@infraded.org>, linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>


 Hi Andrew,

 This patch fixes this warning:

 drivers/video/tdfxfb.c:1005: warning: `tdfxfb_cursor' defined but not
 used

 and make the acceleration function selectable (like hgafb
and tridentfb):


 drivers/video/Kconfig  |    8 ++++++++
 drivers/video/tdfxfb.c |    8 +++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)


diff -X dontdiff -Nparu a/drivers/video/Kconfig a~/drivers/video/Kconfig
--- a/drivers/video/Kconfig	2004-04-26 15:25:52.000000000 -0300
+++ a~/drivers/video/Kconfig	2004-04-27 18:15:23.000000000 -0300
@@ -751,6 +751,14 @@ config FB_3DFX
 	  To compile this driver as a module, choose M here: the
 	  module will be called tdfxfb.
 
+config FB_3DFX_ACCEL
+	bool "3Dfx Banshee/Voodoo3 Acceleration functions (EXPERIMENTAL)"
+	depends on FB_3DFX && EXPERIMENTAL
+	---help---
+	This will compile the 3Dfx Banshee/Voodoo3 frame buffer device
+	with acceleration functions.
+
+
 config FB_VOODOO1
 	tristate "3Dfx Voodoo Graphics (sst1) support"
 	depends on FB && PCI
diff -X dontdiff -Nparu a/drivers/video/tdfxfb.c a~/drivers/video/tdfxfb.c
--- a/drivers/video/tdfxfb.c	2004-03-11 14:20:50.000000000 -0300
+++ a~/drivers/video/tdfxfb.c	2004-04-27 19:35:22.000000000 -0300
@@ -166,7 +166,11 @@ static int tdfxfb_pan_display(struct fb_
 static void tdfxfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect);
 static void tdfxfb_copyarea(struct fb_info *info, const struct fb_copyarea *area);  
 static void tdfxfb_imageblit(struct fb_info *info, const struct fb_image *image); 
+#ifdef CONFIG_FB_3DFX_ACCEL
 static int tdfxfb_cursor(struct fb_info *info, struct fb_cursor *cursor);
+#else /* !CONFIG_FB_3DFX_ACCEL */
+#define tdfxfb_cursor soft_cursor
+#endif /* CONFIG_FB_3DFX_ACCEL */
 static int banshee_wait_idle(struct fb_info *info);
 
 static struct fb_ops tdfxfb_ops = {
@@ -180,7 +184,7 @@ static struct fb_ops tdfxfb_ops = {
 	.fb_copyarea	= tdfxfb_copyarea,
 	.fb_imageblit	= tdfxfb_imageblit,
 	.fb_sync	= banshee_wait_idle,
-	.fb_cursor	= soft_cursor,
+	.fb_cursor	= tdfxfb_cursor,
 };
 
 /*
@@ -1001,6 +1005,7 @@ static void tdfxfb_imageblit(struct fb_i
 	banshee_wait_idle(info);
 }
 
+#ifdef CONFIG_FB_3DFX_ACCEL
 static int tdfxfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
 	struct tdfx_par *par = (struct tdfx_par *) info->par;
@@ -1137,6 +1142,7 @@ static int tdfxfb_cursor(struct fb_info 
 	spin_unlock_irqrestore(&par->DAClock, flags);
 	return 0;
 }
+#endif /* CONFIG_FB_3DFX_ACCEL */
 
 /**
  *      tdfxfb_probe - Device Initializiation

-- 
Luiz Fernando N. Capitulino
<http://www.telecentros.sp.gov.br>


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
