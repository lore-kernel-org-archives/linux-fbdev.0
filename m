From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 17:42:23 +0000
Subject: [PATCH 2/3] video: omap: Improve a size determination in omapfb_do_probe()
Message-Id: <3e367b91-a7ae-fc2e-f145-d62cfee14c77@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1e17c727-884d-5745-2726-48dd3a53c32f@users.sourceforge.net>
In-Reply-To: <1e17c727-884d-5745-2726-48dd3a53c32f@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 18:16:20 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/omap/omapfb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/omap/omapfb_main.c
index b0d91524bf6c..c47059430ca8 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -1645,7 +1645,7 @@ static int omapfb_do_probe(struct platform_device *pdev,
 		goto cleanup;
 	}
 
-	fbdev = kzalloc(sizeof(struct omapfb_device), GFP_KERNEL);
+	fbdev = kzalloc(sizeof(*fbdev), GFP_KERNEL);
 	if (fbdev = NULL) {
 		r = -ENOMEM;
 		goto cleanup;
-- 
2.15.0

