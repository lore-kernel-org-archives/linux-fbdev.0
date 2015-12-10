From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 10 Dec 2015 14:25:30 +0000
Subject: [PATCH RFC 4/9] omapfb/dss: change CONFIG_OMAP* to CONFIG_FB_OMAP*
Message-Id: <1449757535-5674-5-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449757535-5674-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1449757535-5674-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

We need to change the config symbols of omapfb's private copy of
omapdss so that we won't have config symbol conflicts.

This patch changes the symbols from omapdss using simple replacement of
CONFIG_OMAP* to CONFIG_FB_OMAP*.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/omapfb/dss/Kconfig       | 46 ++++++++++------------
 drivers/video/fbdev/omap2/omapfb/dss/Makefile      | 22 +++++------
 drivers/video/fbdev/omap2/omapfb/dss/core.c        | 34 ++++++++--------
 .../video/fbdev/omap2/omapfb/dss/dispc-compat.c    |  8 ++--
 drivers/video/fbdev/omap2/omapfb/dss/dispc.c       |  4 +-
 .../video/fbdev/omap2/omapfb/dss/display-sysfs.c   |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c         | 10 ++---
 drivers/video/fbdev/omap2/omapfb/dss/dss.c         |  6 +--
 drivers/video/fbdev/omap2/omapfb/dss/dss.h         | 10 ++---
 drivers/video/fbdev/omap2/omapfb/dss/venc.c        |  2 +-
 10 files changed, 69 insertions(+), 75 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/Kconfig b/drivers/video/fbdev/omap2/omapfb/dss/Kconfig
index d1fa730c7d54..27d220212870 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/Kconfig
+++ b/drivers/video/fbdev/omap2/omapfb/dss/Kconfig
@@ -1,17 +1,13 @@
-config OMAP2_DSS_INIT
+config FB_OMAP2_DSS_INIT
 	bool
 
-menuconfig OMAP2_DSS
-        tristate "OMAP2+ Display Subsystem support"
+config FB_OMAP2_DSS
+        tristate
 	select VIDEOMODE_HELPERS
-	select OMAP2_DSS_INIT
+	select FB_OMAP2_DSS_INIT
 	select HDMI
-        help
-	  OMAP2+ Display Subsystem support.
 
-if OMAP2_DSS
-
-config OMAP2_DSS_DEBUG
+config FB_OMAP2_DSS_DEBUG
 	bool "Debug support"
 	default n
 	help
@@ -19,7 +15,7 @@ config OMAP2_DSS_DEBUG
 	  can also be enabled by setting CONFIG_DYNAMIC_DEBUG and then setting
 	  appropriate flags in <debugfs>/dynamic_debug/control.
 
-config OMAP2_DSS_DEBUGFS
+config FB_OMAP2_DSS_DEBUGFS
 	bool "Debugfs filesystem support"
 	depends on DEBUG_FS
 	default n
@@ -28,9 +24,9 @@ config OMAP2_DSS_DEBUGFS
 	  querying about clock configuration and register configuration of dss,
 	  dispc, dsi, hdmi and rfbi.
 
-config OMAP2_DSS_COLLECT_IRQ_STATS
+config FB_OMAP2_DSS_COLLECT_IRQ_STATS
 	bool "Collect DSS IRQ statistics"
-	depends on OMAP2_DSS_DEBUGFS
+	depends on FB_OMAP2_DSS_DEBUGFS
 	default n
 	help
 	  Collect DSS IRQ statistics, printable via debugfs.
@@ -39,13 +35,13 @@ config OMAP2_DSS_COLLECT_IRQ_STATS
 	  <debugfs>/omapdss/dispc_irq for DISPC interrupts, and
 	  <debugfs>/omapdss/dsi_irq for DSI interrupts.
 
-config OMAP2_DSS_DPI
+config FB_OMAP2_DSS_DPI
 	bool "DPI support"
 	default y
 	help
 	  DPI Interface. This is the Parallel Display Interface.
 
