From: Wen Yang <wen.yang99@zte.com.cn>
Date: Mon, 03 Dec 2018 06:43:17 +0000
Subject: [PATCH] fbdev: fsl-diu: remove redundant null check on cmap
Message-Id: <20181203064317.57054-1-wen.yang99@zte.com.cn>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Timur Tabi <timur@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>

The null check on &info->cmap is redundant since cmap is a struct
inside fb_info and can never be null, so the check is always true.
we may remove it.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Timur Tabi <timur@kernel.org>
CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC: linux-fbdev@vger.kernel.org
CC: dri-devel@lists.freedesktop.org
CC: linux-kernel@vger.kernel.org
---
 drivers/video/fbdev/fsl-diu-fb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index 332a56b6811f..9a5451ba4d44 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -1575,8 +1575,7 @@ static void uninstall_fb(struct fb_info *info)
 
 	unregister_framebuffer(info);
 	unmap_video_memory(info);
-	if (&info->cmap)
-		fb_dealloc_cmap(&info->cmap);
+	fb_dealloc_cmap(&info->cmap);
 
 	mfbi->registered = 0;
 }
-- 
2.19.1
