From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: [PATCH 1/2] pxafb: add palette format support
	for LCCR4_PAL_FOR_3
Date: Thu, 18 Dec 2008 22:45:35 +0800
Message-ID: <f17812d70812180645tc156946w5306b60ba70bdae1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <eric.y.miao@gmail.com>) id 1LDK8C-0001zo-8W
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 18 Dec 2008 14:45:40 +0000
Received: from rv-out-0708.google.com ([209.85.198.250])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LDK88-0001x4-OM for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 18 Dec 2008 14:45:40 +0000
Received: by rv-out-0708.google.com with SMTP id f25so421676rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 18 Dec 2008 06:45:35 -0800 (PST)
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
Cc: linux-fbdev-devel@lists.sourceforge.net

Add the palette format support for LCCR4_PAL_FOR_3, and fix the
issue of LCCR4 being never assigned.

Signed-off-by: Eric Miao <eric.miao@marvell.com>
---
 arch/arm/mach-pxa/include/mach/regs-lcd.h |    1 +
 drivers/video/pxafb.c                     |   11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/regs-lcd.h
b/arch/arm/mach-pxa/include/mach/regs-lcd.h
index c15df55..5c52226 100644
--- a/arch/arm/mach-pxa/include/mach/regs-lcd.h
+++ b/arch/arm/mach-pxa/include/mach/regs-lcd.h
@@ -48,6 +48,7 @@
 #define LCCR4_PAL_FOR_0	(0 << 15)
 #define LCCR4_PAL_FOR_1	(1 << 15)
 #define LCCR4_PAL_FOR_2	(2 << 15)
+#define LCCR4_PAL_FOR_3	(3 << 15)
 #define LCCR4_PAL_FOR_MASK	(3 << 15)

 #define FDADR0		(0x200)	/* DMA Channel 0 Frame Descriptor Address Register */
diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index b43907d..438928e 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -155,6 +155,12 @@ pxafb_setpalettereg(u_int regno, u_int red, u_int
green, u_int blue,
 		val |= ((blue  >> 8) & 0x000000fc);
 		((u32 *)(fbi->palette_cpu))[regno] = val;
 		break;
+	case LCCR4_PAL_FOR_3:
+		val  = ((red   << 8) & 0x00ff0000);
+		val |= ((green >> 0) & 0x0000ff00);
+		val |= ((blue  >> 8) & 0x000000ff);
+		((u32 *)(fbi->palette_cpu))[regno] = val;
+		break;
 	}

 	return 0;
@@ -727,6 +733,7 @@ int pxafb_smart_flush(struct fb_info *info)
 	lcd_writel(fbi, LCCR1, fbi->reg_lccr1);
 	lcd_writel(fbi, LCCR2, fbi->reg_lccr2);
 	lcd_writel(fbi, LCCR3, fbi->reg_lccr3);
+	lcd_writel(fbi, LCCR4, fbi->reg_lccr4);
 	lcd_writel(fbi, FDADR0, fbi->fdadr[0]);
 	lcd_writel(fbi, FDADR6, fbi->fdadr[6]);

@@ -995,6 +1002,7 @@ static int pxafb_activate_var(struct
fb_var_screeninfo *var,
 	    (lcd_readl(fbi, LCCR1) != fbi->reg_lccr1) ||
 	    (lcd_readl(fbi, LCCR2) != fbi->reg_lccr2) ||
 	    (lcd_readl(fbi, LCCR3) != fbi->reg_lccr3) ||
+	    (lcd_readl(fbi, LCCR4) != fbi->reg_lccr4) ||
 	    (lcd_readl(fbi, FDADR0) != fbi->fdadr[0]) ||
 	    (lcd_readl(fbi, FDADR1) != fbi->fdadr[1]))
 		pxafb_schedule_work(fbi, C_REENABLE);
@@ -1041,6 +1049,7 @@ static void pxafb_enable_controller(struct
pxafb_info *fbi)
 		return;

 	/* Sequence from 11.7.10 */
+	lcd_writel(fbi, LCCR4, fbi->reg_lccr4);
 	lcd_writel(fbi, LCCR3, fbi->reg_lccr3);
 	lcd_writel(fbi, LCCR2, fbi->reg_lccr2);
 	lcd_writel(fbi, LCCR1, fbi->reg_lccr1);
@@ -1313,6 +1322,7 @@ static void pxafb_decode_mach_info(struct pxafb_info *fbi,

 	fbi->cmap_inverse	= inf->cmap_inverse;
 	fbi->cmap_static	= inf->cmap_static;
+	fbi->lccr4 		= inf->lccr4;

 	switch (lcd_conn & LCD_TYPE_MASK) {
 	case LCD_TYPE_MONO_STN:
@@ -1337,7 +1347,6 @@ static void pxafb_decode_mach_info(struct pxafb_info *fbi,
 		/* fall back to backward compatibility way */
 		fbi->lccr0 = inf->lccr0;
 		fbi->lccr3 = inf->lccr3;
-		fbi->lccr4 = inf->lccr4;
 		goto decode_mode;
 	}

-- 
1.6.0.4

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
