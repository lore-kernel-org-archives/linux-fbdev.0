From: Baruch Siach <baruch@tkos.co.il>
Date: Wed, 10 Feb 2010 07:25:19 +0000
Subject: [PATCH 2/3] mx25: add platform support for imxfb
Message-Id: <63f40f35fe8cdea681d8341af36a4c539086f7ef.1265786237.git.baruch@tkos.co.il>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1265786237.git.baruch@tkos.co.il>
In-Reply-To: <cover.1265786237.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/mach-mx25/clock.c            |   12 ++++++++++++
 arch/arm/mach-mx25/devices.c          |   23 +++++++++++++++++++++++
 arch/arm/mach-mx25/devices.h          |    1 +
 arch/arm/plat-mxc/include/mach/mx25.h |    2 ++
 4 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx25/clock.c b/arch/arm/mach-mx25/clock.c
index 744b52a..56bf958 100644
--- a/arch/arm/mach-mx25/clock.c
+++ b/arch/arm/mach-mx25/clock.c
@@ -124,6 +124,11 @@ static unsigned long get_rate_gpt(struct clk *clk)
 	return get_rate_per(5);
 }
 
+static unsigned long get_rate_lcdc(struct clk *clk)
+{
+	return get_rate_per(7);
+}
+
 static unsigned long get_rate_otg(struct clk *clk)
 {
 	return 48000000; /* FIXME */
@@ -167,6 +172,8 @@ DEFINE_CLOCK(cspi1_clk,  0, CCM_CGCR1,  5, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(cspi2_clk,  0, CCM_CGCR1,  6, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(cspi3_clk,  0, CCM_CGCR1,  7, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(fec_ahb_clk, 0, CCM_CGCR0, 23, NULL,	 NULL, NULL);
+DEFINE_CLOCK(lcdc_ahb_clk, 0, CCM_CGCR0, 24, NULL,	 NULL, NULL);
+DEFINE_CLOCK(lcdc_per_clk, 0, CCM_CGCR0,  7, NULL,	 NULL, &lcdc_ahb_clk);
 DEFINE_CLOCK(uart1_clk,  0, CCM_CGCR2, 14, get_rate_uart, NULL, &uart_per_clk);
 DEFINE_CLOCK(uart2_clk,  0, CCM_CGCR2, 15, get_rate_uart, NULL, &uart_per_clk);
 DEFINE_CLOCK(uart3_clk,  0, CCM_CGCR2, 16, get_rate_uart, NULL, &uart_per_clk);
@@ -183,6 +190,7 @@ DEFINE_CLOCK(tsc_clk,	 0, CCM_CGCR2, 13, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(i2c_clk,	 0, CCM_CGCR0,  6, get_rate_i2c, NULL, NULL);
 DEFINE_CLOCK(fec_clk,	 0, CCM_CGCR1, 15, get_rate_ipg, NULL, &fec_ahb_clk);
 DEFINE_CLOCK(dryice_clk, 0, CCM_CGCR1,  8, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(lcdc_clk,	 0, CCM_CGCR1, 29, get_rate_lcdc, NULL, &lcdc_per_clk);
 
 #define _REGISTER_CLOCK(d, n, c)	\
 	{				\
@@ -216,6 +224,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("imx-i2c.2", NULL, i2c_clk)
 	_REGISTER_CLOCK("fec.0", NULL, fec_clk)
 	_REGISTER_CLOCK("imxdi_rtc.0", NULL, dryice_clk)
+	_REGISTER_CLOCK("imx-fb.0", NULL, lcdc_clk)
 };
 
 int __init mx25_clocks_init(void)
@@ -233,6 +242,9 @@ int __init mx25_clocks_init(void)
 	__raw_writel((0xf << 16) | (3 << 26), CRM_BASE + CCM_CGCR1);
 	__raw_writel((1 << 5), CRM_BASE + CCM_CGCR2);
 
+	/* Clock source for lcdc is upll */
+	__raw_writel(__raw_readl(CRM_BASE+0x64) | (1 << 7), CRM_BASE + 0x64);
+
 	mxc_timer_init(&gpt_clk, MX25_IO_ADDRESS(MX25_GPT1_BASE_ADDR), 54);
 
 	return 0;
diff --git a/arch/arm/mach-mx25/devices.c b/arch/arm/mach-mx25/devices.c
index b0b75fc..3f4b8a0 100644
--- a/arch/arm/mach-mx25/devices.c
+++ b/arch/arm/mach-mx25/devices.c
@@ -477,3 +477,26 @@ struct platform_device mx25_rtc_device = {
 	.num_resources	= ARRAY_SIZE(mx25_rtc_resources),
 	.resource	= mx25_rtc_resources,
 };
+
+static struct resource mx25_fb_resources[] = {
+	{
+		.start	= MX25_LCDC_BASE_ADDR,
+		.end	= MX25_LCDC_BASE_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= MX25_INT_LCDC,
+		.end	= MX25_INT_LCDC,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device mx25_fb_device = {
+	.name		= "imx-fb",
+	.id		= 0,
+	.resource	= mx25_fb_resources,
+	.num_resources	= ARRAY_SIZE(mx25_fb_resources),
+	.dev		= {
+		.coherent_dma_mask = 0xFFFFFFFF,
+	},
+};
diff --git a/arch/arm/mach-mx25/devices.h b/arch/arm/mach-mx25/devices.h
index 37e6a08..39560e1 100644
--- a/arch/arm/mach-mx25/devices.h
+++ b/arch/arm/mach-mx25/devices.h
@@ -20,3 +20,4 @@ extern struct platform_device mxc_i2c_device2;
 extern struct platform_device mx25_fec_device;
 extern struct platform_device mxc_nand_device;
 extern struct platform_device mx25_rtc_device;
+extern struct platform_device mx25_fb_device;
diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index 215c4d8..f29798d 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -44,9 +44,11 @@
 #define MX25_FEC_BASE_ADDR		0x50038000
 #define MX25_NFC_BASE_ADDR		0xbb000000
 #define MX25_DRYICE_BASE_ADDR		0x53ffc000
+#define MX25_LCDC_BASE_ADDR		0x53fbc000
 
 #define MX25_INT_DRYICE	25
 #define MX25_INT_FEC	57
 #define MX25_INT_NANDFC	33
+#define MX25_INT_LCDC	39
 
 #endif /* __MACH_MX25_H__ */
-- 
1.6.6.1

