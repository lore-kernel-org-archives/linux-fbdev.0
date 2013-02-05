From: Johan Hovold <jhovold@gmail.com>
Date: Tue, 05 Feb 2013 13:35:15 +0000
Subject: [PATCH 5/5] ARM: at91/avr32/atmel_lcdfb: replace cpu_is macros with device-id table
Message-Id: <1360071315-4032-6-git-send-email-jhovold@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130129135435.GN7360@game.jcrosoft.org>
 <1360071315-4032-1-git-send-email-jhovold@gmail.com>
In-Reply-To: <1360071315-4032-1-git-send-email-jhovold@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Remove cpu_is macros from atmel lcdfb driver and use platform-device-id
table to determine platform configuration parameters.

The currently used configuration parameters are:

have_alt_pixclock
 - SOC uses an alternate pixel-clock calculation formula (at91sam9g45
   non-ES)

have_bus_clk
 - SOC has bus clock hck1 (at91sam9261, at921sam9g10 and at32ap)

have_hozval
 - SOC has a HOZVAL field in LCDFRMCFG which is used to determine the
   linesize for STN displays (at91sam9261, at921sam9g10 and at32ap)

have_intensity_bit
 - SOC uses IBGR:555 rather than BGR:565 16-bit pixel layout
   (at91sam9261, at91sam9263 and at91sam9rl)

Tested on at91sam9g45, compile-tested for other AT91 SOCs, and untested
for AVR32.

Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 arch/arm/mach-at91/at91sam9261_devices.c |  6 +-
 arch/arm/mach-at91/at91sam9263_devices.c |  2 +-
 arch/arm/mach-at91/at91sam9g45_devices.c |  6 +-
 arch/arm/mach-at91/at91sam9rl_devices.c  |  2 +-
 arch/avr32/mach-at32ap/at32ap700x.c      |  2 +
 drivers/video/atmel_lcdfb.c              | 96 ++++++++++++++++++++++++++++----
 include/video/atmel_lcdc.h               |  4 +-
 7 files changed, 101 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index 92e0f86..01647cb 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -488,7 +488,6 @@ static struct resource lcdc_resources[] = {
 };
 
 static struct platform_device at91_lcdc_device = {
-	.name		= "atmel_lcdfb",
 	.id		= 0,
 	.dev		= {
 				.dma_mask		= &lcdc_dmamask,
@@ -505,6 +504,11 @@ void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data)
 		return;
 	}
 