-config OMAP2_DSS_RFBI
+config FB_OMAP2_DSS_RFBI
 	bool "RFBI support"
 	depends on BROKEN
         default n
@@ -58,32 +54,32 @@ config OMAP2_DSS_RFBI
 
 	  See http://www.mipi.org/ for DBI specifications.
 
-config OMAP2_DSS_VENC
+config FB_OMAP2_DSS_VENC
 	bool "VENC support"
         default y
 	help
 	  OMAP Video Encoder support for S-Video and composite TV-out.
 
-config OMAP2_DSS_HDMI_COMMON
+config FB_OMAP2_DSS_HDMI_COMMON
 	bool
 
-config OMAP4_DSS_HDMI
+config FB_OMAP4_DSS_HDMI
 	bool "HDMI support for OMAP4"
         default y
-	select OMAP2_DSS_HDMI_COMMON
+	select FB_OMAP2_DSS_HDMI_COMMON
 	help
 	  HDMI support for OMAP4 based SoCs.
 
-config OMAP5_DSS_HDMI
+config FB_OMAP5_DSS_HDMI
 	bool "HDMI support for OMAP5"
 	default n
-	select OMAP2_DSS_HDMI_COMMON
+	select FB_OMAP2_DSS_HDMI_COMMON
 	help
 	  HDMI Interface for OMAP5 and similar cores. This adds the High
 	  Definition Multimedia Interface. See http://www.hdmi.org/ for HDMI
 	  specification.
 
-config OMAP2_DSS_SDI
+config FB_OMAP2_DSS_SDI
 	bool "SDI support"
         default n
 	help
@@ -92,7 +88,7 @@ config OMAP2_DSS_SDI
 	  SDI is a high speed one-way display serial bus between the host
 	  processor and a display.
 
-config OMAP2_DSS_DSI
+config FB_OMAP2_DSS_DSI
 	bool "DSI support"
         default n
 	help
@@ -103,7 +99,7 @@ config OMAP2_DSS_DSI
 
 	  See http://www.mipi.org/ for DSI specifications.
 
-config OMAP2_DSS_MIN_FCK_PER_PCK
+config FB_OMAP2_DSS_MIN_FCK_PER_PCK
 	int "Minimum FCK/PCK ratio (for scaling)"
 	range 0 32
 	default 0
@@ -121,7 +117,7 @@ config OMAP2_DSS_MIN_FCK_PER_PCK
 	  Max FCK is 173MHz, so this doesn't work if your PCK
 	  is very high.
 
-config OMAP2_DSS_SLEEP_AFTER_VENC_RESET
+config FB_OMAP2_DSS_SLEEP_AFTER_VENC_RESET
 	bool "Sleep 20ms after VENC reset"
 	default y
 	help
@@ -131,5 +127,3 @@ config OMAP2_DSS_SLEEP_AFTER_VENC_RESET
 
 	  This option enables the sleep, and is enabled by default. You can
 	  disable the sleep if it doesn't cause problems on your platform.
-
-endif
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/Makefile b/drivers/video/fbdev/omap2/omapfb/dss/Makefile
index b5136d3d4b77..02308e24f3ef 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/Makefile
+++ b/drivers/video/fbdev/omap2/omapfb/dss/Makefile
@@ -1,18 +1,18 @@
-obj-$(CONFIG_OMAP2_DSS_INIT) += omapdss-boot-init.o
-obj-$(CONFIG_OMAP2_DSS) += omapdss.o
+obj-$(CONFIG_FB_OMAP2_DSS_INIT) += omapdss-boot-init.o
+obj-$(CONFIG_FB_OMAP2_DSS) += omapdss.o
 # Core DSS files
 omapdss-y := core.o dss.o dss_features.o dispc.o dispc_coefs.o display.o \
 	output.o dss-of.o pll.o video-pll.o
 # DSS compat layer files
 omapdss-y += manager.o manager-sysfs.o overlay.o overlay-sysfs.o apply.o \
 	dispc-compat.o display-sysfs.o
