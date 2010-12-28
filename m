From: Inki Dae <inki.dae@samsung.com>
Date: Tue, 28 Dec 2010 11:26:23 +0000
Subject: [PATCH 3/5] S5PC110: add machine specific MIPI-DSI setup code.
Message-Id: <1293535583-24789-1-git-send-email-inki.dae@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Inki Dae <inki.dae@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig      |    6 +++
 arch/arm/mach-s5pv210/Makefile     |    1 +
 arch/arm/mach-s5pv210/setup-mipi.c |   76 ++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pv210/setup-mipi.c

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 862f239..76da541 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -53,6 +53,11 @@ config S5PV210_SETUP_SDHCI_GPIO
 	help
 	  Common setup code for SDHCI gpio.
 
+config S5P_SETUP_MIPI_DSI
+	bool
+	help
+	  Common setup code for MIPI-DSI
+
 menu "S5PC110 Machines"
 
 config MACH_AQUILA
@@ -92,6 +97,7 @@ config MACH_GONI
 	select S5PV210_SETUP_I2C2
 	select S5PV210_SETUP_KEYPAD
 	select S5PV210_SETUP_SDHCI
+	select S5P_SETUP_MIPI_DSI
 	help
 	  Machine support for Samsung GONI board
 	  S5PC110(MCP) is one of package option of S5PV210
diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index ff1a0db..638747c 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -37,3 +37,4 @@ obj-$(CONFIG_S5PV210_SETUP_IDE)		+= setup-ide.o
 obj-$(CONFIG_S5PV210_SETUP_KEYPAD)	+= setup-keypad.o
 obj-$(CONFIG_S5PV210_SETUP_SDHCI)       += setup-sdhci.o
 obj-$(CONFIG_S5PV210_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
+obj-$(CONFIG_S5P_SETUP_MIPI_DSI)	+= setup-mipi.o
\ No newline at end of file
diff --git a/arch/arm/mach-s5pv210/setup-mipi.c b/arch/arm/mach-s5pv210/setup-mipi.c
new file mode 100644
index 0000000..2cc8cd1
--- /dev/null
+++ b/arch/arm/mach-s5pv210/setup-mipi.c
@@ -0,0 +1,76 @@
+/* linux/arch/arm/plat-s5p/setup-mipi.c
+ *
+ * Samsung MIPI-DSI DPHY driver.
+ *
+ * Author: InKi Dae <inki.dae@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ */
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+
+#include <mach/map.h>
+#include <mach/regs-clock.h>
+
+#include <plat/mipi-dsi.h>
+#include <plat/regs-dsim.h>
+
+static int s5p_mipi_enable_d_phy(struct dsim_device *dsim, unsigned int enable)
+{
+	unsigned int reg;
+
+	reg = readl(S5P_MIPI_CONTROL) & ~(1 << 0);
+	reg |= (enable << 0);
+	writel(reg, S5P_MIPI_CONTROL);
+
+	return 0;
+}
+
+static int s5p_mipi_enable_dsi_master(struct dsim_device *dsim,
+	unsigned int enable)
+{
+	unsigned int reg;
+
+	reg = readl(S5P_MIPI_CONTROL) & ~(1 << 2);
+	reg |= (enable << 2);
+	writel(reg, S5P_MIPI_CONTROL);
+
+	return 0;
+}
+
+int s5p_mipi_part_reset(struct dsim_device *dsim)
+{
+	writel(S5P_MIPI_M_RESETN, S5P_MIPI_PHY_CON0);
+
+	return 0;
+}
+
+int s5p_mipi_init_d_phy(struct dsim_device *dsim)
+{
+	/**
+	 * DPHY and Master block must be enabled at the system initialization
+	 * step before data access from/to DPHY begins.
+	 */
+	s5p_mipi_enable_d_phy(dsim, 1);
+
+	s5p_mipi_enable_dsi_master(dsim, 1);
+
+	return 0;
+}
-- 
1.7.0.4

