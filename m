From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 03 Sep 2010 07:52:00 +0000
Subject: [PATCH] fbdev: bail out immediately, if driver's fb_open fails
Message-Id: <Pine.LNX.4.64.1009030951220.2883@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

If driver specific fb_open fails no need to continue the function and call
fb_deferred_io_open(), bail out immediately.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/fbmem.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index b066475..adcf655 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1395,8 +1395,10 @@ __releases(&info->lock)
 	file->private_data = info;
 	if (info->fbops->fb_open) {
 		res = info->fbops->fb_open(info,1);
-		if (res)
+		if (res) {
 			module_put(info->fbops->owner);
+			goto out;
+		}
 	}
 #ifdef CONFIG_FB_DEFERRED_IO
 	if (info->fbdefio)
-- 
1.7.1

