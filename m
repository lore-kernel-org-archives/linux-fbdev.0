From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 28 Feb 2012 11:41:31 +0000
Subject: PATCH V2] video: s3c-fb: Add support EXYNOS5 FIMD
Message-Id: <000001ccf60d$ea8bcce0$bfa366a0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch adds s3c_fb_driverdata s3c_fb_data_exynos5 for EXYNOS5
and adds extended timing control setting.

EXYNOS5 FIMD needs extended setting for video timing control.
Additional bits are added to VIDTCON2, VIDWxxADD2, VIDOSDxA and
VIDOSDxB registers in order to set timing value for lager resolution.

Also, address offset of VIDTCONx registers is changed from 0x0
to 0x20000, thus variable type should be changed to int type
to handle the address offset of VIDTCONx registers for EXYNOS5 FIMD.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
v2: fix commit message from VIDCONx to VIDTCONx.

 arch/arm/plat-samsung/include/plat/regs-fb.h |   24 ++++++++----
 drivers/video/s3c-fb.c                       |   52 +++++++++++++++++++++++--
 2 files changed, 63 insertions(+), 13 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/regs-fb.h b/arch/arm/plat-samsung/include/plat/regs-fb.h
index bbb16e0..9a78012 100644
--- a/arch/arm/plat-samsung/include/plat/regs-fb.h
+++ b/arch/arm/plat-samsung/include/plat/regs-fb.h
@@ -167,15 +167,17 @@
 #define VIDTCON1_HSPW(_x)			((_x) << 0)
 
 #define VIDTCON2				(0x18)
+#define VIDTCON2_LINEVAL_E(_x)			((((_x) & 0x800) >> 11) << 23)
 #define VIDTCON2_LINEVAL_MASK			(0x7ff << 11)
 #define VIDTCON2_LINEVAL_SHIFT			(11)
 #define VIDTCON2_LINEVAL_LIMIT			(0x7ff)
-#define VIDTCON2_LINEVAL(_x)			((_x) << 11)
+#define VIDTCON2_LINEVAL(_x)			(((_x) & 0x7ff) << 11)
 
+#define VIDTCON2_HOZVAL_E(_x)			((((_x) & 0x800) >> 11) << 22)
 #define VIDTCON2_HOZVAL_MASK			(0x7ff << 0)
 #define VIDTCON2_HOZVAL_SHIFT			(0)
 #define VIDTCON2_HOZVAL_LIMIT			(0x7ff)
-#define VIDTCON2_HOZVAL(_x)			((_x) << 0)
+#define VIDTCON2_HOZVAL(_x)			(((_x) & 0x7ff) << 0)
 
 /* WINCONx */
 
@@ -231,25 +233,29 @@
 /* Local input channels (windows 0-2) */
 #define SHADOWCON_CHx_LOCAL_ENABLE(_win)	(1 << (5 + (_win)))
 
+#define VIDOSDxA_TOPLEFT_X_E(_x)		((((_x) & 0x800) >> 11) << 23)
 #define VIDOSDxA_TOPLEFT_X_MASK			(0x7ff << 11)
 #define VIDOSDxA_TOPLEFT_X_SHIFT		(11)
 #define VIDOSDxA_TOPLEFT_X_LIMIT		(0x7ff)
-#define VIDOSDxA_TOPLEFT_X(_x)			((_x) << 11)
+#define VIDOSDxA_TOPLEFT_X(_x)			(((_x) & 0x7ff) << 11)
 
+#define VIDOSDxA_TOPLEFT_Y_E(_x)		((((_x) & 0x800) >> 11) << 22)
 #define VIDOSDxA_TOPLEFT_Y_MASK			(0x7ff << 0)
 #define VIDOSDxA_TOPLEFT_Y_SHIFT		(0)
 #define VIDOSDxA_TOPLEFT_Y_LIMIT		(0x7ff)
-#define VIDOSDxA_TOPLEFT_Y(_x)			((_x) << 0)
+#define VIDOSDxA_TOPLEFT_Y(_x)			(((_x) & 0x7ff) << 0)
 
