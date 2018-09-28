From: YueHaibing <yuehaibing@huawei.com>
Date: Fri, 28 Sep 2018 02:16:47 +0000
Subject: [PATCH -next] pxa168fb: remove set but not used variables 'mi'
Message-Id: <1538101007-160417-1-git-send-email-yuehaibing@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lubomir Rintel <lkundrak@v3.sk>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>, dri-devel@lists.freedesktop.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/video/fbdev/pxa168fb.c: In function 'pxa168fb_set_par':
drivers/video/fbdev/pxa168fb.c:408:29: warning:
 variable 'mi' set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/video/fbdev/pxa168fb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
index d059d04..e31340f 100644
--- a/drivers/video/fbdev/pxa168fb.c
+++ b/drivers/video/fbdev/pxa168fb.c
@@ -405,9 +405,6 @@ static int pxa168fb_set_par(struct fb_info *info)
 	struct fb_var_screeninfo *var = &info->var;
 	struct fb_videomode mode;
 	u32 x;
-	struct pxa168fb_mach_info *mi;
-
-	mi = dev_get_platdata(fbi->dev);
 
 	/*
 	 * Set additional mode info.
