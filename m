From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Date: Tue, 01 Mar 2011 12:06:03 +0000
Subject: [RFC/PATCH 4/6] FBDEV: JZ4740: Add Smart LCD controller support
Message-Id: <56c410783be268e00d09e2c9450e56925bd815a8.1298980528.git.mcuelenaere@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch adds SLCD support to the Ingenic Jz4740 framebuffer driver.
Besides adding the new LCD types to the platform data, this adds chip select
and register select active low support (SLCD only). Also, this exports some
functions related to starting and stopping the SLCD image transfer and sending
commands.

A lot of this code was based on work by Maarten ter Huurne:
https://github.com/mthuurne/opendingux-kernel/commit/3dba5b5e7a868b1067acae8d1b5a19121b77bc6a

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/mips/include/asm/mach-jz4740/jz4740_fb.h |   33 ++
 drivers/video/jz4740_fb.c                     |  435 ++++++++++++++++++++++---
 2 files changed, 429 insertions(+), 39 deletions(-)

diff --git a/arch/mips/include/asm/mach-jz4740/jz4740_fb.h b/arch/mips/include/asm/mach-jz4740/jz4740_fb.h
index 6a50e6f..eaaac43 100644
--- a/arch/mips/include/asm/mach-jz4740/jz4740_fb.h
+++ b/arch/mips/include/asm/mach-jz4740/jz4740_fb.h
@@ -30,6 +30,13 @@ enum jz4740_fb_lcd_type {
 	JZ_LCD_TYPE_DUAL_COLOR_STN = 10,
 	JZ_LCD_TYPE_DUAL_MONOCHROME_STN = 11,
 	JZ_LCD_TYPE_8BIT_SERIAL = 12,
+
+	JZ_SLCD_TYPE_PARALLEL_8_BIT = 1 | (1 << 5),
+	JZ_SLCD_TYPE_PARALLEL_16_BIT = 0 | (1 << 5),
+	JZ_SLCD_TYPE_PARALLEL_18_BIT = 2 | (1 << 5),
+	JZ_SLCD_TYPE_SERIAL_8_BIT = 1 | (3 << 5),
+	JZ_SLCD_TYPE_SERIAL_16_BIT = 0 | (3 << 5),
+	JZ_SLCD_TYPE_SERIAL_18_BIT = 2 | (3 << 5),
 };
 
 #define JZ4740_FB_SPECIAL_TFT_CONFIG(start, stop) (((start) << 16) | (stop))
@@ -62,6 +69,32 @@ struct jz4740_fb_platform_data {
 
 	unsigned pixclk_falling_edge:1;
 	unsigned date_enable_active_low:1;
+	unsigned chip_select_active_low:1;
+	unsigned register_select_active_low:1;
 };
 
+struct platform_device;
+
+/*
+ * JzFB SLCD related functions
+ *
+ * jz4740_fb_slcd_disable_transfer: disables the current image transfer going
+ *       on between memory and the LCD controller
+ * jz4740_fb_slcd_enable_transfer: the reverse operation of the above
+ * jz4740_fb_slcd_send_cmd: sends a command without any data to the LCD
+ *       controller
+ * jz4740_fb_slcd_send_cmd_data: sends a command with a data argument to the LCD
+ *       controller
+ *
+ * These functions can sleep and thus should not be called from an atomic
+ * context. Also, make sure you disable the SLCD image transfer *before* sending
+ * any commands and do not forget to re-enable it.
+ */
+extern void jz4740_fb_slcd_disable_transfer(struct platform_device *pdev);
+extern void jz4740_fb_slcd_enable_transfer(struct platform_device *pdev);
+extern void jz4740_fb_slcd_send_cmd_data(struct platform_device *pdev,
+					 unsigned int cmd, unsigned int data);
+extern void jz4740_fb_slcd_send_cmd(struct platform_device *pdev,
+				    unsigned int cmd);
+
 #endif
diff --git a/drivers/video/jz4740_fb.c b/drivers/video/jz4740_fb.c
index 2f3ea57..4064812 100644
--- a/drivers/video/jz4740_fb.c
+++ b/drivers/video/jz4740_fb.c
@@ -26,6 +26,7 @@
 
 #include <linux/dma-mapping.h>
 
+#include <asm/mach-jz4740/dma.h>
 #include <asm/mach-jz4740/jz4740_fb.h>
 #include <asm/mach-jz4740/gpio.h>
 
