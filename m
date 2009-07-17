From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [PATCH 1/2] ep93xx framebuffer driver
Date: Fri, 17 Jul 2009 15:57:47 +1200
Message-ID: <4A5FF6BB.4000700@bluewatersys.com>
References: <4A5FF431.2000308@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <4A5FF431.2000308@bluewatersys.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: arm kernel <linux-arm-kernel@lists.arm.linux.org.uk>, linux-fbdev-devel@lists.sourceforge.net, hartleys <hartleys@visionengravers.com>, Daniele Venzano <d.venzano@motronica.com>

Add platform support and video clock for ep93xx framebuffer driver

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
 


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
