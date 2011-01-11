From: Jamie Iles <jamie@jamieiles.com>
Date: Tue, 11 Jan 2011 12:43:43 +0000
Subject: [PATCH 06/16] nuc900fb: don't treat NULL clk as an error
Message-Id: <1294749833-32019-7-git-send-email-jamie@jamieiles.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1294749833-32019-1-git-send-email-jamie@jamieiles.com>
In-Reply-To: <1294749833-32019-1-git-send-email-jamie@jamieiles.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Jamie Iles <jamie@jamieiles.com>, Wan ZongShun <mcuos.com@gmail.com>, linux-fbdev@vger.kernel.org

clk_get() returns a struct clk cookie to the driver and some platforms
may return NULL if they only support a single clock.  clk_get() has only
failed if it returns a ERR_PTR() encoded pointer.

Cc: Wan ZongShun <mcuos.com@gmail.com>
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 drivers/video/nuc900fb.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/nuc900fb.c b/drivers/video/nuc900fb.c
index 81687ed..62498bd 100644
--- a/drivers/video/nuc900fb.c
+++ b/drivers/video/nuc900fb.c
@@ -15,6 +15,7 @@
  */
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
@@ -597,9 +598,9 @@ static int __devinit nuc900fb_probe(struct platform_device *pdev)
 	}
 
 	fbi->clk = clk_get(&pdev->dev, NULL);
-	if (!fbi->clk || IS_ERR(fbi->clk)) {
+	if (IS_ERR(fbi->clk)) {
 		printk(KERN_ERR "nuc900-lcd:failed to get lcd clock source\n");
-		ret = -ENOENT;
+		ret = PTR_ERR(fbi->clk);
 		goto release_irq;
 	}
 
-- 
1.7.3.4

