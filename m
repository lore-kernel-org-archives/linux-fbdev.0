From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Sat, 19 Dec 2015 12:14:31 +0000
Subject: [PATCH] video: fbdev: pxafb: fix out of memory error path
Message-Id: <1450527271-21841-1-git-send-email-robert.jarzmik@free.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Robert Jarzmik <robert.jarzmik@free.fr>

As seen by Julia, the initial allocation memory is not checked anymore
after commit "video: fbdev: pxafb: initial devicetree conversion".
Introduce back the removed test.

Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/video/fbdev/pxafb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 8588dd683105..54666424a720 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2252,6 +2252,8 @@ static int pxafb_probe(struct platform_device *dev)
 	ret = -ENOMEM;
 	pdata = dev_get_platdata(&dev->dev);
 	inf = devm_kmalloc(&dev->dev, sizeof(*inf), GFP_KERNEL);
+	if (!inf)
+		goto failed;
 
 	if (pdata) {
 		*inf = *pdata;
-- 
2.1.4

