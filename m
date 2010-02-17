From: Baruch Siach <baruch@tkos.co.il>
Date: Wed, 17 Feb 2010 10:33:25 +0000
Subject: [PATCH 3/3] mx25pdk: add LCD support
Message-Id: <88d35ab38e7f0adf7a8c712843785d21d6225065.1266402631.git.baruch@tkos.co.il>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100217094359.GY17643@pengutronix.de>
In-Reply-To: <20100217094359.GY17643@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/mach-mx25/mx25pdk.c                |   55 +++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/iomux-mx25.h |    2 +
 2 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx25/mx25pdk.c b/arch/arm/mach-mx25/mx25pdk.c
index f4e8b98..6d9dd33 100644
--- a/arch/arm/mach-mx25/mx25pdk.c
+++ b/arch/arm/mach-mx25/mx25pdk.c
@@ -35,6 +35,7 @@
 #include <mach/imx-uart.h>
 #include <mach/mx25.h>
 #include <mach/mxc_nand.h>
+#include <mach/imxfb.h>
 #include "devices.h"
 #include <mach/iomux.h>
 
@@ -54,6 +55,31 @@ static struct pad_desc mx25pdk_pads[] = {
 	MX25_PAD_FEC_TX_CLK__FEC_TX_CLK,
 	MX25_PAD_A17__GPIO_2_3, /* FEC_EN, GPIO 35 */
 	MX25_PAD_D12__GPIO_4_8, /* FEC_RESET_B, GPIO 104 */
+
+	/* LCD */
+	MX25_PAD_LD0__LD0,
+	MX25_PAD_LD1__LD1,
+	MX25_PAD_LD2__LD2,
+	MX25_PAD_LD3__LD3,
+	MX25_PAD_LD4__LD4,
+	MX25_PAD_LD5__LD5,
+	MX25_PAD_LD6__LD6,
+	MX25_PAD_LD7__LD7,
+	MX25_PAD_LD8__LD8,
+	MX25_PAD_LD9__LD9,
+	MX25_PAD_LD10__LD10,
+	MX25_PAD_LD11__LD11,
+	MX25_PAD_LD12__LD12,
+	MX25_PAD_LD13__LD13,
+	MX25_PAD_LD14__LD14,
+	MX25_PAD_LD15__LD15,
+	MX25_PAD_GPIO_E__LD16,
+	MX25_PAD_GPIO_F__LD17,
+	MX25_PAD_HSYNC__HSYNC,
+	MX25_PAD_VSYNC__VSYNC,
+	MX25_PAD_LSCLK__LSCLK,
+	MX25_PAD_OE_ACD__OE_ACD,
+	MX25_PAD_CONTRAST__CONTRAST,
 };
 
 static struct fec_platform_data mx25_fec_pdata = {
@@ -83,6 +109,34 @@ static struct mxc_nand_platform_data mx25pdk_nand_board_info = {
 	.flash_bbt	= 1,
 };
 
+static struct imx_fb_videomode mx25pdk_modes[] = {
+	{
+		.mode	= {
+			.name		= "CRT-VGA",
+			.refresh	= 60,
+			.xres		= 640,
+			.yres		= 480,
+			.pixclock	= 39683,
+			.left_margin	= 45,
+			.right_margin	= 114,
+			.upper_margin	= 33,
+			.lower_margin	= 11,
+			.hsync_len	= 1,
+			.vsync_len	= 1,
+		},
+		.bpp	= 16,
+		.pcr	= 0xFA208B80,
+	},
+};
+
+static struct imx_fb_platform_data mx25pdk_fb_pdata = {
+	.mode		= mx25pdk_modes,
+	.num_modes	= ARRAY_SIZE(mx25pdk_modes),
+	.pwmr		= 0x00A903FF,
+	.lscr1		= 0x00120300,
+	.dmacr		= 0x00020010,
+};
+
 static void __init mx25pdk_init(void)
 {
 	mxc_iomux_v3_setup_multiple_pads(mx25pdk_pads,
@@ -92,6 +146,7 @@ static void __init mx25pdk_init(void)
 	mxc_register_device(&mxc_usbh2, NULL);
 	mxc_register_device(&mxc_nand_device, &mx25pdk_nand_board_info);
 	mxc_register_device(&mx25_rtc_device, NULL);
+	mxc_register_device(&mx25_fb_device, &mx25pdk_fb_pdata);
 
 	mx25pdk_fec_reset();
 	mxc_register_device(&mx25_fec_device, &mx25_fec_pdata);
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx25.h b/arch/arm/plat-mxc/include/mach/iomux-mx25.h
index 9af494f..5418d52 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx25.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx25.h
@@ -462,9 +462,11 @@
 #define MX25_PAD_GPIO_C__CAN2_TX	IOMUX_PAD(0x3f8, 0x1fc, 0x16, 0, 0, PAD_CTL_PUS_22K_UP)
 
 #define MX25_PAD_GPIO_D__GPIO_D		IOMUX_PAD(0x3fc, 0x200, 0x10, 0, 0, NO_PAD_CTRL)
+#define MX25_PAD_GPIO_E__LD16		IOMUX_PAD(0x400, 0x204, 0x02, 0, 0, NO_PAD_CTRL)
 #define MX25_PAD_GPIO_D__CAN2_RX	IOMUX_PAD(0x3fc, 0x200, 0x16, 0x484, 1, PAD_CTL_PUS_22K_UP)
 
 #define MX25_PAD_GPIO_E__GPIO_E		IOMUX_PAD(0x400, 0x204, 0x10, 0, 0, NO_PAD_CTRL)
+#define MX25_PAD_GPIO_F__LD17		IOMUX_PAD(0x404, 0x208, 0x02, 0, 0, NO_PAD_CTRL)
 #define MX25_PAD_GPIO_E__AUD7_TXD	IOMUX_PAD(0x400, 0x204, 0x14, 0, 0, NO_PAD_CTRL)
 
 #define MX25_PAD_GPIO_F__GPIO_F		IOMUX_PAD(0x404, 0x208, 0x10, 0, 0, NO_PAD_CTRL)
-- 
1.6.6.1

