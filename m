From: Andrew Morton <akpm@osdl.org>
Subject: Re: Re: [PATCH] - video/tdfxfb.c warning fix.
Date: Sat, 1 May 2004 12:08:52 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040501120852.139b4ac1.akpm@osdl.org>
References: <20040430180451.GA3119@lorien.prodam>
	<20040430213513.7bafde36.akpm@osdl.org>
	<Pine.GSO.4.58.0405012045070.25805@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJzrZ-0004Br-Nm
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 01 May 2004 12:09:25 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJzrZ-0006Yk-7C
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 01 May 2004 12:09:25 -0700
In-Reply-To: <Pine.GSO.4.58.0405012045070.25805@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: lcapitulino@prefeitura.sp.gov.br, jsimmons@infradead.org, linux-fbdev-devel@lists.sourceforge.net

Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
>  > You've taken a bunch of previously-working 3d acceleration functions and
>  > made them configurable, dependent upon CONFIG_EXPERIMENTAL.
>  >
>  > What on earth for?  Will this not gratuitously break people's
>  > previously-working 3d setups?
> 
>  No, tdfxfb_cursor() was not used before, causing a compiler warning.
>  tdfxfb_cursor() may work, but we don't know, so we didn't dare to enable it by
>  default. Now the user (he who has the hardware) can enable it, and tell us
>  whether it works or not.

OK, thanks.  As you can see, it really helps if people explain this sort of
thing in their initial patch (sigh).

Does the same argument apply to this patch?


From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>

Speaking with frame buffer people, we agree with this patch to fix the
warning:

drivers/video/tridentfb.c:455: warning: `tridentfb_fillrect' defined but not used
drivers/video/tridentfb.c:473: warning: `tridentfb_copyarea' defined but not used


---

 25-akpm/drivers/video/Kconfig     |    8 ++++++++
 25-akpm/drivers/video/tridentfb.c |   13 ++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff -puN drivers/video/Kconfig~tridentfbc-warning-fix drivers/video/Kconfig
--- 25/drivers/video/Kconfig~tridentfbc-warning-fix	2004-04-30 21:31:24.595256488 -0700
+++ 25-akpm/drivers/video/Kconfig	2004-04-30 21:31:24.601255576 -0700
@@ -787,6 +787,14 @@ config FB_TRIDENT
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
diff -puN drivers/video/tridentfb.c~tridentfbc-warning-fix drivers/video/tridentfb.c
--- 25/drivers/video/tridentfb.c~tridentfbc-warning-fix	2004-04-30 21:31:24.597256184 -0700
+++ 25-akpm/drivers/video/tridentfb.c	2004-04-30 21:31:24.602255424 -0700
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

_



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