+	if (cpu_is_at91sam9g10())
+		at91_lcdc_device.name = "fb-at91sam9g10";
+	else
+		at91_lcdc_device.name = "fb-at91sam9261";
+
 #if defined(CONFIG_FB_ATMEL_STN)
 	at91_set_A_periph(AT91_PIN_PB0, 0);     /* LCDVSYNC */
 	at91_set_A_periph(AT91_PIN_PB1, 0);     /* LCDHSYNC */
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index ed666f5..a34f39a 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -848,7 +848,7 @@ static struct resource lcdc_resources[] = {
 };
 
 static struct platform_device at91_lcdc_device = {
-	.name		= "atmel_lcdfb",
+	.name		= "fb-at91sam9263",
 	.id		= 0,
 	.dev		= {
 				.dma_mask		= &lcdc_dmamask,
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 827c9f2..1d5cc51 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -981,7 +981,6 @@ static struct resource lcdc_resources[] = {
 };
 
 static struct platform_device at91_lcdc_device = {
-	.name		= "atmel_lcdfb",
 	.id		= 0,
 	.dev		= {
 				.dma_mask		= &lcdc_dmamask,
@@ -997,6 +996,11 @@ void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data)
 	if (!data)
 		return;
 
+	if (cpu_is_at91sam9g45es())
+		at91_lcdc_device.name = "fb-at91sam9g45es";
+	else
+		at91_lcdc_device.name = "fb-at91sam9g45";
+
 	at91_set_A_periph(AT91_PIN_PE0, 0);	/* LCDDPWR */
 
 	at91_set_A_periph(AT91_PIN_PE2, 0);	/* LCDCC */
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index ddf223f..13cac0a 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -514,7 +514,7 @@ static struct resource lcdc_resources[] = {
 };
 
 static struct platform_device at91_lcdc_device = {
-	.name		= "atmel_lcdfb",
+	.name		= "fb-at91sam9rl",
 	.id		= 0,
 	.dev		= {
 				.dma_mask		= &lcdc_dmamask,
diff --git a/arch/avr32/mach-at32ap/at32ap700x.c b/arch/avr32/mach-at32ap/at32ap700x.c
index b323d8d..5cdaa07 100644
--- a/arch/avr32/mach-at32ap/at32ap700x.c
+++ b/arch/avr32/mach-at32ap/at32ap700x.c
@@ -1530,6 +1530,8 @@ at32_add_device_lcdc(unsigned int id, struct atmel_lcdfb_info *data,
 	memcpy(info, data, sizeof(struct atmel_lcdfb_info));
 	info->default_monspecs = monspecs;
 
+	pdev->name = "fb-at32ap";
+
 	platform_device_register(pdev);
 	return pdev;
 
diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index 347bab2..5ad49ed 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -34,6 +34,81 @@
 #define ATMEL_LCDC_DMA_BURST_LEN	8	/* words */
 #define ATMEL_LCDC_FIFO_SIZE		512	/* words */
 
+struct atmel_lcdfb_config {
+	bool have_alt_pixclock;
+	bool have_bus_clk;
+	bool have_hozval;
+	bool have_intensity_bit;
+};
+
+static struct atmel_lcdfb_config at91sam9261_config = {
+	.have_bus_clk		= true,
+	.have_intensity_bit	= true,
+	.have_hozval		= true,
+};
+
+static struct atmel_lcdfb_config at91sam9263_config = {
+	.have_intensity_bit	= true,
+};
+
+static struct atmel_lcdfb_config at91sam9g10_config = {
+	.have_bus_clk		= true,
+	.have_hozval		= true,
+};
+
+static struct atmel_lcdfb_config at91sam9g45_config = {
+	.have_alt_pixclock	= true,
+};
+
+static struct atmel_lcdfb_config at91sam9g45es_config = {
+};
+
+static struct atmel_lcdfb_config at91sam9rl_config = {
+	.have_intensity_bit	= true,
+};
+
+static struct atmel_lcdfb_config at32ap_config = {
+	.have_bus_clk		= true,
+	.have_hozval		= true,
+};
+
+static const struct platform_device_id atmel_lcdfb_devtypes[] = {
+	{
+		.name = "fb-at91sam9261",
+		.driver_data = (unsigned long)&at91sam9261_config,
+	}, {
+		.name = "fb-at91sam9263",
+		.driver_data = (unsigned long)&at91sam9263_config,
+	}, {
+		.name = "fb-at91sam9g10",
+		.driver_data = (unsigned long)&at91sam9g10_config,
+	}, {
+		.name = "fb-at91sam9g45",
+		.driver_data = (unsigned long)&at91sam9g45_config,
+	}, {
+		.name = "fb-at91sam9g45es",
+		.driver_data = (unsigned long)&at91sam9g45es_config,
+	}, {
+		.name = "fb-at91sam9rl",
+		.driver_data = (unsigned long)&at91sam9rl_config,
+	}, {
+		.name = "fb-at32ap",
+		.driver_data = (unsigned long)&at32ap_config,
+	}, {
+		/* terminator */
+	}
+};
+
+static struct atmel_lcdfb_config *
+atmel_lcdfb_get_config(struct platform_device *pdev)
+{
+	unsigned long data;
+
+	data = platform_get_device_id(pdev)->driver_data;
+
+	return (struct atmel_lcdfb_config *)data;
+}
+
 #if defined(CONFIG_ARCH_AT91)
 #define	ATMEL_LCDFB_FBINFO_DEFAULT	(FBINFO_DEFAULT \
 					 | FBINFO_PARTIAL_PAN_OK \
@@ -199,8 +274,7 @@ static unsigned long compute_hozval(struct atmel_lcdfb_info *sinfo,
 	unsigned long lcdcon2;
 	unsigned long value;
 
-	if (!(cpu_is_at91sam9261() || cpu_is_at91sam9g10()
-		|| cpu_is_at32ap7000()))
+	if (!sinfo->config->have_hozval)
 		return xres;
 
 	lcdcon2 = lcdc_readl(sinfo, ATMEL_LCDC_LCDCON2);
@@ -426,7 +500,7 @@ static int atmel_lcdfb_check_var(struct fb_var_screeninfo *var,
 		break;
 	case 16:
 		/* Older SOCs use IBGR:555 rather than BGR:565. */
-		if (sinfo->have_intensity_bit)
+		if (sinfo->config->have_intensity_bit)
 			var->green.length = 5;
 		else
 			var->green.length = 6;
@@ -534,7 +608,7 @@ static int atmel_lcdfb_set_par(struct fb_info *info)
 	/* Now, the LCDC core... */
 
 	/* Set pixel clock */
-	if (cpu_is_at91sam9g45() && !cpu_is_at91sam9g45es())
+	if (sinfo->config->have_alt_pixclock)
 		pix_factor = 1;
 
 	clk_value_khz = clk_get_rate(sinfo->lcdc_clk) / 1000;
@@ -685,7 +759,7 @@ static int atmel_lcdfb_setcolreg(unsigned int regno, unsigned int red,
 
 	case FB_VISUAL_PSEUDOCOLOR:
 		if (regno < 256) {
-			if (sinfo->have_intensity_bit) {
+			if (sinfo->config->have_intensity_bit) {
 				/* old style I+BGR:555 */
 				val  = ((red   >> 11) & 0x001f);
 				val |= ((green >>  6) & 0x03e0);
@@ -875,10 +949,9 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
 	}
 	sinfo->info = info;
 	sinfo->pdev = pdev;
-	if (cpu_is_at91sam9261() || cpu_is_at91sam9263() ||
-							cpu_is_at91sam9rl()) {
-		sinfo->have_intensity_bit = true;
-	}
+	sinfo->config = atmel_lcdfb_get_config(pdev);
+	if (!sinfo->config)
+		goto free_info;
 
 	strcpy(info->fix.id, sinfo->pdev->name);
 	info->flags = ATMEL_LCDFB_FBINFO_DEFAULT;
@@ -889,8 +962,7 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
 	info->fix = atmel_lcdfb_fix;
 
 	/* Enable LCDC Clocks */
-	if (cpu_is_at91sam9261() || cpu_is_at91sam9g10()
-	 || cpu_is_at32ap7000()) {
+	if (sinfo->config->have_bus_clk) {
 		sinfo->bus_clk = clk_get(dev, "hck1");
 		if (IS_ERR(sinfo->bus_clk)) {
 			ret = PTR_ERR(sinfo->bus_clk);
@@ -1152,7 +1224,7 @@ static struct platform_driver atmel_lcdfb_driver = {
 	.remove		= __exit_p(atmel_lcdfb_remove),
 	.suspend	= atmel_lcdfb_suspend,
 	.resume		= atmel_lcdfb_resume,
-
+	.id_table	= atmel_lcdfb_devtypes,
 	.driver		= {
 		.name	= "atmel_lcdfb",
 		.owner	= THIS_MODULE,
diff --git a/include/video/atmel_lcdc.h b/include/video/atmel_lcdc.h
index 8deb226..0f5a2fc 100644
--- a/include/video/atmel_lcdc.h
+++ b/include/video/atmel_lcdc.h
@@ -31,6 +31,7 @@
 #define ATMEL_LCDC_WIRING_BGR	0
 #define ATMEL_LCDC_WIRING_RGB	1
 
+struct atmel_lcdfb_config;
 
  /* LCD Controller info data structure, stored in device platform_data */
 struct atmel_lcdfb_info {
@@ -61,7 +62,8 @@ struct atmel_lcdfb_info {
 	void (*atmel_lcdfb_power_control)(int on);
 	struct fb_monspecs	*default_monspecs;
 	u32			pseudo_palette[16];
-	bool			have_intensity_bit;
+
+	struct atmel_lcdfb_config *config;
 };
 
 #define ATMEL_LCDC_DMABADDR1	0x00
-- 
1.8.1.1

