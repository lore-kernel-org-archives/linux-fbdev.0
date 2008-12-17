From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] sh_mobile_lcdc: use FB_SYS helpers instead of FB_CFB
Date: Wed, 17 Dec 2008 17:29:49 +0900
Message-ID: <20081217082949.30120.83664.sendpatchset@rx1.opensource.se>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Since the sh_mobile_lcdc hardware has the framebuffer(s) in system RAM,
use FB_SYS instead of FB_CFB. Also hook in read and write helpers.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/video/Kconfig            |    8 ++++----
 drivers/video/sh_mobile_lcdcfb.c |    8 +++++---
 2 files changed, 9 insertions(+), 7 deletions(-)

--- 0001/drivers/video/Kconfig
+++ work/drivers/video/Kconfig	2008-12-17 14:02:59.000000000 +0900
@@ -1889,10 +1889,10 @@ config FB_W100
 config FB_SH_MOBILE_LCDC
 	tristate "SuperH Mobile LCDC framebuffer support"
 	depends on FB && SUPERH
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
-	default m
+	select FB_SYS_FILLRECT
+	select FB_SYS_COPYAREA
+	select FB_SYS_IMAGEBLIT
+	select FB_SYS_FOPS
 	---help---
 	  Frame buffer driver for the on-chip SH-Mobile LCD controller.
 
--- 0001/drivers/video/sh_mobile_lcdcfb.c
+++ work/drivers/video/sh_mobile_lcdcfb.c	2008-12-17 14:04:56.000000000 +0900
@@ -499,9 +499,11 @@ static struct fb_fix_screeninfo sh_mobil
 
 static struct fb_ops sh_mobile_lcdc_ops = {
 	.fb_setcolreg	= sh_mobile_lcdc_setcolreg,
-	.fb_fillrect	= cfb_fillrect,
-	.fb_copyarea	= cfb_copyarea,
-	.fb_imageblit	= cfb_imageblit,
+	.fb_read        = fb_sys_read,
+	.fb_write       = fb_sys_write,
+	.fb_fillrect	= sys_fillrect,
+	.fb_copyarea	= sys_copyarea,
+	.fb_imageblit	= sys_imageblit,
 };
 
 static int sh_mobile_lcdc_set_bpp(struct fb_var_screeninfo *var, int bpp)
