From: Qinglang Miao <miaoqinglang@huawei.com>
Date: Wed, 16 Sep 2020 06:21:23 +0000
Subject: [PATCH -next] fbdev: nvidia: use for_each_child_of_node() macro
Message-Id: <20200916062123.190636-1-miaoqinglang@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, Qinglang Miao <miaoqinglang@huawei.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

Use for_each_child_of_node() macro instead of open coding it.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/video/fbdev/nvidia/nv_of.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/nvidia/nv_of.c b/drivers/video/fbdev/nvidia/nv_of.c
index 5f3e5179c..d20b8779b 100644
--- a/drivers/video/fbdev/nvidia/nv_of.c
+++ b/drivers/video/fbdev/nvidia/nv_of.c
@@ -42,8 +42,7 @@ int nvidia_probe_of_connector(struct fb_info *info, int conn, u8 **out_edid)
 		const char *pname;
 		int len;
 
-		for (dp = NULL;
-		     (dp = of_get_next_child(parent, dp)) != NULL;) {
+		for_each_child_of_node(parent, dp) {
 			pname = of_get_property(dp, "name", NULL);
 			if (!pname)
 				continue;
-- 
2.23.0
