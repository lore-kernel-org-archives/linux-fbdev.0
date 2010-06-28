From: Pawel Osciak <p.osciak@samsung.com>
Date: Mon, 28 Jun 2010 08:08:54 +0000
Subject: [PATCH v3 08/12] s3c-fb: Add SHADOWCON shadow register locking support
Message-Id: <1277712538-23188-9-git-send-email-p.osciak@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1277712538-23188-1-git-send-email-p.osciak@samsung.com>
In-Reply-To: <1277712538-23188-1-git-send-email-p.osciak@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

S5PV210 allows per-window locking of register value updates from shadow
registers.

Signed-off-by: Pawel Osciak <p.osciak@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/include/plat/regs-fb.h |    3 ++
 drivers/video/s3c-fb.c                       |   39 +++++++++++++++++++++++--
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/regs-fb.h b/arch/arm/plat-samsung/include/plat/regs-fb.h
index 5bcdd09..da54b64 100644
--- a/arch/arm/plat-samsung/include/plat/regs-fb.h
+++ b/arch/arm/plat-samsung/include/plat/regs-fb.h
@@ -218,6 +218,9 @@
 #define WINCON1_BPPMODE_25BPP_A1888		(0xd << 2)
 #define WINCON1_BPPMODE_28BPP_A4888		(0xd << 2)
 
+/* S5PV210 */
+#define SHADOWCON				(0x34)
+#define SHADOWCON_WINx_PROTECT(_win)		(1 << (10 + _win))
 
 #define VIDOSDxA_TOPLEFT_X_MASK			(0x7ff << 11)
 #define VIDOSDxA_TOPLEFT_X_SHIFT		(11)
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 0a93fca..94423c5 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -79,6 +79,7 @@ struct s3c_fb;
  * @osd: The base for the OSD registers.
  * @palette: Address of palette memory, or 0 if none.
  * @has_prtcon: Set if has PRTCON register.
+ * @has_shadowcon: Set if has SHADOWCON register.
  */
 struct s3c_fb_variant {
 	unsigned int	is_2443:1;
@@ -95,6 +96,7 @@ struct s3c_fb_variant {
 	unsigned short	palette[S3C_FB_MAX_WIN];
 
 	unsigned int	has_prtcon:1;
+	unsigned int	has_shadowcon:1;
 };
 
 /**
@@ -363,6 +365,36 @@ static int s3c_fb_align_word(unsigned int bpp, unsigned int pix)
 }
 
 /**
+ * shadow_protect_win() - disable updating values from shadow registers at vsync
+ *
+ * @win: window to protect registers for
+ * @protect: 1 to protect (disable updates)
+ */
+static void shadow_protect_win(struct s3c_fb_win *win, int protect)
+{
+	struct s3c_fb *sfb = win->parent;
+	u32 reg;
+
+	if (protect) {
+		if (sfb->variant.has_prtcon) {
+			writel(PRTCON_PROTECT, sfb->regs + PRTCON);
+		} else if (sfb->variant.has_shadowcon) {
+			reg = readl(sfb->regs + SHADOWCON);
+			writel(reg | SHADOWCON_WINx_PROTECT(win->index),
+				sfb->regs + SHADOWCON);
+		}
+	} else {
+		if (sfb->variant.has_prtcon) {
+			writel(0, sfb->regs + PRTCON);
+		} else if (sfb->variant.has_shadowcon) {
+			reg = readl(sfb->regs + SHADOWCON);
+			writel(reg & ~SHADOWCON_WINx_PROTECT(win->index),
+				sfb->regs + SHADOWCON);
+		}
+	}
+}
+
+/**
  * s3c_fb_set_par() - framebuffer request to set new framebuffer state.
  * @info: The framebuffer to change.
  *
@@ -811,16 +843,14 @@ static int s3c_fb_pan_display(struct fb_var_screeninfo *var,
 
 	/* Temporarily turn off per-vsync update from shadow registers until
 	 * both start and end addresses are updated to prevent corruption */
-	if (sfb->variant.has_prtcon)
-		writel(PRTCON_PROTECT, sfb->regs + PRTCON);
+	shadow_protect_win(win, 1);
 
 	writel(info->fix.smem_start + start_byte_offset,
 		buf + sfb->variant.buf_start);
 	writel(info->fix.smem_start + end_byte_offset,
 		buf + sfb->variant.buf_end);
 
-	if (sfb->variant.has_prtcon)
-		writel(0, sfb->regs + PRTCON);
+	shadow_protect_win(win, 0);
 
 	return 0;
 }
@@ -1534,6 +1564,7 @@ static struct s3c_fb_driverdata s3c_fb_data_s5pv210 __devinitdata = {
 			[4] = 0x3400,
 		},
 
+		.has_shadowcon	= 1,
 	},
 	.win[0]	= &s3c_fb_data_64xx_wins[0],
 	.win[1]	= &s3c_fb_data_64xx_wins[1],
-- 
1.7.1.569.g6f426

