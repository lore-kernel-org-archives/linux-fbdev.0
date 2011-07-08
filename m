From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 08 Jul 2011 11:14:35 +0000
Subject: [PATCH v3 21/29] savagefb: use display information in info not in var for panning
Message-Id: <1310123683-8064-22-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

We must not use any information in the passed var besides xoffset,
yoffset and vmode as otherwise applications might abuse it. Also use the
aligned fix.line_length and not the (possible) unaligned xres_virtual.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Tormod Volden <debian.tormod@gmail.com>
Cc: Antonino Daplas <adaplas@gmail.com>
---
 drivers/video/savage/savagefb_driver.c |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
index 4de541c..beb4950 100644
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -1477,15 +1477,9 @@ static void savagefb_set_par_int(struct savagefb_par  *par, struct savage_reg *r
 	vgaHWProtect(par, 0);
 }
 
-static void savagefb_update_start(struct savagefb_par      *par,
-				  struct fb_var_screeninfo *var)
+static void savagefb_update_start(struct savagefb_par *par, int base)
 {
-	int base;
-
-	base = ((var->yoffset * var->xres_virtual + (var->xoffset & ~1))
-		* ((var->bits_per_pixel+7) / 8)) >> 2;
-
-	/* now program the start address registers */
+	/* program the start address registers */
 	vga_out16(0x3d4, (base & 0x00ff00) | 0x0c, par);
 	vga_out16(0x3d4, ((base & 0x00ff) << 8) | 0x0d, par);
 	vga_out8(0x3d4, 0x69, par);
@@ -1550,8 +1544,12 @@ static int savagefb_pan_display(struct fb_var_screeninfo *var,
 				struct fb_info           *info)
 {
 	struct savagefb_par *par = info->par;
+	int base;
+
+	base = (var->yoffset * info->fix.line_length
+	     + (var->xoffset & ~1) * ((info->var.bits_per_pixel+7) / 8)) >> 2;
 
-	savagefb_update_start(par, var);
+	savagefb_update_start(par, base);
 	return 0;
 }
 
-- 
1.7.3.4

