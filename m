From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 22 Nov 2011 09:21:00 +0000
Subject: [PATCH 01/65] OMAPDSS: DISPC: add missing prototype
Message-Id: <1321953724-6350-2-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

dispc_mgr_is_enabled() was missing a prototype in dss.h

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 6308fc5..3310f10 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -414,6 +414,7 @@ void dispc_mgr_set_cpr_coef(enum omap_channel channel,
 		struct omap_dss_cpr_coefs *coefs);
 bool dispc_mgr_go_busy(enum omap_channel channel);
 void dispc_mgr_go(enum omap_channel channel);
+bool dispc_mgr_is_enabled(enum omap_channel channel);
 void dispc_mgr_enable(enum omap_channel channel, bool enable);
 bool dispc_mgr_is_channel_enabled(enum omap_channel channel);
 void dispc_mgr_set_io_pad_mode(enum dss_io_pad_mode mode);
-- 
1.7.4.1

