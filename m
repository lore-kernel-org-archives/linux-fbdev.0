From: Andrei Epure <epure.andrei@gmail.com>
Date: Wed, 27 Mar 2013 20:48:38 +0000
Subject: [PATCH] video: mmp: removed reference preceded by free
Message-Id: <1364417318-26650-1-git-send-email-epure.andrei@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: FlorianSchandinat@gmx.de
Cc: akpm@linux-foundation.org, haojian.zhuang@gmail.com, cldu@marvell.com, zzhu3@marvell.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrei Epure <epure.andrei@gmail.com>

Patch found with coccinelle.

Signed-off-by: Andrei Epure <epure.andrei@gmail.com>
---
 drivers/video/mmp/core.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/mmp/core.c b/drivers/video/mmp/core.c
index 9ed8341..84de263 100644
--- a/drivers/video/mmp/core.c
+++ b/drivers/video/mmp/core.c
@@ -252,7 +252,5 @@ void mmp_unregister_path(struct mmp_path *path)
 
 	kfree(path);
 	mutex_unlock(&disp_lock);
-
-	dev_info(path->dev, "de-register %s\n", path->name);
 }
 EXPORT_SYMBOL_GPL(mmp_unregister_path);
-- 
1.7.9.5

