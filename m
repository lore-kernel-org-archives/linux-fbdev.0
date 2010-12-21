From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 21 Dec 2010 10:46:44 +0000
Subject: [PATCH/RFC 3/3] ARM: mach-shmobile: disable HDMI, if no driver
Message-Id: <Pine.LNX.4.64.1012211057550.32347@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The ap4evb board has an HDMI connector on LCDC1, and a connector for a 
MIPI-DSI display on LCDC0. Currently LCDC1 is always the default 
framebuffer and there is no way to switch to default LCDC0 without editing 
the sources. This patch switches the default framebuffer to LCDC0 if the 
HDMI driver is disabled in .config.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 5b07952..ed999a3 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -739,6 +739,7 @@ static struct platform_device fsi_device = {
 	},
 };
 
+#if defined(CONFIG_FB_SH_MOBILE_HDMI) || defined(CONFIG_FB_SH_MOBILE_HDMI_MODULE)
 static struct sh_mobile_lcdc_info sh_mobile_lcdc1_info = {
 	.clock_source = LCDC_CLK_EXTERNAL,
 	.ch[0] = {
@@ -804,6 +805,61 @@ static struct platform_device hdmi_device = {
 	},
 };
 
+static int __init hdmi_init_pm_clock(void)
+{
+	struct clk *hdmi_ick = clk_get(&hdmi_device.dev, "ick");
+	int ret;
+	long rate;
+
+	if (IS_ERR(hdmi_ick)) {
+		ret = PTR_ERR(hdmi_ick);
+		pr_err("Cannot get HDMI ICK: %d\n", ret);
+		goto out;
+	}
+
+	ret = clk_set_parent(&sh7372_pllc2_clk, &sh7372_dv_clki_div2_clk);
+	if (ret < 0) {
+		pr_err("Cannot set PLLC2 parent: %d, %d users\n", ret, sh7372_pllc2_clk.usecount);
+		goto out;
+	}
+
+	pr_debug("PLLC2 initial frequency %lu\n", clk_get_rate(&sh7372_pllc2_clk));
+
+	rate = clk_round_rate(&sh7372_pllc2_clk, 594000000);
+	if (rate < 0) {
+		pr_err("Cannot get suitable rate: %ld\n", rate);
+		ret = rate;
+		goto out;
+	}
+
+	ret = clk_set_rate(&sh7372_pllc2_clk, rate);
+	if (ret < 0) {
+		pr_err("Cannot set rate %ld: %d\n", rate, ret);
+		goto out;
+	}
+
+	ret = clk_enable(&sh7372_pllc2_clk);
+	if (ret < 0) {
+		pr_err("Cannot enable pllc2 clock\n");
+		goto out;
+	}
+	pr_debug("PLLC2 set frequency %lu\n", rate);
+
+	ret = clk_set_parent(hdmi_ick, &sh7372_pllc2_clk);
+	if (ret < 0) {
+		pr_err("Cannot set HDMI parent: %d\n", ret);
+		goto out;
+	}
+
+out:
+	if (!IS_ERR(hdmi_ick))
+		clk_put(hdmi_ick);
+	return ret;
+}
+
+device_initcall(hdmi_init_pm_clock);
+#endif
+
 static struct gpio_led ap4evb_leds[] = {
 	{
 		.name			= "led4",
@@ -938,68 +994,16 @@ static struct platform_device *ap4evb_devices[] __initdata = {
 	&usb1_host_device,
 	&fsi_device,
 	&sh_mmcif_device,
+#if defined(CONFIG_FB_SH_MOBILE_HDMI) || defined(CONFIG_FB_SH_MOBILE_HDMI_MODULE)
 	&lcdc1_device,
-	&lcdc_device,
 	&hdmi_device,
+#endif
+	&lcdc_device,
 	&csi2_device,
 	&ceu_device,
 	&ap4evb_camera,
 };
 
-static int __init hdmi_init_pm_clock(void)
-{
-	struct clk *hdmi_ick = clk_get(&hdmi_device.dev, "ick");
-	int ret;
-	long rate;
-
-	if (IS_ERR(hdmi_ick)) {
-		ret = PTR_ERR(hdmi_ick);
-		pr_err("Cannot get HDMI ICK: %d\n", ret);
-		goto out;
-	}
-
-	ret = clk_set_parent(&sh7372_pllc2_clk, &sh7372_dv_clki_div2_clk);
-	if (ret < 0) {
-		pr_err("Cannot set PLLC2 parent: %d, %d users\n", ret, sh7372_pllc2_clk.usecount);
-		goto out;
-	}
-
-	pr_debug("PLLC2 initial frequency %lu\n", clk_get_rate(&sh7372_pllc2_clk));
-
-	rate = clk_round_rate(&sh7372_pllc2_clk, 594000000);
-	if (rate < 0) {
-		pr_err("Cannot get suitable rate: %ld\n", rate);
-		ret = rate;
-		goto out;
-	}
-
-	ret = clk_set_rate(&sh7372_pllc2_clk, rate);
-	if (ret < 0) {
-		pr_err("Cannot set rate %ld: %d\n", rate, ret);
-		goto out;
-	}
-
-	ret = clk_enable(&sh7372_pllc2_clk);
-	if (ret < 0) {
-		pr_err("Cannot enable pllc2 clock\n");
-		goto out;
-	}
-	pr_debug("PLLC2 set frequency %lu\n", rate);
-
-	ret = clk_set_parent(hdmi_ick, &sh7372_pllc2_clk);
-	if (ret < 0) {
-		pr_err("Cannot set HDMI parent: %d\n", ret);
-		goto out;
-	}
-
-out:
-	if (!IS_ERR(hdmi_ick))
-		clk_put(hdmi_ick);
-	return ret;
-}
-
-device_initcall(hdmi_init_pm_clock);
-
 static int __init fsi_init_pm_clock(void)
 {
 	struct clk *fsia_ick;
