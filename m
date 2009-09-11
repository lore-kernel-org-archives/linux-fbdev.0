From: Pawel Osciak <p.osciak@samsung.com>
Subject: [PATCH 3/7] [ARM] s3c-fb: Added support for alpha blending.
Date: Fri, 11 Sep 2009 20:04:55 +0200
Message-ID: <E4D3F24EA6C9E54F817833EAE0D912AC0771185D5A@bssrvexch01.BS.local>
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

Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Pawel Osciak <p.osciak@samsung.com>

---
 arch/arm/mach-s3c6400/include/mach/regs-fb.h |    6 ++
 arch/arm/plat-s3c/include/plat/regs-fb.h     |    7 +++
 arch/arm/plat-s3c/include/plat/s3c-fb.h      |   27 +++++++++
 drivers/video/s3c-fb.c                       |   75 ++++++++++++++++++++++++++
 4 files changed, 115 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c6400/include/mach/regs-fb.h b/arch/arm/mach-s3c6400/include/mach/regs-fb.h
index 6339426..84facc9 100644
--- a/arch/arm/mach-s3c6400/include/mach/regs-fb.h
+++ b/arch/arm/mach-s3c6400/include/mach/regs-fb.h
@@ -24,6 +24,9 @@
  * override them at a later date.
 */
 
+#ifndef __ASM_ARCH_REGS_FB_H
+#define __ASM_ARCH_REGS_FB_H __FILE__
+
 #include <plat/regs-fb.h>
 
 #define S3C_FB_MAX_WIN (5)  /* number of hardware windows available. */
