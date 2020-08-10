From: Sasha Levin <sashal@kernel.org>
Date: Mon, 10 Aug 2020 19:11:17 +0000
Subject: [PATCH AUTOSEL 5.4 09/45] video: fbdev: savage: fix memory leak on error handling path in probe
Message-Id: <20200810191153.3794446-9-sashal@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200810191153.3794446-1-sashal@kernel.org>
In-Reply-To: <20200810191153.3794446-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Evgeny Novikov <novikov@ispras.ru>, dri-devel@lists.freedesktop.org

From: Evgeny Novikov <novikov@ispras.ru>

[ Upstream commit e8d35898a78e34fc854ed9680bc3f9caedab08cd ]

savagefb_probe() calls savage_init_fb_info() that can successfully
allocate memory for info->pixmap.addr but then fail when
fb_alloc_cmap() fails. savagefb_probe() goes to label failed_init and
does not free allocated memory. It is not valid to go to label
failed_mmio since savage_init_fb_info() can fail during memory
allocation as well. So, the patch free allocated memory on the error
handling path in savage_init_fb_info() itself.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
Cc: Antonino Daplas <adaplas@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200619162136.9010-1-novikov@ispras.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/savage/savagefb_driver.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/savage/savagefb_driver.c b/drivers/video/fbdev/savage/savagefb_driver.c
index 512789f5f8848..d5d22d9c0f562 100644
--- a/drivers/video/fbdev/savage/savagefb_driver.c
+++ b/drivers/video/fbdev/savage/savagefb_driver.c
@@ -2158,6 +2158,8 @@ static int savage_init_fb_info(struct fb_info *info, struct pci_dev *dev,
 			info->flags |= FBINFO_HWACCEL_COPYAREA |
 				       FBINFO_HWACCEL_FILLRECT |
 				       FBINFO_HWACCEL_IMAGEBLIT;
+		else
+			kfree(info->pixmap.addr);
 	}
 #endif
 	return err;
-- 
2.25.1
