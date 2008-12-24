From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 02/05] video: deferred io sys helpers - sh_mobile_lcdcfb V2
Date: Wed, 24 Dec 2008 17:30:01 +0900
Message-ID: <20081224083001.1848.97506.sendpatchset@rx1.opensource.se>
References: <20081224082946.1848.46644.sendpatchset@rx1.opensource.se>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20081224082946.1848.46644.sendpatchset@rx1.opensource.se>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: aliguori@us.ibm.com, adaplas@gmail.com, linux-sh@vger.kernel.org, armbru@redhat.com, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, jayakumar.lkml@gmail.com

From: Magnus Damm <damm@igel.co.jp>

Change the sh_mobile_lcdcfb driver to use the new shared sys helpers.
This allows us to remove some code.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Changes since V1:
 - remove sysdelay

 drivers/video/Kconfig            |    4 ---
 drivers/video/sh_mobile_lcdcfb.c |   39 ++++----------------------------------
 2 files changed, 5 insertions(+), 38 deletions(-)

--- 0002/drivers/video/Kconfig
+++ work/drivers/video/Kconfig	2008-12-24 16:29:02.000000000 +0900
@@ -1893,10 +1893,6 @@ config FB_W100
 config FB_SH_MOBILE_LCDC
 	tristate "SuperH Mobile LCDC framebuffer support"
 	depends on FB && SUPERH
-	select FB_SYS_FILLRECT
-	select FB_SYS_COPYAREA
-	select FB_SYS_IMAGEBLIT
-	select FB_SYS_FOPS
 	select FB_DEFERRED_IO
 	---help---
 	  Frame buffer driver for the on-chip SH-Mobile LCD controller.
--- 0001/drivers/video/sh_mobile_lcdcfb.c
+++ work/drivers/video/sh_mobile_lcdcfb.c	2008-12-24 16:29:09.000000000 +0900
@@ -215,14 +215,6 @@ static void sh_mobile_lcdc_deferred_io(s
 	lcdc_write_chan(ch, LDSM2R, 1);
 }
 
-static void sh_mobile_lcdc_deferred_io_touch(struct fb_info *info)
-{
-	struct fb_deferred_io *fbdefio = info->fbdefio;
-
-	if (fbdefio)
-		schedule_delayed_work(&info->deferred_work, fbdefio->delay);
-}
-
 static irqreturn_t sh_mobile_lcdc_irq(int irq, void *data)
 {
 	struct sh_mobile_lcdc_priv *priv = data;
@@ -586,34 +578,13 @@ static struct fb_fix_screeninfo sh_mobil
 	.accel =	FB_ACCEL_NONE,
 };
 
-static void sh_mobile_lcdc_fillrect(struct fb_info *info,
-				    const struct fb_fillrect *rect)
-{
-	sys_fillrect(info, rect);
-	sh_mobile_lcdc_deferred_io_touch(info);
-}
-
-static void sh_mobile_lcdc_copyarea(struct fb_info *info,
-				    const struct fb_copyarea *area)
-{
-	sys_copyarea(info, area);
-	sh_mobile_lcdc_deferred_io_touch(info);
-}
-
-static void sh_mobile_lcdc_imageblit(struct fb_info *info,
-				     const struct fb_image *image)
-{
-	sys_imageblit(info, image);
-	sh_mobile_lcdc_deferred_io_touch(info);
-}
-
 static struct fb_ops sh_mobile_lcdc_ops = {
 	.fb_setcolreg	= sh_mobile_lcdc_setcolreg,
-	.fb_read        = fb_sys_read,
-	.fb_write       = fb_sys_write,
-	.fb_fillrect	= sh_mobile_lcdc_fillrect,
-	.fb_copyarea	= sh_mobile_lcdc_copyarea,
-	.fb_imageblit	= sh_mobile_lcdc_imageblit,
+	.fb_read        = fb_deferred_io_read,
+	.fb_write       = fb_deferred_io_write,
+	.fb_fillrect	= fb_deferred_io_fillrect,
+	.fb_copyarea	= fb_deferred_io_copyarea,
+	.fb_imageblit	= fb_deferred_io_imageblit,
 };
 
 static int sh_mobile_lcdc_set_bpp(struct fb_var_screeninfo *var, int bpp)
