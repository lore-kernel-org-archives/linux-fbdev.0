From: Pawel Osciak <p.osciak@samsung.com>
Date: Mon, 31 May 2010 09:08:55 +0000
Subject: [PATCH 6/6] s3c-fb: Add wait for VSYNC ioctl
Message-Id: <1275296935-2693-7-git-send-email-p.osciak@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1275296935-2693-1-git-send-email-p.osciak@samsung.com>
In-Reply-To: <1275296935-2693-1-git-send-email-p.osciak@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add VSYNC interrupt support and an ioctl that allows waiting for it.
Interrupts are turned on only when needed.

Signed-off-by: Pawel Osciak <p.osciak@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/include/plat/regs-fb.h |    1 +
 drivers/video/s3c-fb.c                       |  171 +++++++++++++++++++++++++-
 2 files changed, 171 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/regs-fb.h b/arch/arm/plat-samsung/include/plat/regs-fb.h
index f454e32..5bcdd09 100644
--- a/arch/arm/plat-samsung/include/plat/regs-fb.h
+++ b/arch/arm/plat-samsung/include/plat/regs-fb.h
@@ -298,6 +298,7 @@
 #define VIDINTCON0_FRAMESEL0_FRONTPORCH		(0x3 << 15)
 
 #define VIDINTCON0_FRAMESEL1			(1 << 13)
+#define VIDINTCON0_FRAMESEL1_MASK		(0x3 << 13)
 #define VIDINTCON0_FRAMESEL1_NONE		(0x0 << 13)
 #define VIDINTCON0_FRAMESEL1_BACKPORCH		(0x1 << 13)
 #define VIDINTCON0_FRAMESEL1_VSYNC		(0x2 << 13)
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 4f3680d..0dfa8b0 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -21,6 +21,8 @@
 #include <linux/clk.h>
 #include <linux/fb.h>
 #include <linux/io.h>
+#include <linux/uaccess.h>
+#include <linux/interrupt.h>
 
 #include <mach/map.h>
 #include <plat/regs-fb-v4.h>
@@ -48,6 +50,15 @@
 	__raw_writel(v, r); } while(0)
 #endif /* FB_S3C_DEBUG_REGWRITE */
 
+/* irq_flags bits */
+#define S3C_FB_VSYNC_IRQ_EN	0
+
+#ifndef FBIO_WAITFORVSYNC
+#define FBIO_WAITFORVSYNC _IOW('F', 0x20, __u32)
+#endif
+
+#define VSYNC_TIMEOUT_MSEC 50
+
 struct s3c_fb;
 
 #define VALID_BPP(x) (1 << ((x) - 1))
