From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 26 Feb 2015 12:48:57 +0000
Subject: [PATCH 03/15] OMAPDSS: fix paddr check for TILER addresses
Message-Id: <1424954949-12801-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The DISPC driver checks that the buffer address is not 0. However, when
using TILER, the address space is TILER specific and 0 is a valid
address.

Fix the check to allow address of 0 for TILER.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reported-by: srinivas pulukuru <srinivas.pulukuru@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index 31b743c70272..a19a1d4b2d19 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -2441,7 +2441,7 @@ static int dispc_ovl_setup_common(enum omap_plane plane,
 	unsigned long pclk = dispc_plane_pclk_rate(plane);
 	unsigned long lclk = dispc_plane_lclk_rate(plane);
 
-	if (paddr = 0)
+	if (paddr = 0 && rotation_type != OMAP_DSS_ROT_TILER)
 		return -EINVAL;
 
 	out_width = out_width = 0 ? width : out_width;
-- 
2.3.0

