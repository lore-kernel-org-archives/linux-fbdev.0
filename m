From: Julia Lawall <julia@diku.dk>
Date: Fri, 22 Apr 2011 20:11:23 +0000
Subject: [PATCH 3/3] drivers/video/s3c2410fb.c: Convert release_resource to release_mem_region
Message-Id: <1303503083-26170-3-git-send-email-julia@diku.dk>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Request_mem_region should be used with release_mem_region, not
release_resource.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@s exists@
expression e1,e2,e3,e4,e;
@@

*e4 = request_mem_region(e1,e2,e3)
... when != e4 = e
*release_resource(e4);
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/video/s3c2410fb.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
index 61c819e..0aa1376 100644
--- a/drivers/video/s3c2410fb.c
+++ b/drivers/video/s3c2410fb.c
@@ -867,7 +867,7 @@ static int __devinit s3c24xxfb_probe(struct platform_device *pdev,
 		goto dealloc_fb;
 	}
 
-	size = (res->end - res->start) + 1;
+	size = resource_size(res);
 	info->mem = request_mem_region(res->start, size, pdev->name);
 	if (info->mem = NULL) {
 		dev_err(&pdev->dev, "failed to get memory region\n");
@@ -997,8 +997,7 @@ release_irq:
 release_regs:
 	iounmap(info->io);
 release_mem:
-	release_resource(info->mem);
-	kfree(info->mem);
+	release_mem_region(res->start, size);
 dealloc_fb:
 	platform_set_drvdata(pdev, NULL);
 	framebuffer_release(fbinfo);
@@ -1044,8 +1043,7 @@ static int __devexit s3c2410fb_remove(struct platform_device *pdev)
 
 	iounmap(info->io);
 
-	release_resource(info->mem);
-	kfree(info->mem);
+	release_mem_region(info->mem->start, resource_size(info->mem));
 
 	platform_set_drvdata(pdev, NULL);
 	framebuffer_release(fbinfo);

