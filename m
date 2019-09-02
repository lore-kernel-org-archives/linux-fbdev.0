From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Mon, 02 Sep 2019 12:43:16 +0000
Subject: [PATCH] video/fbdev/68328fb: Remove dead code
Message-Id: <1567428544-8620-1-git-send-email-jrdr.linux@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com, Souptick Joarder <jrdr.linux@gmail.com>

This is dead code since 3.15. If their is no plan to
use it further, these can be removed forever.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/video/fbdev/68328fb.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/video/fbdev/68328fb.c b/drivers/video/fbdev/68328fb.c
index d48e960..02d22b7 100644
--- a/drivers/video/fbdev/68328fb.c
+++ b/drivers/video/fbdev/68328fb.c
@@ -405,20 +405,8 @@ static int mc68x328fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 
 int __init mc68x328fb_setup(char *options)
 {
-#if 0
-	char *this_opt;
-#endif
-
 	if (!options || !*options)
 		return 1;
-#if 0
-	while ((this_opt = strsep(&options, ",")) != NULL) {
-		if (!*this_opt)
-			continue;
-		if (!strncmp(this_opt, "disable", 7))
-			mc68x328fb_enable = 0;
-	}
-#endif
 	return 1;
 }
 
-- 
1.9.1
