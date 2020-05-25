From: Tiezhu Yang <yangtiezhu@loongson.cn>
Date: Mon, 25 May 2020 07:11:45 +0000
Subject: [PATCH] video: fbdev: pxafb: Use correct return value for pxafb_probe()
Message-Id: <1590390705-22898-1-git-send-email-yangtiezhu@loongson.cn>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, linux-fbdev@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

When call function devm_platform_ioremap_resource(), we should use IS_ERR()
to check the return value and return PTR_ERR() if failed.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/video/fbdev/pxafb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 00b96a7..423331c 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2305,7 +2305,7 @@ static int pxafb_probe(struct platform_device *dev)
 	fbi->mmio_base = devm_platform_ioremap_resource(dev, 0);
 	if (IS_ERR(fbi->mmio_base)) {
 		dev_err(&dev->dev, "failed to get I/O memory\n");
-		ret = -EBUSY;
+		ret = PTR_ERR(fbi->mmio_base);
 		goto failed;
 	}
 
-- 
2.1.0
