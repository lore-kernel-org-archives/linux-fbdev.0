From: "Maciej W. Rozycki" <macro@linux-mips.org>
Date: Mon, 22 Feb 2016 01:55:27 +0000
Subject: [PATCH 6/7] video: fbdev: pmag-ba-fb: Optimize Bt455 colormap addressing
Message-Id: <alpine.LFD.2.20.1602220140470.7431@eddie.linux-mips.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LFD.2.20.1602220110330.7431@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.20.1602220110330.7431@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Use the address autoincrement feature when accessing successive palette 
entries and also skip loading a palette address in overlay register 
assesses which do not use that address.  Provide a red/green/blue 
register sequencer reset helper for use in overlay register assesses 
where the state of the sequencer is not known.

References:

[1] "Bt454 Bt455 170 MHz Monolithic CMOS 16 Color Palette RAMDAC",
    Brooktree Corporation, Document Number: L454001, Rev. I

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-bt455-cmap-addr.diff
Index: linux-20160211-4maxp64/drivers/video/fbdev/bt455.h
=================================--- linux-20160211-4maxp64.orig/drivers/video/fbdev/bt455.h
+++ linux-20160211-4maxp64/drivers/video/fbdev/bt455.h
@@ -30,13 +30,17 @@ static inline void bt455_select_reg(stru
 	regs->addr_cmap = ir & 0x0f;
 }
 
+static inline void bt455_reset_reg(struct bt455_regs *regs)
+{
+	mb();
+	regs->addr_clr = 0;
+}
+
 /*
  * Read/write to a Bt455 color map register.
  */
-static inline void bt455_read_cmap_entry(struct bt455_regs *regs,
-					 int cr, u8 *grey)
+static inline void bt455_read_cmap_next(struct bt455_regs *regs, u8 *grey)
 {
-	bt455_select_reg(regs, cr);
 	mb();
 	regs->addr_cmap_data;
 	rmb();
@@ -45,10 +49,8 @@ static inline void bt455_read_cmap_entry
 	regs->addr_cmap_data;
 }
 
-static inline void bt455_write_cmap_entry(struct bt455_regs *regs,
-					  int cr, u8 grey)
+static inline void bt455_write_cmap_next(struct bt455_regs *regs, u8 grey)
 {
-	bt455_select_reg(regs, cr);
 	wmb();
 	regs->addr_cmap_data = 0x0;
 	wmb();
@@ -57,10 +59,8 @@ static inline void bt455_write_cmap_entr
 	regs->addr_cmap_data = 0x0;
 }
 
-static inline void bt455_write_ovly_entry(struct bt455_regs *regs,
-					  int cr, u8 grey)
+static inline void bt455_write_ovly_next(struct bt455_regs *regs, u8 grey)
 {
-	bt455_select_reg(regs, cr);
 	wmb();
 	regs->addr_ovly = 0x0;
 	wmb();
@@ -68,3 +68,23 @@ static inline void bt455_write_ovly_entr
 	wmb();
 	regs->addr_ovly = 0x0;
 }
+
+static inline void bt455_read_cmap_entry(struct bt455_regs *regs,
+					 int cr, u8 *grey)
+{
+	bt455_select_reg(regs, cr);
+	bt455_read_cmap_next(regs, grey);
+}
+
+static inline void bt455_write_cmap_entry(struct bt455_regs *regs,
+					  int cr, u8 grey)
+{
+	bt455_select_reg(regs, cr);
+	bt455_write_cmap_next(regs, grey);
+}
+
+static inline void bt455_write_ovly_entry(struct bt455_regs *regs, u8 grey)
+{
+	bt455_reset_reg(regs);
+	bt455_write_ovly_next(regs, grey);
+}
Index: linux-20160211-4maxp64/drivers/video/fbdev/pmag-aa-fb.c
=================================--- linux-20160211-4maxp64.orig/drivers/video/fbdev/pmag-aa-fb.c
+++ linux-20160211-4maxp64/drivers/video/fbdev/pmag-aa-fb.c
@@ -122,8 +122,8 @@ static int aafb_cursor(struct fb_info *i
 		u8 bg = cursor->image.bg_color ? 0xf : 0x0;
 
 		bt455_write_cmap_entry(par->bt455, 8, bg);
-		bt455_write_cmap_entry(par->bt455, 9, bg);
-		bt455_write_ovly_entry(par->bt455, 0, fg);
+		bt455_write_cmap_next(par->bt455, bg);
+		bt455_write_ovly_next(par->bt455, fg);
 	}
 	if (cursor->set & (FB_CUR_SETSIZE | FB_CUR_SETSHAPE | FB_CUR_SETIMAGE))
 		bt431_set_cursor(par->bt431,
@@ -212,7 +212,7 @@ static int pmagaafb_probe(struct device 
 
 	/* Init colormap. */
 	bt455_write_cmap_entry(par->bt455, 0, 0x0);
-	bt455_write_cmap_entry(par->bt455, 1, 0xf);
+	bt455_write_cmap_next(par->bt455, 0xf);
 
 	/* Init hardware cursor. */
 	bt431_erase_cursor(par->bt431);