@@ -262,3 +265,6 @@ static inline void s3c_fb_init_palette(unsigned int window,
  * 1110		-none-	 -none-	  -none-   -none-    -none-
  * 1111		-none-	 -none-   -none-   -none-    -none-
 */
+
+#endif /* __ASM_ARCH_REGS_FB_H */
+
diff --git a/arch/arm/plat-s3c/include/plat/regs-fb.h b/arch/arm/plat-s3c/include/plat/regs-fb.h
index 4c024ca..26b878b 100644
--- a/arch/arm/plat-s3c/include/plat/regs-fb.h
+++ b/arch/arm/plat-s3c/include/plat/regs-fb.h
@@ -28,6 +28,9 @@
  * ensure all the localised SoC support is included as necessary.
 */
 
+#ifndef __PLAT_S3C_REGS_FB_H
+#define __PLAT_S3C_REGS_FB_H	__FILE__
+
 /* VIDCON0 */
 
 #define VIDCON0					(0x00)
@@ -179,6 +182,8 @@
 #define WINCONx_BURSTLEN_16WORD			(0x0 << 9)
 #define WINCONx_BURSTLEN_8WORD			(0x1 << 9)
 #define WINCONx_BURSTLEN_4WORD			(0x2 << 9)
+#define WINCONx_BLD_PIX				(1 << 6)
+#define WINCONx_ALPHA_SEL			(1 << 1)
 
 #define WINCONx_ENWIN				(1 << 0)
 #define WINCON0_BPPMODE_MASK			(0xf << 2)
@@ -369,3 +374,5 @@
 #define WPALCON_W0PAL_16BPP_A555		(0x5 << 0)
 #define WPALCON_W0PAL_16BPP_565			(0x6 << 0)
 
+#endif /* __PLAT_S3C_REGS_FB_H */
+
diff --git a/arch/arm/plat-s3c/include/plat/s3c-fb.h b/arch/arm/plat-s3c/include/plat/s3c-fb.h
index b08f9ad..080524d 100644
--- a/arch/arm/plat-s3c/include/plat/s3c-fb.h
+++ b/arch/arm/plat-s3c/include/plat/s3c-fb.h
@@ -21,6 +21,16 @@ struct s3c_fb_color {
 	__u32 b : 8;
 } __attribute__((__packed__));
 
+struct s3c_fb_alpha {
+	__u32 reserved : 8;
+	__u32 r0 : 4;
+	__u32 g0 : 4;
+	__u32 b0 : 4;
+	__u32 r1 : 4;
+	__u32 g1 : 4;
+	__u32 b1 : 4;
+} __attribute__((__packed__));
+
 typedef enum s3c_fb_color_key_mode {
 	S3CFB_COLORKEY_MODE_BG = 0,
 	S3CFB_COLORKEY_MODE_FG = 1
@@ -32,6 +42,17 @@ typedef enum s3c_fb_source {
 	S3CFB_SOURCE_LOCAL_YCbCr = 2
 } s3c_fb_source_t;
 
+typedef enum s3c_fb_alpha_mode {
+	/* Use alpha value from each pixel */
+	S3CFB_ALPHA_PIXEL_VALUE,
+	/* Use global alpha (0 or 1) value chosen by alpha bit of the pixel */
+	S3CFB_ALPHA_PIXEL_SWITCH,
+	/* Blend all pixels with global alpha0 value */
+	S3CFB_ALPHA_PLANE_0,
+	/* Blend all pixels with global alpha1 value */
+	S3CFB_ALPHA_PLANE_1
+} s3c_fb_alpha_mode_t;
+
 #ifndef FBIO_WAITFORVSYNC
 #define FBIO_WAITFORVSYNC _IOW('F', 0x20, __u32)
 #endif
@@ -50,5 +71,11 @@ typedef enum s3c_fb_source {
 
 /* Param: s3c_fb_source */
 #define S3CFB_IOCTL_SET_SOURCE		_IO(S3CFB_IOCTL_MAGIC, 5)
+
+/* Param: s3c_fb_alpha_mode */
+#define S3CFB_IOCTL_SET_ALPHA_MODE	_IO(S3CFB_IOCTL_MAGIC, 6)
+
+#define S3CFB_IOCTL_SET_WINDOW_ALPHA	_IOW(S3CFB_IOCTL_MAGIC, 7,\
+					struct s3c_fb_alpha)
 #endif /* __LINUX_S3C_FB_H__ */
 
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 28622c0..54ed018 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -997,6 +997,67 @@ static int s3c_fb_set_source(struct s3c_fb_win *win, s3c_fb_source_t source)
 	return 0;
 }
 
+static int s3c_fb_set_alpha_mode(struct s3c_fb_win *win,
+				 s3c_fb_alpha_mode_t mode)
+{
+	struct s3c_fb *sfb = win->parent;
+	int wincon_reg;
+
+	if (win->index == 0) {
+		dev_err(sfb->dev,
+			"Alpha mode for window %d is not supported.\n",
+			win->index);
+		return -EINVAL;
+	}
+
+	wincon_reg = readl(sfb->regs + WINCONx(win->index));
+	wincon_reg &= ~(WINCONx_BLD_PIX | WINCONx_ALPHA_SEL);
+
+	switch (mode) {
+	case S3CFB_ALPHA_PIXEL_VALUE:
+		/* Use alpha value of each pixel */
+		wincon_reg |= WINCONx_BLD_PIX | WINCONx_ALPHA_SEL;
+		break;
+	case S3CFB_ALPHA_PIXEL_SWITCH:
+		/* Use global alpha chosen by the alpha bit of each pixel */
+		wincon_reg |= WINCONx_BLD_PIX;
+		break;
+	case S3CFB_ALPHA_PLANE_0:
+		/* Use global alpha0 for every pixel */
+		wincon_reg &= ~WINCONx_BLD_PIX;
+		break;
+	case S3CFB_ALPHA_PLANE_1:
+		/* Use global alpha1 for every pixel */
+		wincon_reg &= ~WINCONx_BLD_PIX;
+		wincon_reg |= WINCONx_ALPHA_SEL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	writel(wincon_reg, sfb->regs + WINCONx(win->index));
+
+	return 0;
+}
+
+static int s3c_fb_set_win_alpha(struct s3c_fb_win *win,
+				struct s3c_fb_alpha *alpha)
+{
+	struct s3c_fb *sfb = win->parent;
+	u32 vidosdc_reg = 0;
+
+	if (win->index == 0) {
+		dev_err(sfb->dev, "Alpha cannot be set for window %d\n.",
+			win->index);
+	}
+
+	vidosdc_reg = alpha->r0 << 20 | alpha->g0 << 16 | alpha->b0 << 12
+		    | alpha->r1 << 8  | alpha->g1 << 4  | alpha->b1;
+	writel(vidosdc_reg, sfb->regs + VIDOSD_C(win->index));
+
+	return 0;
+}
+
 static int s3c_fb_ioctl(struct fb_info *info, unsigned int cmd,
 			unsigned long arg)
 {
@@ -1039,6 +1100,20 @@ static int s3c_fb_ioctl(struct fb_info *info, unsigned int cmd,
 
 	case S3CFB_IOCTL_SET_SOURCE:
 		return s3c_fb_set_source(win, arg);
+
+	case S3CFB_IOCTL_SET_ALPHA_MODE:
+		return s3c_fb_set_alpha_mode(win, arg);
+
+	case S3CFB_IOCTL_SET_WINDOW_ALPHA: {
+		struct s3c_fb_alpha alpha_arg;
+		ret = copy_from_user(&alpha_arg, (void __user *)arg,
+				     sizeof(struct s3c_fb_alpha));
+		if (ret)
+			return ret;
+
+		return s3c_fb_set_win_alpha(win, &alpha_arg);
+		}
+
 	default:
 		return -ENOTTY;
 	}
-- 
1.6.4.2.253.g0b1fac
