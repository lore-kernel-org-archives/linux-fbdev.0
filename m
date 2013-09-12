From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 12 Sep 2013 06:56:32 +0000
Subject: [PATCH 11/21] video: kyrofb: remove unnecessary pci_set_drvdata()
Message-Id: <002501ceaf85$3693cc50$a3bb64f0$%han@samsung.com>
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
 drivers/video/kyro/fbdev.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/kyro/fbdev.c b/drivers/video/kyro/fbdev.c
index 6157f74..c82f040 100644
--- a/drivers/video/kyro/fbdev.c
+++ b/drivers/video/kyro/fbdev.c
@@ -779,7 +779,6 @@ static void kyrofb_remove(struct pci_dev *pdev)
 #endif
 
 	unregister_framebuffer(info);
-	pci_set_drvdata(pdev, NULL);
 	framebuffer_release(info);
 }
 
-- 
1.7.10.4


