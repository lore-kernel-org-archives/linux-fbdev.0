From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
Subject: [PATCH] - hgafbc-warning-fix.patch v2.
Date: Fri, 30 Apr 2004 14:51:51 -0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040430175151.GA575@lorien.prodam>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJcBL-0003FP-Lk
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 30 Apr 2004 10:52:15 -0700
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BJcBL-0002Ii-7s
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 30 Apr 2004 10:52:15 -0700
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

 This is the hgafbc-warning-fix.patch version 2, I added the
missing EXPERIMENTAL in Kconfig.

 drivers/video/Kconfig |    8 ++++++++
 drivers/video/hgafb.c |   15 ++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)


diff -X dontdiff -Nparu a/drivers/video/hgafb.c a~/drivers/video/hgafb.c
--- a/drivers/video/hgafb.c	2004-04-30 14:26:05.000000000 -0300
+++ a~/drivers/video/hgafb.c	2004-04-30 12:54:25.000000000 -0300
@@ -448,6 +448,10 @@ static int hgafb_blank(int blank_mode, s
 	return 0;
 }
 
+/*
+ * Accel functions
+ */
+#ifdef CONFIG_FB_HGA_ACCEL
 static void hgafb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 {
 	u_int rows, y;
@@ -510,6 +514,11 @@ static void hgafb_imageblit(struct fb_in
 		*dest = d;
 	}
 }
+#else /* !CONFIG_FB_HGA_ACCEL */
+#define hgafb_fillrect cfb_fillrect
+#define hgafb_copyarea cfb_copyarea
+#define hgafb_imageblit cfb_imageblit
+#endif /* CONFIG_FB_HGA_ACCEL */
 
 
 static struct fb_ops hgafb_ops = {
@@ -519,9 +528,9 @@ static struct fb_ops hgafb_ops = {
 	.fb_setcolreg	= hgafb_setcolreg,
 	.fb_pan_display	= hgafb_pan_display,
 	.fb_blank	= hgafb_blank,
-	.fb_fillrect	= cfb_fillrect, //hgafb_fillrect,
-	.fb_copyarea	= cfb_copyarea,	//hgafb_copyarea,
-	.fb_imageblit	= cfb_imageblit,//hgafb_imageblit,
+	.fb_fillrect	= hgafb_fillrect,
+	.fb_copyarea	= hgafb_copyarea,
+	.fb_imageblit	= hgafb_imageblit,
 };
 		
 /* ------------------------------------------------------------------------- *
diff -X dontdiff -Nparu a/drivers/video/Kconfig a~/drivers/video/Kconfig
--- a/drivers/video/Kconfig	2004-04-30 14:26:05.000000000 -0300
+++ a~/drivers/video/Kconfig	2004-04-30 14:12:18.000000000 -0300
@@ -312,6 +312,14 @@ config FB_HGA
 	  As this card technology is 15 years old, most people will answer N
 	  here.
 
+config FB_HGA_ACCEL
+	bool "Hercules mono Acceleration functions (EXPERIMENTAL)"
+	depends on FB_HGA && EXPERIMENTAL
+	---help---
+	This will compile the Hercules mono graphics with
+	acceleration functions.
+
+
 config VIDEO_SELECT
 	bool
 	depends on FB && X86
-- 
Luiz Fernando N. Capitulino
<http://www.telecentros.sp.gov.br>


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