-omapdss-$(CONFIG_OMAP2_DSS_DPI) += dpi.o
-omapdss-$(CONFIG_OMAP2_DSS_RFBI) += rfbi.o
-omapdss-$(CONFIG_OMAP2_DSS_VENC) += venc.o
-omapdss-$(CONFIG_OMAP2_DSS_SDI) += sdi.o
-omapdss-$(CONFIG_OMAP2_DSS_DSI) += dsi.o
-omapdss-$(CONFIG_OMAP2_DSS_HDMI_COMMON) += hdmi_common.o hdmi_wp.o hdmi_pll.o \
+omapdss-$(CONFIG_FB_OMAP2_DSS_DPI) += dpi.o
+omapdss-$(CONFIG_FB_OMAP2_DSS_RFBI) += rfbi.o
+omapdss-$(CONFIG_FB_OMAP2_DSS_VENC) += venc.o
+omapdss-$(CONFIG_FB_OMAP2_DSS_SDI) += sdi.o
+omapdss-$(CONFIG_FB_OMAP2_DSS_DSI) += dsi.o
+omapdss-$(CONFIG_FB_OMAP2_DSS_HDMI_COMMON) += hdmi_common.o hdmi_wp.o hdmi_pll.o \
 	hdmi_phy.o
-omapdss-$(CONFIG_OMAP4_DSS_HDMI) += hdmi4.o hdmi4_core.o
-omapdss-$(CONFIG_OMAP5_DSS_HDMI) += hdmi5.o hdmi5_core.o
-ccflags-$(CONFIG_OMAP2_DSS_DEBUG) += -DDEBUG
+omapdss-$(CONFIG_FB_OMAP4_DSS_HDMI) += hdmi4.o hdmi4_core.o
+omapdss-$(CONFIG_FB_OMAP5_DSS_HDMI) += hdmi5.o hdmi5_core.o
+ccflags-$(CONFIG_FB_OMAP2_DSS_DEBUG) += -DDEBUG
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/core.c b/drivers/video/fbdev/omap2/omapfb/dss/core.c
index 54eeb507f9b3..5a87179b7312 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/core.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/core.c
@@ -98,7 +98,7 @@ int dss_set_min_bus_tput(struct device *dev, unsigned long tput)
 		return 0;
 }
 
-#if defined(CONFIG_OMAP2_DSS_DEBUGFS)
+#if defined(CONFIG_FB_OMAP2_DSS_DEBUGFS)
 static int dss_debug_show(struct seq_file *s, void *unused)
 {
 	void (*func)(struct seq_file *) = s->private;
@@ -150,7 +150,7 @@ int dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *))
 
 	return PTR_ERR_OR_ZERO(d);
 }
-#else /* CONFIG_OMAP2_DSS_DEBUGFS */
+#else /* CONFIG_FB_OMAP2_DSS_DEBUGFS */
 static inline int dss_initialize_debugfs(void)
 {
 	return 0;
@@ -162,7 +162,7 @@ int dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *))
 {
 	return 0;
 }
-#endif /* CONFIG_OMAP2_DSS_DEBUGFS */
+#endif /* CONFIG_FB_OMAP2_DSS_DEBUGFS */
 
 /* PLATFORM DEVICE */
 static int omap_dss_pm_notif(struct notifier_block *b, unsigned long v, void *d)
