From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: [PATCH 2/2] pxafb: remove now unused
	pxafb_setup_gpio() and related stuffs
Date: Thu, 11 Dec 2008 17:06:21 +0800
Message-ID: <f17812d70812110106h47a53304nb02b14391aee77bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <eric.y.miao@gmail.com>) id 1LAhV7-00084j-SY
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 11 Dec 2008 09:06:29 +0000
Received: from rv-out-0708.google.com ([209.85.198.244])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LAhV5-0005uL-K7 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 11 Dec 2008 09:06:29 +0000
Received: by rv-out-0708.google.com with SMTP id f25so783555rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 11 Dec 2008 01:06:21 -0800 (PST)
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net, Ian Molton <spyro@f2s.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, pHilipp Zabel <philipp.zabel@gmail.com>, Marc Zyngier <maz@misterjones.org>, Juergen Schindele <linux@schindele.name>, Jaya Kumar <jayakumar.lkml@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Stefan Schmidt <stefan@datenfreihafen.org>

From ad6c7f8030e440049c152af25fa59c6fcd0336e7 Mon Sep 17 00:00:00 2001
From: Eric Miao <eric.miao@marvell.com>
Date: Thu, 11 Dec 2008 14:06:43 +0800
Subject: [PATCH] [ARM] pxafb: remove now unused pxafb_setup_gpio() and
related stuffs

platform should now initialize the pin usage for the LCD controller
to correctly work.

Signed-off-by: Eric Miao <eric.miao@marvell.com>
Cc: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: Mike Rapoport <mike@compulab.co.il>
Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: Ian Molton <spyro@f2s.com>
Cc: Philipp Zabel <philipp.zabel@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@pengutronix.de>
Cc: Marc Zyngier <marc.zyngier@altran.com>
Cc: Jrgen Schindele <linux@schindele.name>
---
 drivers/video/pxafb.c |   54 -------------------------------------------------
 1 files changed, 0 insertions(+), 54 deletions(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index d6aa07b..ab60537 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -50,7 +50,6 @@
 #include <asm/irq.h>
 #include <asm/div64.h>
 #include <mach/pxa-regs.h>
-#include <mach/pxa2xx-gpio.h>
 #include <mach/bitfield.h>
 #include <mach/pxafb.h>

@@ -986,57 +985,6 @@ static inline void __pxafb_lcd_power(struct
pxafb_info *fbi, int on)
 		fbi->lcd_power(on, &fbi->fb.var);
 }

-static void pxafb_setup_gpio(struct pxafb_info *fbi)
-{
-	int gpio, ldd_bits;
-	unsigned int lccr0 = fbi->lccr0;
-
-	/*
-	 * setup is based on type of panel supported
-	 */
-
-	/* 4 bit interface */
-	if ((lccr0 & LCCR0_CMS) == LCCR0_Mono &&
-	    (lccr0 & LCCR0_SDS) == LCCR0_Sngl &&
-	    (lccr0 & LCCR0_DPD) == LCCR0_4PixMono)
-		ldd_bits = 4;
-
-	/* 8 bit interface */
-	else if (((lccr0 & LCCR0_CMS) == LCCR0_Mono &&
-		  ((lccr0 & LCCR0_SDS) == LCCR0_Dual ||
-		   (lccr0 & LCCR0_DPD) == LCCR0_8PixMono)) ||
-		 ((lccr0 & LCCR0_CMS) == LCCR0_Color &&
-		  (lccr0 & LCCR0_PAS) == LCCR0_Pas &&
-		  (lccr0 & LCCR0_SDS) == LCCR0_Sngl))
-		ldd_bits = 8;
-
-	/* 16 bit interface */
-	else if ((lccr0 & LCCR0_CMS) == LCCR0_Color &&
-		 ((lccr0 & LCCR0_SDS) == LCCR0_Dual ||
-		  (lccr0 & LCCR0_PAS) == LCCR0_Act))
-		ldd_bits = 16;
-
-	else {
-		printk(KERN_ERR "pxafb_setup_gpio: unable to determine "
-			       "bits per pixel\n");
-		return;
-	}
-
-	for (gpio = 58; ldd_bits; gpio++, ldd_bits--)
-		pxa_gpio_mode(gpio | GPIO_ALT_FN_2_OUT);
-	/* 18 bit interface */
-	if (fbi->fb.var.bits_per_pixel > 16) {
-		pxa_gpio_mode(86 | GPIO_ALT_FN_2_OUT);
-		pxa_gpio_mode(87 | GPIO_ALT_FN_2_OUT);
-	}
-	pxa_gpio_mode(GPIO74_LCD_FCLK_MD);
-	pxa_gpio_mode(GPIO75_LCD_LCLK_MD);
-	pxa_gpio_mode(GPIO76_LCD_PCLK_MD);
-
-	if ((lccr0 & LCCR0_PAS) == 0)
-		pxa_gpio_mode(GPIO77_LCD_ACBIAS_MD);
-}
-
 static void pxafb_enable_controller(struct pxafb_info *fbi)
 {
 	pr_debug("pxafb: Enabling LCD controller\n");
@@ -1179,7 +1127,6 @@ static void set_ctrlr_state(struct pxafb_info
*fbi, u_int state)
 		if (old_state == C_ENABLE) {
 			__pxafb_lcd_power(fbi, 0);
 			pxafb_disable_controller(fbi);
-			pxafb_setup_gpio(fbi);
 			pxafb_enable_controller(fbi);
 			__pxafb_lcd_power(fbi, 1);
 		}
@@ -1202,7 +1149,6 @@ static void set_ctrlr_state(struct pxafb_info
*fbi, u_int state)
 		 */
 		if (old_state != C_ENABLE) {
 			fbi->state = C_ENABLE;
-			pxafb_setup_gpio(fbi);
 			pxafb_enable_controller(fbi);
 			__pxafb_lcd_power(fbi, 1);
 			__pxafb_backlight_power(fbi, 1);
-- 
1.6.0.4

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
