From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 4/4 v8] i.MX31: platform bindings and initialisation for
	IPU and framebuffer drivers
Date: Thu, 8 Jan 2009 19:05:19 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0901081900270.6387@axis700.grange>
References: <Pine.LNX.4.64.0901081850280.6387@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.64.0901081850280.6387@axis700.grange>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Dan Williams <dan.j.williams@intel.com>, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, linux-kernel@vger.kernel.org

From: Guennadi Liakhovetski <lg@denx.de>

This patch includes platform device data for IPU and framebuffer devices
and pin initialisation for the pcm037 platform.

Signed-off-by: Guennadi Liakhovetski <lg@denx.de>
---

Updated to current git. Also based on my earlier patch from today

http://marc.info/?l=linux-arm-kernel&m=123143547207971&w=2

which is not going into the mainline, because Russell has a more generic 
fix. So, might well be, that it will not apply. Please, merge manually. 
Should be trivial.

 arch/arm/mach-mx3/devices.c |   81 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mx3/pcm037.c  |   55 ++++++++++++++++++++++++++++-
 2 files changed, 135 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index a3881d3..f0ec1e3 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -21,9 +21,12 @@
 #include <linux/platform_device.h>
 #include <linux/serial.h>
 #include <linux/gpio.h>
+
 #include <mach/hardware.h>
 #include <mach/imx-uart.h>
 #include <mach/irqs.h>
+#include <mach/ipu.h>
+#include <mach/mx3fb.h>
 
 static struct resource uart0[] = {
 	{
@@ -180,3 +183,81 @@ struct platform_device mxc_nand_device = {
 	.num_resources = ARRAY_SIZE(mxc_nand_resources),
 	.resource = mxc_nand_resources,
 };
+
+/* i.MX31 Image Processing Unit */
+
+/* The resource order is important! */
+static struct resource mx3_ipu_rsrc[] = {
+	{
+		.start = IPU_CTRL_BASE_ADDR,
+		.end = IPU_CTRL_BASE_ADDR + 0x5F,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = IPU_CTRL_BASE_ADDR + 0x88,
+		.end = IPU_CTRL_BASE_ADDR + 0xB3,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = MXC_INT_IPU_SYN,
+		.end = MXC_INT_IPU_SYN,
+		.flags = IORESOURCE_IRQ,
+	}, {
+		.start = MXC_INT_IPU_ERR,
+		.end = MXC_INT_IPU_ERR,
+		.flags = IORESOURCE_IRQ,
+	}
+};
+
+static struct ipu_platform_data mx3_ipu_data = {
+	.irq_base = MXC_IPU_IRQ_START,
+};
+
+static struct platform_device mx3_ipu = {
+	.name = "ipu-core",
+	.id = -1,
+	.resource = mx3_ipu_rsrc,
+	.num_resources = ARRAY_SIZE(mx3_ipu_rsrc),
+	.dev = {
+		.platform_data = &mx3_ipu_data,
+	},
+};
+
+static bool ipu_registered = false;
+
+static struct resource fb_resources[] = {
+	{
+		.start		= IPU_CTRL_BASE_ADDR + 0xB4,
+		.end		= IPU_CTRL_BASE_ADDR + 0x1BF,
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct mx3fb_platform_data mx3fb_data = {
+	.dma_dev	= &mx3_ipu.dev,
+};
+
+static struct platform_device mx3_fb = {
+	.name		= "mx3_sdc_fb",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(fb_resources),
+	.resource	= fb_resources,
+	.dev		= {
+		.platform_data = &mx3fb_data,
+		.coherent_dma_mask = 0xffffffff,
+	},
+};
+
+int __init mx3_register_fb(const char *name, const struct fb_videomode *modes,
+			   int num_modes)
+{
+	if (!ipu_registered) {
+		int ret = platform_device_register(&mx3_ipu);
+		if (ret < 0)
+			return ret;
+		ipu_registered = true;
+	}
+
+	mx3fb_data.name = name;
+	mx3fb_data.mode = modes;
+	mx3fb_data.num_modes = num_modes;
+	return platform_device_register(&mx3_fb);
+}
diff --git a/arch/arm/mach-mx3/pcm037.c b/arch/arm/mach-mx3/pcm037.c
index 8cea825..d9ecb0c 100644
--- a/arch/arm/mach-mx3/pcm037.c
+++ b/arch/arm/mach-mx3/pcm037.c
@@ -27,16 +27,18 @@
 #include <linux/smc911x.h>
 #include <linux/interrupt.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
+
+#include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
 #include <mach/board-pcm037.h>
 #include <mach/mxc_nand.h>
+#include <mach/mx3fb.h>
 
 #include "devices.h"
 
@@ -123,6 +125,27 @@ static struct platform_device *devices[] __initdata = {
 	&pcm037_sram_device,
 };
 
+static const struct fb_videomode fb_modedb[] = {
+	{
+		/* 240x320 @ 60 Hz */
+		.name		= "Sharp-LQ035Q7DH06-QVGA",
+		.refresh	= 60,
+		.xres		= 240,
+		.yres		= 320,
+		.pixclock	= 185925,
+		.left_margin	= 9,
+		.right_margin	= 16,
+		.upper_margin	= 7,
+		.lower_margin	= 9,
+		.hsync_len	= 1,
+		.vsync_len	= 1,
+		.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_SHARP_MODE |
+				  FB_SYNC_CLK_INVERT | FB_SYNC_CLK_IDLE_EN,
+		.vmode		= FB_VMODE_NONINTERLACED,
+		.flag		= 0,
+	},
+};
+
 /*
  * Board specific initialization.
  */
@@ -151,6 +174,36 @@ static void __init mxc_board_init(void)
 		gpio_direction_input(MX31_PIN_GPIO3_1);
 
 	mxc_register_device(&mxc_nand_device, &pcm037_nand_board_info);
+
+	/* Display Interface #3 */
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD0, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD1, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD2, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD3, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD4, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD5, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD6, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD7, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD8, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD9, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD10, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD11, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD12, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD13, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD14, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD15, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD16, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD17, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_VSYNC3, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_HSYNC, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_FPSHIFT, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_DRDY0, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_D3_REV, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_CONTRAST, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_D3_SPL, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_D3_CLS, IOMUX_CONFIG_FUNC));
+
+	mx3_register_fb(fb_modedb[0].name, fb_modedb, ARRAY_SIZE(fb_modedb));
 }
 
 /*
-- 
1.5.4


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
