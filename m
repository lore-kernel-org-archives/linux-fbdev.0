From: Andrew Morton <akpm@osdl.org>
Subject: Re: Re: [PATCH] - video/tdfxfb.c warning fix.
Date: Sat, 1 May 2004 12:09:36 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040501120936.62c6db39.akpm@osdl.org>
References: <20040430180451.GA3119@lorien.prodam>
	<20040430213513.7bafde36.akpm@osdl.org>
	<Pine.GSO.4.58.0405012045070.25805@waterleaf.sonytel.be>
	<20040501120852.139b4ac1.akpm@osdl.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJzsA-0004Mr-GR
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 01 May 2004 12:10:02 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJzs6-0006i9-ST
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 01 May 2004 12:09:58 -0700
In-Reply-To: <20040501120852.139b4ac1.akpm@osdl.org>
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
To: geert@linux-m68k.org, lcapitulino@prefeitura.sp.gov.br, jsimmons@infradead.org, linux-fbdev-devel@lists.sourceforge.net

Andrew Morton <akpm@osdl.org> wrote:
>
>  Does the same argument apply to this patch?
> 

And to this one?


From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>

Make HGA acceleration functions selectable in kernel config, fix these
warnings:

drivers/video/hgafb.c:452: warning: `hgafb_fillrect' defined but not used
drivers/video/hgafb.c:472: warning: `hgafb_copyarea' defined but not used
drivers/video/hgafb.c:502: warning: `hgafb_imageblit' defined but not used


---

 25-akpm/drivers/video/Kconfig |    8 ++++++++
 25-akpm/drivers/video/hgafb.c |   15 ++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff -puN drivers/video/hgafb.c~hgafbc-warning-fix drivers/video/hgafb.c
--- 25/drivers/video/hgafb.c~hgafbc-warning-fix	2004-04-30 21:30:31.788284368 -0700
+++ 25-akpm/drivers/video/hgafb.c	2004-04-30 21:30:31.793283608 -0700
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
diff -puN drivers/video/Kconfig~hgafbc-warning-fix drivers/video/Kconfig
--- 25/drivers/video/Kconfig~hgafbc-warning-fix	2004-04-30 21:30:31.789284216 -0700
+++ 25-akpm/drivers/video/Kconfig	2004-04-30 21:30:31.794283456 -0700
@@ -308,6 +308,14 @@ config FB_HGA
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

_



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