@@ -247,49 +247,49 @@ static struct platform_driver omap_dss_driver = {
 static int (*dss_output_drv_reg_funcs[])(void) __initdata = {
 	dss_init_platform_driver,
 	dispc_init_platform_driver,
-#ifdef CONFIG_OMAP2_DSS_DSI
+#ifdef CONFIG_FB_OMAP2_DSS_DSI
 	dsi_init_platform_driver,
 #endif
-#ifdef CONFIG_OMAP2_DSS_DPI
+#ifdef CONFIG_FB_OMAP2_DSS_DPI
 	dpi_init_platform_driver,
 #endif
-#ifdef CONFIG_OMAP2_DSS_SDI
+#ifdef CONFIG_FB_OMAP2_DSS_SDI
 	sdi_init_platform_driver,
 #endif
-#ifdef CONFIG_OMAP2_DSS_RFBI
+#ifdef CONFIG_FB_OMAP2_DSS_RFBI
 	rfbi_init_platform_driver,
 #endif
-#ifdef CONFIG_OMAP2_DSS_VENC
+#ifdef CONFIG_FB_OMAP2_DSS_VENC
 	venc_init_platform_driver,
 #endif
-#ifdef CONFIG_OMAP4_DSS_HDMI
+#ifdef CONFIG_FB_OMAP4_DSS_HDMI
 	hdmi4_init_platform_driver,
 #endif
-#ifdef CONFIG_OMAP5_DSS_HDMI
+#ifdef CONFIG_FB_OMAP5_DSS_HDMI
 	hdmi5_init_platform_driver,
 #endif
 };
 
 static void (*dss_output_drv_unreg_funcs[])(void) = {
-#ifdef CONFIG_OMAP5_DSS_HDMI
+#ifdef CONFIG_FB_OMAP5_DSS_HDMI
 	hdmi5_uninit_platform_driver,
 #endif
-#ifdef CONFIG_OMAP4_DSS_HDMI
+#ifdef CONFIG_FB_OMAP4_DSS_HDMI
 	hdmi4_uninit_platform_driver,
 #endif
-#ifdef CONFIG_OMAP2_DSS_VENC
+#ifdef CONFIG_FB_OMAP2_DSS_VENC
 	venc_uninit_platform_driver,
 #endif
-#ifdef CONFIG_OMAP2_DSS_RFBI
+#ifdef CONFIG_FB_OMAP2_DSS_RFBI
 	rfbi_uninit_platform_driver,
 #endif
-#ifdef CONFIG_OMAP2_DSS_SDI
+#ifdef CONFIG_FB_OMAP2_DSS_SDI
 	sdi_uninit_platform_driver,
 #endif
-#ifdef CONFIG_OMAP2_DSS_DPI
+#ifdef CONFIG_FB_OMAP2_DSS_DPI
 	dpi_uninit_platform_driver,
 #endif
-#ifdef CONFIG_OMAP2_DSS_DSI
+#ifdef CONFIG_FB_OMAP2_DSS_DSI
 	dsi_uninit_platform_driver,
 #endif
 	dispc_uninit_platform_driver,
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c b/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c
index 633c461fbc6e..262e3eeb2724 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c
@@ -60,14 +60,14 @@ static struct {
 	u32 error_irqs;
 	struct work_struct error_work;
 
-#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
+#ifdef CONFIG_FB_OMAP2_DSS_COLLECT_IRQ_STATS
 	spinlock_t irq_stats_lock;
 	struct dispc_irq_stats irq_stats;
 #endif
 } dispc_compat;
 
 
-#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
+#ifdef CONFIG_FB_OMAP2_DSS_COLLECT_IRQ_STATS
 static void dispc_dump_irqs(struct seq_file *s)
 {
 	unsigned long flags;
@@ -279,7 +279,7 @@ static irqreturn_t omap_dispc_irq_handler(int irq, void *arg)
 		return IRQ_NONE;
 	}
 
-#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
+#ifdef CONFIG_FB_OMAP2_DSS_COLLECT_IRQ_STATS
 	spin_lock(&dispc_compat.irq_stats_lock);
 	dispc_compat.irq_stats.irq_count++;
 	dss_collect_irq_stats(irqstatus, dispc_compat.irq_stats.irqs);
@@ -416,7 +416,7 @@ int dss_dispc_initialize_irq(void)
 {
 	int r;
 
-#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
+#ifdef CONFIG_FB_OMAP2_DSS_COLLECT_IRQ_STATS
 	spin_lock_init(&dispc_compat.irq_stats_lock);
 	dispc_compat.irq_stats.last_reset = jiffies;
 	dss_debugfs_create_file("dispc_irq", dispc_dump_irqs);
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
index be716c9ffb88..10f060ecd9cb 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
@@ -3626,8 +3626,8 @@ bool dispc_div_calc(unsigned long dispc,
 	unsigned min_fck_per_pck;
 	unsigned long fck;
 
-#ifdef CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK
-	min_fck_per_pck = CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK;
+#ifdef CONFIG_FB_OMAP2_DSS_MIN_FCK_PER_PCK
+	min_fck_per_pck = CONFIG_FB_OMAP2_DSS_MIN_FCK_PER_PCK;
 #else
 	min_fck_per_pck = 0;
 #endif
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c b/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
index 6ad0991f8259..75b5286029ee 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
@@ -120,7 +120,7 @@ static ssize_t display_timings_store(struct omap_dss_device *dssdev,
 		return -ENOENT;
 
 	found = 0;
-#ifdef CONFIG_OMAP2_DSS_VENC
+#ifdef CONFIG_FB_OMAP2_DSS_VENC
 	if (strncmp("pal", buf, 3) = 0) {
 		t = omap_dss_pal_timings;
 		found = 1;
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
index b3606def5b7b..c0b3e82a15b8 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
@@ -369,7 +369,7 @@ struct dsi_data {
 	int debug_read;
 	int debug_write;
 
-#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
+#ifdef CONFIG_FB_OMAP2_DSS_COLLECT_IRQ_STATS
 	spinlock_t irq_stats_lock;
 	struct dsi_irq_stats irq_stats;
 #endif
@@ -698,7 +698,7 @@ static void print_irq_status_cio(u32 status)
 #undef PIS
 }
 
-#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
+#ifdef CONFIG_FB_OMAP2_DSS_COLLECT_IRQ_STATS
 static void dsi_collect_irq_stats(struct platform_device *dsidev, u32 irqstatus,
 		u32 *vcstatus, u32 ciostatus)
 {
@@ -1551,7 +1551,7 @@ void dsi_dump_clocks(struct seq_file *s)
 	}
 }
 
-#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
+#ifdef CONFIG_FB_OMAP2_DSS_COLLECT_IRQ_STATS
 static void dsi_dump_dsidev_irqs(struct platform_device *dsidev,
 		struct seq_file *s)
 {
@@ -5296,7 +5296,7 @@ static int dsi_bind(struct device *dev, struct device *master, void *data)
 	spin_lock_init(&dsi->errors_lock);
 	dsi->errors = 0;
 
-#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
+#ifdef CONFIG_FB_OMAP2_DSS_COLLECT_IRQ_STATS
 	spin_lock_init(&dsi->irq_stats_lock);
 	dsi->irq_stats.last_reset = jiffies;
 #endif
@@ -5468,7 +5468,7 @@ static int dsi_bind(struct device *dev, struct device *master, void *data)
 	else if (dsi->module_id = 1)
 		dss_debugfs_create_file("dsi2_regs", dsi2_dump_regs);
 
-#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
+#ifdef CONFIG_FB_OMAP2_DSS_COLLECT_IRQ_STATS
 	if (dsi->module_id = 0)
 		dss_debugfs_create_file("dsi1_irqs", dsi1_dump_irqs);
 	else if (dsi->module_id = 1)
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss.c b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
index 9200a8668b49..1ff4ec997ebf 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dss.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
@@ -793,12 +793,12 @@ void dss_runtime_put(void)
 }
 
 /* DEBUGFS */
-#if defined(CONFIG_OMAP2_DSS_DEBUGFS)
+#if defined(CONFIG_FB_OMAP2_DSS_DEBUGFS)
 void dss_debug_dump_clocks(struct seq_file *s)
 {
 	dss_dump_clocks(s);
 	dispc_dump_clocks(s);
-#ifdef CONFIG_OMAP2_DSS_DSI
+#ifdef CONFIG_FB_OMAP2_DSS_DSI
 	dsi_dump_clocks(s);
 #endif
 }
@@ -1144,7 +1144,7 @@ static int dss_bind(struct device *dev)
 
 	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
 
-#ifdef CONFIG_OMAP2_DSS_VENC
+#ifdef CONFIG_FB_OMAP2_DSS_VENC
 	REG_FLD_MOD(DSS_CONTROL, 1, 4, 4);	/* venc dac demen */
 	REG_FLD_MOD(DSS_CONTROL, 1, 3, 3);	/* venc clock 4x enable */
 	REG_FLD_MOD(DSS_CONTROL, 0, 2, 2);	/* venc clock mode = normal */
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss.h b/drivers/video/fbdev/omap2/omapfb/dss/dss.h
index 2406bcdb831a..eea33a5cd3ce 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dss.h
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dss.h
@@ -278,7 +278,7 @@ void dss_video_pll_uninit(struct dss_pll *pll);
 struct device_node *dss_of_port_get_parent_device(struct device_node *port);
 u32 dss_of_port_get_port_number(struct device_node *port);
 
-#if defined(CONFIG_OMAP2_DSS_DEBUGFS)
+#if defined(CONFIG_FB_OMAP2_DSS_DEBUGFS)
 void dss_debug_dump_clocks(struct seq_file *s);
 #endif
 
@@ -311,7 +311,7 @@ bool dss_div_calc(unsigned long pck, unsigned long fck_min,
 int sdi_init_platform_driver(void) __init;
 void sdi_uninit_platform_driver(void);
 
-#ifdef CONFIG_OMAP2_DSS_SDI
+#ifdef CONFIG_FB_OMAP2_DSS_SDI
 int sdi_init_port(struct platform_device *pdev, struct device_node *port);
 void sdi_uninit_port(struct device_node *port);
 #else
@@ -327,7 +327,7 @@ static inline void sdi_uninit_port(struct device_node *port)
 
 /* DSI */
 
-#ifdef CONFIG_OMAP2_DSS_DSI
+#ifdef CONFIG_FB_OMAP2_DSS_DSI
 
 struct dentry;
 struct file_operations;
@@ -352,7 +352,7 @@ static inline u8 dsi_get_pixel_size(enum omap_dss_dsi_pixel_format fmt)
 int dpi_init_platform_driver(void) __init;
 void dpi_uninit_platform_driver(void);
 
-#ifdef CONFIG_OMAP2_DSS_DPI
+#ifdef CONFIG_FB_OMAP2_DSS_DPI
 int dpi_init_port(struct platform_device *pdev, struct device_node *port);
 void dpi_uninit_port(struct device_node *port);
 #else
@@ -432,7 +432,7 @@ int rfbi_init_platform_driver(void) __init;
 void rfbi_uninit_platform_driver(void);
 
 
-#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
+#ifdef CONFIG_FB_OMAP2_DSS_COLLECT_IRQ_STATS
 static inline void dss_collect_irq_stats(u32 irqstatus, unsigned *irq_arr)
 {
 	int b;
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/venc.c b/drivers/video/fbdev/omap2/omapfb/dss/venc.c
index 99ca268c1cdd..dd72281cf926 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/venc.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/venc.c
@@ -388,7 +388,7 @@ static void venc_reset(void)
 		}
 	}
 
-#ifdef CONFIG_OMAP2_DSS_SLEEP_AFTER_VENC_RESET
+#ifdef CONFIG_FB_OMAP2_DSS_SLEEP_AFTER_VENC_RESET
 	/* the magical sleep that makes things work */
 	/* XXX more info? What bug this circumvents? */
 	msleep(20);
-- 
2.5.0

