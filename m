From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 14:17:34 +0000
Subject: [PATCH 2/2] video: s3c-fb: Improve a size determination in s3c_fb_probe()
Message-Id: <3eb68979-60cd-81e2-7a6b-9caf4afc1737@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <2c837da0-6b0f-12e7-4d76-960b660a8911@users.sourceforge.net>
In-Reply-To: <2c837da0-6b0f-12e7-4d76-960b660a8911@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 15:03:03 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/s3c-fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/s3c-fb.c b/drivers/video/fbdev/s3c-fb.c
index 0914c973cbd9..8c7623d63eb1 100644
--- a/drivers/video/fbdev/s3c-fb.c
+++ b/drivers/video/fbdev/s3c-fb.c
@@ -1383,7 +1383,7 @@ static int s3c_fb_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	sfb = devm_kzalloc(dev, sizeof(struct s3c_fb), GFP_KERNEL);
+	sfb = devm_kzalloc(dev, sizeof(*sfb), GFP_KERNEL);
 	if (!sfb)
 		return -ENOMEM;
 
-- 
2.15.0

