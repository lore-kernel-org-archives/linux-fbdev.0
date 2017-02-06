From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Mon, 06 Feb 2017 14:24:44 +0000
Subject: [PATCH -next] video: fbdev: sh_mobile_lcdcfb: fix error return code in sh_mobile_lcdc_probe()
Message-Id: <20170206142444.27505-1-weiyj.lk@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fix to return error code -ENODEV from the ioremap_nocache() error
handling case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index 93469f9..ea8b6d5 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -2782,8 +2782,10 @@ static int sh_mobile_lcdc_probe(struct platform_device *pdev)
 		priv->forced_fourcc = pdata->ch[0].fourcc;
 
 	priv->base = ioremap_nocache(res->start, resource_size(res));
-	if (!priv->base)
+	if (!priv->base) {
+		error = -ENODEV;
 		goto err1;
+	}
 
 	error = sh_mobile_lcdc_setup_clocks(priv, pdata->clock_source);
 	if (error) {

