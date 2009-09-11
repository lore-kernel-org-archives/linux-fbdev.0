From: Pawel Osciak <p.osciak@samsung.com>
Subject: [PATCH 7/7] [ARM] s3c-fb: Added color key blending.
Date: Fri, 11 Sep 2009 20:05:04 +0200
Message-ID: <E4D3F24EA6C9E54F817833EAE0D912AC0771185D5E@bssrvexch01.BS.local>
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

This feature allows blending based on color key value.
Pixels with key value get blended with alpha1, while the rest
gets blended with alpha0.

Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Pawel Osciak <p.osciak@samsung.com>

---
 arch/arm/plat-s3c/include/plat/s3c-fb.h |    2 ++
 drivers/video/s3c-fb.c                  |   27 ++++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-s3c/include/plat/s3c-fb.h b/arch/arm/plat-s3c/include/plat/s3c-fb.h
index 080524d..def54ec 100644
--- a/arch/arm/plat-s3c/include/plat/s3c-fb.h
+++ b/arch/arm/plat-s3c/include/plat/s3c-fb.h
@@ -67,6 +67,8 @@ typedef enum s3c_fb_alpha_mode {
 #define S3CFB_IOCTL_SET_COLOR_KEY_MODE	_IO(S3CFB_IOCTL_MAGIC, 2)
 /* param: 1 - on, 0 - off */
 #define S3CFB_IOCTL_COLOR_KEY_ENABLE	_IO(S3CFB_IOCTL_MAGIC, 3)
+/* param: 1 - on, 0 - off */
+#define S3CFB_IOCTL_COLOR_KEY_BLEND_ENABLE _IO(S3CFB_IOCTL_MAGIC, 8)
 
 
 /* Param: s3c_fb_source */
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 6721f20..5ea6a5b 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -926,7 +926,8 @@ static int s3c_fb_color_key_enable(struct s3c_fb_win *win, int enable)
 	int keycon0_reg;
 
 	if (! has_colorkey(win->index)) {
-		dev_err(sfb->dev, "Window does not support color keying\n");
+		dev_err(sfb->dev, "Window %d does not support color keying\n",
+			win->index);
 		return -EINVAL;
 	}
 
@@ -941,6 +942,27 @@ static int s3c_fb_color_key_enable(struct s3c_fb_win *win, int enable)
 	return 0;
 }
 
+static int s3c_fb_color_key_blending_enable(struct s3c_fb_win *win, int enable)
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
+	if (enable)
+		keycon0_reg |= WxKEYCON0_KEYBL_EN;
+	else
+		keycon0_reg &= ~WxKEYCON0_KEYBL_EN;
+
+	writel(keycon0_reg, sfb->regs + WxKEYCON0(win->index));
+
+	return 0;
+}
 static int s3c_fb_set_color_key_mode(struct s3c_fb_win *win,
 				     enum s3c_fb_color_key_mode mode)
 {
@@ -1115,6 +1137,9 @@ static int s3c_fb_ioctl(struct fb_info *info, unsigned int cmd,
 	case S3CFB_IOCTL_COLOR_KEY_ENABLE:
 		return s3c_fb_color_key_enable(win, arg);
 
+	case S3CFB_IOCTL_COLOR_KEY_BLEND_ENABLE:
+		return s3c_fb_color_key_blending_enable(win, arg);
+
 
 	case S3CFB_IOCTL_SET_SOURCE:
 		return s3c_fb_set_source(win, arg);
-- 
1.6.4.2.253.g0b1fac
