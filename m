From: Ryan Harkin <ryan.harkin@linaro.org>
Date: Wed, 19 Sep 2012 16:04:25 +0000
Subject: [RFC PATCH 2/3] ARM: vexpress: Add device tree support for CLCD driver
Message-Id: <1348070666-9153-3-git-send-email-ryan.harkin@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348070666-9153-1-git-send-email-ryan.harkin@linaro.org>
In-Reply-To: <1348070666-9153-1-git-send-email-ryan.harkin@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add support for device tree in the amba-clcd PL111 video driver.

Special case support is added for the A9 CoreTile which uses the "legacy"
address map and has a PL111 device on-board.  The default case is to configure
the device on the motherboard.

Oscillator support is added for the A9 CoreTile's CLCD driver.

Signed-off-by: Ryan Harkin <ryan.harkin@linaro.org>
---
 arch/arm/mach-vexpress/v2m.c |   58 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 37608f2..799e00e 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -3,6 +3,7 @@
  */
 #include <linux/device.h>
 #include <linux/amba/bus.h>
+#include <linux/amba/clcd.h>
 #include <linux/amba/mmci.h>
 #include <linux/io.h>
 #include <linux/init.h>
@@ -37,6 +38,7 @@
 #include <mach/ct-ca9x4.h>
 #include <mach/motherboard.h>
 
+#include <plat/clcd.h>
 #include <plat/sched_clock.h>
 
 #include "core.h"
@@ -541,6 +543,54 @@ MACHINE_END
 
 #if defined(CONFIG_ARCH_VEXPRESS_DT)
 
+static struct v2m_osc v2m_dt_clcd_osc = {
+	.rate_min = 10000000,
+	.rate_max = 165000000,
+	.rate_default = 23750000,
+};
+
+static int v2m_dt_clcd_init(void)
+{
+	struct device_node *node;
+	u32 osc;
+	u32 clcd_site;
+	u32 dvimode;
+	const __be32 *prop;
+	int len, na, ns;
+	phys_addr_t reg_base;
+
+	node = of_find_compatible_node(NULL, NULL, "arm,pl111");
+	if (!node)
+		return -ENODEV;
+
+	na = of_n_addr_cells(node);
+	ns = of_n_size_cells(node);
+
+	prop = of_get_property(node, "reg", &len);
+	if (WARN_ON(!prop || len < (na + ns) * sizeof(*prop)))
+		return -EINVAL;
+	reg_base = of_read_number(prop, na);
+
+	switch (reg_base) {
+	case CT_CA9X4_CLCDC:
+		clcd_site = v2m_get_master_site();
+		dvimode = 2;
+		break;
+	default:
+		clcd_site = SYS_CFG_SITE_MB;
+		dvimode = 0;
+		break;
+	}
+
+	if (of_property_read_u32(node, "arm,vexpress-osc", &osc) != 0)
+		return -EINVAL;
+	v2m_dt_clcd_osc.site = clcd_site;
+	v2m_dt_clcd_osc.osc = osc;
+	v2m_cfg_write(SYS_CFG_MUXFPGA | clcd_site, clcd_site);
+	v2m_cfg_write(SYS_CFG_DVIMODE | clcd_site, dvimode);
+	return 0;
+}
+
 static struct map_desc v2m_rs1_io_desc __initdata = {
 	.virtual	= V2M_PERIPH,
 	.pfn		= __phys_to_pfn(0x1c000000),
@@ -598,6 +648,8 @@ void __init v2m_dt_init_early(void)
 			pr_warning("vexpress: DT HBI (%x) is not matching "
 					"hardware (%x)!\n", dt_hbi, hbi);
 	}
+
+	v2m_dt_clcd_init();
 }
 
 static  struct of_device_id vexpress_irq_match[] __initdata = {
@@ -631,6 +683,12 @@ static void __init v2m_dt_timer_init(void)
 
 	if (arch_timer_sched_clock_init() != 0)
 		versatile_sched_clock_init(v2m_sysreg_base + V2M_SYS_24MHZ, 24000000);
+
+	if (v2m_dt_clcd_osc.site) {
+		/* core tile clcd controller for A9 */
+		clk = v2m_osc_register("10020000.clcd", &v2m_dt_clcd_osc);
+		clk_register_clkdev(clk, NULL, "10020000.clcd");
+	}
 }
 
 static struct sys_timer v2m_dt_timer = {
-- 
1.7.9.5

