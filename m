From: Pawel Osciak <p.osciak@samsung.com>
Subject: [PATCH 4/7] [ARM] s3c-fb: Corrected and added new VIDOSD register
	macros.
Date: Fri, 11 Sep 2009 20:04:57 +0200
Message-ID: <E4D3F24EA6C9E54F817833EAE0D912AC0771185D5B@bssrvexch01.BS.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-language: en-US
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>
Cc: Pawel Osciak <p.osciak@samsung.com>, =?utf-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "adaplas@gmail.com" <adaplas@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>

For S3C64xx, only windows 1 and 2 have VIDOSD_D registers.
The VIDOSD_x register functions differ depending on the window number, as
does the ability of setting up size and alpha:

win0: size in VIDOSD_C
win1-2: alpha in VIDOSD_C and size in VIDOSD_D
win3-4: alpha in VIDOSD_C

Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Pawel Osciak <p.osciak@samsung.com>

---
 arch/arm/mach-s3c6400/include/mach/regs-fb.h |   14 +++++++-
 arch/arm/plat-s3c/include/plat/regs-fb.h     |   44 +++++++++++++------------
 drivers/video/s3c-fb.c                       |   27 ++++++++++------
 3 files changed, 52 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-s3c6400/include/mach/regs-fb.h b/arch/arm/mach-s3c6400/include/mach/regs-fb.h
index 84facc9..b926057 100644
--- a/arch/arm/mach-s3c6400/include/mach/regs-fb.h
+++ b/arch/arm/mach-s3c6400/include/mach/regs-fb.h
@@ -46,7 +46,7 @@
 
 #define WINCON(_win)				(0x20 + ((_win) * 4))
 
-/* OSD1 and OSD4 do not have register D */
+/* Only OSD1 and OSD2 have register VIDOSD_D */
 
 #define VIDOSD_A(_win)				(0x40 + ((_win) * 16))
 #define VIDOSD_B(_win)				(0x44 + ((_win) * 16))
@@ -168,7 +168,17 @@
 */
 
 /* return true if window _win has OSD register D */
