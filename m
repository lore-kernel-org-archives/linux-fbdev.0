From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 08 Jan 2014 00:44:31 +0000
Subject: [PATCH RESEND 1/4] video: asiliantfb: remove unnecessary pci_set_drvdata()
Message-Id: <001901cf0c0a$cb48b5e0$61da21a0$%han@samsung.com>
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
 drivers/video/asiliantfb.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/asiliantfb.c b/drivers/video/asiliantfb.c
index d611f1a..7e8ddf0 100644
--- a/drivers/video/asiliantfb.c
+++ b/drivers/video/asiliantfb.c
@@ -589,7 +589,6 @@ static void asiliantfb_remove(struct pci_dev *dp)
 	fb_dealloc_cmap(&p->cmap);
 	iounmap(p->screen_base);
 	release_mem_region(pci_resource_start(dp, 0), pci_resource_len(dp, 0));
-	pci_set_drvdata(dp, NULL);
 	framebuffer_release(p);
 }
 
-- 
1.7.10.4


