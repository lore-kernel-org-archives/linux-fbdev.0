From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 14:16:37 +0000
Subject: [PATCH 1/2] video: s3c-fb: Delete an error message for a failed memory allocation in s3c_fb_probe()
Message-Id: <734da0dc-cc64-50f5-7816-bf3f5dd2e9a4@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <2c837da0-6b0f-12e7-4d76-960b660a8911@users.sourceforge.net>
In-Reply-To: <2c837da0-6b0f-12e7-4d76-960b660a8911@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 15:00:16 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/s3c-fb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/s3c-fb.c b/drivers/video/fbdev/s3c-fb.c
index 5f4f696c2ecf..0914c973cbd9 100644
--- a/drivers/video/fbdev/s3c-fb.c
+++ b/drivers/video/fbdev/s3c-fb.c
@@ -1384,10 +1384,8 @@ static int s3c_fb_probe(struct platform_device *pdev)
 	}
 
 	sfb = devm_kzalloc(dev, sizeof(struct s3c_fb), GFP_KERNEL);
-	if (!sfb) {
-		dev_err(dev, "no memory for framebuffers\n");
+	if (!sfb)
 		return -ENOMEM;
-	}
 
 	dev_dbg(dev, "allocate new framebuffer %p\n", sfb);
 
-- 
2.15.0

