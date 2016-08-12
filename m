From: Russell King <rmk+kernel@arm.linux.org.uk>
Date: Fri, 12 Aug 2016 14:15:05 +0000
Subject: [PATCH RFC 3/5] drm/bridge: dw_hdmi: add HDMI notifier support
Message-Id: <E1bYDEn-0004rl-CH@rmk-PC.armlinux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160812141421.GB1041@n2100.armlinux.org.uk>
In-Reply-To: <20160812141421.GB1041@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Airlie <airlied@linux.ie>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Hans Verkuil <hansverk@cisco.com>
Cc: linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org

Add HDMI notifiers to the HDMI bridge driver.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/bridge/Kconfig   | 1 +
 drivers/gpu/drm/bridge/dw-hdmi.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 8f7423f18da5..6d97d9f2b164 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -20,6 +20,7 @@ config DRM_ANALOGIX_ANX78XX
 config DRM_DW_HDMI
 	tristate
 	select DRM_KMS_HELPER
+	select HDMI_NOTIFIERS
 
 config DRM_DW_HDMI_AHB_AUDIO
 	tristate "Synopsis Designware AHB Audio interface"
diff --git a/drivers/gpu/drm/bridge/dw-hdmi.c b/drivers/gpu/drm/bridge/dw-hdmi.c
index c9d941283d30..cb6e03efbebf 100644
--- a/drivers/gpu/drm/bridge/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/dw-hdmi.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/hdmi.h>
+#include <linux/hdmi-notifier.h>
 #include <linux/mutex.h>
 #include <linux/of_device.h>
 #include <linux/spinlock.h>
@@ -1447,9 +1448,11 @@ static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
 		hdmi->sink_is_hdmi = drm_detect_hdmi_monitor(edid);
 		hdmi->sink_has_audio = drm_detect_monitor_audio(edid);
 		drm_mode_connector_update_edid_property(connector, edid);
+		hdmi_event_new_edid(hdmi->dev, edid, 0);
 		ret = drm_add_edid_modes(connector, edid);
 		/* Store the ELD */
 		drm_edid_to_eld(connector, edid);
+		hdmi_event_new_eld(hdmi->dev, connector->eld);
 		kfree(edid);
 	} else {
 		dev_dbg(hdmi->dev, "failed to get edid\n");
@@ -1601,6 +1604,12 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
 			dw_hdmi_update_phy_mask(hdmi);
 		}
 		mutex_unlock(&hdmi->mutex);
+
+		if ((phy_stat & (HDMI_PHY_RX_SENSE | HDMI_PHY_HPD)) = 0)
+			hdmi_event_disconnect(hdmi->dev);
+		else if ((phy_stat & (HDMI_PHY_RX_SENSE | HDMI_PHY_HPD)) =
+			 (HDMI_IH_PHY_STAT0_RX_SENSE | HDMI_PHY_HPD))
+			hdmi_event_connect(hdmi->dev);
 	}
 
 	if (intr_stat & HDMI_IH_PHY_STAT0_HPD) {
-- 
2.1.0

