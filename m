From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 17:59:57 +0000
Subject: [PATCH 2/3] video: au1100fb: Improve a size determination in au1100fb_drv_probe()
Message-Id: <231de972-f0bf-18ce-e681-a29767c086ea@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <980dc009-429b-ad88-966b-0e75808cbacc@users.sourceforge.net>
In-Reply-To: <980dc009-429b-ad88-966b-0e75808cbacc@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 18:18:34 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/au1100fb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index cae17d02d804..1e5b872f0da6 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -416,8 +416,7 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 	struct clk *c;
 
 	/* Allocate new device private */
-	fbdev = devm_kzalloc(&dev->dev, sizeof(struct au1100fb_device),
-			     GFP_KERNEL);
+	fbdev = devm_kzalloc(&dev->dev, sizeof(*fbdev), GFP_KERNEL);
 	if (!fbdev)
 		return -ENOMEM;
 
-- 
2.15.0

