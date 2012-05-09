From: Archit Taneja <archit@ti.com>
Date: Wed, 09 May 2012 10:22:54 +0000
Subject: [PATCH v4 7/9] OMAPDSS: APPLY: Remove an unnecessary omap_dss_device pointer
Message-Id: <1336558256-26140-8-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
 <1336558256-26140-1-git-send-email-archit@ti.com>
In-Reply-To: <1336558256-26140-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The omap_dss_device pointer declared in dss_ovl_setup_fifo() isn't used. Remove
the pointer variable declaration and it's assignment.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 0ffe4e1..15c070c 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -960,14 +960,11 @@ static void dss_ovl_setup_fifo(struct omap_overlay *ovl,
 		bool use_fifo_merge)
 {
 	struct ovl_priv_data *op = get_ovl_priv(ovl);
-	struct omap_dss_device *dssdev;
 	u32 fifo_low, fifo_high;
 
 	if (!op->enabled && !op->enabling)
 		return;
 
-	dssdev = ovl->manager->device;
-
 	dispc_ovl_compute_fifo_thresholds(ovl->id, &fifo_low, &fifo_high,
 			use_fifo_merge);
 
-- 
1.7.5.4

