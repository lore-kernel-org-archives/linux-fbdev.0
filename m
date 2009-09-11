From: Pawel Osciak <p.osciak@samsung.com>
Subject: [PATCH 1/7] [ARM] s3c-fb: Added colorkey support
Date: Fri, 11 Sep 2009 20:04:48 +0200
Message-ID: <E4D3F24EA6C9E54F817833EAE0D912AC0771185D58@bssrvexch01.BS.local>
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
 arch/arm/plat-s3c/include/plat/regs-fb.h |    3 +
 arch/arm/plat-s3c/include/plat/s3c-fb.h  |   45 ++++++++
 drivers/video/s3c-fb.c                   |  164 ++++++++++++++++++++++++++++++
 3 files changed, 212 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-s3c/include/plat/s3c-fb.h

diff --git a/arch/arm/plat-s3c/include/plat/regs-fb.h b/arch/arm/plat-s3c/include/plat/regs-fb.h
index 8048cae..8d3071d 100644
--- a/arch/arm/plat-s3c/include/plat/regs-fb.h
+++ b/arch/arm/plat-s3c/include/plat/regs-fb.h
@@ -323,6 +323,7 @@
 
 /* Window colour-key control registers */
 
+#define WxKEYCON0(_x)				(0x140 + ((_x-1) * 8))
 #define WxKEYCON0_KEYBL_EN			(1 << 26)
 #define WxKEYCON0_KEYEN_F			(1 << 25)
 #define WxKEYCON0_DIRCON			(1 << 24)
@@ -330,6 +331,8 @@
 #define WxKEYCON0_COMPKEY_SHIFT			(0)
 #define WxKEYCON0_COMPKEY_LIMIT			(0xffffff)
 #define WxKEYCON0_COMPKEY(_x)			((_x) << 0)
+
+#define WxKEYCON1(_x)				(0x144 + ((_x-1) * 8))
 #define WxKEYCON1_COLVAL_MASK			(0xffffff << 0)
 #define WxKEYCON1_COLVAL_SHIFT			(0)
 #define WxKEYCON1_COLVAL_LIMIT			(0xffffff)
diff --git a/arch/arm/plat-s3c/include/plat/s3c-fb.h b/arch/arm/plat-s3c/include/plat/s3c-fb.h
new file mode 100644
index 0000000..0aebc40
--- /dev/null
+++ b/arch/arm/plat-s3c/include/plat/s3c-fb.h
@@ -0,0 +1,45 @@
+/*
+ * include/linux/s3c/s3c-fb.h
+ *
+ * Copyright 2009 Samsung Electronics Co., Ltd.
+ * Author:  Pawel Osciak <p.osciak@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_S3C_FB_H__
+#define __LINUX_S3C_FB_H__
+
+#include <linux/types.h>
+
+struct s3c_fb_color {
+	__u32 a : 8;
+	__u32 r : 8;
+	__u32 g : 8;
+	__u32 b : 8;
+} __attribute__((__packed__));
+
+typedef enum s3c_fb_color_key_mode {
+	S3CFB_COLORKEY_MODE_BG = 0,
+	S3CFB_COLORKEY_MODE_FG = 1
+} s3c_fb_color_key_mode_t;
+
+#ifndef FBIO_WAITFORVSYNC
+#define FBIO_WAITFORVSYNC _IOW('F', 0x20, __u32)
+#endif
+
+#define S3CFB_IOCTL_MAGIC 'k'
+
+#define S3CFB_IOCTL_SET_COLOR_KEY	_IOW(S3CFB_IOCTL_MAGIC, 0,\
+					struct s3c_fb_color)
+#define S3CFB_IOCTL_SET_COLOR_KEY_MASK	_IOW(S3CFB_IOCTL_MAGIC, 1,\
+					struct s3c_fb_color)
+/* param: s3c_fb_color_key_mode */
+#define S3CFB_IOCTL_SET_COLOR_KEY_MODE	_IO(S3CFB_IOCTL_MAGIC, 2)
+/* param: 1 - on, 0 - off */
+#define S3CFB_IOCTL_COLOR_KEY_ENABLE	_IO(S3CFB_IOCTL_MAGIC, 3)
+
+#endif /* __LINUX_S3C_FB_H__ */
+
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 001a1a1..2de3151 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -24,6 +24,8 @@
 #include <linux/uaccess.h>
 #include <linux/interrupt.h>
 
