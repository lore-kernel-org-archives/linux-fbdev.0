From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 19 Sep 2012 08:30:32 +0000
Subject: [PATCH 2/8] OMAPDSS: Add dss_get_default_display_name()
Message-Id: <1348043438-2624-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348043438-2624-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1348043438-2624-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add function dss_get_default_display_name() which returns the name of
the default display, given from the board file or via module parameters.
The default display name can be used by output drivers to decide which
display is the wanted one.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 20c8bc8..315f557 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -57,6 +57,11 @@ bool dss_debug;
 module_param_named(debug, dss_debug, bool, 0644);
 #endif
 
+const char *dss_get_default_display_name(void)
+{
+	return core.default_display_name;
+}
+
 /* REGULATORS */
 
 struct regulator *dss_get_vdds_dsi(void)
-- 
1.7.9.5

