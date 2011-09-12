From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 12 Sep 2011 09:13:24 +0000
Subject: [PATCHv2 01/15] OMAP: DSS2: add read_edid() to omap_dss_driver struct
Message-Id: <1315818818-18733-2-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

read_edid() can be used to get the EDID information from the display.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omapdss.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 8120433..cf7ecfb 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -615,6 +615,8 @@ struct omap_dss_driver {
 
 	int (*set_wss)(struct omap_dss_device *dssdev, u32 wss);
 	u32 (*get_wss)(struct omap_dss_device *dssdev);
+
+	int (*read_edid)(struct omap_dss_device *dssdev, u8 *buf, int len);
 };
 
 int omap_dss_register_driver(struct omap_dss_driver *);
-- 
1.7.4.1