@@ -156,6 +167,16 @@ struct s3c_fb_win {
 };
 
 /**
+ * struct s3c_fb_vsync - vsync information
+ * @wait:	a queue for processes waiting for vsync
+ * @count:	vsync interrupt count
+ */
+struct s3c_fb_vsync {
+	wait_queue_head_t	wait;
+	unsigned int		count;
+};
+
+/**
  * struct s3c_fb - overall hardware state of the hardware
  * @dev: The device that we bound to, for printing, etc.
  * @regs_res: The resource we claimed for the IO registers.
@@ -165,6 +186,9 @@ struct s3c_fb_win {
  * @enabled: A bitmask of enabled hardware windows.
  * @pdata: The platform configuration data passed with the device.
  * @windows: The hardware windows that have been claimed.
+ * @irq_no: IRQ line number
+ * @irq_flags: irq flags
+ * @vsync_info: VSYNC-related information (count, queues...)
  */
 struct s3c_fb {
 	struct device		*dev;
@@ -177,6 +201,10 @@ struct s3c_fb {
 
 	struct s3c_fb_platdata	*pdata;
 	struct s3c_fb_win	*windows[S3C_FB_MAX_WIN];
+
+	int			 irq_no;
+	unsigned long		 irq_flags;
+	struct s3c_fb_vsync	 vsync_info;
 };
 
 /**
@@ -801,6 +829,124 @@ static int s3c_fb_pan_display(struct fb_var_screeninfo *var,
 	return 0;
 }
 
+/**
+ * s3c_fb_enable_irq() - enable framebuffer interrupts
+ * @sfb: main hardware state
+ */
+static void s3c_fb_enable_irq(struct s3c_fb *sfb)
+{
+	void __iomem *regs = sfb->regs;
+	u32 irq_ctrl_reg;
+
+	if (!test_and_set_bit(S3C_FB_VSYNC_IRQ_EN, &sfb->irq_flags)) {
+		/* IRQ disabled, enable it */
+		irq_ctrl_reg = readl(regs + VIDINTCON0);
+
+		irq_ctrl_reg |= VIDINTCON0_INT_ENABLE;
+		irq_ctrl_reg |= VIDINTCON0_INT_FRAME;
+
+		irq_ctrl_reg &= ~VIDINTCON0_FRAMESEL0_MASK;
+		irq_ctrl_reg |= VIDINTCON0_FRAMESEL0_VSYNC;
+		irq_ctrl_reg &= ~VIDINTCON0_FRAMESEL1_MASK;
+		irq_ctrl_reg |= VIDINTCON0_FRAMESEL1_NONE;
+
+		writel(irq_ctrl_reg, regs + VIDINTCON0);
+	}
+}
+
+/**
+ * s3c_fb_disable_irq() - disable framebuffer interrupts
+ * @sfb: main hardware state
+ */
+static void s3c_fb_disable_irq(struct s3c_fb *sfb)
+{
+	void __iomem *regs = sfb->regs;
+	u32 irq_ctrl_reg;
+
+	if (test_and_clear_bit(S3C_FB_VSYNC_IRQ_EN, &sfb->irq_flags)) {
+		/* IRQ enabled, disable it */
+		irq_ctrl_reg = readl(regs + VIDINTCON0);
+
+		irq_ctrl_reg &= ~VIDINTCON0_INT_FRAME;
+		irq_ctrl_reg &= ~VIDINTCON0_INT_ENABLE;
+
+		writel(irq_ctrl_reg, regs + VIDINTCON0);
+	}
+}
+
+static irqreturn_t s3c_fb_irq(int irq, void *dev_id)
+{
+	struct s3c_fb *sfb = dev_id;
+	void __iomem  *regs = sfb->regs;
+	u32 irq_sts_reg;
+
+	irq_sts_reg = readl(regs + VIDINTCON1);
+
+	if (irq_sts_reg & VIDINTCON1_INT_FRAME) {
+
+		/* VSYNC interrupt, accept it */
+		writel(VIDINTCON1_INT_FRAME, regs + VIDINTCON1);
+
+		sfb->vsync_info.count++;
+		wake_up_interruptible(&sfb->vsync_info.wait);
+	}
+
+	/* We only support waiting for VSYNC for now, so it's safe
+	 * to always disable irqs here.
+	 */
+	s3c_fb_disable_irq(sfb);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * s3c_fb_wait_for_vsync() - sleep until next VSYNC interrupt or timeout
+ * @sfb: main hardware state
+ * @crtc: head index.
+ */
+static int s3c_fb_wait_for_vsync(struct s3c_fb *sfb, u32 crtc)
+{
+	unsigned long count;
+	int ret;
+
+	if (crtc != 0)
+		return -ENODEV;
+
+	s3c_fb_enable_irq(sfb);
+	count = sfb->vsync_info.count;
+	ret = wait_event_interruptible_timeout(sfb->vsync_info.wait,
+				       count != sfb->vsync_info.count,
+				       msecs_to_jiffies(VSYNC_TIMEOUT_MSEC));
+	if (ret = 0)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int s3c_fb_ioctl(struct fb_info *info, unsigned int cmd,
+			unsigned long arg)
+{
+	struct s3c_fb_win *win = info->par;
+	struct s3c_fb *sfb = win->parent;
+	int ret;
+	u32 crtc;
+
+	switch (cmd) {
+	case FBIO_WAITFORVSYNC:
+		if (get_user(crtc, (u32 __user *)arg)) {
+			ret = -EFAULT;
+			break;
+		}
+
+		ret = s3c_fb_wait_for_vsync(sfb, crtc);
+		break;
+	default:
+		ret = -ENOTTY;
+	}
+
+	return ret;
+}
+
 static struct fb_ops s3c_fb_ops = {
 	.owner		= THIS_MODULE,
 	.fb_check_var	= s3c_fb_check_var,
@@ -811,6 +957,7 @@ static struct fb_ops s3c_fb_ops = {
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
 	.fb_pan_display	= s3c_fb_pan_display,
+	.fb_ioctl	= s3c_fb_ioctl,
 };
 
 /**
@@ -917,6 +1064,8 @@ static int __devinit s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
 
 	dev_dbg(sfb->dev, "probing window %d, variant %p\n", win_no, variant);
 
+	init_waitqueue_head(&sfb->vsync_info.wait);
+
 	palette_size = variant->palette_sz * 4;
 
 	fbinfo = framebuffer_alloc(sizeof(struct s3c_fb_win) +
@@ -1096,6 +1245,20 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 		goto err_req_region;
 	}
 
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res) {
+		dev_err(dev, "failed to acquire irq resource\n");
+		ret = -ENOENT;
+		goto err_ioremap;
+	}
+	sfb->irq_no = res->start;
+	ret = request_irq(sfb->irq_no, s3c_fb_irq,
+			  0, "s3c_fb", sfb);
+	if (ret) {
+		dev_err(dev, "irq request failed\n");
+		goto err_ioremap;
+	}
+
 	dev_dbg(dev, "got resources (regs %p), probing windows\n", sfb->regs);
 
 	/* setup gpio and output polarity controls */
@@ -1130,7 +1293,7 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 			dev_err(dev, "failed to create window %d\n", win);
 			for (; win >= 0; win--)
 				s3c_fb_release_win(sfb, sfb->windows[win]);
-			goto err_ioremap;
+			goto err_irq;
 		}
 	}
 
@@ -1138,6 +1301,9 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_irq:
+	free_irq(sfb->irq_no, sfb);
+
 err_ioremap:
 	iounmap(sfb->regs);
 
@@ -1170,6 +1336,8 @@ static int __devexit s3c_fb_remove(struct platform_device *pdev)
 		if (sfb->windows[win])
 			s3c_fb_release_win(sfb, sfb->windows[win]);
 
+	free_irq(sfb->irq_no, sfb);
+
 	iounmap(sfb->regs);
 
 	clk_disable(sfb->bus_clk);
@@ -1370,6 +1538,7 @@ static struct s3c_fb_driverdata s3c_fb_data_s5pv210 __devinitdata = {
 			[3] = 0x3000,
 			[4] = 0x3400,
 		},
+
 	},
 	.win[0]	= &s3c_fb_data_64xx_wins[0],
 	.win[1]	= &s3c_fb_data_64xx_wins[1],
-- 
1.7.0.4

