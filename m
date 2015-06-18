From: Marcin Chojnacki <marcinch7@gmail.com>
Date: Thu, 18 Jun 2015 13:01:52 +0000
Subject: [PATCH] fbdev: remove unnecessary memset in vfb
Message-Id: <1434632512-128161-1-git-send-email-marcinch7@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com
Cc: tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Marcin Chojnacki <marcinch7@gmail.com>

In vfb_probe memory is allocated using rvmalloc which automatically
sets the allocated memory to zero. This patch removes the second
unnecessary memset in vfb_probe.

Signed-off-by: Marcin Chojnacki <marcinch7@gmail.com>
---
 drivers/video/fbdev/vfb.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
index 70a897b..b2d38b7 100644
--- a/drivers/video/fbdev/vfb.c
+++ b/drivers/video/fbdev/vfb.c
@@ -490,14 +490,6 @@ static int vfb_probe(struct platform_device *dev)
 	if (!(videomemory = rvmalloc(videomemorysize)))
 		return retval;
 
-	/*
-	 * VFB must clear memory to prevent kernel info
-	 * leakage into userspace
-	 * VGA-based drivers MUST NOT clear memory if
-	 * they want to be able to take over vgacon
-	 */
-	memset(videomemory, 0, videomemorysize);
-
 	info = framebuffer_alloc(sizeof(u32) * 256, &dev->dev);
 	if (!info)
 		goto err;
-- 
2.1.4

