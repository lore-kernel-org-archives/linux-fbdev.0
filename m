From: "Maciej W. Rozycki" <macro@linux-mips.org>
Date: Thu, 12 Jan 2017 12:55:06 +0000
Subject: [PATCH RESEND 1/2] video: fbdev: pmag-ba-fb: Remove bad `__init' annotation
Message-Id: <alpine.LFD.2.20.1701120218510.19339@eddie.linux-mips.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Fix:

WARNING: drivers/video/fbdev/pmag-ba-fb.o(.text+0x308): Section mismatch in reference from the function pmagbafb_probe() to the function .init.text:pmagbafb_erase_cursor()
The function pmagbafb_probe()
references the function __init pmagbafb_erase_cursor().
This is often because pmagbafb_probe lacks a __init
annotation or the annotation of pmagbafb_erase_cursor is wrong.

-- a fallout from a missed update from commit 9625b51350cc ("VIDEO: 
PMAG-BA: Fix section mismatch") and then commit 48c68c4f1b54 ("Drivers: 
video: remove __dev* attributes.")

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-pmag-ba-init.diff
Index: linux-20160515-declance-module/drivers/video/fbdev/pmag-ba-fb.c
=================================--- linux-20160515-declance-module.orig/drivers/video/fbdev/pmag-ba-fb.c
+++ linux-20160515-declance-module/drivers/video/fbdev/pmag-ba-fb.c
@@ -129,7 +129,7 @@ static struct fb_ops pmagbafb_ops = {
 /*
  * Turn the hardware cursor off.
  */
-static void __init pmagbafb_erase_cursor(struct fb_info *info)
+static void pmagbafb_erase_cursor(struct fb_info *info)
 {
 	struct pmagbafb_par *par = info->par;
 
