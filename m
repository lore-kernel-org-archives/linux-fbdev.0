From: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
Date: Wed, 25 Feb 2015 21:01:21 +0000
Subject: [PATCH] video: ARM CLCD: Added support for FBIO_WAITFORVSYNC
Message-Id: <1424898082-1522-3-git-send-email-arun.ramamurthy@broadcom.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1424898082-1522-1-git-send-email-arun.ramamurthy@broadcom.com>
In-Reply-To: <1424898082-1522-1-git-send-email-arun.ramamurthy@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Jonathan Richardson <jonathar@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Arun Ramamurthy <arun.ramamurthy@broadcom.com>

Added ioctl and interrupt handler functions to support FBIO_WAITFORVSYNC
Also corrected documentation to make interrupts and interrupt-names
optional as they are not required properties.

Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
Signed-off-by: Arun Ramamurthy <arun.ramamurthy@broadcom.com>0
---
 .../devicetree/bindings/video/arm,pl11x.txt        | 11 +--
 drivers/video/fbdev/amba-clcd.c                    | 82 ++++++++++++++++++++++
 include/linux/amba/clcd.h                          |  4 ++
 3 files changed, 89 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/video/arm,pl11x.txt b/Documentation/devicetree/bindings/video/arm,pl11x.txt
index 2262cdb..7d19024 100644
--- a/Documentation/devicetree/bindings/video/arm,pl11x.txt
+++ b/Documentation/devicetree/bindings/video/arm,pl11x.txt
@@ -10,14 +10,6 @@ Required properties:
 
 - reg: base address and size of the control registers block
 
-- interrupt-names: either the single entry "combined" representing a
-	combined interrupt output (CLCDINTR), or the four entries
-	"mbe", "vcomp", "lnbu", "fuf" representing the individual
-	CLCDMBEINTR, CLCDVCOMPINTR, CLCDLNBUINTR, CLCDFUFINTR interrupts
-
-- interrupts: contains an interrupt specifier for each entry in
-	interrupt-names
-
 - clock-names: should contain "clcdclk" and "apb_pclk"
 
 - clocks: contains phandle and clock specifier pairs for the entries
@@ -54,6 +46,9 @@ Optional properties:
 	It can be used to configure a virtual y resolution. It
 	must be a value larger than the actual y resolution.
 
+- interrupts: contains an interrupt specifier for the clcd vcomp interrupt
+	 This is required for the driver to handle FBIO_WAITFORVSYNC ioctls.
+
 Required sub-nodes:
 
 - port: describes LCD panel signals, following the common binding
diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index 3bc09ad..9f7a58c 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -30,6 +30,8 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_graph.h>
+#include <linux/of_irq.h>
+#include <linux/interrupt.h>
 #include <video/display_timing.h>
 #include <video/of_display_timing.h>
 #include <video/videomode.h>
@@ -466,6 +468,73 @@ static int clcdfb_pan_display(struct fb_var_screeninfo *var,
 	return 0;
 }
 