@@ -107,6 +108,40 @@
 
 #define JZ_LCD_STATE_DISABLED BIT(0)
 
+#define JZ_REG_SLCD_CFG		0xA0
+#define JZ_REG_SLCD_CTRL	0xA4
+#define JZ_REG_SLCD_STATE	0xA8
+#define JZ_REG_SLCD_DATA	0xAC
+#define JZ_REG_SLCD_FIFO	0xB0
+
+#define JZ_SLCD_CFG_BURST_8_WORD	BIT(14)
+#define JZ_SLCD_CFG_DWIDTH_MASK		(7 << 10)
+#define JZ_SLCD_CFG_DWIDTH_18		(0 << 10)
+#define JZ_SLCD_CFG_DWIDTH_16		(1 << 10)
+#define JZ_SLCD_CFG_DWIDTH_8_x3		(2 << 10)
+#define JZ_SLCD_CFG_DWIDTH_8_x2		(3 << 10)
+#define JZ_SLCD_CFG_DWIDTH_8_x1		(4 << 10)
+#define JZ_SLCD_CFG_DWIDTH_9_x2		(7 << 10)
+#define JZ_SLCD_CFG_CWIDTH_MASK		(3 << 8)
+#define JZ_SLCD_CFG_CWIDTH(n)		((n) << 8)
+#define JZ_SLCD_CFG_CWIDTH_16BIT	(0 << 8)
+#define JZ_SLCD_CFG_CWIDTH_8BIT		(1 << 8)
+#define JZ_SLCD_CFG_CWIDTH_18BIT	(2 << 8)
+#define JZ_SLCD_CFG_CS_ACTIVE_HIGH	BIT(4)
+#define JZ_SLCD_CFG_RS_CMD_HIGH		BIT(3)
+#define JZ_SLCD_CFG_CLK_ACTIVE_RISING	BIT(1)
+#define JZ_SLCD_CFG_TYPE_SERIAL		BIT(0)
+
+#define JZ_SLCD_CTRL_DMA_EN		(1 << 0)
+
+#define JZ_SLCD_STATE_BUSY		(1 << 0)
+
+#define JZ_SLCD_DATA_RS_DATA		(0 << 31)
+#define JZ_SLCD_DATA_RS_COMMAND		(1 << 31)
+
+#define JZ_SLCD_FIFO_RS_DATA		(0 << 31)
+#define JZ_SLCD_FIFO_RS_COMMAND		(1 << 31)
+
 struct jzfb_framedesc {
 	uint32_t next;
 	uint32_t addr;
@@ -118,6 +153,7 @@ struct jzfb {
 	struct fb_info *fb;
 	struct platform_device *pdev;
 	void __iomem *base;
+	phys_t phys_base;
 	struct resource *mem;
 	struct jz4740_fb_platform_data *pdata;
 
@@ -126,6 +162,7 @@ struct jzfb {
 	dma_addr_t vidmem_phys;
 	struct jzfb_framedesc *framedesc;
 	dma_addr_t framedesc_phys;
+	struct jz4740_dma_chan *slcd_dma;
 
 	struct clk *ldclk;
 	struct clk *lpclk;
@@ -136,6 +173,9 @@ struct jzfb {
 	uint32_t pseudo_palette[16];
 };
 
+#define JZFB_IS_SLCD(jzfb) ((jzfb)->pdata->lcd_type & (1 << 5))
+#define JZFB_IS_SLCD_SERIAL_TYPE(jzfb) ((jzfb)->pdata->lcd_type & (2 << 5))
+
 static const struct fb_fix_screeninfo jzfb_fix __devinitdata = {
 	.id		= "JZ4740 FB",
 	.type		= FB_TYPE_PACKED_PIXELS,
@@ -192,14 +232,17 @@ static void jzfb_pins_operation(struct jzfb *jzfb,
 
 	switch (jzfb->pdata->lcd_type) {
 	case JZ_LCD_TYPE_GENERIC_16_BIT:
+	case JZ_SLCD_TYPE_PARALLEL_16_BIT:
 		ctrl_num = 4;
 		data_num = 16;
 		break;
 	case JZ_LCD_TYPE_GENERIC_18_BIT:
+	case JZ_SLCD_TYPE_PARALLEL_18_BIT:
 		ctrl_num = 4;
 		data_num = 18;
 		break;
 	case JZ_LCD_TYPE_8BIT_SERIAL:
+	case JZ_SLCD_TYPE_PARALLEL_8_BIT:
 		ctrl_num = 3;
 		data_num = 8;
 		break;
@@ -212,8 +255,17 @@ static void jzfb_pins_operation(struct jzfb *jzfb,
 		else
 			data_num = 16;
 		break;
+	case JZ_SLCD_TYPE_SERIAL_8_BIT:
+	case JZ_SLCD_TYPE_SERIAL_16_BIT:
+	case JZ_SLCD_TYPE_SERIAL_18_BIT:
+		data_start = 15;
+		data_num = 1;
+		break;
 	}
 
+	if (JZFB_IS_SLCD(jzfb))
+		ctrl_num = 3;
+
 	switch (operation) {
 	case REQUEST_PINS:
 		jz_gpio_bulk_request(jz_lcd_ctrl_pins, ctrl_num);
@@ -348,12 +400,9 @@ static int jzfb_check_var(struct fb_var_screeninfo *var, struct fb_info *fb)
 	return 0;
 }
 
-static int jzfb_set_par(struct fb_info *info)
+static void jzfb_lcd_set_par(struct jzfb *jzfb, struct fb_videomode *mode)
 {
-	struct jzfb *jzfb = info->par;
 	struct jz4740_fb_platform_data *pdata = jzfb->pdata;
-	struct fb_var_screeninfo *var = &info->var;
-	struct fb_videomode *mode;
 	uint16_t hds, vds;
 	uint16_t hde, vde;
 	uint16_t ht, vt;
@@ -361,15 +410,6 @@ static int jzfb_set_par(struct fb_info *info)
 	uint32_t cfg;
 	unsigned long rate;
 
-	mode = jzfb_get_mode(jzfb, var);
-	if (mode = NULL)
-		return -EINVAL;
-
-	if (mode = info->mode)
-		return 0;
-
-	info->mode = mode;
-
 	hds = mode->hsync_len + mode->left_margin;
 	hde = hds + mode->xres;
 	ht = hde + mode->right_margin;
@@ -478,10 +518,154 @@ static int jzfb_set_par(struct fb_info *info)
 
 	clk_set_rate(jzfb->lpclk, rate);
 	clk_set_rate(jzfb->ldclk, rate * 3);
+}
+
+static void jzfb_slcd_set_par(struct jzfb *jzfb, struct fb_videomode *mode)
+{
+	struct jz4740_fb_platform_data *pdata = jzfb->pdata;
+	uint32_t cfg;
+	unsigned long rate;
+
+	cfg = JZ_SLCD_CFG_BURST_8_WORD;
+	cfg |= JZ_SLCD_CFG_CWIDTH(jzfb->pdata->lcd_type & 3);
+
+	if (JZFB_IS_SLCD_SERIAL_TYPE(jzfb)) {
+		switch (jzfb->pdata->lcd_type) {
+		case JZ_SLCD_TYPE_SERIAL_8_BIT:
+			cfg |= JZ_SLCD_CFG_DWIDTH_8_x1;
+			break;
+		case JZ_SLCD_TYPE_SERIAL_16_BIT:
+			cfg |= JZ_SLCD_CFG_DWIDTH_16;
+			break;
+		case JZ_SLCD_TYPE_SERIAL_18_BIT:
+			cfg |= JZ_SLCD_CFG_DWIDTH_18;
+			break;
+		}
+		cfg |= JZ_SLCD_CFG_TYPE_SERIAL;
+	} else {
+		switch (jzfb->pdata->bpp) {
+		case 8:
+			cfg |= JZ_SLCD_CFG_DWIDTH_8_x1;
+			break;
+		case 15:
+		case 16:
+			switch (jzfb->pdata->lcd_type) {
+			case JZ_SLCD_TYPE_PARALLEL_8_BIT:
+				cfg |= JZ_SLCD_CFG_DWIDTH_8_x2;
+				break;
+			case JZ_SLCD_TYPE_PARALLEL_16_BIT:
+			case JZ_SLCD_TYPE_PARALLEL_18_BIT:
+				cfg |= JZ_SLCD_CFG_DWIDTH_16;
+				break;
+			}
+			break;
+		case 18:
+			switch (jzfb->pdata->lcd_type) {
+			case JZ_SLCD_TYPE_PARALLEL_8_BIT:
+				cfg |= JZ_SLCD_CFG_DWIDTH_8_x3;
+				break;
+			case JZ_SLCD_TYPE_PARALLEL_16_BIT:
+				cfg |= JZ_SLCD_CFG_DWIDTH_9_x2;
+				break;
+			case JZ_SLCD_TYPE_PARALLEL_18_BIT:
+				cfg |= JZ_SLCD_CFG_DWIDTH_18;
+				break;
+			}
+			break;
+		}
+	}
+
+	if (!pdata->pixclk_falling_edge)
+		cfg |= JZ_SLCD_CFG_CLK_ACTIVE_RISING;
+
+	if (!pdata->chip_select_active_low)
+		cfg |= JZ_SLCD_CFG_CS_ACTIVE_HIGH;
+
+	if (!pdata->register_select_active_low)
+		cfg |= JZ_SLCD_CFG_RS_CMD_HIGH;
+
+	if (mode->pixclock) {
+		rate = PICOS2KHZ(mode->pixclock) * 1000;
+		mode->refresh = rate;
+	} else {
+		rate = mode->refresh;
+		mode->pixclock = KHZ2PICOS(rate / 1000);
+	}
+
+	mutex_lock(&jzfb->lock);
+	if (!jzfb->is_enabled)
+		clk_enable(jzfb->ldclk);
+
+	writel(JZ_LCD_CFG_SLCD, jzfb->base + JZ_REG_LCD_CFG);
+	writel(cfg, jzfb->base + JZ_REG_SLCD_CFG);
+	writel(0, jzfb->base + JZ_REG_SLCD_CTRL);
+
+	if (!jzfb->is_enabled)
+		clk_disable(jzfb->ldclk);
+	mutex_unlock(&jzfb->lock);
+
+	clk_set_rate(jzfb->lpclk, rate);
+	clk_set_rate(jzfb->ldclk, rate * 3);
+}
+
+static int jzfb_set_par(struct fb_info *info)
+{
+	struct jzfb *jzfb = info->par;
+	struct fb_var_screeninfo *var = &info->var;
+	struct fb_videomode *mode;
+
+	mode = jzfb_get_mode(jzfb, var);
+	if (mode = NULL)
+		return -EINVAL;
+
+	if (mode = info->mode)
+		return 0;
+
+	info->mode = mode;
+
+	if (JZFB_IS_SLCD(jzfb))
+		jzfb_slcd_set_par(jzfb, mode);
+	else
+		jzfb_lcd_set_par(jzfb, mode);
 
 	return 0;
 }
 
+static void jzfb_slcd_wait(struct jzfb *jzfb)
+{
+	int timeout = 1000;
+	while (readb(jzfb->base + JZ_REG_SLCD_STATE) & JZ_SLCD_STATE_BUSY
+	       && timeout--)
+	    cpu_relax();
+
+	if (timeout <= 0)
+		dev_warn(&jzfb->pdev->dev, "waiting for SLCD busy timed out!");
+}
+
+static void jzfb_slcd_start_dma(struct jzfb *jzfb)
+{
+	struct fb_info *fb = jzfb->fb;
+	unsigned int length = fb->fix.line_length * fb->mode->yres;
+
+	jzfb_slcd_wait(jzfb);
+
+	jz4740_dma_set_src_addr(jzfb->slcd_dma, jzfb->vidmem_phys);
+	jz4740_dma_set_dst_addr(jzfb->slcd_dma,
+				jzfb->phys_base + JZ_REG_SLCD_FIFO);
+	jz4740_dma_set_transfer_count(jzfb->slcd_dma, length);
+
+	jz4740_dma_enable(jzfb->slcd_dma);
+}
+
+static void jzfb_slcd_dma_callback(struct jz4740_dma_chan *chan, int unk,
+				   void *dev)
+{
+	struct jzfb *jzfb = dev;
+
+	/* TODO: use DMA descriptors! */
+	jzfb_slcd_start_dma(jzfb);
+}
+
 static void jzfb_enable(struct jzfb *jzfb)
 {
 	uint32_t ctrl;
@@ -489,28 +673,40 @@ static void jzfb_enable(struct jzfb *jzfb)
 	clk_enable(jzfb->ldclk);
 
 	jzfb_pins_operation(jzfb, RESUME_PINS);
+	if (JZFB_IS_SLCD(jzfb)) {
+		jzfb_slcd_wait(jzfb);
+		writeb(JZ_SLCD_CTRL_DMA_EN, jzfb->base + JZ_REG_SLCD_CTRL);
 
-	writel(0, jzfb->base + JZ_REG_LCD_STATE);
+		jzfb_slcd_start_dma(jzfb);
+	} else {
+		writel(0, jzfb->base + JZ_REG_LCD_STATE);
 
-	writel(jzfb->framedesc->next, jzfb->base + JZ_REG_LCD_DA0);
+		writel(jzfb->framedesc->next, jzfb->base + JZ_REG_LCD_DA0);
 
-	ctrl = readl(jzfb->base + JZ_REG_LCD_CTRL);
-	ctrl |= JZ_LCD_CTRL_ENABLE;
-	ctrl &= ~JZ_LCD_CTRL_DISABLE;
-	writel(ctrl, jzfb->base + JZ_REG_LCD_CTRL);
+		ctrl = readl(jzfb->base + JZ_REG_LCD_CTRL);
+		ctrl |= JZ_LCD_CTRL_ENABLE;
+		ctrl &= ~JZ_LCD_CTRL_DISABLE;
+		writel(ctrl, jzfb->base + JZ_REG_LCD_CTRL);
+	}
 }
 
 static void jzfb_disable(struct jzfb *jzfb)
 {
 	uint32_t ctrl;
 
-	ctrl = readl(jzfb->base + JZ_REG_LCD_CTRL);
-	ctrl |= JZ_LCD_CTRL_DISABLE;
-	writel(ctrl, jzfb->base + JZ_REG_LCD_CTRL);
-	do {
-		ctrl = readl(jzfb->base + JZ_REG_LCD_STATE);
-	} while (!(ctrl & JZ_LCD_STATE_DISABLED));
+	if (JZFB_IS_SLCD(jzfb)) {
+		jz4740_dma_disable(jzfb->slcd_dma);
 
+		jzfb_slcd_wait(jzfb);
+		writeb(0, jzfb->base + JZ_REG_SLCD_CTRL);
+	} else {
+		ctrl = readl(jzfb->base + JZ_REG_LCD_CTRL);
+		ctrl |= JZ_LCD_CTRL_DISABLE;
+		writel(ctrl, jzfb->base + JZ_REG_LCD_CTRL);
+		do {
+			ctrl = readl(jzfb->base + JZ_REG_LCD_STATE);
+		} while (!(ctrl & JZ_LCD_STATE_DISABLED));
+	}
 	jzfb_pins_operation(jzfb, SUSPEND_PINS);
 
 	clk_disable(jzfb->ldclk);
@@ -564,12 +760,19 @@ static int jzfb_alloc_devmem(struct jzfb *jzfb)
 
 	max_videosize *= jzfb_get_controller_bpp(jzfb) >> 3;
 
-	jzfb->framedesc = dma_alloc_coherent(&jzfb->pdev->dev,
-					sizeof(*jzfb->framedesc),
-					&jzfb->framedesc_phys, GFP_KERNEL);
+	if (!JZFB_IS_SLCD(jzfb)) {
+		jzfb->framedesc = dma_alloc_coherent(&jzfb->pdev->dev,
+						sizeof(*jzfb->framedesc),
+						&jzfb->framedesc_phys,
+						GFP_KERNEL);
 
-	if (!jzfb->framedesc)
-		return -ENOMEM;
+		if (!jzfb->framedesc)
+			return -ENOMEM;
+	} else {
+		jzfb->slcd_dma = jz4740_dma_request(jzfb, "SLCD");
+		if (!jzfb->slcd_dma)
+			return -ENXIO;
+	}
 
 	jzfb->vidmem_size = PAGE_ALIGN(max_videosize);
 	jzfb->vidmem = dma_alloc_coherent(&jzfb->pdev->dev,
@@ -585,17 +788,48 @@ static int jzfb_alloc_devmem(struct jzfb *jzfb)
 		SetPageReserved(virt_to_page(page));
 	}
 
-	jzfb->framedesc->next = jzfb->framedesc_phys;
-	jzfb->framedesc->addr = jzfb->vidmem_phys;
-	jzfb->framedesc->id = 0xdeafbead;
-	jzfb->framedesc->cmd = 0;
-	jzfb->framedesc->cmd |= max_videosize / 4;
+	if (jzfb->framedesc) {
+		jzfb->framedesc->next = jzfb->framedesc_phys;
+		jzfb->framedesc->addr = jzfb->vidmem_phys;
+		jzfb->framedesc->id = 0xdeafbead;
+		jzfb->framedesc->cmd = 0;
+		jzfb->framedesc->cmd |= max_videosize / 4;
+	} else {
+		struct jz4740_dma_config config = {
+			.src_width	= JZ4740_DMA_WIDTH_32BIT,
+			.request_type	= JZ4740_DMA_TYPE_SLCD,
+			.flags		= JZ4740_DMA_SRC_AUTOINC,
+			.mode		= JZ4740_DMA_MODE_SINGLE,
+		};
+
+		switch (jzfb->pdata->bpp) {
+		case 1 ... 8:
+			config.dst_width = JZ4740_DMA_WIDTH_8BIT;
+			config.transfer_size = JZ4740_DMA_TRANSFER_SIZE_1BYTE;
+			break;
+		case 9 ... 16:
+			config.dst_width = JZ4740_DMA_WIDTH_16BIT;
+			config.transfer_size = JZ4740_DMA_TRANSFER_SIZE_2BYTE;
+			break;
+		case 17 ... 32:
+			config.dst_width = JZ4740_DMA_WIDTH_32BIT;
+			config.transfer_size = JZ4740_DMA_TRANSFER_SIZE_4BYTE;
+			break;
+		}
+
+		jz4740_dma_configure(jzfb->slcd_dma, &config);
+		jz4740_dma_set_complete_cb(jzfb->slcd_dma,
+					   jzfb_slcd_dma_callback);
+	}
 
 	return 0;
 
 err_free_framedesc:
-	dma_free_coherent(&jzfb->pdev->dev, sizeof(*jzfb->framedesc),
-				jzfb->framedesc, jzfb->framedesc_phys);
+	if (jzfb->framedesc)
+		dma_free_coherent(&jzfb->pdev->dev, sizeof(*jzfb->framedesc),
+				  jzfb->framedesc, jzfb->framedesc_phys);
+	if (jzfb->slcd_dma)
+		jz4740_dma_free(jzfb->slcd_dma);
 	return -ENOMEM;
 }
 
@@ -603,8 +837,11 @@ static void jzfb_free_devmem(struct jzfb *jzfb)
 {
 	dma_free_coherent(&jzfb->pdev->dev, jzfb->vidmem_size,
 				jzfb->vidmem, jzfb->vidmem_phys);
-	dma_free_coherent(&jzfb->pdev->dev, sizeof(*jzfb->framedesc),
-				jzfb->framedesc, jzfb->framedesc_phys);
+	if (jzfb->framedesc)
+		dma_free_coherent(&jzfb->pdev->dev, sizeof(*jzfb->framedesc),
+				  jzfb->framedesc, jzfb->framedesc_phys);
+	if (jzfb->slcd_dma)
+		jz4740_dma_free(jzfb->slcd_dma);
 }
 
 static struct  fb_ops jzfb_ops = {
@@ -618,6 +855,125 @@ static struct  fb_ops jzfb_ops = {
 	.fb_setcolreg = jzfb_setcolreg,
 };
 
+static void send_panel_command(struct jzfb *jzfb, u32 cmd)
+{
+	u16 slcd_cfg = readw(jzfb->base + JZ_REG_SLCD_CFG);
+
+	jzfb_slcd_wait(jzfb);
+
+	switch (slcd_cfg & JZ_SLCD_CFG_CWIDTH_MASK) {
+	case JZ_SLCD_CFG_CWIDTH_8BIT:
+		writel(JZ_SLCD_DATA_RS_COMMAND | ((cmd & 0xff00) >> 8),
+		       jzfb->base + JZ_REG_SLCD_DATA);
+		jzfb_slcd_wait(jzfb);
+		writel(JZ_SLCD_DATA_RS_COMMAND | (cmd & 0xff),
+		       jzfb->base + JZ_REG_SLCD_DATA);
+		break;
+
+	case JZ_SLCD_CFG_CWIDTH_16BIT:
+		writel(JZ_SLCD_DATA_RS_COMMAND | (cmd & 0xffff),
+		       jzfb->base + JZ_REG_SLCD_DATA);
+		break;
+
+	case JZ_SLCD_CFG_CWIDTH_18BIT:
+		writel(JZ_SLCD_DATA_RS_COMMAND | ((cmd & 0xff00) << 2) |
+		       ((cmd & 0xff) << 1), jzfb->base + JZ_REG_SLCD_DATA);
+		break;
+	}
+}
+
+static void send_panel_data(struct jzfb *jzfb, u32 data)
+{
+	u16 slcd_cfg = readw(jzfb->base + JZ_REG_SLCD_CFG);
+
+	switch (slcd_cfg & JZ_SLCD_CFG_DWIDTH_MASK) {
+	case JZ_SLCD_CFG_DWIDTH_18:
+	case JZ_SLCD_CFG_DWIDTH_9_x2:
+		data = ((data & 0xff) << 1) | ((data & 0xff00) << 2);
+		data = ((data << 6) & 0xfc0000) | ((data << 4) & 0xfc00) |
+		       ((data << 2) & 0x0000fc);
+		break;
+
+	case JZ_SLCD_CFG_DWIDTH_16:
+	default:
+		data &= 0xffff;
+		break;
+	}
+
+	jzfb_slcd_wait(jzfb);
+	writel(JZ_SLCD_DATA_RS_DATA | data, jzfb->base + JZ_REG_SLCD_DATA);
+}
+
+void jz4740_fb_slcd_disable_transfer(struct platform_device *pdev)
+{
+	struct jzfb *jzfb = platform_get_drvdata(pdev);
+
+	mutex_lock(&jzfb->lock);
+
+	if (jzfb->is_enabled) {
+		jz4740_dma_disable(jzfb->slcd_dma);
+		jzfb_slcd_wait(jzfb);
+	}
+
+	mutex_unlock(&jzfb->lock);
+}
+EXPORT_SYMBOL_GPL(jz4740_fb_slcd_disable_transfer);
+
+void jz4740_fb_slcd_enable_transfer(struct platform_device *pdev)
+{
+	struct jzfb *jzfb = platform_get_drvdata(pdev);
+
+	mutex_lock(&jzfb->lock);
+
+	if (jzfb->is_enabled)
+		jzfb_slcd_start_dma(jzfb);
+
+	mutex_unlock(&jzfb->lock);
+}
+EXPORT_SYMBOL_GPL(jz4740_fb_slcd_enable_transfer);
+
+void jz4740_fb_slcd_send_cmd_data(struct platform_device *pdev,
+				  unsigned int cmd, unsigned int data)
+{
+	struct jzfb *jzfb = platform_get_drvdata(pdev);
+
+	mutex_lock(&jzfb->lock);
+
+	if (!jzfb->is_enabled)
+		clk_enable(jzfb->ldclk);
+
+	send_panel_command(jzfb, cmd);
+	send_panel_data(jzfb, data);
+
+	if (!jzfb->is_enabled) {
+		jzfb_slcd_wait(jzfb);
+		clk_disable(jzfb->ldclk);
+	}
+
+	mutex_unlock(&jzfb->lock);
+}
+EXPORT_SYMBOL_GPL(jz4740_fb_slcd_send_cmd_data);
+
+void jz4740_fb_slcd_send_cmd(struct platform_device *pdev, unsigned int cmd)
+{
+	struct jzfb *jzfb = platform_get_drvdata(pdev);
+
+	mutex_lock(&jzfb->lock);
+
+	if (!jzfb->is_enabled)
+		clk_enable(jzfb->ldclk);
+
+	send_panel_command(jzfb, cmd);
+
+	if (!jzfb->is_enabled) {
+		jzfb_slcd_wait(jzfb);
+		clk_disable(jzfb->ldclk);
+	}
+
+	mutex_unlock(&jzfb->lock);
+}
+EXPORT_SYMBOL_GPL(jz4740_fb_slcd_send_cmd);
+
 static int __devinit jzfb_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -673,6 +1029,7 @@ static int __devinit jzfb_probe(struct platform_device *pdev)
 		goto err_put_ldclk;
 	}
 
+	jzfb->phys_base = mem->start;
 	jzfb->base = ioremap(mem->start, resource_size(mem));
 	if (!jzfb->base) {
 		dev_err(&pdev->dev, "Failed to ioremap register memory region\n");
-- 
1.7.4

