From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
Subject: [PATCH] - video/hgafb.c warning fix.
Date: Mon, 19 Apr 2004 17:09:34 -0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040419170934.700d2c0a.lcapitulino@prefeitura.sp.gov.br>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BFf7Z-0000R7-Lt
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 19 Apr 2004 13:12:01 -0700
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BFf7Z-0004SJ-7i
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 19 Apr 2004 13:12:01 -0700
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

 It is the something of video/tridentfb.c: accelerations
functions which can be selected by the user. The patch also
fixes the warnings:

drivers/video/hgafb.c:452: warning: `hgafb_fillrect' defined but not used
drivers/video/hgafb.c:472: warning: `hgafb_copyarea' defined but not used
drivers/video/hgafb.c:502: warning: `hgafb_imageblit' defined but not used

 Here is the patch:

 drivers/video/Kconfig |    8 ++++++++
 drivers/video/hgafb.c |   15 ++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)


diff -X dontdiff -Nparu a/drivers/video/hgafb.c a~/drivers/video/hgafb.c
--- a/drivers/video/hgafb.c	2004-01-09 10:30:36.000000000 -0200
+++ a~/drivers/video/hgafb.c	2004-04-16 20:58:49.000000000 -0300
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
--- a/drivers/video/Kconfig	2004-04-16 20:03:09.000000000 -0300
+++ a~/drivers/video/Kconfig	2004-04-16 20:57:56.000000000 -0300
@@ -308,6 +308,14 @@ config FB_HGA
 	  As this card technology is 15 years old, most people will answer N
 	  here.
 
+config FB_HGA_ACCEL
+	bool "Hercules mono Acceleration functions (EXPERIMENTAL)"
+	depends on FB_HGA
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
<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
