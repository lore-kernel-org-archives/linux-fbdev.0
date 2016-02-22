From: "Maciej W. Rozycki" <macro@linux-mips.org>
Date: Mon, 22 Feb 2016 01:55:21 +0000
Subject: [PATCH 5/7] video: fbdev: pmag-ba-fb: Fix and rework Bt455 colormap handling
Message-Id: <alpine.LFD.2.20.1602220140120.7431@eddie.linux-mips.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LFD.2.20.1602220110330.7431@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.20.1602220110330.7431@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

The Bt455 is a greyscale RAMDAC, using the green color palette entries 
only while still providing registers for the red and blue components, 
all the three of which have to be loaded on palette updates.  Chip 
documentation [1] mandates that the unused red and blue registers are 
written with 0.

Therefore update code to follow this requirement and given that it makes 
the red and blue components unusable remove them from internal API calls 
altogether.

References:

[1] "Bt454 Bt455 170 MHz Monolithic CMOS 16 Color Palette RAMDAC",
    Brooktree Corporation, Document Number: L454001, Rev. I

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-bt455-cmap-grey.diff
Index: linux-20160211-4maxp64/drivers/video/fbdev/bt455.h
=================================--- linux-20160211-4maxp64.orig/drivers/video/fbdev/bt455.h
+++ linux-20160211-4maxp64/drivers/video/fbdev/bt455.h
@@ -2,6 +2,7 @@
  *	linux/drivers/video/bt455.h
  *
  *	Copyright 2003  Thiemo Seufer <seufer@csv.ica.uni-stuttgart.de>
+ *	Copyright 2016  Maciej W. Rozycki <macro@linux-mips.org>
  *
  *	This file is subject to the terms and conditions of the GNU General
  *	Public License. See the file COPYING in the main directory of this
@@ -32,38 +33,38 @@ static inline void bt455_select_reg(stru
 /*
  * Read/write to a Bt455 color map register.
  */
-static inline void bt455_read_cmap_entry(struct bt455_regs *regs, int cr,
-					 u8* red, u8* green, u8* blue)
+static inline void bt455_read_cmap_entry(struct bt455_regs *regs,
+					 int cr, u8 *grey)
 {
 	bt455_select_reg(regs, cr);
 	mb();
-	*red = regs->addr_cmap_data & 0x0f;
+	regs->addr_cmap_data;
 	rmb();
-	*green = regs->addr_cmap_data & 0x0f;
+	*grey = regs->addr_cmap_data & 0xf;
 	rmb();
-	*blue = regs->addr_cmap_data & 0x0f;
+	regs->addr_cmap_data;
 }
 
-static inline void bt455_write_cmap_entry(struct bt455_regs *regs, int cr,
-					  u8 red, u8 green, u8 blue)
+static inline void bt455_write_cmap_entry(struct bt455_regs *regs,
+					  int cr, u8 grey)
 {
 	bt455_select_reg(regs, cr);
 	wmb();
-	regs->addr_cmap_data = red & 0x0f;
+	regs->addr_cmap_data = 0x0;
 	wmb();
-	regs->addr_cmap_data = green & 0x0f;
+	regs->addr_cmap_data = grey & 0xf;
 	wmb();
-	regs->addr_cmap_data = blue & 0x0f;
+	regs->addr_cmap_data = 0x0;
 }
 
-static inline void bt455_write_ovly_entry(struct bt455_regs *regs, int cr,
-					  u8 red, u8 green, u8 blue)
+static inline void bt455_write_ovly_entry(struct bt455_regs *regs,
+					  int cr, u8 grey)
 {
 	bt455_select_reg(regs, cr);
 	wmb();
-	regs->addr_ovly = red & 0x0f;
+	regs->addr_ovly = 0x0;
 	wmb();
-	regs->addr_ovly = green & 0x0f;
+	regs->addr_ovly = grey & 0xf;
 	wmb();
-	regs->addr_ovly = blue & 0x0f;
+	regs->addr_ovly = 0x0;
 }
Index: linux-20160211-4maxp64/drivers/video/fbdev/pmag-aa-fb.c
=================================--- linux-20160211-4maxp64.orig/drivers/video/fbdev/pmag-aa-fb.c
+++ linux-20160211-4maxp64/drivers/video/fbdev/pmag-aa-fb.c
@@ -121,9 +121,9 @@ static int aafb_cursor(struct fb_info *i
 		u8 fg = cursor->image.fg_color ? 0xf : 0x0;
 		u8 bg = cursor->image.bg_color ? 0xf : 0x0;
 
-		bt455_write_cmap_entry(par->bt455, 8, 0, bg, 0);
-		bt455_write_cmap_entry(par->bt455, 9, 0, bg, 0);
-		bt455_write_ovly_entry(par->bt455, 0, 0, fg, 0);
+		bt455_write_cmap_entry(par->bt455, 8, bg);
+		bt455_write_cmap_entry(par->bt455, 9, bg);
+		bt455_write_ovly_entry(par->bt455, 0, fg);
 	}
 	if (cursor->set & (FB_CUR_SETSIZE | FB_CUR_SETSHAPE | FB_CUR_SETIMAGE))
 		bt431_set_cursor(par->bt431,
@@ -143,7 +143,7 @@ static int aafb_blank(int blank, struct 
 	struct aafb_par *par = info->par;
 	u8 val = blank ? 0x00 : 0x0f;
 
-	bt455_write_cmap_entry(par->bt455, 1, val, val, val);
+	bt455_write_cmap_entry(par->bt455, 1, val);
 	return 0;
 }
 
@@ -211,8 +211,8 @@ static int pmagaafb_probe(struct device 
 	info->screen_size = info->fix.smem_len;
 
 	/* Init colormap. */
-	bt455_write_cmap_entry(par->bt455, 0, 0x00, 0x00, 0x00);
-	bt455_write_cmap_entry(par->bt455, 1, 0x0f, 0x0f, 0x0f);
+	bt455_write_cmap_entry(par->bt455, 0, 0x0);
+	bt455_write_cmap_entry(par->bt455, 1, 0xf);
 
 	/* Init hardware cursor. */
 	bt431_erase_cursor(par->bt431);
