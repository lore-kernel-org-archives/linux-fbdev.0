From: "Maciej W. Rozycki" <macro@linux-mips.org>
Date: Mon, 22 Feb 2016 01:55:17 +0000
Subject: [PATCH 4/7] video: fbdev: bt455: Remove unneeded colormap helpers for cursor support
Message-Id: <alpine.LFD.2.20.1602220139280.7431@eddie.linux-mips.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LFD.2.20.1602220110330.7431@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.20.1602220110330.7431@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-bt455-cursor.diff
Index: linux-20160211-4maxp64/drivers/video/fbdev/bt455.h
=================================--- linux-20160211-4maxp64.orig/drivers/video/fbdev/bt455.h
+++ linux-20160211-4maxp64/drivers/video/fbdev/bt455.h
@@ -67,28 +67,3 @@ static inline void bt455_write_ovly_entr
 	wmb();
 	regs->addr_ovly = blue & 0x0f;
 }
-
-static inline void bt455_set_cursor(struct bt455_regs *regs)
-{
-	mb();
-	regs->addr_ovly = 0x0f;
-	wmb();
-	regs->addr_ovly = 0x0f;
-	wmb();
-	regs->addr_ovly = 0x0f;
-}
-
-static inline void bt455_erase_cursor(struct bt455_regs *regs)
-{
-	/* bt455_write_cmap_entry(regs, 8, 0x00, 0x00, 0x00); */
-	/* bt455_write_cmap_entry(regs, 9, 0x00, 0x00, 0x00); */
-	bt455_write_ovly_entry(regs, 8, 0x03, 0x03, 0x03);
-	bt455_write_ovly_entry(regs, 9, 0x07, 0x07, 0x07);
-
-	wmb();
-	regs->addr_ovly = 0x09;
-	wmb();
-	regs->addr_ovly = 0x09;
-	wmb();
-	regs->addr_ovly = 0x09;
-}