+static int clcdfb_ioctl(struct fb_info *info,
+			unsigned int cmd, unsigned long args)
+{
+	struct clcd_fb *fb = to_clcd(info);
+	int retval = 0;
+	u32 val, ienb_val;
+
+	switch (cmd) {
+	case FBIO_WAITFORVSYNC:{
+		if (fb->lcd_irq <= 0) {
+			retval = -EINVAL;
+			break;
+		}
+		/* disable Vcomp interrupts */
+		ienb_val = readl(fb->regs + fb->off_ienb);
+		ienb_val &= ~CLCD_PL111_IENB_VCOMP;
+		writel(ienb_val, fb->regs + fb->off_ienb);
+
+		/* clear Vcomp interrupt */
+		writel(CLCD_PL111_IENB_VCOMP, fb->regs + CLCD_PL111_ICR);
+
+		/* Generate Interrupt at the start of Vsync */
+		reinit_completion(&fb->wait);
+		val = readl(fb->regs +  fb->off_cntl);
+		val &= ~(CNTL_LCDVCOMP(3));
+		writel(val, fb->regs + fb->off_cntl);
+
+		/* enable Vcomp interrupt */
+		ienb_val = readl(fb->regs + fb->off_ienb);
+		ienb_val |= CLCD_PL111_IENB_VCOMP;
+		writel(ienb_val, fb->regs + fb->off_ienb);
+		if (!wait_for_completion_interruptible_timeout
+			(&fb->wait, HZ/10))
+			retval = -ETIMEDOUT;
+		break;
+	}
+	default:
+		retval = -ENOIOCTLCMD;
+		break;
+	}
+	return retval;
+}
+
+static irqreturn_t clcd_interrupt(int irq, void *data)
+{
+	struct clcd_fb *fb = data;
+	u32 val;
+
+	/* check for vsync interrupt */
+	val = readl(fb->regs + CLCD_PL111_MIS);
+
+	if (val & CLCD_PL111_IENB_VCOMP) {
+		val = readl(fb->regs + fb->off_ienb);
+		val &= ~CLCD_PL111_IENB_VCOMP;
+
+		/* disable Vcomp interrupts */
+		writel(val, fb->regs + fb->off_ienb);
+
+		/* clear Vcomp interrupt */
+		writel(CLCD_PL111_IENB_VCOMP, fb->regs + CLCD_PL111_ICR);
+
+		complete(&fb->wait);
+		return IRQ_HANDLED;
+	}
+	return IRQ_NONE;
+}
+
 static struct fb_ops clcdfb_ops = {
 	.owner		= THIS_MODULE,
 	.fb_check_var	= clcdfb_check_var,
@@ -477,6 +546,7 @@ static struct fb_ops clcdfb_ops = {
 	.fb_imageblit	= cfb_imageblit,
 	.fb_mmap	= clcdfb_mmap,
 	.fb_pan_display	= clcdfb_pan_display,
+	.fb_ioctl	= clcdfb_ioctl,
 };
 
 static int clcdfb_register(struct clcd_fb *fb)
@@ -753,6 +823,18 @@ static int clcdfb_of_init_display(struct clcd_fb *fb)
 	else
 		fb->fb.var.yres_virtual = yres_virtual;
 
+	fb->lcd_irq = irq_of_parse_and_map(fb->dev->dev.of_node, 0);
+	if (fb->lcd_irq > 0) {
+		err = devm_request_irq(&fb->dev->dev,
+					fb->lcd_irq, clcd_interrupt,
+					IRQF_SHARED, "clcd", fb);
+		if (err < 0) {
+			dev_err(&fb->dev->dev, "unable to register CLCD interrupt\n");
+			return err;
+		}
+		init_completion(&fb->wait);
+	}
+
 	if (of_property_read_u32_array(endpoint,
 			"arm,pl11x,tft-r0g0b0-pads",
 			tft_r0b0g0, ARRAY_SIZE(tft_r0b0g0)) = 0)
diff --git a/include/linux/amba/clcd.h b/include/linux/amba/clcd.h
index e82e3ee..6a3bc2d 100644
--- a/include/linux/amba/clcd.h
+++ b/include/linux/amba/clcd.h
@@ -28,6 +28,8 @@
 #define CLCD_PL110_UCUR		0x00000028
 #define CLCD_PL110_LCUR		0x0000002C
 
+#define CLCD_PL111_IENB_VCOMP	(1 << 3)
+
 #define CLCD_PL111_CNTL		0x00000018
 #define CLCD_PL111_IENB		0x0000001c
 #define CLCD_PL111_RIS		0x00000020
@@ -184,6 +186,8 @@ struct clcd_fb {
 	u32			clcd_cntl;
 	u32			cmap[16];
 	bool			clk_enabled;
+	struct completion	wait;
+	int			lcd_irq;
 };
 
 static inline void clcdfb_decode(struct clcd_fb *fb, struct clcd_regs *regs)
-- 
2.3.0

