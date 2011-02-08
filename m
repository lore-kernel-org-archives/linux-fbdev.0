From: Axel Lin <axel.lin@gmail.com>
Date: Tue, 08 Feb 2011 14:58:45 +0000
Subject: [PATCH] video: ffb: fix ffb_probe error path
Message-Id: <1297177125.2343.3.camel@phoenix>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Paul Mundt <lethal@linux-sh.org>, linux-fbdev@vger.kernel.org

Current implementation calls of_iounmap for par->fbc twice in error path.
In the case of goto out_unmap_dac, we should call of_iounmap for par->dac.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/video/ffb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/ffb.c b/drivers/video/ffb.c
index 6739b2a..b5d6a46 100644
--- a/drivers/video/ffb.c
+++ b/drivers/video/ffb.c
@@ -1011,7 +1011,7 @@ out_dealloc_cmap:
 	fb_dealloc_cmap(&info->cmap);
 
 out_unmap_dac:
-	of_iounmap(&op->resource[2], par->fbc, sizeof(struct ffb_fbc));
+	of_iounmap(&op->resource[1], par->dac, sizeof(struct ffb_dac));
 
 out_unmap_fbc:
 	of_iounmap(&op->resource[2], par->fbc, sizeof(struct ffb_fbc));
-- 
1.7.1



