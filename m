From: Jingoo Han <jg1.han@samsung.com>
Date: Sat, 11 May 2013 12:50:34 +0000
Subject: [PATCH 06/15] video: nuc900fb: remove unnecessary platform_set_drvdata()
Message-Id: <000601ce4e46$20f2e6b0$62d8b410$@samsung.com>
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
 drivers/video/nuc900fb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/video/nuc900fb.c b/drivers/video/nuc900fb.c
index 32581c7..8c527e5 100644
--- a/drivers/video/nuc900fb.c
+++ b/drivers/video/nuc900fb.c
@@ -707,7 +707,6 @@ static int nuc900fb_remove(struct platform_device *pdev)
 	release_resource(fbi->mem);
 	kfree(fbi->mem);
 
-	platform_set_drvdata(pdev, NULL);
 	framebuffer_release(fbinfo);
 
 	return 0;
-- 
1.7.2.5


