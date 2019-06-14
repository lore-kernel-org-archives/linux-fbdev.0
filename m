From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 14 Jun 2019 14:47:34 +0000
Subject: [PATCH 1/3] video: fbdev: s3c-fb: return -ENOMEM on framebuffer_alloc() failure
Message-Id: <bbf32fbc-b4bc-39fc-e8dd-db9f0cd0d83f@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190614144735eucas1p2f71313b752ae4ea841ddd4ea502fd79f@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Jingoo Han <jingoohan1@gmail.com>

Fix error code from -ENOENT to -ENOMEM.

Cc: Jingoo Han <jingoohan1@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/s3c-fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/video/fbdev/s3c-fb.c
=================================--- a/drivers/video/fbdev/s3c-fb.c
+++ b/drivers/video/fbdev/s3c-fb.c
@@ -1191,7 +1191,7 @@ static int s3c_fb_probe_win(struct s3c_f
 				   palette_size * sizeof(u32), sfb->dev);
 	if (!fbinfo) {
 		dev_err(sfb->dev, "failed to allocate framebuffer\n");
-		return -ENOENT;
+		return -ENOMEM;
 	}
 
 	windata = sfb->pdata->win[win_no];
