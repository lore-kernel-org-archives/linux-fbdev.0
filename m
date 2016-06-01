From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Wed, 01 Jun 2016 08:35:37 +0000
Subject: [PATCH v2 15/27] ARM: OMAP: rx51-video: Do not set TV connector_type
Message-Id: <20160601083549.10549-16-peter.ujfalusi@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160601083549.10549-1-peter.ujfalusi@ti.com>
In-Reply-To: <20160601083549.10549-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, tony@atomide.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, jsarha@ti.com, linux-omap@vger.kernel.org, laurent.pinchart@ideasonboard.com

In legacy mode only composite type is supported by omapdss so there is no
need to specify the connector_type.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/board-rx51-video.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-omap2/board-rx51-video.c
index 9cfebc5c7455..b76f84245ad9 100644
--- a/arch/arm/mach-omap2/board-rx51-video.c
+++ b/arch/arm/mach-omap2/board-rx51-video.c
@@ -32,7 +32,6 @@
 static struct connector_atv_platform_data rx51_tv_pdata = {
 	.name = "tv",
 	.source = "venc.0",
-	.connector_type = OMAP_DSS_VENC_TYPE_COMPOSITE,
 	.invert_polarity = false,
 };
 
-- 
2.8.3

