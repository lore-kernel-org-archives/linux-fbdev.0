From: Vladimir Murzin <vladimir.murzin@arm.com>
Date: Fri, 12 Jun 2015 13:59:19 +0000
Subject: [PATCH] fbdev: propagate result of fb_videomode_from_videomode()
Message-Id: <1434117559-32130-1-git-send-email-vladimir.murzin@arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

fb_videomode_from_videomode() may fail, but of_get_fb_videomode()
silently covers this fact. Instead, trow the error code to the
caller.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 drivers/video/fbdev/core/fbmon.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 01ef1b9..d787533 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -1475,7 +1475,9 @@ int of_get_fb_videomode(struct device_node *np, struct fb_videomode *fb,
 	if (ret)
 		return ret;
 
-	fb_videomode_from_videomode(&vm, fb);
+	ret = fb_videomode_from_videomode(&vm, fb);
+	if (ret)
+		return ret;
 
 	pr_debug("%s: got %dx%d display mode from %s\n",
 		of_node_full_name(np), vm.hactive, vm.vactive, np->name);
-- 
1.7.9.5

