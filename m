From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 17:58:22 +0000
Subject: [PATCH 1/3] video: au1100fb: Delete an error message for a failed memory allocation in au1100fb_drv_
Message-Id: <f2ad18dd-2525-d8d9-10a8-c12b345cb509@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <980dc009-429b-ad88-966b-0e75808cbacc@users.sourceforge.net>
In-Reply-To: <980dc009-429b-ad88-966b-0e75808cbacc@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 18:14:41 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/au1100fb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index 8de42f617d16..cae17d02d804 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -418,10 +418,8 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 	/* Allocate new device private */
 	fbdev = devm_kzalloc(&dev->dev, sizeof(struct au1100fb_device),
 			     GFP_KERNEL);
-	if (!fbdev) {
-		print_err("fail to allocate device private record");
+	if (!fbdev)
 		return -ENOMEM;
-	}
 
 	if (au1100fb_setup(fbdev))
 		goto failed;
-- 
2.15.0

