From: Jingoo Han <jg1.han@samsung.com>
Date: Sat, 11 May 2013 12:48:55 +0000
Subject: [PATCH 04/15] video: jz4740: remove unnecessary platform_set_drvdata()
Message-Id: <000401ce4e45$e593ed30$b0bbc790$@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/jz4740_fb.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/video/jz4740_fb.c b/drivers/video/jz4740_fb.c
index 36979b4..2c49112 100644
--- a/drivers/video/jz4740_fb.c
+++ b/drivers/video/jz4740_fb.c
@@ -737,8 +737,6 @@ static int jzfb_remove(struct platform_device *pdev)
 	fb_dealloc_cmap(&jzfb->fb->cmap);
 	jzfb_free_devmem(jzfb);
 
-	platform_set_drvdata(pdev, NULL);
-
 	framebuffer_release(jzfb->fb);
 
 	return 0;
-- 
1.7.2.5


