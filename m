From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 04 Nov 2010 11:05:55 +0000
Subject: [PATCH 1/5] fbdev: sh_mobile_hdmi: properly clean up modedb on
Message-Id: <Pine.LNX.4.64.1011041158550.13123@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Even though this is not a problem currently, it is better to clear the freed
pointer and nullify the length of the freed memory.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mobile_hdmi.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index b3241dd..dadb632 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -1130,6 +1130,10 @@ static void sh_hdmi_edid_work_fn(struct work_struct *work)
 		if (!hdmi->info)
 			goto out;
 
+		hdmi->monspec.modedb_len = 0;
+		fb_destroy_modedb(hdmi->monspec.modedb);
+		hdmi->monspec.modedb = NULL;
+
 		acquire_console_sem();
 
 		/* HDMI disconnect */
@@ -1137,7 +1141,6 @@ static void sh_hdmi_edid_work_fn(struct work_struct *work)
 
 		release_console_sem();
 		pm_runtime_put(hdmi->dev);
-		fb_destroy_modedb(hdmi->monspec.modedb);
 	}
 
 out:
-- 
1.7.2.3

