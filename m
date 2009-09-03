From: Pawel Osciak <p.osciak@samsung.com>
Subject: [PATCH v2 2/3] [ARM] s3c-fb: Added support for panning the display in
	both directions.
Date: Thu, 03 Sep 2009 14:44:48 +0200
Message-ID: <E4D3F24EA6C9E54F817833EAE0D912AC077065804A@bssrvexch01.BS.local>
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

This patch supports all bpp modes.

It includes a feature (a "protect" register) that blocks in-hardware
updates of registers which store start and end addresses of the fb memory
while it is turned on.

This prevents display corruption in case we don't make it before vsync with
updating both start and end registers.


Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Pawel Osciak <p.osciak@samsung.com>

---
 arch/arm/mach-s3c6400/include/mach/regs-fb.h |    5 ++
 drivers/video/s3c-fb.c                       |   58 ++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c6400/include/mach/regs-fb.h b/arch/arm/mach-s3c6400/include/mach/regs-fb.h
index 4701979..6339426 100644
--- a/arch/arm/mach-s3c6400/include/mach/regs-fb.h
+++ b/arch/arm/mach-s3c6400/include/mach/regs-fb.h
@@ -29,6 +29,11 @@
 #define S3C_FB_MAX_WIN (5)  /* number of hardware windows available. */
 #define VIDCON1_FSTATUS_EVEN	(1 << 15)
 
+/* Protect control register, turns on/off per-frame shadow registers update */
+#define PRTCON					(0x0C)
+#define PRTCON_PROTECT				(1 << 11)
+#define PRTCON_NOPROTECT			(0 << 11)
+
 /* Video timing controls */
 #define VIDTCON0				(0x10)
 #define VIDTCON1				(0x14)
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 5a72083..3dd4327 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -294,6 +294,8 @@ static int s3c_fb_set_par(struct fb_info *info)
 	}
 
 	info->fix.line_length = (var->xres_virtual * var->bits_per_pixel) / 8;
+	info->fix.xpanstep = info->var.xres_virtual > info->var.xres ? 1 : 0;
+	info->fix.ypanstep = info->var.yres_virtual > info->var.yres ? 1 : 0;
 
 	/* disable the window whilst we update it */
 	writel(0, regs + WINCON(win_no));
@@ -640,6 +642,61 @@ static int s3c_fb_blank(int blank_mode, struct fb_info *info)
 	return 0;
 }
 
+/**
+ * s3c_fb_pan_display() - Pan the display.
+ *
+ * Note, that the offsets can be written to the device at any time, as their
+ * values are latched at each vsync automatically. This also means that only
+ * the last call to this function will have any effect on next vsync, but
+ * there is no need to sleep waiting for it to prevent tearing.
+ *
+ * @var: The screen information to verify.
+ * @info: The framebuffer device.
+ */
+static int s3c_fb_pan_display(struct fb_var_screeninfo *var,
+			      struct fb_info *info)
+{
+	struct s3c_fb_win *win	= info->par;
+	struct s3c_fb *sfb	= win->parent;
+	unsigned int start_byte_offset, end_byte_offset;
+
+	/* Offset in bytes to the start of the displayed area */
+	start_byte_offset = var->yoffset * info->fix.line_length;
+	/* X offset depends on the current bpp */
+	if (info->var.bits_per_pixel >= 8) {
+		start_byte_offset +=
+			var->xoffset * (info->var.bits_per_pixel >> 3);
+	} else {
+		switch (info->var.bits_per_pixel) {
+		case 4:
+			start_byte_offset += var->xoffset >> 1;
+			break;
+		case 2:
+			start_byte_offset += var->xoffset >> 2;
+			break;
+		case 1:
+			start_byte_offset += var->xoffset >> 3;
+			break;
+		default:
+			dev_err(sfb->dev, "invalid bpp\n");
+			return -EINVAL;
+		}
+	}
+	/* Offset in bytes to the end of the displayed area */
+	end_byte_offset = start_byte_offset + var->yres * info->fix.line_length;
+
+	/* Temporarily turn off per-frame shadow registers update until both
+	 * start and end are updated to prevent corruption */
+	writel(PRTCON_PROTECT, sfb->regs + PRTCON);
+	writel(info->fix.smem_start + start_byte_offset,
+	       sfb->regs + VIDW_BUF_START(win->index));
+	writel(info->fix.smem_start + end_byte_offset,
+	       sfb->regs + VIDW_BUF_END(win->index));
+	writel(PRTCON_NOPROTECT, sfb->regs + PRTCON);
+
+	return 0;
+}
+
 static struct fb_ops s3c_fb_ops = {
 	.owner		= THIS_MODULE,
 	.fb_check_var	= s3c_fb_check_var,
@@ -649,6 +706,7 @@ static struct fb_ops s3c_fb_ops = {
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
+	.fb_pan_display	= s3c_fb_pan_display,
 };
 
 /**
-- 
1.6.4.2.253.g0b1fac
