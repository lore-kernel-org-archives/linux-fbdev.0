From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [RFC/PATCH] atmel_lcdfb: Don't initialize a
	pre-allocated framebuffer
Date: Thu, 29 Nov 2007 15:41:18 +0100
Message-ID: <1196347278-1184-1-git-send-email-hskinnemoen@atmel.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IxkZz-0006fS-Hq for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 29 Nov 2007 06:41:27 -0800
Received: from nat-132.atmel.no ([80.232.32.132] helo=relay.atmel.no)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IxkZy-0001ei-QL
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 29 Nov 2007 06:41:27 -0800
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: kernel@avr32linux.org, linux-fbdev-devel@lists.sourceforge.net, linux@maxim.org.za

If the user specified a fixed framebuffer address on the command line,
it may have been initialized already with a splash image or something,
so we shouldn't clear it.

Therefore, we should only initialize the framebuffer if we allocated
it ourselves. This patch also updates the AVR32 setup code to clear
the framebuffer if it allocated it itself, i.e. the user didn't
provide a fixed address or the reservation failed.

I've updated the at91 platform code as well so that it initializes the
framebuffer if it is located in SRAM, but I haven't tested that it
actually works.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/arm/mach-at91/at91sam9261_devices.c |   11 +++++++++++
 arch/arm/mach-at91/at91sam9rl_devices.c  |   14 ++++++++++++++
 arch/avr32/kernel/setup.c                |    2 ++
 drivers/video/atmel_lcdfb.c              |    8 +++++++-
 4 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index 3576595..a72c006 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -494,6 +494,17 @@ void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data)
 	at91_set_B_periph(AT91_PIN_PB27, 0);	/* LCDD22 */
 	at91_set_B_periph(AT91_PIN_PB28, 0);	/* LCDD23 */
 
+	if (ARRAY_SIZE(lcdc_resources) > 2) {
+		void __iomem *fb;
+		struct resource *fb_res = &lcdc_resources[2];
+		size_t fb_len = fb_res->end - fb_res->start + 1;
+
+		fb = ioremap_writecombine(fb_res->start, fb_len);
+		if (fb) {
+			memset(fb, 0, fb_len);
+			iounmap(fb, fb_len);
+		}
+	}
 	lcdc_data = *data;
 	platform_device_register(&at91_lcdc_device);
 }
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index cd7532b..0ceb87a 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -340,6 +340,20 @@ void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data)
 	at91_set_B_periph(AT91_PIN_PC24, 0);	/* LCDD22 */
 	at91_set_B_periph(AT91_PIN_PC25, 0);	/* LCDD23 */
 
+#ifdef CONFIG_FB_INTSRAM
+	{
+		void __iomem *fb;
+		struct resource *fb_res = &lcdc_resources[2];
+		size_t fb_len = fb_res->end - fb_res->start + 1;
+
+		fb = ioremap_writecombine(fb_res->start, fb_len);
+		if (fb) {
+			memset(fb, 0, fb_len);
+			iounmap(fb, fb_len);
+		}
+	}
+#endif
+
 	lcdc_data = *data;
 	platform_device_register(&at91_lcdc_device);
 }
diff --git a/arch/avr32/kernel/setup.c b/arch/avr32/kernel/setup.c
index 4b4c188..488078d 100644
--- a/arch/avr32/kernel/setup.c
+++ b/arch/avr32/kernel/setup.c
@@ -273,6 +273,8 @@ static int __init early_parse_fbmem(char *p)
 			printk(KERN_WARNING
 			       "Failed to allocate framebuffer memory\n");
 			fbmem_size = 0;
+		} else {
+			memset(__va(fbmem_start), 0, fbmem_size);
 		}
 	}
 
diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index 12da65e..138a367 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -150,6 +150,8 @@ static int atmel_lcdfb_alloc_video_memory(struct atmel_lcdfb_info *sinfo)
 		return -ENOMEM;
 	}
 
+	memset(info->screen_base, 0, info->fix.smem_len);
+
 	return 0;
 }
 
@@ -534,7 +536,6 @@ static int __init atmel_lcdfb_init_fbinfo(struct atmel_lcdfb_info *sinfo)
 	struct fb_info *info = sinfo->info;
 	int ret = 0;
 
-	memset_io(info->screen_base, 0, info->fix.smem_len);
 	info->var.activate |= FB_ACTIVATE_FORCE | FB_ACTIVATE_NOW;
 
 	dev_info(info->device,
@@ -663,6 +664,11 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
 		info->screen_base = ioremap(info->fix.smem_start, info->fix.smem_len);
 		if (!info->screen_base)
 			goto release_intmem;
+
+		/*
+		 * Don't clear the framebuffer -- someone may have set
+		 * up a splash image.
+		 */
 	} else {
 		/* alocate memory buffer */
 		ret = atmel_lcdfb_alloc_video_memory(sinfo);
-- 
1.5.3.4


-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
