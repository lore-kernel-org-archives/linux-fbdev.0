From: Daniel Mack <daniel@zonque.org>
Date: Sun, 24 Jun 2018 15:38:16 +0000
Subject: [PATCH 3/4] video: fbdev: pxafb: handle errors from pxafb_init_fbinfo() correctly
Message-Id: <20180624153817.24387-3-daniel@zonque.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

pxafb_init_fbinfo() can not only report errors caused by failed
allocations but also when the clock can't be found.

To fix this, return an error pointer instead of NULL in case of errors,
and up-chain the result.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 drivers/video/fbdev/pxafb.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 6f3a93b3097c..68459b07d442 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -1802,14 +1802,14 @@ static struct pxafb_info *pxafb_init_fbinfo(struct device *dev,
 	fbi = devm_kzalloc(dev, sizeof(struct pxafb_info) + sizeof(u32) * 16,
 			   GFP_KERNEL);
 	if (!fbi)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	fbi->dev = dev;
 	fbi->inf = inf;
 
 	fbi->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(fbi->clk))
-		return NULL;
+		return ERR_CAST(fbi->clk);
 
 	strcpy(fbi->fb.fix.id, PXA_NAME);
 
@@ -2287,10 +2287,9 @@ static int pxafb_probe(struct platform_device *dev)
 	}
 
 	fbi = pxafb_init_fbinfo(&dev->dev, inf);
-	if (!fbi) {
-		/* only reason for pxafb_init_fbinfo to fail is kmalloc */
+	if (IS_ERR(fbi)) {
 		dev_err(&dev->dev, "Failed to initialize framebuffer device\n");
-		ret = -ENOMEM;
+		ret = PTR_ERR(fbi);
 		goto failed;
 	}
 
-- 
2.17.1

