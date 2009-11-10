From: Jun Nie <niej0001@gmail.com>
Date: Tue, 10 Nov 2009 08:12:04 +0000
Subject: [PATCH 1/8] pxa: support pxa168 LCD controller SPI operation
Message-Id: <7c34ac520911100012s3504b2ek75670ecb057692a7@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From fbdcfdc7877f2e6030a0ae5f6738a07e35fc6757 Mon Sep 17 00:00:00 2001
From: Jun Nie <njun@marvell.com>
Date: Tue, 10 Nov 2009 10:01:03 +0800
Subject: [PATCH] pxa: support pxa168 LCD controller SPI operation

Signed-off-by: Jun Nie <njun@marvell.com>
---
 drivers/video/pxa168fb.c |   81 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/video/pxa168fb.h |   24 +-------------
 include/video/pxa168fb.h |   44 +++++++++++++++++++++++++
 3 files changed, 126 insertions(+), 23 deletions(-)

diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
index 84d8327..e1f1c5f 100644
--- a/drivers/video/pxa168fb.c
+++ b/drivers/video/pxa168fb.c
@@ -27,12 +27,90 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/uaccess.h>
+#include <linux/gpio.h>
 #include <video/pxa168fb.h>

+#include <mach/gpio.h>
 #include "pxa168fb.h"

 #define DEFAULT_REFRESH		60	/* Hz */

