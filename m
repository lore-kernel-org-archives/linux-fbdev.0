From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 12 Sep 2013 06:56:00 +0000
Subject: [PATCH 10/21] video: intelfb: remove unnecessary pci_set_drvdata()
Message-Id: <002401ceaf85$23f60540$6be20fc0$%han@samsung.com>
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
 drivers/video/intelfb/intelfbdrv.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
index 8209e46..b847d53 100644
--- a/drivers/video/intelfb/intelfbdrv.c
+++ b/drivers/video/intelfb/intelfbdrv.c
@@ -931,8 +931,6 @@ static void intelfb_pci_unregister(struct pci_dev *pdev)
 		return;
 
 	cleanup(dinfo);
-
-	pci_set_drvdata(pdev, NULL);
 }
 
 /***************************************************************
-- 
1.7.10.4


