From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 30 Oct 2012 16:09:59 +0000
Subject: [PATCH 02/12] OMAPFB: improve mode selection from EDID
Message-Id: <1351613409-21186-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: rob@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

The current omapfb code goes over all the modes found from the monitors
EDID data, and searches for a mode that is compatible with the DSS
hardware and has the highest x-res.

While this works ok as such, it proves problematic when using DSI PLL
for pixel clock. Calculating DSI PLL dividers is not the fastest of the
operations, and while doing it for one mode is usually ok, doing it for
20 modes is noticable.

Also, the first mode given in the EDID data should be the native mode of
the monitor, and thus also the best mode, so if that can be used, no
need to look further.

This patch changes the code to use the first mode that is compatible
with the DSS hardware.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 0358b14..6e5334c 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2258,7 +2258,7 @@ static int omapfb_find_best_mode(struct omap_dss_device *display,
 {
 	struct fb_monspecs *specs;
 	u8 *edid;
-	int r, i, best_xres, best_idx, len;
+	int r, i, best_idx, len;
 
 	if (!display->driver->read_edid)
 		return -ENODEV;
@@ -2274,7 +2274,6 @@ static int omapfb_find_best_mode(struct omap_dss_device *display,
 
 	fb_edid_to_monspecs(edid, specs);
 
-	best_xres = 0;
 	best_idx = -1;
 
 	for (i = 0; i < specs->modedb_len; ++i) {
@@ -2290,16 +2289,20 @@ static int omapfb_find_best_mode(struct omap_dss_device *display,
 		if (m->xres = 2880 || m->xres = 1440)
 			continue;
 
+		if (m->vmode & FB_VMODE_INTERLACED ||
+				m->vmode & FB_VMODE_DOUBLE)
+			continue;
+
 		fb_videomode_to_omap_timings(m, display, &t);
 
 		r = display->driver->check_timings(display, &t);
-		if (r = 0 && best_xres < m->xres) {
-			best_xres = m->xres;
+		if (r = 0) {
 			best_idx = i;
+			break;
 		}
 	}
 
-	if (best_xres = 0) {
+	if (best_idx = -1) {
 		r = -ENOENT;
 		goto err2;
 	}
-- 
1.7.10.4

