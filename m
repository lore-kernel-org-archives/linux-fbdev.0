From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Fri, 03 Jun 2016 11:03:22 +0000
Subject: [PATCH v3 20/27] drm/omap: Remove reference to pdata->default_device
Message-Id: <20160603110329.9953-21-peter.ujfalusi@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160603110329.9953-1-peter.ujfalusi@ti.com>
In-Reply-To: <20160603110329.9953-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, tony@atomide.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com, jsarha@ti.com, dri-devel@lists.freedesktop.org

The default_device is no longer used, it is a leftower from legacy. The
else if (pdata->default_device) is always going to be false.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/gpu/drm/omapdrm/dss/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/core.c b/drivers/gpu/drm/omapdrm/dss/core.c
index 7e4e5bebabbe..9cf22b30023f 100644
--- a/drivers/gpu/drm/omapdrm/dss/core.c
+++ b/drivers/gpu/drm/omapdrm/dss/core.c
@@ -196,8 +196,6 @@ static int __init omap_dss_probe(struct platform_device *pdev)
 		core.default_display_name = def_disp_name;
 	else if (pdata->default_display_name)
 		core.default_display_name = pdata->default_display_name;
-	else if (pdata->default_device)
-		core.default_display_name = pdata->default_device->name;
 
 	return 0;
 
-- 
2.8.3

