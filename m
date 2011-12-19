From: Timur Tabi <timur@freescale.com>
Date: Mon, 19 Dec 2011 22:26:17 +0000
Subject: [PATCH 4/5] drivers/video: fsl-diu-fb: add default platform ops functions
Message-Id: <1324333578-23992-4-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The DIU driver requires some platform-specific functions to be defined,
but two them can be optional because most platforms implement them the
same way.  Functions set_gamma_table() and get_pixel_format() are only
needed because of quirks in the Freescale MPC8610 HPCD reference board.
For other boards, a generic implementation works, so we shouldn't
require the platform code to define them.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |   64 +++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index d8d461d..e2f4f32 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -832,7 +832,8 @@ static void update_lcdc(struct fb_info *info)
 		for (j = 0; j <= 255; j++)
 			*gamma_table_base++ = j;
 
-	diu_ops.set_gamma_table(data->monitor_port, data->gamma);
+	if (diu_ops.set_gamma_table)
+		diu_ops.set_gamma_table(data->monitor_port, data->gamma);
 
 	disable_lcdc(info);
 
@@ -917,6 +918,59 @@ static int fsl_diu_set_aoi(struct fb_info *info)
 	return 0;
 }
 
+/**
+ * fsl_diu_get_pixel_format: return the pixel format for a given color depth
+ *
+ * The pixel format is a 32-bit value that determine which bits in each
+ * pixel are to be used for each color.  This is the default function used
+ * if the platform does not define its own version.
+ */
+static u32 fsl_diu_get_pixel_format(unsigned int bits_per_pixel)
+{
+#define PF_BYTE_F		0x10000000
+#define PF_ALPHA_C_MASK		0x0E000000
+#define PF_ALPHA_C_SHIFT	25
+#define PF_BLUE_C_MASK		0x01800000
+#define PF_BLUE_C_SHIFT		23
+#define PF_GREEN_C_MASK		0x00600000
+#define PF_GREEN_C_SHIFT	21
+#define PF_RED_C_MASK		0x00180000
+#define PF_RED_C_SHIFT		19
+#define PF_PALETTE		0x00040000
+#define PF_PIXEL_S_MASK		0x00030000
+#define PF_PIXEL_S_SHIFT	16
+#define PF_COMP_3_MASK		0x0000F000
+#define PF_COMP_3_SHIFT		12
+#define PF_COMP_2_MASK		0x00000F00
+#define PF_COMP_2_SHIFT		8
+#define PF_COMP_1_MASK		0x000000F0
+#define PF_COMP_1_SHIFT		4
+#define PF_COMP_0_MASK		0x0000000F
+#define PF_COMP_0_SHIFT		0
+
+#define MAKE_PF(alpha, red, blue, green, size, c0, c1, c2, c3) \
+	cpu_to_le32(PF_BYTE_F | (alpha << PF_ALPHA_C_SHIFT) | \
+	(blue << PF_BLUE_C_SHIFT) | (green << PF_GREEN_C_SHIFT) | \
+	(red << PF_RED_C_SHIFT) | (c3 << PF_COMP_3_SHIFT) | \
+	(c2 << PF_COMP_2_SHIFT) | (c1 << PF_COMP_1_SHIFT) | \
+	(c0 << PF_COMP_0_SHIFT) | (size << PF_PIXEL_S_SHIFT))
+
+	switch (bits_per_pixel) {
+	case 32:
+		/* 0x88883316 */
+		return MAKE_PF(3, 2, 0, 1, 3, 8, 8, 8, 8);
+	case 24:
+		/* 0x88082219 */
+		return MAKE_PF(4, 0, 1, 2, 2, 0, 8, 8, 8);
+	case 16:
+		/* 0x65053118 */
+		return MAKE_PF(4, 2, 1, 0, 1, 5, 6, 5, 0);
+	default:
+		pr_err("fsl-diu: unsupported color depth %u\n", bits_per_pixel);
+		return 0;
+	}
+}
+
 /*
  * Using the fb_var_screeninfo in fb_info we set the resolution of this
  * particular framebuffer. This function alters the fb_fix_screeninfo stored
@@ -952,8 +1006,12 @@ static int fsl_diu_set_par(struct fb_info *info)
 		}
 	}
 
-	ad->pix_fmt = diu_ops.get_pixel_format(data->monitor_port,
-					       var->bits_per_pixel);
+	if (diu_ops.get_pixel_format)
+		ad->pix_fmt = diu_ops.get_pixel_format(data->monitor_port,
+						       var->bits_per_pixel);
+	else
+		ad->pix_fmt = fsl_diu_get_pixel_format(var->bits_per_pixel);
+
 	ad->addr    = cpu_to_le32(info->fix.smem_start);
 	ad->src_size_g_alpha = cpu_to_le32((var->yres_virtual << 12) |
 				var->xres_virtual) | mfbi->g_alpha;
-- 
1.7.3.4


