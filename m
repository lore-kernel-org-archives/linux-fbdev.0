From: "Maciej W. Rozycki" <macro@linux-mips.org>
Date: Mon, 16 May 2016 23:00:12 +0000
Subject: [PATCH 2/2] video: fbdev: pmagb-b-fb: Remove bad `__init' annotation
Message-Id: <alpine.LFD.2.20.1605162329120.19898@eddie.linux-mips.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Fix:

WARNING: drivers/video/fbdev/pmagb-b-fb.o(.text+0x6dc): Section mismatch in reference from the function pmagbbfb_probe() to the function .init.text:pmagbbfb_erase_cursor()
The function pmagbbfb_probe() 
references the function __init pmagbbfb_erase_cursor().
This is often because pmagbbfb_probe lacks a __init
annotation or the annotation of pmagbbfb_erase_cursor is wrong.

-- a fallout from a missed update from commit 5b1638d94080 ("VIDEO: 
PMAGB-B: Fix section mismatch") and then commit 48c68c4f1b54 ("Drivers: 
video: remove __dev* attributes.")

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-pmagb-b-init.diff
Index: linux-20160515-declance-module/drivers/video/fbdev/pmagb-b-fb.c
=================================--- linux-20160515-declance-module.orig/drivers/video/fbdev/pmagb-b-fb.c
+++ linux-20160515-declance-module/drivers/video/fbdev/pmagb-b-fb.c
@@ -133,7 +133,7 @@ static struct fb_ops pmagbbfb_ops = {
 /*
  * Turn the hardware cursor off.
  */
-static void __init pmagbbfb_erase_cursor(struct fb_info *info)
+static void pmagbbfb_erase_cursor(struct fb_info *info)
 {
 	struct pmagbbfb_par *par = info->par;
 
