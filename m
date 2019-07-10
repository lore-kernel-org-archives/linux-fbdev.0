From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Wed, 10 Jul 2019 17:58:57 +0000
Subject: [PATCH] video: fbdev: nvidia: Remove extra return
Message-Id: <1562781795-3494-1-git-send-email-jrdr.linux@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@gmail.com, b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com, Souptick Joarder <jrdr.linux@gmail.com>

Minor cleanup to remove extra return statement.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/video/fbdev/nvidia/nv_backlight.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/nvidia/nv_backlight.c b/drivers/video/fbdev/nvidia/nv_backlight.c
index e705a78..2ce5352 100644
--- a/drivers/video/fbdev/nvidia/nv_backlight.c
+++ b/drivers/video/fbdev/nvidia/nv_backlight.c
@@ -123,8 +123,6 @@ void nvidia_bl_init(struct nvidia_par *par)
 
 	printk("nvidia: Backlight initialized (%s)\n", name);
 
-	return;
-
 error:
 	return;
 }
-- 
1.9.1
