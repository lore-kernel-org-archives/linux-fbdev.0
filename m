From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Tue, 29 Mar 2011 03:35:58 +0000
Subject: [RFC][PATCH 3/3] sh_mobile_meram: MERAM platform data for LCDC
Message-Id: <1301369758-18394-4-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Based on the patch by Takanari Hayama <taki@igel.co.jp>

Add the necessary platform data to add MERAM functionality to LCDC

Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
---
 arch/arm/mach-shmobile/board-ap4evb.c |   69 +++++++++++++++++++++++++++++++++
 1 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index a94f29d..e467696 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -249,6 +249,31 @@ static int slot_cn7_get_cd(struct platform_device *pdev)
 {
 	return !gpio_get_value(GPIO_PORT41);
 }
+#ifdef CONFIG_FB_SH_MOBILE_MERAM
+/* MERAM */
+static struct sh_mobile_meram_info mackerel_meram_info = {
+	.addr_mode      = SH_MOBILE_MERAM_MODE1,
+};
+
+static struct resource meram_resources[] = {
+	[0] = {
+		.name   = "MERAM",
+		.start  = 0xe8000000,
+		.end    = 0xe81fffff,
+		.flags  = IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device meram_device = {
+	.name           = "sh_mobile_meram",
+	.id             = -1,
+	.num_resources  = ARRAY_SIZE(meram_resources),
+	.resource       = meram_resources,
+	.dev            = {
+		.platform_data = &mackerel_meram_info,
+	},
+};
+#endif
 
 /* SH_MMCIF */
 static struct resource sh_mmcif_resources[] = {
@@ -431,6 +456,23 @@ const static struct fb_videomode ap4evb_lcdc_modes[] = {
 #endif
 	},
 };
+#ifdef CONFIG_FB_SH_MOBILE_MERAM
+static struct sh_mobile_meram_cfg lcd_meram_cfg = {
+	.meram_dev = &mackerel_meram_info,
+	.icb[0] = {
+		.marker_icb     = 28,
+		.cache_icb      = 24,
+		.meram_offset   = 0x0,
+		.meram_size     = 0x40,
+	},
+	.icb[1] = {
+		.marker_icb     = 29,
+		.cache_icb      = 25,
+		.meram_offset   = 0x40,
+		.meram_size     = 0x40,
+	},
+};
+#endif
 
 static struct sh_mobile_lcdc_info lcdc_info = {
 	.ch[0] = {
@@ -438,6 +480,9 @@ static struct sh_mobile_lcdc_info lcdc_info = {
 		.bpp = 16,
 		.lcd_cfg = ap4evb_lcdc_modes,
 		.num_cfg = ARRAY_SIZE(ap4evb_lcdc_modes),
+#ifdef CONFIG_FB_SH_MOBILE_MERAM
+		.meram_cfg = &lcd_meram_cfg,
+#endif
 	}
 };
 
@@ -708,6 +753,23 @@ static struct platform_device fsi_device = {
 static struct platform_device fsi_ak4643_device = {
 	.name		= "sh_fsi2_a_ak4643",
 };
+#ifdef CONFIG_FB_SH_MOBILE_MERAM
+static struct sh_mobile_meram_cfg hdmi_meram_cfg = {
+	.meram_dev = &mackerel_meram_info,
+	.icb[0] = {
+		.marker_icb     = 30,
+		.cache_icb      = 26,
+		.meram_offset   = 0x80,
+		.meram_size     = 0x100,
+	},
+	.icb[1] = {
+		.marker_icb     = 31,
+		.cache_icb      = 27,
+		.meram_offset   = 0x180,
+		.meram_size     = 0x100,
+	},
+};
+#endif
 
 static struct sh_mobile_lcdc_info sh_mobile_lcdc1_info = {
 	.clock_source = LCDC_CLK_EXTERNAL,
@@ -717,6 +779,10 @@ static struct sh_mobile_lcdc_info sh_mobile_lcdc1_info = {
 		.interface_type = RGB24,
 		.clock_divider = 1,
 		.flags = LCDC_FLAGS_DWPOL,
+#ifdef CONFIG_FB_SH_MOBILE_MERAM
+		.meram_cfg = &hdmi_meram_cfg,
+#endif
+
 	}
 };
 
@@ -945,6 +1011,9 @@ static struct platform_device *ap4evb_devices[] __initdata = {
 	&csi2_device,
 	&ceu_device,
 	&ap4evb_camera,
+#ifdef CONFIG_FB_SH_MOBILE_MERAM
+	&meram_device,
+#endif
 };
 
 static int __init hdmi_init_pm_clock(void)
-- 
1.7.1

