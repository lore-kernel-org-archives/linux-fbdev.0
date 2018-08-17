From: Mikulas Patocka <mpatocka@redhat.com>
Date: Fri, 17 Aug 2018 19:26:45 +0000
Subject: [PATCH] atyfb: fix debugging printks
Message-Id: <alpine.LRH.2.02.1808171525200.31883@file01.intranet.prod.int.rdu2.redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

This patch fixes the debugging printks. Use pr_cont, so that the lines are
not broken up. Use printk when starting a new line (a long string of
pr_cont's without any printks causes missing characters in the console
output on sparc).

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/video/fbdev/aty/atyfb_base.c |   36 +++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

Index: linux-stable/drivers/video/fbdev/aty/atyfb_base.c
=================================--- linux-stable.orig/drivers/video/fbdev/aty/atyfb_base.c	2018-08-15 19:45:56.000000000 +0200
+++ linux-stable/drivers/video/fbdev/aty/atyfb_base.c	2018-08-15 20:46:52.000000000 +0200
@@ -1480,24 +1480,28 @@ static int atyfb_set_par(struct fb_info
 	base = 0x2000;
 	printk("debug atyfb: Mach64 non-shadow register values:");
 	for (i = 0; i < 256; i = i+4) {
-		if (i % 16 = 0)
-			printk("\ndebug atyfb: 0x%04X: ", base + i);
-		printk(" %08X", aty_ld_le32(i, par));
+		if (i % 16 = 0) {
+			pr_cont("\n");
+			printk("debug atyfb: 0x%04X: ", base + i);
+		}
+		pr_cont(" %08X", aty_ld_le32(i, par));
 	}
-	printk("\n\n");
+	pr_cont("\n\n");
 
 #ifdef CONFIG_FB_ATY_CT
 	/* PLL registers */
 	base = 0x00;
 	printk("debug atyfb: Mach64 PLL register values:");
 	for (i = 0; i < 64; i++) {
-		if (i % 16 = 0)
-			printk("\ndebug atyfb: 0x%02X: ", base + i);
+		if (i % 16 = 0) {
+			pr_cont("\n");
+			printk("debug atyfb: 0x%02X: ", base + i);
+		}
 		if (i % 4 = 0)
-			printk(" ");
-		printk("%02X", aty_ld_pll_ct(i, par));
+			pr_cont(" ");
+		pr_cont("%02X", aty_ld_pll_ct(i, par));
 	}
-	printk("\n\n");
+	pr_cont("\n\n");
 #endif	/* CONFIG_FB_ATY_CT */
 
 #ifdef CONFIG_FB_ATY_GENERIC_LCD
@@ -1509,19 +1513,19 @@ static int atyfb_set_par(struct fb_info
 			for (i = 0; i <= POWER_MANAGEMENT; i++) {
 				if (i = EXT_VERT_STRETCH)
 					continue;
-				printk("\ndebug atyfb: 0x%04X: ",
+				pr_cont("\ndebug atyfb: 0x%04X: ",
 				       lt_lcd_regs[i]);
-				printk(" %08X", aty_ld_lcd(i, par));
+				pr_cont(" %08X", aty_ld_lcd(i, par));
 			}
 		} else {
 			for (i = 0; i < 64; i++) {
 				if (i % 4 = 0)
-					printk("\ndebug atyfb: 0x%02X: ",
+					pr_cont("\ndebug atyfb: 0x%02X: ",
 					       base + i);
-				printk(" %08X", aty_ld_lcd(i, par));
+				pr_cont(" %08X", aty_ld_lcd(i, par));
 			}
 		}
-		printk("\n\n");
+		pr_cont("\n\n");
 	}
 #endif /* CONFIG_FB_ATY_GENERIC_LCD */
 }
@@ -2597,8 +2601,8 @@ static int aty_init(struct fb_info *info
 		       aty_ld_le32(DSP_ON_OFF, par),
 		       aty_ld_le32(CLOCK_CNTL, par));
 		for (i = 0; i < 40; i++)
-			printk(" %02x", aty_ld_pll_ct(i, par));
-		printk("\n");
+			pr_cont(" %02x", aty_ld_pll_ct(i, par));
+		pr_cont("\n");
 	}
 #endif
 	if (par->pll_ops->init_pll)
