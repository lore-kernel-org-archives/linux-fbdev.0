From: Pawel Osciak <p.osciak@samsung.com>
Subject: [PATCH 2/7] [ARM] s3c-fb: Added window source
	selection.
Date: Fri, 11 Sep 2009 20:04:52 +0200
Message-ID: <E4D3F24EA6C9E54F817833EAE0D912AC0771185D59@bssrvexch01.BS.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <p.osciak@samsung.com>) id 1MmAVb-000265-QM
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 11 Sep 2009 18:06:07 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MmAVV-0006mf-Qs for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 11 Sep 2009 18:06:07 +0000
Received: from eu_spt1 (mailout1.w1.samsung.com [210.118.77.11])
	by mailout1.w1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KPT00L3WJLUQI@mailout1.w1.samsung.com> for
	linux-fbdev-devel@lists.sourceforge.net;
	Fri, 11 Sep 2009 19:05:54 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
	by spt1.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul
	14 2004)) with ESMTPA id <0KPT005R2JLU5M@spt1.w1.samsung.com> for
	linux-fbdev-devel@lists.sourceforge.net;
	Fri, 11 Sep 2009 19:05:54 +0100 (BST)
Content-language: en-US
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>
Cc: Pawel Osciak <p.osciak@samsung.com>, =?utf-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "adaplas@gmail.com" <adaplas@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>

It is now possible to switch between local bus and DMA as the source
for a window. Local source mode can handle RGB and YCbCr formats.

Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Pawel Osciak <p.osciak@samsung.com>

---
 arch/arm/plat-s3c/include/plat/regs-fb.h |    1 +
 arch/arm/plat-s3c/include/plat/s3c-fb.h  |    9 ++++++
 drivers/video/s3c-fb.c                   |   40 ++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c/include/plat/regs-fb.h b/arch/arm/plat-s3c/include/plat/regs-fb.h
index 8d3071d..4c024ca 100644
--- a/arch/arm/plat-s3c/include/plat/regs-fb.h
+++ b/arch/arm/plat-s3c/include/plat/regs-fb.h
@@ -170,6 +170,7 @@
 /* WINCONx */
 
 
+#define WINCONx(_x)				(0x20 + ((_x) * 4))
 #define WINCONx_BITSWP				(1 << 18)
 #define WINCONx_BYTSWP				(1 << 17)
 #define WINCONx_HAWSWP				(1 << 16)
diff --git a/arch/arm/plat-s3c/include/plat/s3c-fb.h b/arch/arm/plat-s3c/include/plat/s3c-fb.h
index 0aebc40..b08f9ad 100644
--- a/arch/arm/plat-s3c/include/plat/s3c-fb.h
+++ b/arch/arm/plat-s3c/include/plat/s3c-fb.h
@@ -26,6 +26,12 @@ typedef enum s3c_fb_color_key_mode {
 	S3CFB_COLORKEY_MODE_FG = 1
 } s3c_fb_color_key_mode_t;
 
+typedef enum s3c_fb_source {
+	S3CFB_SOURCE_DMA = 0,
+	S3CFB_SOURCE_LOCAL_RGB = 1,
+	S3CFB_SOURCE_LOCAL_YCbCr = 2
+} s3c_fb_source_t;
+
 #ifndef FBIO_WAITFORVSYNC
 #define FBIO_WAITFORVSYNC _IOW('F', 0x20, __u32)
 #endif
@@ -41,5 +47,8 @@ typedef enum s3c_fb_color_key_mode {
 /* param: 1 - on, 0 - off */
 #define S3CFB_IOCTL_COLOR_KEY_ENABLE	_IO(S3CFB_IOCTL_MAGIC, 3)
 
+
+/* Param: s3c_fb_source */
+#define S3CFB_IOCTL_SET_SOURCE		_IO(S3CFB_IOCTL_MAGIC, 5)
 #endif /* __LINUX_S3C_FB_H__ */
 
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 2de3151..28622c0 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -960,6 +960,43 @@ static int s3c_fb_set_color_key_mode(struct s3c_fb_win *win,
 	return 0;
 }
 
+static int s3c_fb_set_source(struct s3c_fb_win *win, s3c_fb_source_t source)
+{
+	struct s3c_fb *sfb = win->parent;
+	int wincon_reg, new_val;
+
+	if (win->index > 2) {
+		dev_err(sfb->dev, "Source change not supported for window %d\n",
+			win->index);
+		return -EINVAL;
+	}
+
+	wincon_reg = readl(sfb->regs + WINCONx(win->index));
+	new_val = wincon_reg;
+
+	switch (source) {
+	case S3CFB_SOURCE_DMA:
+		new_val &= ~(WINCONx_ENLOCAL | WINCONx_YCbCr);
+		break;
+	case S3CFB_SOURCE_LOCAL_RGB:
+		new_val &= ~WINCONx_YCbCr;
+		new_val |= WINCONx_ENLOCAL;
+		break;
+	case S3CFB_SOURCE_LOCAL_YCbCr:
+		new_val |= WINCONx_YCbCr | WINCONx_ENLOCAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* The window has to be disabled during source switch */
+	writel(wincon_reg & ~WINCONx_ENWIN, sfb->regs + WINCONx(win->index));
+	new_val |= WINCONx_ENWIN;
+	writel(new_val, sfb->regs + WINCONx(win->index));
+
+	return 0;
+}
+
 static int s3c_fb_ioctl(struct fb_info *info, unsigned int cmd,
 			unsigned long arg)
 {
@@ -999,6 +1036,9 @@ static int s3c_fb_ioctl(struct fb_info *info, unsigned int cmd,
 	case S3CFB_IOCTL_COLOR_KEY_ENABLE:
 		return s3c_fb_color_key_enable(win, arg);
 
+
+	case S3CFB_IOCTL_SET_SOURCE:
+		return s3c_fb_set_source(win, arg);
 	default:
 		return -ENOTTY;
 	}
-- 
1.6.4.2.253.g0b1fac


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
