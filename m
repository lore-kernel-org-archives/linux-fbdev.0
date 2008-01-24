From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [Linux-fbdev-devel] [PATCH] atmel_lcdfb: backlight control -
 tiny rework
Date: Thu, 24 Jan 2008 10:30:44 +0100
Message-ID: <47985AC4.9070104@atmel.com>
References: <4790BB53.3080407@atmel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754805AbYAXJbk@vger.kernel.org>
In-Reply-To: <4790BB53.3080407@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, David Brownell <david-b@pacbell.net>, Andrew Victor <linux@maxim.org.za>, ARM Linux Mailing List <linux-arm-kernel@lists.arm.linux.org.uk>

Tiny patch that removes not needed "inline" and renames 
function : exit_contrast() -> exit_backlight().
It adds the missing exit_backlight() in  probe() 
error path.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Follows comments from Andrew Morton and Haavard Skinnemoen.
Thanks to both of you.

 drivers/video/atmel_lcdfb.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -118,7 +118,7 @@ static struct backlight_ops atmel_lcdc_b
 	.get_brightness = atmel_bl_get_brightness,
 };
 
-static inline void init_backlight(struct atmel_lcdfb_info *sinfo)
+static void init_backlight(struct atmel_lcdfb_info *sinfo)
 {
 	struct backlight_device	*bl;
 
@@ -142,7 +142,7 @@ static inline void init_backlight(struct
 	bl->props.brightness = atmel_bl_get_brightness(bl);
 }
 
-static inline void exit_contrast(struct atmel_lcdfb_info *sinfo)
+static void exit_backlight(struct atmel_lcdfb_info *sinfo)
 {
 	if (sinfo->backlight)
 		backlight_device_unregister(sinfo->backlight);
@@ -150,18 +150,18 @@ static inline void exit_contrast(struct 
 
 #else
 
-static inline void init_backlight(struct atmel_lcdfb_info *sinfo)
+static void init_backlight(struct atmel_lcdfb_info *sinfo)
 {
 	dev_warn(&sinfo->pdev->dev, "backlight control is not available\n");
 }
 
-static inline void exit_contrast(struct atmel_lcdfb_info *sinfo)
+static void exit_backlight(struct atmel_lcdfb_info *sinfo)
 {
 }
 
 #endif
 
-static inline void init_contrast(struct atmel_lcdfb_info *sinfo)
+static void init_contrast(struct atmel_lcdfb_info *sinfo)
 {
 	/* have some default contrast/backlight settings */
 	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR, contrast_ctr);
@@ -823,6 +823,7 @@ free_cmap:
 unregister_irqs:
 	free_irq(sinfo->irq_base, info);
 unmap_mmio:
+	exit_backlight(sinfo);
 	iounmap(sinfo->mmio);
 release_mem:
  	release_mem_region(info->fix.mmio_start, info->fix.mmio_len);
@@ -857,7 +858,7 @@ static int __exit atmel_lcdfb_remove(str
 	if (!sinfo)
 		return 0;
 
-	exit_contrast(sinfo);
+	exit_backlight(sinfo);
 	if (sinfo->atmel_lcdfb_power_control)
 		sinfo->atmel_lcdfb_power_control(0);
 	unregister_framebuffer(info);
