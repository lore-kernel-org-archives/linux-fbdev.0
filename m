From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 22 Aug 2011 08:27:48 +0000
Subject: [PATCH 07/10] OMAP: DSS2: DISPC: remove non-existing func prototypes
Message-Id: <1314001671-18123-8-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1314001671-18123-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1314001671-18123-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The functions do not exist, so remove the prototypes.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index adeff04..c9b50af 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -395,10 +395,6 @@ void dispc_enable_cpr(enum omap_channel channel, bool enable);
 void dispc_set_cpr_coef(enum omap_channel channel,
 		struct omap_dss_cpr_coefs *coefs);
 
-void dispc_set_plane_ba0(enum omap_plane plane, u32 paddr);
-void dispc_set_plane_ba1(enum omap_plane plane, u32 paddr);
-void dispc_set_plane_pos(enum omap_plane plane, u16 x, u16 y);
-void dispc_set_plane_size(enum omap_plane plane, u16 width, u16 height);
 void dispc_set_channel_out(enum omap_plane plane,
 		enum omap_channel channel_out);
 
-- 
1.7.4.1

