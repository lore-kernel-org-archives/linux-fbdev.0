From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 12 Sep 2013 06:51:57 +0000
Subject: [PATCH 03/21] video: cirrusfb: remove unnecessary pci_set_drvdata()
Message-Id: <001d01ceaf84$92cfd140$b86f73c0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The driver core clears the driver data to NULL after device_release
or on probe failure. Thus, it is not needed to manually clear the
device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/cirrusfb.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index 97db3ba..b016746 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -2159,7 +2159,6 @@ static int cirrusfb_pci_register(struct pci_dev *pdev,
 	if (!ret)
 		return 0;
 
-	pci_set_drvdata(pdev, NULL);
 	iounmap(info->screen_base);
 err_release_legacy:
 	if (release_io_ports)
-- 
1.7.10.4


