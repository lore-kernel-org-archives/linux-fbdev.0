From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 17 Sep 2013 05:06:39 +0000
Subject: [PATCH 01/19] video: atmel_lcdfb: use dev_get_platdata()
Message-Id: <001101ceb363$b0f5b530$12e11f90$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Use the wrapper function for retrieving the platform data instead of
accessing dev->platform_data directly. This is a cosmetic change
to make the code simpler and enhance the readability.

Also, unnecessary casting from return value that is a void pointer
is removed.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/atmel_lcdfb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index 088511a..df05550 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -935,8 +935,8 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
 
 	sinfo = info->par;
 
-	if (dev->platform_data) {
-		pdata_sinfo = (struct atmel_lcdfb_info *)dev->platform_data;
+	if (dev_get_platdata(dev)) {
+		pdata_sinfo = dev_get_platdata(dev);
 		sinfo->default_bpp = pdata_sinfo->default_bpp;
 		sinfo->default_dmacon = pdata_sinfo->default_dmacon;
 		sinfo->default_lcdcon2 = pdata_sinfo->default_lcdcon2;
-- 
1.7.10.4