-#define s3c_fb_has_osd_d(_win) ((_win) != 4 && (_win) != 0)
+#define s3c_fb_has_osd_d(_win) ((_win) == 1 || (_win) == 2)
+
+/* Return true if the window allows setting its alpha.
+ * If so, then the register to put the alpha values in is VIDOSD_C */
+#define s3c_fb_has_alpha(_win) ((_win) > 0)
+
+/* Return true if the window allows adjusting its size.
+ * If so, then the register to put it in is VIDOSD_C for win0 and D otherwise */
+#define s3c_fb_allows_size(_win) ((_win) < 3)
+#define VIDOSD_SIZE(_win)	(((_win) == 0) ? \
+					(VIDOSD_C(_win)) : (VIDOSD_D(_win)))
 
 static inline unsigned int s3c_fb_win_pal_size(unsigned int win)
 {
diff --git a/arch/arm/plat-s3c/include/plat/regs-fb.h b/arch/arm/plat-s3c/include/plat/regs-fb.h
index 26b878b..efe163c 100644
--- a/arch/arm/plat-s3c/include/plat/regs-fb.h
+++ b/arch/arm/plat-s3c/include/plat/regs-fb.h
@@ -240,27 +240,29 @@
 #define VIDOSDxB_BOTRIGHT_Y(_x)			((_x) << 0)
 
 /* For VIDOSD[1..4]C */
-#define VIDISD14C_ALPHA0_R(_x)			((_x) << 20)
-#define VIDISD14C_ALPHA0_G_MASK			(0xf << 16)
-#define VIDISD14C_ALPHA0_G_SHIFT		(16)
-#define VIDISD14C_ALPHA0_G_LIMIT		(0xf)
-#define VIDISD14C_ALPHA0_G(_x)			((_x) << 16)
-#define VIDISD14C_ALPHA0_B_MASK			(0xf << 12)
-#define VIDISD14C_ALPHA0_B_SHIFT		(12)
-#define VIDISD14C_ALPHA0_B_LIMIT		(0xf)
-#define VIDISD14C_ALPHA0_B(_x)			((_x) << 12)
-#define VIDISD14C_ALPHA1_R_MASK			(0xf << 8)
-#define VIDISD14C_ALPHA1_R_SHIFT		(8)
-#define VIDISD14C_ALPHA1_R_LIMIT		(0xf)
-#define VIDISD14C_ALPHA1_R(_x)			((_x) << 8)
-#define VIDISD14C_ALPHA1_G_MASK			(0xf << 4)
-#define VIDISD14C_ALPHA1_G_SHIFT		(4)
-#define VIDISD14C_ALPHA1_G_LIMIT		(0xf)
-#define VIDISD14C_ALPHA1_G(_x)			((_x) << 4)
-#define VIDISD14C_ALPHA1_B_MASK			(0xf << 0)
-#define VIDISD14C_ALPHA1_B_SHIFT		(0)
-#define VIDISD14C_ALPHA1_B_LIMIT		(0xf)
-#define VIDISD14C_ALPHA1_B(_x)			((_x) << 0)
+#define VIDOSD14C_ALPHA0_R(_x)			((_x) << 20)
+#define VIDOSD14C_ALPHA0_G_MASK			(0xf << 16)
+#define VIDOSD14C_ALPHA0_G_SHIFT		(16)
+#define VIDOSD14C_ALPHA0_G_LIMIT		(0xf)
+#define VIDOSD14C_ALPHA0_G(_x)			((_x) << 16)
+#define VIDOSD14C_ALPHA0_B_MASK			(0xf << 12)
+#define VIDOSD14C_ALPHA0_B_SHIFT		(12)
+#define VIDOSD14C_ALPHA0_B_LIMIT		(0xf)
+#define VIDOSD14C_ALPHA0_B(_x)			((_x) << 12)
+#define VIDOSD14C_ALPHA1_R_MASK			(0xf << 8)
+#define VIDOSD14C_ALPHA1_R_SHIFT		(8)
+#define VIDOSD14C_ALPHA1_R_LIMIT		(0xf)
+#define VIDOSD14C_ALPHA1_R(_x)			((_x) << 8)
+#define VIDOSD14C_ALPHA1_G_MASK			(0xf << 4)
+#define VIDOSD14C_ALPHA1_G_SHIFT		(4)
+#define VIDOSD14C_ALPHA1_G_LIMIT		(0xf)
+#define VIDOSD14C_ALPHA1_G(_x)			((_x) << 4)
+#define VIDOSD14C_ALPHA1_B_MASK			(0xf << 0)
+#define VIDOSD14C_ALPHA1_B_SHIFT		(0)
+#define VIDOSD14C_ALPHA1_B_LIMIT		(0xf)
+#define VIDOSD14C_ALPHA1_B(_x)			((_x) << 0)
+#define VIDOSD14C_ALPHA0_MASK		(0xfff << VIDOSD14C_ALPHA0_B_SHIFT)
+#define VIDOSD14C_ALPHA1_MASK			(0xfff)
 
 /* Video buffer addresses */
 #define VIDW_BUF_START(_buff)			(0xA0 + ((_buff) * 8))
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 54ed018..307a7e8 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -390,15 +390,15 @@ static int s3c_fb_set_par(struct fb_info *info)
 
 	data = var->xres * var->yres;
 
-	osdc_data = VIDISD14C_ALPHA1_R(0xf) |
-		VIDISD14C_ALPHA1_G(0xf) |
-		VIDISD14C_ALPHA1_B(0xf);
+	if (s3c_fb_allows_size(win_no))
+		writel(data, regs + VIDOSD_SIZE(win_no));
 
-	if (s3c_fb_has_osd_d(win_no)) {
-		writel(data, regs + VIDOSD_D(win_no));
+	osdc_data = VIDOSD14C_ALPHA1_R(0xf) |
+		VIDOSD14C_ALPHA1_G(0xf) |
+		VIDOSD14C_ALPHA1_B(0xf);
+
+	if (s3c_fb_has_alpha(win_no))
 		writel(osdc_data, regs + VIDOSD_C(win_no));
-	} else
-		writel(data, regs + VIDOSD_C(win_no));
 
 	data = WINCONx_ENWIN;
 
@@ -1046,13 +1046,18 @@ static int s3c_fb_set_win_alpha(struct s3c_fb_win *win,
 	struct s3c_fb *sfb = win->parent;
 	u32 vidosdc_reg = 0;
 
-	if (win->index == 0) {
+	if (!s3c_fb_has_alpha(win->index)) {
 		dev_err(sfb->dev, "Alpha cannot be set for window %d\n.",
 			win->index);
+		return -EINVAL;
 	}
 
-	vidosdc_reg = alpha->r0 << 20 | alpha->g0 << 16 | alpha->b0 << 12
-		    | alpha->r1 << 8  | alpha->g1 << 4  | alpha->b1;
+	vidosdc_reg = VIDOSD14C_ALPHA0_R(alpha->r0)
+		    | VIDOSD14C_ALPHA0_G(alpha->g0)
+		    | VIDOSD14C_ALPHA0_B(alpha->b0)
+		    | VIDOSD14C_ALPHA1_R(alpha->r1)
+		    | VIDOSD14C_ALPHA1_G(alpha->g1)
+		    | VIDOSD14C_ALPHA1_B(alpha->b1);
 	writel(vidosdc_reg, sfb->regs + VIDOSD_C(win->index));
 
 	return 0;
@@ -1331,6 +1336,8 @@ static void s3c_fb_clear_win(struct s3c_fb *sfb, int win)
 	writel(0, regs + VIDOSD_A(win));
 	writel(0, regs + VIDOSD_B(win));
 	writel(0, regs + VIDOSD_C(win));
+	if (s3c_fb_has_osd_d(win))
+		writel(0, regs + VIDOSD_D(win));
 }
 
 static int __devinit s3c_fb_probe(struct platform_device *pdev)
-- 
1.6.4.2.253.g0b1fac
