From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 24 Nov 2017 19:30:04 +0000
Subject: [PATCH] video/fbdev/wm8505fb: Delete an error message for a failed memory allocation in wm8505fb_pro
Message-Id: <8f4f12ca-f2b3-6b3b-5f4c-5519f13c474f@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, Tony Prisk <linux@prisktech.co.nz>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 24 Nov 2017 20:22:10 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/wm8505fb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/wm8505fb.c b/drivers/video/fbdev/wm8505fb.c
index 253ffe9baab2..8f0d5379861d 100644
--- a/drivers/video/fbdev/wm8505fb.c
+++ b/drivers/video/fbdev/wm8505fb.c
@@ -276,10 +276,8 @@ static int wm8505fb_probe(struct platform_device *pdev)
 
 	fbi = devm_kzalloc(&pdev->dev, sizeof(struct wm8505fb_info) +
 			sizeof(u32) * 16, GFP_KERNEL);
-	if (!fbi) {
-		dev_err(&pdev->dev, "Failed to initialize framebuffer device\n");
+	if (!fbi)
 		return -ENOMEM;
-	}
 
 	strcpy(fbi->fb.fix.id, DRIVER_NAME);
 
-- 
2.15.0

