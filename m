From: "eric miao" <eric.y.miao@gmail.com>
Subject: [PATCH 1/4] pxafb: introduce lcd_{read,
	write}l() to wrap the __raw_{read, write}l()
Date: Tue, 8 Apr 2008 12:03:16 +0800
Message-ID: <f17812d70804072103s4fa2b6d4t57abfcda9d8e0b11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jj53I-00040P-GP for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 Apr 2008 21:03:20 -0700
Received: from wa-out-1112.google.com ([209.85.146.176])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jj53H-0002Tk-3E
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 Apr 2008 21:03:20 -0700
Received: by wa-out-1112.google.com with SMTP id k22so1774688waf.18
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 07 Apr 2008 21:03:17 -0700 (PDT)
Content-Disposition: inline
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
To: linux-arm-kernel email list <linux-arm-kernel@lists.arm.linux.org.uk>, linux-fbdev-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

From 917ed27ddcaca455f7799f74a1db9a4497725de8 Mon Sep 17 00:00:00 2001
From: Eric Miao <eric.miao@marvell.com>
Date: Thu, 27 Mar 2008 09:28:32 +0800
Subject: [PATCH] pxafb: introduce lcd_{read,write}l() to wrap the
__raw_{read,write}l()

using __raw_{read,write}l() everywhere looks messy, introduce
lcd_{read,write}l() to get this cleaned up a bit

Signed-off-by: eric miao <eric.miao@marvell.com>
---
 drivers/video/pxafb.c |   50 +++++++++++++++++++++++++-----------------------
 1 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 0031a5f..27d9fed 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -64,6 +64,9 @@
 #define LCCR3_INVALID_CONFIG_MASK	(LCCR3_HSP | LCCR3_VSP |\
 					 LCCR3_PCD | LCCR3_BPP)

+#define lcd_readl(f, off)	__raw_readl((f)->mmio_base + (off))
+#define lcd_writel(f, off, v)	__raw_writel((v), (f)->mmio_base + (off))
+
 static void (*pxafb_backlight_power)(int);
 static void (*pxafb_lcd_power)(int, struct fb_var_screeninfo *);

