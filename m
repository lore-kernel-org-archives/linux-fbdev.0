From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sat, 04 Nov 2017 21:24:19 +0000
Subject: [PATCH 1/3] sm501fb: deallocate colormap only if allocated
Message-Id: <1509830661-7384-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

There are cases when panel and crt both are not defined and only one of
them is defined and initialized. In such cases, while removing the
device deallocate the colormap only if that particular fb is defined.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/video/fbdev/sm501fb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index 076dd27..381475f 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -1889,6 +1889,9 @@ static void sm501_free_init_fb(struct sm501fb_info *info,
 {
 	struct fb_info *fbi = info->fb[head];
 
+	if (!fbi)
+		return;
+
 	fb_dealloc_cmap(&fbi->cmap);
 }
 
-- 
2.1.4

