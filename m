From: Ryan Mallon <ryan@bluewatersys.com>
Subject: [PATCH v2 1/2] ep93xx video platform support
Date: Sat, 18 Jul 2009 07:54:27 +1200
Message-ID: <4A60D6F3.5060906@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ryan@bluewatersys.com>) id 1MRiH7-0005ae-0f
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Jul 2009 07:54:37 +0000
Received: from mail.bluewatersys.com ([202.124.120.130]
	helo=hayes.bluewaternz.com)
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MRiH0-0006CI-8H
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Jul 2009 07:54:36 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: arm kernel <linux-arm-kernel@lists.arm.linux.org.uk>, linux-fbdev-devel@lists.sourceforge.net, hartleys <hartleys@visionengravers.com>, d.venzano@motronica.com

As pointed out by Daniele Venzano I missed a file in the previous patch
set. I also messed up the order. The following series fixes these problems
---
Added platform and clock support for the ep93xx video driver

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---

diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index b6b5344..4367a09 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -37,7 +37,7 @@ struct clk {
 static unsigned long get_uart_rate(struct clk *clk);
 
 static int set_keytchclk_rate(struct clk *clk, unsigned long rate);
-
+static int set_div_rate(struct clk *clk, unsigned long rate);
 
 static struct clk clk_uart1 = {
 	.sw_locked	= 1,
@@ -73,6 +73,13 @@ static struct clk clk_keypad = {
 	.set_rate	= set_keytchclk_rate,
 };
 
+static struct clk clk_video = {
+	.enable_reg     = EP93XX_SYSCON_VIDCLKDIV,
+	.enable_mask    = EP93XX_SYSCON_CLKDIV_ENABLE,
+	.sw_locked	= 1,
+	.set_rate	= set_div_rate,
+};
+
 /* DMA Clocks */
 static struct clk clk_m2p0 = {
 	.enable_reg	= EP93XX_SYSCON_PWRCNT,
@@ -137,6 +144,7 @@ static struct clk_lookup clocks[] = {
 	INIT_CK(NULL,			"pll2",		&clk_pll2),
 	INIT_CK("ep93xx-ohci",		NULL,		&clk_usb_host),
 	INIT_CK("ep93xx-keypad",	NULL,		&clk_keypad),
+	INIT_CK("ep93xx-fb",		NULL,		&clk_video),
 	INIT_CK(NULL,			"m2p0",		&clk_m2p0),
 	INIT_CK(NULL,			"m2p1",		&clk_m2p1),
 	INIT_CK(NULL,			"m2p2",		&clk_m2p2),
@@ -232,6 +240,86 @@ static int set_keytchclk_rate(struct clk *clk, unsigned long rate)
 	return 0;
 }
 
+static unsigned long calc_clk_div(unsigned long rate, int *psel, int *esel, 
+				  int *pdiv, int *div)
+{
+	unsigned long max_rate, best_rate = 0, 
+		actual_rate = 0, mclk_rate = 0, rate_err = -1;
+	int i, found = 0, __div = 0, __pdiv = 0;
+	
+	/* Don't exceed the maximum rate */
+	max_rate = max(max(clk_pll1.rate / 4, clk_pll2.rate / 4),
+		       (unsigned long)EP93XX_EXT_CLK_RATE / 4);
+	rate = min(rate, max_rate);
+	
+	/*
+	 * Try the two pll's and the external clock
+	 * Because the valid predividers are 2, 2.5 and 3, we multiply
+	 * all the clocks by 2 to avoid floating point math.
+	 *
+	 * This is based on the algorithm in the ep93xx raster guide:
+	 * http://be-a-maverick.com/en/pubs/appNote/AN269REV1.pdf
+	 *
+	 */
+	for (i = 0; i < 3; i++) {
+		if (i == 0)
+			mclk_rate = EP93XX_EXT_CLK_RATE * 2;
+		else if (i == 1)
+			mclk_rate = clk_pll1.rate * 2;
+		else if (i == 2)
+			mclk_rate = clk_pll2.rate * 2;
+		
+		/* Try each predivider value */
+		for (__pdiv = 4; __pdiv <= 6; __pdiv++) {
+			__div = mclk_rate / (rate * __pdiv);
+			if (__div < 2 || __div > 127)
+				continue;
+			
+			actual_rate = mclk_rate / __pdiv * __div;
+			
+			if (!found || abs(actual_rate - rate) < rate_err) {
+				*pdiv = __pdiv - 3;
+				*div = __div;
+				*psel = (i == 2);
+				*esel = (i != 0);
+				best_rate = actual_rate;
+				rate_err = actual_rate - rate;
+				found = 1;
+			}
+		}
+	}
+	
+	if (!found)
+		return 0;
+	
+	return best_rate;
+}
+
+static int set_div_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned long actual_rate;
+	int psel = 0, esel = 0, pdiv = 0, div = 0;
+	u32 val;
+
+	actual_rate = calc_clk_div(rate, &psel, &esel, &pdiv, &div);
+	if (actual_rate == 0)
+		return -EINVAL;
+	clk->rate = actual_rate;
+
+	/* Clear the esel, psel, pdiv and div bits */
+	val = __raw_readl(clk->enable_reg);
+	val &= ~0x7fff;
+	
+	/* Set the new esel, psel, pdiv and div bits for the new clock rate */
+	val |= (esel ? EP93XX_SYSCON_CLKDIV_ESEL : 0) |
+		(psel ? EP93XX_SYSCON_CLKDIV_PSEL : 0) |
+		(pdiv << EP93XX_SYSCON_CLKDIV_PDIV_SHIFT) | div;
+	__raw_writel(0xaa, EP93XX_SYSCON_SWLOCK);
+	__raw_writel(val, clk->enable_reg);
+	
+	return 0;
+}
+
 int clk_set_rate(struct clk *clk, unsigned long rate)
 {
 	if (clk->set_rate)
diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 8e59bdc..0e96ada 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -36,6 +36,7 @@
 
 #include <asm/hardware/vic.h>
 
+#include <mach/fb.h>
 
 /*************************************************************************
  * Static I/O mappings that are needed for all EP93xx platforms
@@ -570,6 +571,35 @@ void __init ep93xx_register_i2c(struct i2c_board_info *devices, int num)
 	platform_device_register(&ep93xx_i2c_device);
 }
 
+/*************************************************************************
+ * EP93xx video peripheral handling
+ *************************************************************************/
+static struct ep93xxfb_mach_info ep93xxfb_data;
+
+static struct resource ep93xx_fb_resource[] = {
+	{
+		.start		= EP93XX_RASTER_PHYS_BASE,
+		.end		= EP93XX_RASTER_PHYS_BASE + 0x800 - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device ep93xx_fb_device = {
+	.name			= "ep93xx-fb",
+	.id			= -1,
+	.dev.platform_data	= &ep93xxfb_data,
+	.dev.coherent_dma_mask	= DMA_BIT_MASK(32),
+	.dev.dma_mask		= &ep93xx_fb_device.dev.coherent_dma_mask,
+	.num_resources		= ARRAY_SIZE(ep93xx_fb_resource),
+	.resource		= ep93xx_fb_resource,
+};
+
+void __init ep93xx_register_fb(struct ep93xxfb_mach_info *data)
+{
+	ep93xxfb_data = *data;
+	platform_device_register(&ep93xx_fb_device);
+}
+
 extern void ep93xx_gpio_init(void);
 
 void __init ep93xx_init_devices(void)
diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
index a11ae77..33765fa 100644
--- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
+++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
@@ -70,6 +70,7 @@
 #define EP93XX_USB_PHYS_BASE		(EP93XX_AHB_PHYS_BASE + 0x00020000)
 #define EP93XX_USB_BASE			EP93XX_AHB_IOMEM(0x00020000)
 
+#define EP93XX_RASTER_PHYS_BASE		(EP93XX_AHB_PHYS_BASE + 0x00030000)
 #define EP93XX_RASTER_BASE		EP93XX_AHB_IOMEM(0x00030000)
 
 #define EP93XX_GRAPHICS_ACCEL_BASE	EP93XX_AHB_IOMEM(0x00040000)
@@ -206,13 +207,17 @@
 #define EP93XX_SYSCON_DEVCFG_ADCPD	(1<<2)
 #define EP93XX_SYSCON_DEVCFG_KEYS	(1<<1)
 #define EP93XX_SYSCON_DEVCFG_SHENA	(1<<0)
+#define EP93XX_SYSCON_VIDCLKDIV		EP93XX_SYSCON_REG(0x84)
+#define EP93XX_SYSCON_CLKDIV_PSEL	(1 << 13)
+#define EP93XX_SYSCON_CLKDIV_ESEL	(1 << 14)
+#define EP93XX_SYSCON_CLKDIV_ENABLE	(1 << 15)
+#define EP93XX_SYSCON_CLKDIV_PDIV_SHIFT	8
 #define EP93XX_SYSCON_KEYTCHCLKDIV	EP93XX_SYSCON_REG(0x90)
 #define EP93XX_SYSCON_KEYTCHCLKDIV_TSEN	(1<<31)
 #define EP93XX_SYSCON_KEYTCHCLKDIV_ADIV	(1<<16)
 #define EP93XX_SYSCON_KEYTCHCLKDIV_KEN	(1<<15)
 #define EP93XX_SYSCON_KEYTCHCLKDIV_KDIV	(1<<0)
 #define EP93XX_SYSCON_SWLOCK		EP93XX_SYSCON_REG(0xc0)
-
 #define EP93XX_WATCHDOG_BASE		EP93XX_APB_IOMEM(0x00140000)
 
 
diff --git a/arch/arm/mach-ep93xx/include/mach/fb.h b/arch/arm/mach-ep93xx/include/mach/fb.h
new file mode 100644
index 0000000..c16b622
--- /dev/null
+++ b/arch/arm/mach-ep93xx/include/mach/fb.h
@@ -0,0 +1,55 @@
+/*
+ * arch/arm/mach-ep93xx/include/mach/fb.h
+ */
+
+#ifndef __ASM_ARCH_EP93XXFB_H
+#define __ASM_ARCH_EP93XXFB_H
+
+struct fb_videomode;
+struct fb_info;
+
+#define EP93XXFB_USE_MODEDB		0
+
+/* VideoAttributes flags */
+#define EP93XXFB_STATE_MACHINE_ENABLE	(1 << 0)
+#define EP93XXFB_PIXEL_CLOCK_ENABLE	(1 << 1)
+#define EP93XXFB_VSYNC_ENABLE		(1 << 2)
+#define EP93XXFB_PIXEL_DATA_ENABLE	(1 << 3)
+#define EP93XXFB_COMPOSITE_SYNC		(1 << 4)
+#define EP93XXFB_SYNC_VERT_HIGH		(1 << 5)
+#define EP93XXFB_SYNC_HORIZ_HIGH	(1 << 6)
+#define EP93XXFB_SYNC_BLANK_HIGH	(1 << 7)
+#define EP93XXFB_PCLK_FALLING		(1 << 8)
+#define EP93XXFB_ENABLE_AC		(1 << 9)
+#define EP93XXFB_ENABLE_LCD		(1 << 10)
+#define EP93XXFB_ENABLE_CCIR		(1 << 12)
+#define EP93XXFB_USE_PARALLEL_INTERFACE	(1 << 13)
+#define EP93XXFB_ENABLE_INTERRUPT	(1 << 14)
+#define EP93XXFB_USB_INTERLACE		(1 << 16)
+#define EP93XXFB_USE_EQUALIZATION	(1 << 17)
+#define EP93XXFB_USE_DOUBLE_HORZ	(1 << 18)
+#define EP93XXFB_USE_DOUBLE_VERT	(1 << 19)
+#define EP93XXFB_USE_BLANK_PIXEL	(1 << 20)
+#define EP93XXFB_USE_SDCSN0		(0 << 21)
+#define EP93XXFB_USE_SDCSN1		(1 << 21)
+#define EP93XXFB_USE_SDCSN2		(2 << 21)
+#define EP93XXFB_USE_SDCSN3		(3 << 21)
+
+#define EP93XXFB_ENABLE			(EP93XXFB_STATE_MACHINE_ENABLE	| \
+					 EP93XXFB_PIXEL_CLOCK_ENABLE	| \
+					 EP93XXFB_VSYNC_ENABLE		| \
+					 EP93XXFB_PIXEL_DATA_ENABLE)
+
+struct ep93xxfb_mach_info {
+	unsigned int			num_modes;
+	const struct fb_videomode	*modes;
+	const struct fb_videomode	*default_mode;
+	int				bpp;
+	unsigned int			flags;
+
+	int	(*setup)(struct fb_info *info);
+	void	(*teardown)(struct fb_info *info);
+	void	(*blank)(int blank_mode, struct fb_info *info);
+};
+
+#endif /* __ASM_ARCH_EP93XXFB_H */
diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
index 0af0a3b..e8787e0 100644
--- a/arch/arm/mach-ep93xx/include/mach/platform.h
+++ b/arch/arm/mach-ep93xx/include/mach/platform.h
@@ -5,6 +5,7 @@
 #ifndef __ASSEMBLY__
 
 struct i2c_board_info;
+struct ep93xxfb_mach_info;
 
 struct ep93xx_eth_data
 {
@@ -32,7 +33,7 @@ static inline void ep93xx_devcfg_clear_bits(unsigned int bits)
 
 void ep93xx_register_eth(struct ep93xx_eth_data *data, int copy_addr);
 void ep93xx_register_i2c(struct i2c_board_info *devices, int num);
-
+void ep93xx_register_fb(struct ep93xxfb_mach_info *data);
 void ep93xx_init_devices(void);
 extern struct sys_timer ep93xx_timer;
 


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
