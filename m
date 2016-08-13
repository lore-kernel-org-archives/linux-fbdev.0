From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Sat, 13 Aug 2016 08:57:23 +0000
Subject: [PATCH -next] video: fbdev: pxafb: add missing of_node_put() in of_get_pxafb_mode_info()
Message-Id: <1471078643-4815-1-git-send-email-weiyj.lk@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This node pointer is returned by of_graph_get_next_endpoint() with
refcount incremented in this function. of_node_put() on it before
exitting this function.

Found by Coccinelle.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/video/fbdev/pxafb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index ed41fdb..ef73f14 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2186,6 +2186,7 @@ static int of_get_pxafb_mode_info(struct device *dev,
 	ret = of_property_read_u32(np, "bus-width", &bus_width);
 	if (ret) {
 		dev_err(dev, "no bus-width specified: %d\n", ret);
+		of_node_put(np);
 		return ret;
 	}

