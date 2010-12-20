From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 20 Dec 2010 13:03:14 +0000
Subject: [PATCH 1/2] fbdev: Minor cleanup in WM8505-related code
Message-Id: <20101220130314.GA3627@alchark-u3s>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20101219181300.GA32645@alchark-u3s>
 <EAF47CD23C76F840A9E7FCE10091EFAB0322F86AE6@dbde02.ent.ti.com>
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB0322F86AE6@dbde02.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Janorkar, Mayuresh" <mayur@ti.com>
Cc: Alexey Charkov <alchark@gmail.com>, Paul Mundt <lethal@linux-sh.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "vt8500-wm8505-linux-kernel@googlegroups.com" <vt8500-wm8505-linux-kernel@googlegroups.com>

This replaces the last remaining driver name reference with the
macro for uniformity in wm8505fb.

In addition, the error return path in wmt_ge_rops.c is made more
uniform by getting rid of goto's in remaining places.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---

Splitted the vsync change (will follow in PATCH 2/2) from trivial
cleanups. This indeed makes sense for at least bisecting purposes.
Thanks Mayuresh for the suggestion!

Best regards,
Alexey

 drivers/video/wm8505fb.c    |    2 +-
 drivers/video/wmt_ge_rops.c |   10 ++--------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/video/wm8505fb.c b/drivers/video/wm8505fb.c
index e37251b..9ca9dbb 100644
--- a/drivers/video/wm8505fb.c
+++ b/drivers/video/wm8505fb.c
@@ -291,7 +291,7 @@ static int __devinit wm8505fb_probe(struct platform_device *pdev)
 		goto failed_fbi;
 	}
 
-	res = request_mem_region(res->start, resource_size(res), "wm8505fb");
+	res = request_mem_region(res->start, resource_size(res), DRIVER_NAME);
 	if (res = NULL) {
 		dev_err(&pdev->dev, "failed to request I/O memory\n");
 		ret = -EBUSY;
diff --git a/drivers/video/wmt_ge_rops.c b/drivers/video/wmt_ge_rops.c
index f31883f..45832b7 100644
--- a/drivers/video/wmt_ge_rops.c
+++ b/drivers/video/wmt_ge_rops.c
@@ -127,13 +127,11 @@ EXPORT_SYMBOL_GPL(wmt_ge_sync);
 static int __devinit wmt_ge_rops_probe(struct platform_device *pdev)
 {
 	struct resource *res;
-	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res = NULL) {
 		dev_err(&pdev->dev, "no I/O memory resource defined\n");
-		ret = -ENODEV;
-		goto error;
+		return -ENODEV;
 	}
 
 	/* Only one ROP engine is presently supported. */
@@ -145,17 +143,13 @@ static int __devinit wmt_ge_rops_probe(struct platform_device *pdev)
 	regbase = ioremap(res->start, resource_size(res));
 	if (regbase = NULL) {
 		dev_err(&pdev->dev, "failed to map I/O memory\n");
-		ret = -EBUSY;
-		goto error;
+		return -EBUSY;
 	}
 
 	writel(1, regbase + GE_ENABLE_OFF);
 	printk(KERN_INFO "Enabled support for WMT GE raster acceleration\n");
 
 	return 0;
-
-error:
-	return ret;
 }
 
 static int __devexit wmt_ge_rops_remove(struct platform_device *pdev)
-- 
1.7.3.4

