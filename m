From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 11 Jun 2012 02:27:27 +0000
Subject: [PATCH 2/2] video: s3c-fb: fix possible division by zero in s3c_fb_calc_pixclk
Message-Id: <001901cd4779$bea8c980$3bfa5c80$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Divider value can be zero and it makes division by zero
from debug message in s3c_fb_calc_pixclk; therefore, it
should be fixed.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/s3c-fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index b5c2939..ea7b661 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -361,7 +361,7 @@ static int s3c_fb_calc_pixclk(struct s3c_fb *sfb, unsigned int pixclk)
 	result = (unsigned int)tmp / 1000;
 
 	dev_dbg(sfb->dev, "pixclk=%u, clk=%lu, div=%d (%lu)\n",
-		pixclk, clk, result, clk / result);
+		pixclk, clk, result, result ? clk / result : clk);
 
 	return result;
 }
-- 
1.7.1


