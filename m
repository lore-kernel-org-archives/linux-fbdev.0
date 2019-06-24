From: Colin King <colin.king@canonical.com>
Date: Mon, 24 Jun 2019 22:37:24 +0000
Subject: [PATCH] fbmem: remove redundant assignment to err
Message-Id: <20190624223724.13629-1-colin.king@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable err is initialized to a value that is never read and it
is re-assigned later.  The initialization is redundant and can
be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/core/fbmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index dd1a708df1a7..ae044a1325ca 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1987,7 +1987,7 @@ int fb_new_modelist(struct fb_info *info)
 	struct list_head *pos, *n;
 	struct fb_modelist *modelist;
 	struct fb_videomode *m, mode;
-	int err = 1;
+	int err;
 
 	list_for_each_safe(pos, n, &info->modelist) {
 		modelist = list_entry(pos, struct fb_modelist, list);
-- 
2.20.1
