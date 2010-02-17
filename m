From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Wed, 17 Feb 2010 11:57:17 +0000
Subject: [PATCH 2/4] OMAP: DSS2: fix driver probe error handling
Message-Id: <1266407839-14713-2-git-send-email-tomi.valkeinen@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1266407839-14713-1-git-send-email-tomi.valkeinen@nokia.com>
In-Reply-To: <1266407839-14713-1-git-send-email-tomi.valkeinen@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

If driver's probe failed, the uninit was not called.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/dss/core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 967cbda..39b1a20 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -778,6 +778,7 @@ static int dss_driver_probe(struct device *dev)
 
 	if (r) {
 		DSSERR("driver probe failed: %d\n", r);
+		dss_uninit_device(core.pdev, dssdev);
 		return r;
 	}
 
-- 
1.6.5

