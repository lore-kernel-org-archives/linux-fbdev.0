From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 30 Oct 2012 16:09:58 +0000
Subject: [PATCH 01/12] OMAPFB: remove use of extended edid block
Message-Id: <1351613409-21186-2-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: rob@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

It seems that using the second EDID block causes more problems than is
of any help. The first mode in the extended block will get
FB_MODE_IS_FIRST set, which will override the first mode from the first
EDID block, thus making the default videomode selection not to work
properly.

This patch removes the use of the extended edid block for now.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index bc225e4..0358b14 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2274,9 +2274,6 @@ static int omapfb_find_best_mode(struct omap_dss_device *display,
 
 	fb_edid_to_monspecs(edid, specs);
 
-	if (edid[126] > 0)
-		fb_edid_add_monspecs(edid + 0x80, specs);
-
 	best_xres = 0;
 	best_idx = -1;
 
-- 
1.7.10.4

