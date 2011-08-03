From: Daniel Morsing <daniel.morsing@gmail.com>
Date: Wed, 03 Aug 2011 20:10:51 +0000
Subject: [PATCH] OMAP: DSS2: Don't allow moving managers away from enabled displays
Message-Id: <1312402251-31588-1-git-send-email-daniel.morsing@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, Daniel Morsing <daniel.morsing@gmail.com>, linux-fbdev@vger.kernel.org

If a manager is moved while attached to an enabled display, the DSS
system will be left in an inconsistent state. This will eventually cause
a kernel oops when the enabled display is disabled.

Fix this by not allowing the user to move a manager away from an enabled
display.

Signed-off-by: Daniel Morsing <daniel.morsing@gmail.com>
---
 drivers/video/omap2/dss/manager.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 9aeea50..d3372d1 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -502,6 +502,13 @@ static int omap_dss_unset_device(struct omap_overlay_manager *mgr)
 		return -EINVAL;
 	}
 
+	/*
+	 * Don't allow currently enabled displays to have the overlay manager
+	 * pulled out from underneath them
+	 */
+	if (mgr->device->state != OMAP_DSS_DISPLAY_DISABLED)
+		return -EINVAL;
+
 	mgr->device->manager = NULL;
 	mgr->device = NULL;
 	mgr->device_changed = true;
-- 
1.7.6

