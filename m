From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 31 Mar 2011 10:11:00 +0000
Subject: [PATCH 3/9] OMAP: DSS2: make 50ms bug-fix sleep optional
Message-Id: <1301566266-11187-4-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1301566266-11187-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1301566266-11187-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

For some unknown reason we may get SYNC_LOST errors from the display
subsystem at initialization time if we don't sleep before resetting the
DSS. See the source (dss.c) for more comments.

However, 50ms is quite long time to sleep, and with some configurations
the SYNC_LOST may never happen, so this patch creates a Kconfig option
to disable the sleep.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/Kconfig |   11 +++++++++++
 drivers/video/omap2/dss/dss.c   |    5 +++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
index bfc5da0..458cfe1 100644
--- a/drivers/video/omap2/dss/Kconfig
+++ b/drivers/video/omap2/dss/Kconfig
@@ -125,4 +125,15 @@ config OMAP2_DSS_MIN_FCK_PER_PCK
 	  Max FCK is 173MHz, so this doesn't work if your PCK
 	  is very high.
 
+config OMAP2_DSS_SLEEP_BEFORE_RESET
+	bool "Sleep 50ms before DSS reset"
+	default y
+	help
+	  For some unknown reason we may get SYNC_LOST errors from the display
+	  subsystem at initialization time if we don't sleep before resetting
+	  the DSS. See the source (dss.c) for more comments.
+
+	  However, 50ms is quite long time to sleep, and with some
+	  configurations the SYNC_LOST may never happen, so the sleep can
+	  be disabled here.
 endif
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 3f1fee6..688947f 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -659,13 +659,18 @@ static int dss_init(void)
 	 * the kernel resets it */
 	omap_writel(omap_readl(0x48050440) & ~0x3, 0x48050440);
 
+#ifdef CONFIG_OMAP2_DSS_SLEEP_BEFORE_RESET
 	/* We need to wait here a bit, otherwise we sometimes start to
 	 * get synclost errors, and after that only power cycle will
 	 * restore DSS functionality. I have no idea why this happens.
 	 * And we have to wait _before_ resetting the DSS, but after
 	 * enabling clocks.
+	 *
+	 * This bug was at least present on OMAP3430. It's unknown
+	 * if it happens on OMAP2 or OMAP3630.
 	 */
 	msleep(50);
+#endif
 
 	_omap_dss_reset();
 
-- 
1.7.1

