From: YueHaibing <yuehaibing@huawei.com>
Date: Sat, 30 Mar 2019 02:26:26 +0000
Subject: [PATCH -next] video: fbdev: remove set but not used variable 'size'
Message-Id: <20190330022626.97340-1-yuehaibing@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Kees Cook <keescook@chromium.org>, Ira Weiny <ira.weiny@intel.com>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>, dri-devel@lists.freedesktop.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/video/fbdev/pvr2fb.c: In function 'pvr2fb_init':
drivers/video/fbdev/pvr2fb.c:1074:6: warning:
 variable 'size' set but not used [-Wunused-but-set-variable]

It's not used since commit 9cd1c6743454 ("pvr2fb: Fix oops when
pseudo_palette is written")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/video/fbdev/pvr2fb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
index 41390c8e0f67..4e4d6a0df978 100644
--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -1071,7 +1071,6 @@ static struct pvr2_board {
 static int __init pvr2fb_init(void)
 {
 	int i, ret = -ENODEV;
-	int size;
 
 #ifndef MODULE
 	char *option = NULL;
@@ -1080,7 +1079,6 @@ static int __init pvr2fb_init(void)
 		return -ENODEV;
 	pvr2fb_setup(option);
 #endif
-	size = sizeof(struct fb_info) + sizeof(struct pvr2fb_par) + 16 * sizeof(u32);
 
 	fb_info = framebuffer_alloc(sizeof(struct pvr2fb_par), NULL);