+#define VIDOSDxB_BOTRIGHT_X_E(_x)		((((_x) & 0x800) >> 11) << 23)
 #define VIDOSDxB_BOTRIGHT_X_MASK		(0x7ff << 11)
 #define VIDOSDxB_BOTRIGHT_X_SHIFT		(11)
 #define VIDOSDxB_BOTRIGHT_X_LIMIT		(0x7ff)
-#define VIDOSDxB_BOTRIGHT_X(_x)			((_x) << 11)
+#define VIDOSDxB_BOTRIGHT_X(_x)			(((_x) & 0x7ff) << 11)
 
+#define VIDOSDxB_BOTRIGHT_Y_E(_x)		((((_x) & 0x800) >> 11) << 22)
 #define VIDOSDxB_BOTRIGHT_Y_MASK		(0x7ff << 0)
 #define VIDOSDxB_BOTRIGHT_Y_SHIFT		(0)
 #define VIDOSDxB_BOTRIGHT_Y_LIMIT		(0x7ff)
-#define VIDOSDxB_BOTRIGHT_Y(_x)			((_x) << 0)
+#define VIDOSDxB_BOTRIGHT_Y(_x)			(((_x) & 0x7ff) << 0)
 
 /* For VIDOSD[1..4]C */
 #define VIDISD14C_ALPHA0_R(_x)			((_x) << 20)
@@ -281,15 +287,17 @@
 #define VIDW_BUF_END1(_buff)			(0xD4 + ((_buff) * 8))
 #define VIDW_BUF_SIZE(_buff)			(0x100 + ((_buff) * 4))
 
+#define VIDW_BUF_SIZE_OFFSET_E(_x)		((((_x) & 0x2000) >> 13) << 27)
 #define VIDW_BUF_SIZE_OFFSET_MASK		(0x1fff << 13)
 #define VIDW_BUF_SIZE_OFFSET_SHIFT		(13)
 #define VIDW_BUF_SIZE_OFFSET_LIMIT		(0x1fff)
-#define VIDW_BUF_SIZE_OFFSET(_x)		((_x) << 13)
+#define VIDW_BUF_SIZE_OFFSET(_x)		(((_x) & 0x1fff) << 13)
 
+#define VIDW_BUF_SIZE_PAGEWIDTH_E(_x)		((((_x) & 0x2000) >> 13) << 26)
 #define VIDW_BUF_SIZE_PAGEWIDTH_MASK		(0x1fff << 0)
 #define VIDW_BUF_SIZE_PAGEWIDTH_SHIFT		(0)
 #define VIDW_BUF_SIZE_PAGEWIDTH_LIMIT		(0x1fff)
-#define VIDW_BUF_SIZE_PAGEWIDTH(_x)		((_x) << 0)
+#define VIDW_BUF_SIZE_PAGEWIDTH(_x)		(((_x) & 0x1fff) << 0)
 
 /* Interrupt controls and status */
 
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 1fb7ddf..f310516 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -89,7 +89,7 @@ struct s3c_fb;
 struct s3c_fb_variant {
 	unsigned int	is_2443:1;
 	unsigned short	nr_windows;
-	unsigned short	vidtcon;
+	unsigned int	vidtcon;
 	unsigned short	wincon;
 	unsigned short	winmap;
 	unsigned short	keycon;
@@ -568,7 +568,9 @@ static int s3c_fb_set_par(struct fb_info *info)
 		writel(data, regs + sfb->variant.vidtcon + 4);
 
 		data = VIDTCON2_LINEVAL(var->yres - 1) |
-		       VIDTCON2_HOZVAL(var->xres - 1);
+		       VIDTCON2_HOZVAL(var->xres - 1) |
+		       VIDTCON2_LINEVAL_E(var->yres - 1) |
+		       VIDTCON2_HOZVAL_E(var->xres - 1);
 		writel(data, regs + sfb->variant.vidtcon + 8);
 	}
 
