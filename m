From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 14 Nov 2013 08:19:18 +0000
Subject: [patch 1/2] video: mmp: delete a stray mutex_unlock()
Message-Id: <20131114081918.GB8150@elgon.mountain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

We aren't holding the disp_lock so we shouldn't release it.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/video/mmp/core.c b/drivers/video/mmp/core.c
index 84de263..c8d4265 100644
--- a/drivers/video/mmp/core.c
+++ b/drivers/video/mmp/core.c
@@ -173,7 +173,7 @@ struct mmp_path *mmp_register_path(struct mmp_path_info *info)
 		+ sizeof(struct mmp_overlay) * info->overlay_num;
 	path = kzalloc(size, GFP_KERNEL);
 	if (!path)
-		goto failed;
+		return NULL;
 
 	/* path set */
 	mutex_init(&path->access_ok);
@@ -219,11 +219,6 @@ struct mmp_path *mmp_register_path(struct mmp_path_info *info)
 
 	mutex_unlock(&disp_lock);
 	return path;
-
-failed:
-	kfree(path);
-	mutex_unlock(&disp_lock);
-	return NULL;
 }
 EXPORT_SYMBOL_GPL(mmp_register_path);
 