+#include <plat/s3c-fb.h>
+
 #include <mach/map.h>
 #include <mach/regs-fb.h>
 #include <plat/fb.h>
@@ -43,6 +45,7 @@
  * is being built for.
 */
 
+/*#define CONFIG_FB_S3C_DEBUG_REGWRITE*/
 #ifdef CONFIG_FB_S3C_DEBUG_REGWRITE
 #undef writel
 #define writel(v, r) do { \
@@ -821,11 +824,148 @@ static int s3c_fb_pan_display(struct fb_var_screeninfo *var,
 	return 0;
 }
 
+static inline int s3c_fb_color_to_rgb565(struct s3c_fb_color *color)
+{
+	return (((color->r & 0x1f) << 19) | 0x70000)
+	     | (((color->g & 0x3f) << 10) | 0x300)
+	     | (((color->b & 0x1f) <<  3) | 0x7);
+}
+
+static inline int s3c_fb_color_to_rgb888(struct s3c_fb_color *color)
+{
+	return (color->r << 16) | (color->g << 8) | color->b;
+}
+
+static inline int has_colorkey(int win_no)
+{
+	if (win_no == 0)
+		return 0;
+	else
+		return 1;
+}
+
+static int s3c_fb_set_color_key(struct s3c_fb_win *win,
+			        struct s3c_fb_color *color_key)
+{
+	struct s3c_fb *sfb = win->parent;
+	void __iomem *regs = sfb->regs;
+	int color = 0;
+
+	if (! has_colorkey(win->index)) {
+		dev_err(sfb->dev, "Window %d does not support color keying\n",
+			win->index);
+		return -EINVAL;
+	}
+
+	dev_info(sfb->dev, "Window %d, BPP: %d\n", win->index,
+		 win->fbinfo->var.bits_per_pixel);
+
+	if (win->fbinfo->var.bits_per_pixel == 16) {
+		color = s3c_fb_color_to_rgb565(color_key);
+	} else if (win->fbinfo->var.bits_per_pixel >= 24) {
+		  /*|| win->fbinfo->var.bits_per_pixel == 28) {*/
+		color = s3c_fb_color_to_rgb888(color_key);
+	} else {
+		dev_err(sfb->dev, "Invalid BPP\n");
+		return -EINVAL;
+	}
+
+	writel(color, regs + WxKEYCON1(win->index));
+
+	return 0;
+}
+
+static int s3c_fb_set_color_key_mask(struct s3c_fb_win *win,
+				     struct s3c_fb_color *color_key_mask)
+{
+	struct s3c_fb *sfb = win->parent;
+	void __iomem *regs = sfb->regs;
+	int keycon0_reg;
+	int mask = 0;
+
+	if (! has_colorkey(win->index)) {
+		dev_err(sfb->dev, "Window %d does not support color keying\n",
+			win->index);
+		return -EINVAL;
+	}
+
+	if (win->fbinfo->var.bits_per_pixel == 16) {
+		mask = s3c_fb_color_to_rgb565(color_key_mask);
+	} else if (win->fbinfo->var.bits_per_pixel >= 24) {
+		  /*|| win->fbinfo->var.bits_per_pixel == 28) {*/
+		mask = s3c_fb_color_to_rgb888(color_key_mask);
+	} else {
+		dev_err(sfb->dev, "Invalid BPP\n");
+		return -EINVAL;
+	}
+
+	keycon0_reg = readl(regs + WxKEYCON0(win->index));
+	keycon0_reg &= ~WxKEYCON0_COMPKEY_MASK;
+	keycon0_reg |= mask;
+	writel(keycon0_reg, regs + WxKEYCON0(win->index));
+
+	return 0;
+}
+
+static int s3c_fb_color_key_enable(struct s3c_fb_win *win, int enable)
+{
+	struct s3c_fb *sfb = win->parent;
+	int keycon0_reg;
+
+	if (! has_colorkey(win->index)) {
+		dev_err(sfb->dev, "Window does not support color keying\n");
+		return -EINVAL;
+	}
+
+	keycon0_reg = readl(sfb->regs + WxKEYCON0(win->index));
+	if (enable)
+		keycon0_reg |= WxKEYCON0_KEYEN_F;
+	else
+		keycon0_reg &= ~WxKEYCON0_KEYEN_F;
+
+	writel(keycon0_reg, sfb->regs + WxKEYCON0(win->index));
+
+	return 0;
+}
+
+static int s3c_fb_set_color_key_mode(struct s3c_fb_win *win,
+				     enum s3c_fb_color_key_mode mode)
+{
+	struct s3c_fb *sfb = win->parent;
+	int keycon0_reg;
+
+	if (! has_colorkey(win->index)) {
+		dev_err(sfb->dev, "Window %d does not support color keying\n",
+			win->index);
+		return -EINVAL;
+	}
+
+	keycon0_reg = readl(sfb->regs + WxKEYCON0(win->index));
+
+	switch(mode) {
+	case S3CFB_COLORKEY_MODE_BG:
+		keycon0_reg &= ~WxKEYCON0_DIRCON;
+		break;
+	case S3CFB_COLORKEY_MODE_FG:
+		keycon0_reg |= WxKEYCON0_DIRCON;
+		break;
+	default:
+		dev_err(sfb->dev, "Invalid colorkey mode\n");
+		return -EINVAL;
+	}
+
+	writel(keycon0_reg, sfb->regs + WxKEYCON0(win->index));
+	s3c_fb_color_key_enable(win, 1);
+
+	return 0;
+}
+
 static int s3c_fb_ioctl(struct fb_info *info, unsigned int cmd,
 			unsigned long arg)
 {
 	struct s3c_fb_win *win = info->par;
 	struct s3c_fb *sfb = win->parent;
+	int ret;
 
 	switch (cmd) {
 	case FBIO_WAITFORVSYNC: {
@@ -835,6 +975,30 @@ static int s3c_fb_ioctl(struct fb_info *info, unsigned int cmd,
 
 		return s3c_fb_wait_for_vsync(sfb, crtc);
 		}
+	case S3CFB_IOCTL_SET_COLOR_KEY: {
+		struct s3c_fb_color ck_arg;
+		ret = copy_from_user(&ck_arg, (void __user *)arg,
+				     sizeof(struct s3c_fb_color));
+		if (ret)
+			return ret;
+
+		return s3c_fb_set_color_key(win, &ck_arg);
+		}
+	case S3CFB_IOCTL_SET_COLOR_KEY_MASK: {
+		struct s3c_fb_color ck_mask_arg;
+		ret = copy_from_user(&ck_mask_arg, (void __user *)arg,
+				     sizeof(struct s3c_fb_color));
+		if (ret)
+			return ret;
+
+		return s3c_fb_set_color_key_mask(win, &ck_mask_arg);
+		}
+	case S3CFB_IOCTL_SET_COLOR_KEY_MODE:
+		return s3c_fb_set_color_key_mode(win, arg);
+
+	case S3CFB_IOCTL_COLOR_KEY_ENABLE:
+		return s3c_fb_color_key_enable(win, arg);
+
 	default:
 		return -ENOTTY;
 	}
-- 
1.6.4.2.253.g0b1fac
