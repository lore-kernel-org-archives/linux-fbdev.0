From: Jason Yan <yanaijie@huawei.com>
Date: Wed, 29 Apr 2020 14:09:42 +0000
Subject: [PATCH] video: fbdev: valkyriefb.c: fix warning comparing pointer to 0
Message-Id: <20200429140942.8137-1-yanaijie@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jason Yan <yanaijie@huawei.com>

Fix the following coccicheck warning:

drivers/video/fbdev/valkyriefb.c:348:10-11: WARNING comparing pointer to
0, suggest !E
drivers/video/fbdev/valkyriefb.c:334:12-13: WARNING comparing pointer to
0
drivers/video/fbdev/valkyriefb.c:348:10-11: WARNING comparing pointer to
0

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/video/fbdev/valkyriefb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/valkyriefb.c b/drivers/video/fbdev/valkyriefb.c
index 4d20c4603e5a..8425afe37d7c 100644
--- a/drivers/video/fbdev/valkyriefb.c
+++ b/drivers/video/fbdev/valkyriefb.c
@@ -331,7 +331,7 @@ int __init valkyriefb_init(void)
 		struct resource r;
 
 		dp = of_find_node_by_name(NULL, "valkyrie");
-		if (dp = 0)
+		if (!dp)
 			return 0;
 
 		if (of_address_to_resource(dp, 0, &r)) {
@@ -345,7 +345,7 @@ int __init valkyriefb_init(void)
 #endif /* ppc (!CONFIG_MAC) */
 
 	p = kzalloc(sizeof(*p), GFP_ATOMIC);
-	if (p = 0)
+	if (!p)
 		return -ENOMEM;
 
 	/* Map in frame buffer and registers */
-- 
2.21.1
