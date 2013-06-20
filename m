From: Randy Dunlap <rdunlap@infradead.org>
Date: Thu, 20 Jun 2013 02:39:18 +0000
Subject: [PATCH 2/2] fb: fix atyfb unused data warnings
Message-Id: <51C26B56.20802@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

From: Randy Dunlap <rdunlap@infradead.org>

Fix compiler warnings of data defined but not used.  They are only used
with certain kconfig settings.

drivers/video/aty/atyfb_base.c:534:13: warning: 'ram_dram' defined but not used [-Wunused-variable]
drivers/video/aty/atyfb_base.c:535:13: warning: 'ram_resv' defined but not used [-Wunused-variable]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc:	Paul Mackerras <paulus@samba.org>
Cc:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:	linux-fbdev@vger.kernel.org
Cc:	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc:	Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/aty/atyfb_base.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20130619.orig/drivers/video/aty/atyfb_base.c
+++ linux-next-20130619/drivers/video/aty/atyfb_base.c
@@ -531,8 +531,10 @@ static int correct_chipset(struct atyfb_
 	return 0;
 }
 
+#if defined(CONFIG_FB_ATY_GX) || defined(CONFIG_FB_ATY_CT)
 static char ram_dram[] = "DRAM";
 static char ram_resv[] = "RESV";
+#endif
 #ifdef CONFIG_FB_ATY_GX
 static char ram_vram[] = "VRAM";
 #endif /* CONFIG_FB_ATY_GX */
