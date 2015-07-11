From: Christian Engelmayer <cengelma@gmx.at>
Date: Sat, 11 Jul 2015 17:46:11 +0000
Subject: [PATCH] video: Fix possible leak in of_get_videomode()
Message-Id: <1436636771-16844-1-git-send-email-cengelma@gmx.at>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

In case videomode_from_timings() fails in function of_get_videomode(), the
allocated display timing data is not freed in the exit path. Make sure that
display_timings_release() is called in any case. Detected by Coverity CID
1309681.

Signed-off-by: Christian Engelmayer <cengelma@gmx.at>
---
Compile tested only. Applies against linux-next.
---
 drivers/video/of_videomode.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/video/of_videomode.c b/drivers/video/of_videomode.c
index 111c2d1911d3..3495b48c6805 100644
--- a/drivers/video/of_videomode.c
+++ b/drivers/video/of_videomode.c
@@ -44,11 +44,7 @@ int of_get_videomode(struct device_node *np, struct videomode *vm,
 		index = disp->native_mode;
 
 	ret = videomode_from_timings(disp, vm, index);
-	if (ret)
-		return ret;
-
 	display_timings_release(disp);
-
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(of_get_videomode);
-- 
1.9.1

