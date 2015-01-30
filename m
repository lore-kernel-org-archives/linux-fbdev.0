From: Peter Meerwald <pmeerw@pmeerw.net>
Date: Fri, 30 Jan 2015 07:59:46 +0000
Subject: [PATCH] omapfb: Return error code when applying overlay settings fails
Message-Id: <1422604786-6804-1-git-send-email-pmeerw@pmeerw.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>

the check of the return code is missing, user space does not get notified
about the error condition:

omapdss OVERLAY error: overlay 2 horizontally not inside the display area (403 + 800 >= 800)
omapdss APPLY error: failed to apply settings: illegal configuration.

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c b/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
index 146b6f5..9ddfdd6 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
@@ -137,8 +137,11 @@ static int omapfb_setup_plane(struct fb_info *fbi, struct omapfb_plane_info *pi)
 			goto undo;
 	}
 
-	if (ovl->manager)
-		ovl->manager->apply(ovl->manager);
+	if (ovl->manager) {
+		r = ovl->manager->apply(ovl->manager);
+		if (r)
+			goto undo;
+	}
 
 	if (pi->enabled) {
 		r = ovl->enable(ovl);
-- 
1.7.10.4

