From: Pawel Osciak <p.osciak@samsung.com>
Date: Fri, 09 Jul 2010 08:50:04 +0000
Subject: [PATCH 16/19] s3c-fb: Correct window osd size and alpha register
Message-Id: <1278665407-18002-17-git-send-email-p.osciak@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1278665407-18002-1-git-send-email-p.osciak@samsung.com>
In-Reply-To: <1278665407-18002-1-git-send-email-p.osciak@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

S3C64xx and S5P OSD registers for OSD size and alpha are as follows:
VIDOSDC: win 0 - size, win 1-4: alpha
VIDOSDD: win 1-2 - size; not present for windows 0, 3 and 4

Signed-off-by: Pawel Osciak <p.osciak@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/video/s3c-fb.c |   54 +++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index f767911..2173869 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -103,8 +103,11 @@ struct s3c_fb_variant {
  * struct s3c_fb_win_variant
  * @has_osd_c: Set if has OSD C register.
  * @has_osd_d: Set if has OSD D register.
+ * @has_osd_alpha: Set if can change alpha transparency for a window.
  * @palette_sz: Size of palette in entries.
  * @palette_16bpp: Set if palette is 16bits wide.
+ * @osd_size_off: If != 0, supports setting up OSD for a window; the appropriate
+ *                register is located at the given offset from OSD_BASE.
  * @valid_bpp: 1 bit per BPP setting to show valid bits-per-pixel.
  *
  * valid_bpp bit x is set if (x+1)BPP is supported.
@@ -112,7 +115,9 @@ struct s3c_fb_variant {
 struct s3c_fb_win_variant {
 	unsigned int	has_osd_c:1;
 	unsigned int	has_osd_d:1;
+	unsigned int	has_osd_alpha:1;
 	unsigned int	palette_16bpp:1;
+	unsigned short	osd_size_off;
 	unsigned short	palette_sz;
 	u32		valid_bpp;
 };
@@ -365,6 +370,36 @@ static int s3c_fb_align_word(unsigned int bpp, unsigned int pix)
 }
 
 /**
+ * vidosd_set_size() - set OSD size for a window
+ *
+ * @win: the window to set OSD size for
+ * @size: OSD size register value
+ */
+static void vidosd_set_size(struct s3c_fb_win *win, u32 size)
+{
+	struct s3c_fb *sfb = win->parent;
+
+	/* OSD can be set up if osd_size_off != 0 for this window */
+	if (win->variant.osd_size_off)
+		writel(size, sfb->regs + OSD_BASE(win->index, sfb->variant)
+				+ win->variant.osd_size_off);
+}
+
+/**
+ * vidosd_set_alpha() - set alpha transparency for a window
+ *
+ * @win: the window to set OSD size for
+ * @alpha: alpha register value
+ */
+static void vidosd_set_alpha(struct s3c_fb_win *win, u32 alpha)
+{
+	struct s3c_fb *sfb = win->parent;
+
+	if (win->variant.has_osd_alpha)
+		writel(alpha, sfb->regs + VIDOSD_C(win->index, sfb->variant));
+}
+
+/**
  * shadow_protect_win() - disable updating values from shadow registers at vsync
  *
  * @win: window to protect registers for
@@ -408,7 +443,7 @@ static int s3c_fb_set_par(struct fb_info *info)
 	void __iomem *regs = sfb->regs;
 	void __iomem *buf = regs;
 	int win_no = win->index;
-	u32 osdc_data = 0;
+	u32 alpha = 0;
 	u32 data;
 	u32 pagewidth;
 	int clkdiv;
@@ -511,15 +546,12 @@ static int s3c_fb_set_par(struct fb_info *info)
 
 	data = var->xres * var->yres;
 
-	osdc_data = VIDISD14C_ALPHA1_R(0xf) |
+	alpha = VIDISD14C_ALPHA1_R(0xf) |
 		VIDISD14C_ALPHA1_G(0xf) |
 		VIDISD14C_ALPHA1_B(0xf);
 
-	if (win->variant.has_osd_d) {
-		writel(data, regs + VIDOSD_D(win_no, sfb->variant));
-		writel(osdc_data, regs + VIDOSD_C(win_no, sfb->variant));
-	} else
-		writel(data, regs + VIDOSD_C(win_no, sfb->variant));
+	vidosd_set_alpha(win, alpha);
+	vidosd_set_size(win, data);
 
 	data = WINCONx_ENWIN;
 
@@ -1442,12 +1474,15 @@ static int s3c_fb_resume(struct platform_device *pdev)
 static struct s3c_fb_win_variant s3c_fb_data_64xx_wins[] __devinitdata = {
 	[0] = {
 		.has_osd_c	= 1,
+		.osd_size_off	= 0x8,
 		.palette_sz	= 256,
 		.valid_bpp	= VALID_BPP1248 | VALID_BPP(16) | VALID_BPP(24),
 	},
 	[1] = {
 		.has_osd_c	= 1,
 		.has_osd_d	= 1,
+		.osd_size_off	= 0x12,
+		.has_osd_alpha	= 1,
 		.palette_sz	= 256,
 		.valid_bpp	= (VALID_BPP1248 | VALID_BPP(16) |
 				   VALID_BPP(18) | VALID_BPP(19) |
@@ -1456,6 +1491,8 @@ static struct s3c_fb_win_variant s3c_fb_data_64xx_wins[] __devinitdata = {
 	[2] = {
 		.has_osd_c	= 1,
 		.has_osd_d	= 1,
+		.osd_size_off	= 0x12,
+		.has_osd_alpha	= 1,
 		.palette_sz	= 16,
 		.palette_16bpp	= 1,
 		.valid_bpp	= (VALID_BPP1248 | VALID_BPP(16) |
@@ -1464,6 +1501,7 @@ static struct s3c_fb_win_variant s3c_fb_data_64xx_wins[] __devinitdata = {
 	},
 	[3] = {
 		.has_osd_c	= 1,
+		.has_osd_alpha	= 1,
 		.palette_sz	= 16,
 		.palette_16bpp	= 1,
 		.valid_bpp	= (VALID_BPP124  | VALID_BPP(16) |
@@ -1472,6 +1510,7 @@ static struct s3c_fb_win_variant s3c_fb_data_64xx_wins[] __devinitdata = {
 	},
 	[4] = {
 		.has_osd_c	= 1,
+		.has_osd_alpha	= 1,
 		.palette_sz	= 4,
 		.palette_16bpp	= 1,
 		.valid_bpp	= (VALID_BPP(1) | VALID_BPP(2) |
@@ -1597,6 +1636,7 @@ static struct s3c_fb_driverdata s3c_fb_data_s3c2443 __devinitdata = {
 	},
 	.win[1] = &(struct s3c_fb_win_variant) {
 		.has_osd_c	= 1,
+		.has_osd_alpha	= 1,
 		.palette_sz	= 256,
 		.valid_bpp	= (VALID_BPP1248 | VALID_BPP(16) |
 				   VALID_BPP(18) | VALID_BPP(19) |
-- 
1.7.1.569.g6f426