@@ -584,17 +586,23 @@ static int s3c_fb_set_par(struct fb_info *info)
 
 	pagewidth = (var->xres * var->bits_per_pixel) >> 3;
 	data = VIDW_BUF_SIZE_OFFSET(info->fix.line_length - pagewidth) |
-	       VIDW_BUF_SIZE_PAGEWIDTH(pagewidth);
+	       VIDW_BUF_SIZE_PAGEWIDTH(pagewidth) |
+	       VIDW_BUF_SIZE_OFFSET_E(info->fix.line_length - pagewidth) |
+	       VIDW_BUF_SIZE_PAGEWIDTH_E(pagewidth);
 	writel(data, regs + sfb->variant.buf_size + (win_no * 4));
 
 	/* write 'OSD' registers to control position of framebuffer */
 
-	data = VIDOSDxA_TOPLEFT_X(0) | VIDOSDxA_TOPLEFT_Y(0);
+	data = VIDOSDxA_TOPLEFT_X(0) | VIDOSDxA_TOPLEFT_Y(0) |
+	       VIDOSDxA_TOPLEFT_X_E(0) | VIDOSDxA_TOPLEFT_Y_E(0);
 	writel(data, regs + VIDOSD_A(win_no, sfb->variant));
 
 	data = VIDOSDxB_BOTRIGHT_X(s3c_fb_align_word(var->bits_per_pixel,
 						     var->xres - 1)) |
-	       VIDOSDxB_BOTRIGHT_Y(var->yres - 1);
+	       VIDOSDxB_BOTRIGHT_Y(var->yres - 1) |
+	       VIDOSDxB_BOTRIGHT_X_E(s3c_fb_align_word(var->bits_per_pixel,
+						     var->xres - 1)) |
+	       VIDOSDxB_BOTRIGHT_Y_E(var->yres - 1);
 
 	writel(data, regs + VIDOSD_B(win_no, sfb->variant));
 
@@ -1903,6 +1911,37 @@ static struct s3c_fb_driverdata s3c_fb_data_exynos4 = {
 	.win[4]	= &s3c_fb_data_s5p_wins[4],
 };
 
+static struct s3c_fb_driverdata s3c_fb_data_exynos5 = {
+	.variant = {
+		.nr_windows	= 5,
+		.vidtcon	= VIDTCON0,
+		.wincon		= WINCON(0),
+		.winmap		= WINxMAP(0),
+		.keycon		= WKEYCON,
+		.osd		= VIDOSD_BASE,
+		.osd_stride	= 16,
+		.buf_start	= VIDW_BUF_START(0),
+		.buf_size	= VIDW_BUF_SIZE(0),
+		.buf_end	= VIDW_BUF_END(0),
+
+		.palette = {
+			[0] = 0x2400,
+			[1] = 0x2800,
+			[2] = 0x2c00,
+			[3] = 0x3000,
+			[4] = 0x3400,
+		},
+		.has_shadowcon	= 1,
+		.has_blendcon	= 1,
+		.has_fixvclk	= 1,
+	},
+	.win[0]	= &s3c_fb_data_s5p_wins[0],
+	.win[1]	= &s3c_fb_data_s5p_wins[1],
+	.win[2]	= &s3c_fb_data_s5p_wins[2],
+	.win[3]	= &s3c_fb_data_s5p_wins[3],
+	.win[4]	= &s3c_fb_data_s5p_wins[4],
+};
+
 /* S3C2443/S3C2416 style hardware */
 static struct s3c_fb_driverdata s3c_fb_data_s3c2443 = {
 	.variant = {
@@ -1981,6 +2020,9 @@ static struct platform_device_id s3c_fb_driver_ids[] = {
 		.name		= "exynos4-fb",
 		.driver_data	= (unsigned long)&s3c_fb_data_exynos4,
 	}, {
+		.name		= "exynos5-fb",
+		.driver_data	= (unsigned long)&s3c_fb_data_exynos5,
+	}, {
 		.name		= "s3c2443-fb",
 		.driver_data	= (unsigned long)&s3c_fb_data_s3c2443,
 	}, {
-- 
1.7.1


