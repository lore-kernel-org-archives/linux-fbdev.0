From: Axel Lin <axel.lin@gmail.com>
Date: Fri, 11 Feb 2011 08:51:10 +0000
Subject: [PATCH] video: s3c-fb: return proper error if clk_get fails
Message-Id: <1297414270.14046.1.camel@mola>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Ben Dooks <ben-linux@fluff.org>, Paul Mundt <lethal@linux-sh.org>, linux-fbdev@vger.kernel.org

Return PTR_ERR(sfb->bus_clk) instead of 0 if clk_get fails.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/video/s3c-fb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 83ce9a0..6817d18 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -1340,6 +1340,7 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 	sfb->bus_clk = clk_get(dev, "lcd");
 	if (IS_ERR(sfb->bus_clk)) {
 		dev_err(dev, "failed to get bus clock\n");
+		ret = PTR_ERR(sfb->bus_clk);
 		goto err_sfb;
 	}
 
-- 
1.7.2



