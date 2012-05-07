From: Archit Taneja <archit@ti.com>
Date: Mon, 07 May 2012 11:33:31 +0000
Subject: [PATCH 1/6] OMAPDSS: DPI/HDMI: Apply manager timings even if panel is disabled
Message-Id: <1336389696-21636-2-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1336389696-21636-1-git-send-email-archit@ti.com>
In-Reply-To: <1336389696-21636-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The HDMI and DPI interfaces use their 'set_timing' functions to take in a new
set of timings. If the panel is disabled, they do not disable and re-enable
the interface. Currently, the manager timings are applied in hdmi_power_on()
and dpi_set_mode() respectively, these are not called by set_timings if the
panel is disabled.

When checking overlay and manager data, the DSS driver uses the last applied
manager timings, and not the timings stored in omap_dss_device struct. Hence,
there is a need to apply the new manager timings even if the panel is disabled.

Apply the manager timings if the panel is disabled. Eventually, there should be
one common place where the timings are applied independent of the state of the
panel.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dpi.c  |    2 ++
 drivers/video/omap2/dss/hdmi.c |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 8127f46..1650050 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -298,6 +298,8 @@ void dpi_set_timings(struct omap_dss_device *dssdev,
 
 		dispc_runtime_put();
 		dss_runtime_put();
+	} else {
+		dss_mgr_set_timings(dssdev->manager, timings);
 	}
 }
 EXPORT_SYMBOL(dpi_set_timings);
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 8d4ff8c..32ad712 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -435,6 +435,8 @@ void omapdss_hdmi_display_set_timing(struct omap_dss_device *dssdev)
 		r = hdmi_power_on(dssdev);
 		if (r)
 			DSSERR("failed to power on device\n");
+	} else {
+		dss_mgr_set_timings(dssdev->manager, &dssdev->panel.timings);
 	}
 }
 
-- 
1.7.5.4

