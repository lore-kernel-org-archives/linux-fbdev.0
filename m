From: Zhou Zhu <zzhu3@marvell.com>
Date: Wed, 24 Oct 2012 06:59:13 +0000
Subject: [PATCHv4 8/9] ARM: mmp: enable display in ttc_dkb
Message-Id: <1351061953-6804-1-git-send-email-zzhu3@marvell.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

enable display in ttc_dkb

Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
---
 arch/arm/mach-mmp/ttc_dkb.c |   92 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 92 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index 7a7de2b..1ec31d0 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -19,6 +19,8 @@
 #include <linux/gpio.h>
 #include <linux/mfd/88pm860x.h>
 #include <linux/platform_data/mv_usb.h>
+#include <linux/spi/spi.h>
+#include <linux/delay.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -177,6 +179,92 @@ static struct mv_usb_platform_data ttc_usb_pdata = {
 #endif
 #endif
 
+#ifdef CONFIG_MMP_DISP
+/* path config */
+#define CFG_IOPADMODE(iopad)   (iopad)  /* 0x0 ~ 0xd */
+#define SCLK_SOURCE_SELECT(x)  (x << 30) /* 0x0 ~ 0x3 */
+/* link config */
+#define CFG_DUMBMODE(mode)     (mode << 28) /* 0x0 ~ 0x6*/
+#define CFG_GRA_SWAPRB(x)      (x << 0) /* 1: rbswap enabled */
+static struct mmp_mach_path_config dkb_disp_config[] = {
+	[0] = {
+		.name = "mmp-parallel",
+		.ovly_num = 2,
+		.output_type = PATH_OUT_PARALLEL,
+		.path_config = CFG_IOPADMODE(0x1)\
+			| SCLK_SOURCE_SELECT(0x1),
+		.link_config = CFG_DUMBMODE(0x2)\
+			| CFG_GRA_SWAPRB(0x1),
+	},
+};
+
+static struct mmp_mach_plat_info dkb_disp_info = {
+	.name = "mmp-disp",
+	.clk_name = "LCDCLK",
+	.path_num = 1,
+	.paths = dkb_disp_config,
+};
+
+static struct mmp_buffer_driver_mach_info dkb_fb_info = {
+	.name = "mmp-fb",
+	.path_name = "mmp-parallel",
+	.ovly_id = 0,
+	.dmafetch_id = 1,
+	.default_pixfmt = PIXFMT_RGB565,
+};
+
+static void dkb_tpo_panel_power(int on)
+{
+	int err;
+	u32 spi_reset = mfp_to_gpio(MFP_PIN_GPIO106);
+
+	if (on) {
+		err = gpio_request(spi_reset, "TPO_LCD_SPI_RESET");
+		if (err) {
+			pr_err("failed to request GPIO for TPO LCD RESET\n");
+			return;
+		}
+		gpio_direction_output(spi_reset, 0);
+		udelay(100);
+		gpio_set_value(spi_reset, 1);
+		gpio_free(spi_reset);
+	} else {
+		err = gpio_request(spi_reset, "TPO_LCD_SPI_RESET");
+		if (err) {
+			pr_err("failed to request LCD RESET gpio\n");
+			return;
+		}
+		gpio_set_value(spi_reset, 0);
+		gpio_free(spi_reset);
+	}
+}
+
+static struct mmp_mach_panel_info dkb_tpo_panel_info = {
+	.name = "tpo-hvga",
+	.plat_path_name = "mmp-parallel",
+	.plat_set_onoff = dkb_tpo_panel_power,
+};
+
+static struct spi_board_info spi_board_info[] __initdata = {
+	{
+		.modalias       = "tpo-hvga",
+		.platform_data  = &dkb_tpo_panel_info,
+		.bus_num        = 5,
+	}
+};
+
+static void __init add_disp(void)
+{
+	pxa_register_device(&pxa910_device_disp,\
+		&dkb_disp_info, sizeof(dkb_disp_info));
+	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
+	pxa_register_device(&pxa910_device_fb,\
+		&dkb_fb_info, sizeof(dkb_fb_info));
+	pxa_register_device(&pxa910_device_panel,\
+		&dkb_tpo_panel_info, sizeof(dkb_tpo_panel_info));
+}
+#endif
+
 static void __init ttc_dkb_init(void)
 {
 	mfp_config(ARRAY_AND_SIZE(ttc_dkb_pin_config));
@@ -202,6 +290,10 @@ static void __init ttc_dkb_init(void)
 	pxa168_device_u2ootg.dev.platform_data = &ttc_usb_pdata;
 	platform_device_register(&pxa168_device_u2ootg);
 #endif
+
+#ifdef CONFIG_MMP_DISP
+	add_disp();
+#endif
 }
 
 MACHINE_START(TTC_DKB, "PXA910-based TTC_DKB Development Platform")
-- 
1.7.0.4

