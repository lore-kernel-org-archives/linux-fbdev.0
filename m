From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 30 May 2013 09:34:53 +0000
Subject: [PATCH 32/32] OMAPFB: use EPROBE_DEFER if default display is not present
Message-Id: <1369906493-27538-33-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Currently omapfb returns EPROBE_DEFER if no displays have been probed at
the time omapfb is probed. However, sometimes some of the displays have
been probed at that time, but not all. We can't return EPROBE_DEFER in
that case, because then one missing driver would cause omapfb to defer
always, preventing any display from working.

However, if the user has defined a default display, we can presume that
the driver for that display is eventually loaded. Thus, this patch
changes omapfb to return EPROBE_DEFER in case default display is not
found.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index eacbafa..0c0d078 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2500,7 +2500,7 @@ static int omapfb_probe(struct platform_device *pdev)
 
 	if (def_display = NULL) {
 		dev_err(fbdev->dev, "failed to find default display\n");
-		r = -EINVAL;
+		r = -EPROBE_DEFER;
 		goto cleanup;
 	}
 
-- 
1.8.1.2

