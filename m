From: Colin King <colin.king@canonical.com>
Date: Tue, 12 Feb 2019 13:34:44 +0000
Subject: [PATCH] video: fbdev: savage: fix indentation issue
Message-Id: <20190212133444.7669-1-colin.king@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The indentation in the if statement is not indented correctly, fix
this with extra level of indentation.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/savage/savagefb_driver.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/savage/savagefb_driver.c b/drivers/video/fbdev/savage/savagefb_driver.c
index c09d7426cd92..47b78f0138c3 100644
--- a/drivers/video/fbdev/savage/savagefb_driver.c
+++ b/drivers/video/fbdev/savage/savagefb_driver.c
@@ -2155,9 +2155,9 @@ static int savage_init_fb_info(struct fb_info *info, struct pci_dev *dev,
 
 		err = fb_alloc_cmap(&info->cmap, NR_PALETTE, 0);
 		if (!err)
-		info->flags |= FBINFO_HWACCEL_COPYAREA |
-	                       FBINFO_HWACCEL_FILLRECT |
-		               FBINFO_HWACCEL_IMAGEBLIT;
+			info->flags |= FBINFO_HWACCEL_COPYAREA |
+				       FBINFO_HWACCEL_FILLRECT |
+				       FBINFO_HWACCEL_IMAGEBLIT;
 	}
 #endif
 	return err;
-- 
2.20.1
