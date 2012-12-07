From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 07 Dec 2012 11:55:05 +0000
Subject: [PATCH 1/5] OMAPFB: remove exported udpate window
Message-Id: <1354881309-17625-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

omapfb contains an exported omapfb_update_window function, which, at
some point in history, was used by a closed source SGX driver. This was
a hack even then, and should not be needed anymore. So remove it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-ioctl.c |   27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/omap2/omapfb/omapfb-ioctl.c
index 8b1e9e3..94de47e 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -279,7 +279,7 @@ static int omapfb_query_mem(struct fb_info *fbi, struct omapfb_mem_info *mi)
 	return 0;
 }
 
-static int omapfb_update_window_nolock(struct fb_info *fbi,
+static int omapfb_update_window(struct fb_info *fbi,
 		u32 x, u32 y, u32 w, u32 h)
 {
 	struct omap_dss_device *display = fb2display(fbi);
@@ -299,27 +299,6 @@ static int omapfb_update_window_nolock(struct fb_info *fbi,
 	return display->driver->update(display, x, y, w, h);
 }
 
-/* This function is exported for SGX driver use */
-int omapfb_update_window(struct fb_info *fbi,
-		u32 x, u32 y, u32 w, u32 h)
-{
-	struct omapfb_info *ofbi = FB2OFB(fbi);
-	struct omapfb2_device *fbdev = ofbi->fbdev;
-	int r;
-
-	if (!lock_fb_info(fbi))
-		return -ENODEV;
-	omapfb_lock(fbdev);
-
-	r = omapfb_update_window_nolock(fbi, x, y, w, h);
-
-	omapfb_unlock(fbdev);
-	unlock_fb_info(fbi);
-
-	return r;
-}
-EXPORT_SYMBOL(omapfb_update_window);
-
 int omapfb_set_update_mode(struct fb_info *fbi,
 				   enum omapfb_update_mode mode)
 {
@@ -646,7 +625,7 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd, unsigned long arg)
 			break;
 		}
 
-		r = omapfb_update_window_nolock(fbi, p.uwnd_o.x, p.uwnd_o.y,
+		r = omapfb_update_window(fbi, p.uwnd_o.x, p.uwnd_o.y,
 				p.uwnd_o.width, p.uwnd_o.height);
 		break;
 
@@ -663,7 +642,7 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd, unsigned long arg)
 			break;
 		}
 
-		r = omapfb_update_window_nolock(fbi, p.uwnd.x, p.uwnd.y,
+		r = omapfb_update_window(fbi, p.uwnd.x, p.uwnd.y,
 				p.uwnd.width, p.uwnd.height);
 		break;
 
-- 
1.7.10.4