+static inline void spi_gpio_assert(int spi_gpio_cs, int val)
+{
+	       if (gpio_is_valid(spi_gpio_cs))
+		                      gpio_set_value(spi_gpio_cs, val);
+}
+
+int pxa168fb_spi_send(struct pxa168fb_info *fbi, void *value, int count,
+		unsigned int spi_gpio_cs, unsigned int cs_active, unsigned int interval_us)
+{
+	u32 x, spi_byte_len;
+	u8 *cmd = (u8 *)value;
+	int i, isr, iopad, ret = 0;
+
+	if (gpio_is_valid(spi_gpio_cs)) {
+		ret = gpio_direction_output(spi_gpio_cs, !cs_active);
+		if(ret)
+			goto spi_exit;
+	}
+	spi_byte_len = readl(fbi->reg_base + LCD_SPU_SPI_CTRL);
+	spi_byte_len = (spi_byte_len >> 8) & 0xff;
+	/* Alignment should be (spi_byte_len + 7) >> 3, but
+	 * spi controller request set one less than bit length */
+	spi_byte_len = (spi_byte_len + 8) >> 3;
+	/* spi command provided by platform should be 1, 2, or 4 byte aligned */
+	if(3 = spi_byte_len)
+		spi_byte_len = 4;
+
+	iopad = readl(fbi->reg_base + SPU_IOPAD_CONTROL);
+	if ((iopad & CFG_IOPADMODE_MASK) != PIN_MODE_DUMB_18_SPI)
+		writel(PIN_MODE_DUMB_18_SPI, fbi->reg_base + SPU_IOPAD_CONTROL);
+	isr = readl(fbi->reg_base + SPU_IRQ_ISR);
+	writel((isr & ~SPI_IRQ_ENA_MASK), fbi->reg_base + SPU_IRQ_ISR);
+	for (i = 0; i < count; i++) {
+		spi_gpio_assert(spi_gpio_cs, cs_active);
+		udelay(interval_us);
+		switch (spi_byte_len){
+		case 1:
+			writel(*cmd, fbi->reg_base + LCD_SPU_SPI_TXDATA);
+			break;
+		case 2:
+			writel(*(u16*)cmd, fbi->reg_base + LCD_SPU_SPI_TXDATA);
+			break;
+		case 4:
+			writel(*(u32*)cmd, fbi->reg_base + LCD_SPU_SPI_TXDATA);
+			break;
+		default:
+			dev_err(fbi->dev, "Wrong spi bit length\n");
+			spi_gpio_assert(spi_gpio_cs, !cs_active);
+			ret = -EINVAL;
+			goto spi_exit;
+		}
+		cmd += spi_byte_len;
+		x = readl(fbi->reg_base + LCD_SPU_SPI_CTRL);
+		x |= CFG_SPI_START_MASK;
+		writel(x, fbi->reg_base + LCD_SPU_SPI_CTRL);
+		isr = readl(fbi->reg_base + SPU_IRQ_ISR);
+		while(!(isr & SPI_IRQ_ENA_MASK)) {
+			udelay(1);
+			isr = readl(fbi->reg_base + SPU_IRQ_ISR);
+		}
+		x = readl(fbi->reg_base + LCD_SPU_SPI_CTRL);
+		x &= ~CFG_SPI_START_MASK;
+		writel(x, fbi->reg_base + LCD_SPU_SPI_CTRL);
+		spi_gpio_assert(spi_gpio_cs, !cs_active);
+	}
+
+spi_exit:
+	if (gpio_is_valid(spi_gpio_cs))
+		gpio_direction_input(spi_gpio_cs);
+	if ((iopad & CFG_IOPADMODE_MASK) != PIN_MODE_DUMB_18_SPI)
+		writel(iopad, fbi->reg_base + SPU_IOPAD_CONTROL);
+
+	return ret;
+}
+EXPORT_SYMBOL(pxa168fb_spi_send);
+
 static int determine_best_pix_fmt(struct fb_var_screeninfo *var)
 {
 	/*
@@ -728,6 +806,9 @@ static int __init pxa168fb_probe(struct
platform_device *pdev)
 	writel(0, fbi->reg_base + LCD_SPU_SRAM_PARA0);
 	writel(CFG_CSB_256x32(0x1)|CFG_CSB_256x24(0x1)|CFG_CSB_256x8(0x1),
 		fbi->reg_base + LCD_SPU_SRAM_PARA1);
+	if ((mi->spi_ctrl != -1) && (mi->spi_ctrl & CFG_SPI_ENA_MASK))
+		writel(mi->spi_ctrl, fbi->reg_base + LCD_SPU_SPI_CTRL);
+

 	/*
 	 * Allocate color map.
diff --git a/drivers/video/pxa168fb.h b/drivers/video/pxa168fb.h
index eee0927..55ec4dc 100644
--- a/drivers/video/pxa168fb.h
+++ b/drivers/video/pxa168fb.h
@@ -170,29 +170,7 @@
 #define     DMA_FRAME_CNT_MASK			0x00000003  /* Video */

 /* SPI Control Register. */
-#define LCD_SPU_SPI_CTRL			0x0180
-#define     CFG_SCLKCNT(div)			((div) << 24)  /* 0xFF~0x2 */
-#define     CFG_SCLKCNT_MASK			0xFF000000
-#define     CFG_RXBITS(rx)			((rx) << 16)   /* 0x1F~0x1 */
-#define     CFG_RXBITS_MASK			0x00FF0000
-#define     CFG_TXBITS(tx)			((tx) << 8)    /* 0x1F~0x1 */
-#define     CFG_TXBITS_MASK			0x0000FF00
-#define     CFG_CLKINV(clk)			((clk) << 7)
-#define     CFG_CLKINV_MASK			0x00000080
-#define     CFG_KEEPXFER(transfer)		((transfer) << 6)
-#define     CFG_KEEPXFER_MASK			0x00000040
-#define     CFG_RXBITSTO0(rx)			((rx) << 5)
-#define     CFG_RXBITSTO0_MASK			0x00000020
-#define     CFG_TXBITSTO0(tx)			((tx) << 4)
-#define     CFG_TXBITSTO0_MASK			0x00000010
-#define     CFG_SPI_ENA(spi)			((spi) << 3)
-#define     CFG_SPI_ENA_MASK			0x00000008
-#define     CFG_SPI_SEL(spi)			((spi) << 2)
-#define     CFG_SPI_SEL_MASK			0x00000004
-#define     CFG_SPI_3W4WB(wire)			((wire) << 1)
-#define     CFG_SPI_3W4WB_MASK			0x00000002
-#define     CFG_SPI_START(start)		(start)
-#define     CFG_SPI_START_MASK			0x00000001
+/* For SPI register, please refer to include/video/pxa168fb.h */

 /* SPI Tx Data Register */
 #define LCD_SPU_SPI_TXDATA			0x0184
diff --git a/include/video/pxa168fb.h b/include/video/pxa168fb.h
index b5cc72f..024767c 100644
--- a/include/video/pxa168fb.h
+++ b/include/video/pxa168fb.h
@@ -14,6 +14,31 @@
 #include <linux/fb.h>
 #include <linux/interrupt.h>

+/* SPI Control Register. */
+#define LCD_SPU_SPI_CTRL			0x0180
+#define     CFG_SCLKCNT(div)			((div) << 24)  /* 0xFF~0x2 */
+#define     CFG_SCLKCNT_MASK			0xFF000000
+#define     CFG_RXBITS(rx)			((rx - 1) << 16)   /* 0x1F~0x1, 0x1:
2bits ... 0x1F: 32bits */
+#define     CFG_RXBITS_MASK			0x00FF0000
+#define     CFG_TXBITS(tx)                      ((tx - 1) << 8)    /*
0x1F~0x1, 0x1: 2bits ... 0x1F: 32bits */
+#define     CFG_TXBITS_MASK			0x0000FF00
+#define     CFG_CLKINV(clk)			((clk) << 7)
+#define     CFG_CLKINV_MASK			0x00000080
+#define     CFG_KEEPXFER(transfer)		((transfer) << 6)
+#define     CFG_KEEPXFER_MASK			0x00000040
+#define     CFG_RXBITSTO0(rx)			((rx) << 5)
+#define     CFG_RXBITSTO0_MASK			0x00000020
+#define     CFG_TXBITSTO0(tx)			((tx) << 4)
+#define     CFG_TXBITSTO0_MASK			0x00000010
+#define     CFG_SPI_ENA(spi)			((spi) << 3)
+#define     CFG_SPI_ENA_MASK			0x00000008
+#define     CFG_SPI_SEL(spi)			((spi) << 2)	/* 1: port1; 0: port0 */
+#define     CFG_SPI_SEL_MASK			0x00000004
+#define     CFG_SPI_3W4WB(wire)                 ((wire)<<1)  /* 1:
3-wire; 0: 4-wire */
+#define     CFG_SPI_3W4WB_MASK			0x00000002
+#define     CFG_SPI_START(start)		(start)
+#define     CFG_SPI_START_MASK			0x00000001
+
 /* Dumb interface */
 #define PIN_MODE_DUMB_24		0
 #define PIN_MODE_DUMB_18_SPI		1
@@ -122,6 +147,25 @@ struct pxa168fb_mach_info {
 	unsigned	panel_rbswap:1;
 	unsigned	active:1;
 	unsigned	enable_lcd:1;
+	/*
+	 * SPI control
+	 */
+	unsigned int	spi_ctrl;
+	unsigned int	spi_gpio_cs;
+	unsigned int 	spi_gpio_reset;
+	/*
+	 * power on/off function.
+	 */
+	int (*pxa168fb_lcd_power)(struct pxa168fb_info *, unsigned int,
unsigned int, int);
 };

+/* SPI utility for configure panel SPI command.
+ * value: command array, element should be 1, 2 or 4 byte aligned.
+ * count: command array length
+ * spi_gpio_cs: gpio number for spi chip select
+ * cs_active: CS active polarity for SPI transaction
+ * interval_us: time interval between two commands, us as unit */
+int pxa168fb_spi_send(struct pxa168fb_info *fbi, void *value, int count,
+		unsigned int spi_gpio_cs,unsigned int cs_active, unsigned int interval_us);
+
 #endif /* __ASM_MACH_PXA168FB_H */
-- 
1.5.4.3
