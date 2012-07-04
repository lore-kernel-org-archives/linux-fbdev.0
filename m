From: Archit Taneja <archit@ti.com>
Date: Wed, 04 Jul 2012 12:55:49 +0000
Subject: [PATCH 2/2] OMAPDSS: fix warnings if CONFIG_PM_RUNTIME=n
Message-Id: <1341405829-16964-3-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1341405829-16964-1-git-send-email-archit@ti.com>
In-Reply-To: <1341405829-16964-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: FlorianSchandinat@gmx.de
Cc: tomi.valkeinen@ti.com, jaswinder.singh@linaro.org, jw@terrafix.co.uk, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

If runtime PM is not enabled in the kernel config, pm_runtime_get_sync()
will always return 1 and pm_runtime_put_sync() will always return
-ENOSYS. pm_runtime_get_sync() returning 1 presents no problem to the
driver, but -ENOSYS from pm_runtime_put_sync() causes the driver to
print a warning.

One option would be to ignore errors returned by pm_runtime_put_sync()
totally, as they only say that the call was unable to put the hardware
into suspend mode.

However, I chose to ignore the returned -ENOSYS explicitly, and print a
warning for other errors, as I think we should get notified if the HW
failed to go to suspend properly.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/video/omap2/dss/dispc.c |    2 +-
 drivers/video/omap2/dss/dsi.c   |    2 +-
 drivers/video/omap2/dss/dss.c   |    2 +-
 drivers/video/omap2/dss/hdmi.c  |    2 +-
 drivers/video/omap2/dss/rfbi.c  |    2 +-
 drivers/video/omap2/dss/venc.c  |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 4749ac3..397d4ee 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -384,7 +384,7 @@ void dispc_runtime_put(void)
 	DSSDBG("dispc_runtime_put\n");
 
 	r = pm_runtime_put_sync(&dispc.pdev->dev);
-	WARN_ON(r < 0);
+	WARN_ON(r < 0 && r != -ENOSYS);
 }
 
 static inline bool dispc_mgr_is_lcd(enum omap_channel channel)
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index ca8382d..14ce8cc 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1075,7 +1075,7 @@ void dsi_runtime_put(struct platform_device *dsidev)
 	DSSDBG("dsi_runtime_put\n");
 
 	r = pm_runtime_put_sync(&dsi->pdev->dev);
-	WARN_ON(r < 0);
+	WARN_ON(r < 0 && r != -ENOSYS);
 }
 
 /* source clock for DSI PLL. this could also be PCLKFREE */
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 7706323..d2b5719 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -731,7 +731,7 @@ static void dss_runtime_put(void)
 	DSSDBG("dss_runtime_put\n");
 
 	r = pm_runtime_put_sync(&dss.pdev->dev);
-	WARN_ON(r < 0 && r != -EBUSY);
+	WARN_ON(r < 0 && r != -ENOSYS && r != -EBUSY);
 }
 
 /* DEBUGFS */
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 8195c71..26a2430 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -138,7 +138,7 @@ static void hdmi_runtime_put(void)
 	DSSDBG("hdmi_runtime_put\n");
 
 	r = pm_runtime_put_sync(&hdmi.pdev->dev);
-	WARN_ON(r < 0);
+	WARN_ON(r < 0 && r != -ENOSYS);
 }
 
 static int __init hdmi_init_display(struct omap_dss_device *dssdev)
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 3d8c206..7985fa1 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -141,7 +141,7 @@ static void rfbi_runtime_put(void)
 	DSSDBG("rfbi_runtime_put\n");
 
 	r = pm_runtime_put_sync(&rfbi.pdev->dev);
-	WARN_ON(r < 0);
+	WARN_ON(r < 0 && r != -ENOSYS);
 }
 
 void rfbi_bus_lock(void)
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 2b89739..3907c8b 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -402,7 +402,7 @@ static void venc_runtime_put(void)
 	DSSDBG("venc_runtime_put\n");
 
 	r = pm_runtime_put_sync(&venc.pdev->dev);
-	WARN_ON(r < 0);
+	WARN_ON(r < 0 && r != -ENOSYS);
 }
 
 static const struct venc_config *venc_timings_to_config(
-- 
1.7.9.5

