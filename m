From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 14 Nov 2013 08:19:57 +0000
Subject: [patch 2/2] video: mmp: Using plain integer as NULL pointer
Message-Id: <20131114081957.GC8150@elgon.mountain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Sparse complains here:

	drivers/video/mmp/core.c:33:16:
		warning: Using plain integer as NULL pointer

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/video/mmp/core.c b/drivers/video/mmp/core.c
index c8d4265..b563b92 100644
--- a/drivers/video/mmp/core.c
+++ b/drivers/video/mmp/core.c
@@ -30,7 +30,7 @@ static struct mmp_overlay *path_get_overlay(struct mmp_path *path,
 {
 	if (path && overlay_id < path->overlay_num)
 		return &path->overlays[overlay_id];
-	return 0;
+	return NULL;
 }
 
 static int path_check_status(struct mmp_path *path)
