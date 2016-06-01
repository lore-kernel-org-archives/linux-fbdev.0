From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Wed, 01 Jun 2016 08:35:34 +0000
Subject: [PATCH v2 12/27] omapdss: omap-panel-data.h: Remove struct omap_dss_device declaration
Message-Id: <20160601083549.10549-13-peter.ujfalusi@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160601083549.10549-1-peter.ujfalusi@ti.com>
In-Reply-To: <20160601083549.10549-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, tony@atomide.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, jsarha@ti.com, linux-omap@vger.kernel.org, laurent.pinchart@ideasonboard.com

The omap_dss_device is not needed by anything in the header file.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/video/omap-panel-data.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/video/omap-panel-data.h b/include/video/omap-panel-data.h
index a64e9ba12b0d..7b4fadf82cd5 100644
--- a/include/video/omap-panel-data.h
+++ b/include/video/omap-panel-data.h
@@ -30,8 +30,6 @@
 #include <video/omapdss.h>
 #include <video/display_timing.h>
 
-struct omap_dss_device;
-
 /**
  * connector_atv platform data
  * @name: name for this display entity
-- 
2.8.3