@@ -684,8 +687,7 @@ static int pxafb_activate_var(struct fb_var_screeninfo *var,
 	fbi->reg_lccr1 = new_regs.lccr1;
 	fbi->reg_lccr2 = new_regs.lccr2;
 	fbi->reg_lccr3 = new_regs.lccr3;
-	fbi->reg_lccr4 = __raw_readl(fbi->mmio_base + LCCR4) &
-				(~LCCR4_PAL_FOR_MASK);
+	fbi->reg_lccr4 = lcd_readl(fbi, LCCR4) & ~LCCR4_PAL_FOR_MASK;
 	fbi->reg_lccr4 |= (fbi->lccr4 & LCCR4_PAL_FOR_MASK);
 	set_hsync_time(fbi, pcd);
 	local_irq_restore(flags);
@@ -694,12 +696,12 @@ static int pxafb_activate_var(struct
fb_var_screeninfo *var,
 	 * Only update the registers if the controller is enabled
 	 * and something has changed.
 	 */
-	if ((__raw_readl(fbi->mmio_base + LCCR0) != fbi->reg_lccr0) ||
-	    (__raw_readl(fbi->mmio_base + LCCR1) != fbi->reg_lccr1) ||
-	    (__raw_readl(fbi->mmio_base + LCCR2) != fbi->reg_lccr2) ||
-	    (__raw_readl(fbi->mmio_base + LCCR3) != fbi->reg_lccr3) ||
-	    (__raw_readl(fbi->mmio_base + FDADR0) != fbi->fdadr[0]) ||
-	    (__raw_readl(fbi->mmio_base + FDADR1) != fbi->fdadr[1]))
+	if ((lcd_readl(fbi, LCCR0) != fbi->reg_lccr0) ||
+	    (lcd_readl(fbi, LCCR1) != fbi->reg_lccr1) ||
+	    (lcd_readl(fbi, LCCR2) != fbi->reg_lccr2) ||
+	    (lcd_readl(fbi, LCCR3) != fbi->reg_lccr3) ||
+	    (lcd_readl(fbi, FDADR0) != fbi->fdadr[0]) ||
+	    (lcd_readl(fbi, FDADR1) != fbi->fdadr[1]))
 		pxafb_schedule_work(fbi, C_REENABLE);

 	return 0;
@@ -785,14 +787,14 @@ static void pxafb_enable_controller(struct
pxafb_info *fbi)
 	clk_enable(fbi->clk);

 	/* Sequence from 11.7.10 */
-	__raw_writel(fbi->reg_lccr3, fbi->mmio_base + LCCR3);
-	__raw_writel(fbi->reg_lccr2, fbi->mmio_base + LCCR2);
-	__raw_writel(fbi->reg_lccr1, fbi->mmio_base + LCCR1);
-	__raw_writel(fbi->reg_lccr0 & ~LCCR0_ENB, fbi->mmio_base + LCCR0);
-
-	__raw_writel(fbi->fdadr[0], fbi->mmio_base + FDADR0);
-	__raw_writel(fbi->fdadr[1], fbi->mmio_base + FDADR1);
-	__raw_writel(fbi->reg_lccr0 | LCCR0_ENB, fbi->mmio_base + LCCR0);
+	lcd_writel(fbi, LCCR3, fbi->reg_lccr3);
+	lcd_writel(fbi, LCCR2, fbi->reg_lccr2);
+	lcd_writel(fbi, LCCR1, fbi->reg_lccr1);
+	lcd_writel(fbi, LCCR0, fbi->reg_lccr0 & ~LCCR0_ENB);
+
+	lcd_writel(fbi, FDADR0, fbi->fdadr[0]);
+	lcd_writel(fbi, FDADR1, fbi->fdadr[1]);
+	lcd_writel(fbi, LCCR0, fbi->reg_lccr0 | LCCR0_ENB);
 }

 static void pxafb_disable_controller(struct pxafb_info *fbi)
@@ -805,11 +807,11 @@ static void pxafb_disable_controller(struct
pxafb_info *fbi)
 	add_wait_queue(&fbi->ctrlr_wait, &wait);

 	/* Clear LCD Status Register */
-	__raw_writel(0xffffffff, fbi->mmio_base + LCSR);
+	lcd_writel(fbi, LCSR, 0xffffffff);

-	lccr0 = __raw_readl(fbi->mmio_base + LCCR0) & ~LCCR0_LDM;
-	__raw_writel(lccr0, fbi->mmio_base + LCCR0);
-	__raw_writel(lccr0 | LCCR0_DIS, fbi->mmio_base + LCCR0);
+	lccr0 = lcd_readl(fbi, LCCR0) & ~LCCR0_LDM;
+	lcd_writel(fbi, LCCR0, lccr0);
+	lcd_writel(fbi, LCCR0, lccr0 | LCCR0_DIS);

 	schedule_timeout(200 * HZ / 1000);
 	remove_wait_queue(&fbi->ctrlr_wait, &wait);
@@ -824,15 +826,15 @@ static void pxafb_disable_controller(struct
pxafb_info *fbi)
 static irqreturn_t pxafb_handle_irq(int irq, void *dev_id)
 {
 	struct pxafb_info *fbi = dev_id;
-	unsigned int lccr0, lcsr = __raw_readl(fbi->mmio_base + LCSR);
+	unsigned int lccr0, lcsr = lcd_readl(fbi, LCSR);

 	if (lcsr & LCSR_LDD) {
-		lccr0 = __raw_readl(fbi->mmio_base + LCCR0) | LCCR0_LDM;
-		__raw_writel(lccr0, fbi->mmio_base + LCCR0);
+		lccr0 = lcd_readl(fbi, LCCR0);
+		lcd_writel(fbi, LCCR0, lccr0 | LCCR0_LDM);
 		wake_up(&fbi->ctrlr_wait);
 	}

-	__raw_writel(lcsr, fbi->mmio_base + LCSR);
+	lcd_writel(fbi, LCSR, lcsr);
 	return IRQ_HANDLED;
 }

-- 
1.5.4.3



-- 
Cheers
- eric

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
