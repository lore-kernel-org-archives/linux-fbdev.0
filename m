From: Jingoo Han <jg1.han@samsung.com>
Date: Sat, 11 May 2013 13:00:43 +0000
Subject: [PATCH 14/15] video: vga16fb: remove unnecessary platform_set_drvdata()
Message-Id: <000e01ce4e47$8bc410d0$a34c3270$@samsung.com>
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
 drivers/video/vga16fb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
index 545faec..830ded4 100644
--- a/drivers/video/vga16fb.c
+++ b/drivers/video/vga16fb.c
@@ -1269,7 +1269,6 @@ static void vga16fb_destroy(struct fb_info *info)
 	iounmap(info->screen_base);
 	fb_dealloc_cmap(&info->cmap);
 	/* XXX unshare VGA regions */
-	platform_set_drvdata(dev, NULL);
 	framebuffer_release(info);
 }
 
-- 
1.7.2.5


