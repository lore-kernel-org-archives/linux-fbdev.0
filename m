From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 17:41:32 +0000
Subject: [PATCH 1/3] video: omap: Delete an error message for a failed memory allocation in omapfb_do_probe()
Message-Id: <e6b19a4a-566b-d1a0-1847-ed1167e118b6@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1e17c727-884d-5745-2726-48dd3a53c32f@users.sourceforge.net>
In-Reply-To: <1e17c727-884d-5745-2726-48dd3a53c32f@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 18:09:15 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/omap/omapfb_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/omap/omapfb_main.c
index 3479a47a3082..b0d91524bf6c 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -1647,8 +1647,6 @@ static int omapfb_do_probe(struct platform_device *pdev,
 
 	fbdev = kzalloc(sizeof(struct omapfb_device), GFP_KERNEL);
 	if (fbdev = NULL) {
-		dev_err(&pdev->dev,
-			"unable to allocate memory for device info\n");
 		r = -ENOMEM;
 		goto cleanup;
 	}
-- 
2.15.0

