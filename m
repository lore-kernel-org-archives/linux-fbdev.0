From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Wed, 26 Jun 2013 01:50:50 +0000
Subject: [PATCH -next] video: mxsfb: remove redundant dev_err call in mxsfb_probe()
Message-Id: <CAPgLHd80wMDBg8ADjtDvZC1=yUoigS7_btHMz1=r8WQTwpgSvg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/video/mxsfb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 21223d4..251bbec 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -899,7 +899,6 @@ static int mxsfb_probe(struct platform_device *pdev)
 
 	host->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(host->base)) {
-		dev_err(&pdev->dev, "ioremap failed\n");
 		ret = PTR_ERR(host->base);
 		goto fb_release;
 	}

