From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 08 Jan 2014 00:45:15 +0000
Subject: [PATCH RESEND 2/4] video: nvidiafb: remove unnecessary pci_set_drvdata()
Message-Id: <001a01cf0c0a$e5a7f630$b0f7e290$%han@samsung.com>
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
 drivers/video/nvidia/nvidia.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index ff22871..def0412 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -1461,7 +1461,6 @@ static void nvidiafb_remove(struct pci_dev *pd)
 	pci_release_regions(pd);
 	kfree(info->pixmap.addr);
 	framebuffer_release(info);
-	pci_set_drvdata(pd, NULL);
 	NVTRACE_LEAVE();
 }
 
-- 
1.7.10.4


