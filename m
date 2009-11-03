From: Jun Nie <niej0001@gmail.com>
Subject: [PATCH 1/6] pxa: support pxa168 LCD controller SPI operation
Date: Tue, 3 Nov 2009 14:45:20 +0800
Message-ID: <7c34ac520911022245x2845e5dex1311bd74a08606db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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
To: linux-arm-kernel@lists.infradead.org, linux-fbdev-devel@lists.sourceforge.net

pxa: support pxa168 LCD controller SPI operation

Signed-off-by: Jun Nie <njun@marvell.com>
---
 arch/arm/mach-mmp/include/mach/pxa168fb.h |   29 +++++++++
 drivers/video/pxa168fb.c                  |   92 +++++++++++++++++++++++++++++
 drivers/video/pxa168fb.h                  |   24 +-------
 include/video/pxa168fb.h                  |   18 ++++++
 4 files changed, 140 insertions(+), 23 deletions(-)
 create mode 100644 arch/arm/mach-mmp/include/mach/pxa168fb.h

diff --git a/arch/arm/mach-mmp/include/mach/pxa168fb.h
b/arch/arm/mach-mmp/include/mach/pxa168fb.h
new file mode 100644
index 0000000..897cc3e
--- /dev/null
+++ b/arch/arm/mach-mmp/include/mach/pxa168fb.h
@@ -0,0 +1,29 @@
+#ifndef __PXA168FBSPI_H__
+#define __PXA168FBSPI_H__
+
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
+#endif /* __PXA168FBSPI_H__ */
diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
index 84d8327..27bdf2b 100644
--- a/drivers/video/pxa168fb.c
+++ b/drivers/video/pxa168fb.c
@@ -29,10 +29,91 @@
 #include <linux/uaccess.h>
 #include <video/pxa168fb.h>

+#include <mach/pxa168fb.h>
+#include <mach/gpio.h>
 #include "pxa168fb.h"

 #define DEFAULT_REFRESH		60	/* Hz */

+static inline void spi_gpio_assert_set(int spi_gpio_cs, int val)
+{
+	       if (gpio_is_valid(spi_gpio_cs))
+		                      gpio_set_value(spi_gpio_cs, val);
+}
+
+int pxa168fb_spi_send(struct pxa168fb_info *fbi, void *value, int count,
+		unsigned int spi_gpio_cs, unsigned int interval_us)
+{
+	u32 x, spi_byte_len;
+	u8 *cmd = (u8 *)value;
+	int i, err, isr, iopad, ret = 0;
+
+	if (gpio_is_valid(spi_gpio_cs)) {
+		err = gpio_request(spi_gpio_cs, "LCD_SPI_CS");
+		if (err) {
+			dev_err(fbi->dev, "failed to request GPIO for LCD CS\n");
+			return -1;
+		}
+		gpio_direction_output(spi_gpio_cs, 1);
+	}
+	spi_byte_len = readl(fbi->reg_base + LCD_SPU_SPI_CTRL);
+	spi_byte_len = (spi_byte_len >> 8) & 0xff;
+	/* Alignment should be (spi_byte_len + 7) >> 3, but
+	 * spi controller request set one less than bit length */
+	spi_byte_len = (spi_byte_len + 8) >> 3;
+	/* spi command provided by platform should be 1, 2, or 4 byte aligned */
+	if(3 == spi_byte_len)
+		spi_byte_len = 4;
+
+	iopad = readl(fbi->reg_base + SPU_IOPAD_CONTROL);
+	if ((iopad & CFG_IOPADMODE_MASK) != PIN_MODE_DUMB_18_SPI)
+		writel(PIN_MODE_DUMB_18_SPI, fbi->reg_base + SPU_IOPAD_CONTROL);
+	isr = readl(fbi->reg_base + SPU_IRQ_ISR);
+	writel((isr & ~SPI_IRQ_ENA_MASK), fbi->reg_base + SPU_IRQ_ISR);
+	for (i = 0; i < count; i++) {
+		spi_gpio_assert_set(spi_gpio_cs, 0);
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
+			spi_gpio_assert_set(spi_gpio_cs, 1);
+			ret = -1;
+			goto spi_exit;
+		}
+		cmd += spi_byte_len;
+		x = readl(fbi->reg_base + LCD_SPU_SPI_CTRL);
+		x |= 0x1;
+		writel(x, fbi->reg_base + LCD_SPU_SPI_CTRL);
+		isr = readl(fbi->reg_base + SPU_IRQ_ISR);
+		while(!(isr & SPI_IRQ_ENA_MASK)) {
+			udelay(1);
+			isr = readl(fbi->reg_base + SPU_IRQ_ISR);
+		}
+		x = readl(fbi->reg_base + LCD_SPU_SPI_CTRL);
+		x &= ~0x1;
+		writel(x, fbi->reg_base + LCD_SPU_SPI_CTRL);
+		spi_gpio_assert_set(spi_gpio_cs, 1);
+	}
+
+spi_exit:
+	if (gpio_is_valid(spi_gpio_cs))
+		gpio_free(spi_gpio_cs);
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
@@ -687,6 +768,7 @@ static int __init pxa168fb_probe(struct
platform_device *pdev)
 	}

 	info->fix.smem_start = (unsigned long)fbi->fb_start_dma;
+	set_graphics_start(info, 0, 0);

 	/*
 	 * Set video mode according to platform data.
@@ -728,6 +810,9 @@ static int __init pxa168fb_probe(struct
platform_device *pdev)
 	writel(0, fbi->reg_base + LCD_SPU_SRAM_PARA0);
 	writel(CFG_CSB_256x32(0x1)|CFG_CSB_256x24(0x1)|CFG_CSB_256x8(0x1),
 		fbi->reg_base + LCD_SPU_SRAM_PARA1);
+	if ((mi->spi_ctrl != -1) && (mi->spi_ctrl & CFG_SPI_ENA_MASK))
+		writel(mi->spi_ctrl, fbi->reg_base + LCD_SPU_SPI_CTRL);
+

 	/*
 	 * Allocate color map.
@@ -764,6 +849,13 @@ static int __init pxa168fb_probe(struct
platform_device *pdev)
 	}

 	platform_set_drvdata(pdev, fbi);
+	if (mi->pxa168fb_lcd_power){
+		if(mi->pxa168fb_lcd_power(fbi, mi->spi_gpio_cs, mi->spi_gpio_reset, 1)){
+			dev_err(&pdev->dev, "Failed to power up pxa168-fb\n");
+			goto failed_free_irq;
+		}
+	}
+	dev_info(fbi->dev, "frame buffer detected\n");
 	return 0;

 failed_free_irq:
diff --git a/drivers/video/pxa168fb.h b/drivers/video/pxa168fb.h
index eee0927..1e4859e 100644
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
+/* For SPI register, please refer to
arch/arm/mach-mmp/include/mach/pxa168fb.h */

 /* SPI Tx Data Register */
 #define LCD_SPU_SPI_TXDATA			0x0184
diff --git a/include/video/pxa168fb.h b/include/video/pxa168fb.h
index b5cc72f..f0497ae 100644
--- a/include/video/pxa168fb.h
+++ b/include/video/pxa168fb.h
@@ -122,6 +122,24 @@ struct pxa168fb_mach_info {
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
+ * interval_us: time interval between two commands, us as unit */
+int pxa168fb_spi_send(struct pxa168fb_info *fbi, void *value, int count,
+		unsigned int spi_gpio_cs, unsigned int interval_us);
+
 #endif /* __ASM_MACH_PXA168FB_H */
-- 
1.5.4.3
