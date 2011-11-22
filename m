From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 22 Nov 2011 09:21:46 +0000
Subject: [PATCH 47/65] OMAPDSS: DISPC: add dispc_mgr_get_framedone_irq
Message-Id: <1321953724-6350-48-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add dispc_mgr_get_framedone_irq() which returns the irq number for
FRAMEDONE for the given channel.

Note that the function returns always 0 for DIGIT channel, even if OMAP4
does have FRAMEDONE_TV interrupt. The reason for this is that this
function is currently used only to track manual updates, and thus
FRAMEDONE_TV is not needed.

If there's need in the future to also get the FRAMEDONE_TV this needs
revisiting. However, as FRAMEDONE_TV doesn't exist on OMAP2/3, the use
of this function for that purpose needs some extra code to handle the
OMAP2/3 case.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   14 ++++++++++++++
 drivers/video/omap2/dss/dss.h   |    1 +
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 27a2cff..8ce0c81 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -452,6 +452,20 @@ u32 dispc_mgr_get_vsync_irq(enum omap_channel channel)
 	}
 }
 
+u32 dispc_mgr_get_framedone_irq(enum omap_channel channel)
+{
+	switch (channel) {
+	case OMAP_DSS_CHANNEL_LCD:
+		return DISPC_IRQ_FRAMEDONE;
+	case OMAP_DSS_CHANNEL_LCD2:
+		return DISPC_IRQ_FRAMEDONE2;
+	case OMAP_DSS_CHANNEL_DIGIT:
+		return 0;
+	default:
+		BUG();
+	}
+}
+
 bool dispc_mgr_go_busy(enum omap_channel channel)
 {
 	int bit;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index b597485..c6caf2f 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -430,6 +430,7 @@ void dispc_ovl_set_channel_out(enum omap_plane plane,
 void dispc_mgr_enable_fifohandcheck(enum omap_channel channel, bool enable);
 void dispc_mgr_set_lcd_size(enum omap_channel channel, u16 width, u16 height);
 u32 dispc_mgr_get_vsync_irq(enum omap_channel channel);
+u32 dispc_mgr_get_framedone_irq(enum omap_channel channel);
 bool dispc_mgr_go_busy(enum omap_channel channel);
 void dispc_mgr_go(enum omap_channel channel);
 bool dispc_mgr_is_enabled(enum omap_channel channel);
-- 
1.7.4.1

