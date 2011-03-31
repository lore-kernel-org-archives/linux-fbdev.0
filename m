From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 31 Mar 2011 10:11:02 +0000
Subject: [PATCH 5/9] OMAP: DSS2: VENC: Remove sleeps at venc enable/disable
Message-Id: <1301566266-11187-6-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1301566266-11187-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1301566266-11187-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

VENC code had 50ms sleep after enabling the output and 100ms sleep after
disabling the output. I don't see any reason for these sleeps.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/venc.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 8c7af90..fe18800 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -487,9 +487,6 @@ static int venc_panel_enable(struct omap_dss_device *dssdev)
 
 	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
 
-	/* wait couple of vsyncs until enabling the LCD */
-	msleep(50);
-
 err1:
 	mutex_unlock(&venc.venc_lock);
 
@@ -513,9 +510,6 @@ static void venc_panel_disable(struct omap_dss_device *dssdev)
 
 	venc_power_off(dssdev);
 
-	/* wait at least 5 vsyncs after disabling the LCD */
-	msleep(100);
-
 	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 end:
 	mutex_unlock(&venc.venc_lock);
-- 
1.7.1

