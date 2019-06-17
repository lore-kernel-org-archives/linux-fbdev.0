From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 17 Jun 2019 13:16:12 +0000
Subject: [PATCH] video: fbdev: pvr2fb: fix link error for pvr2fb_pci_exit
Message-Id: <20190617131624.2382303-1-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Andrew Morton <akpm@linux-foundation.org>, Ira Weiny <ira.weiny@intel.com>

When the driver is built-in for PCI, we reference the exit function
after discarding it:

`pvr2fb_pci_exit' referenced in section `.ref.data' of drivers/video/fbdev/pvr2fb.o: defined in discarded section `.exit.text' of drivers/video/fbdev/pvr2fb.o

Just remove the __exit annotation as the easiest workaround.

Fixes: 0f5a5712ad1e ("video: fbdev: pvr2fb: add COMPILE_TEST support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/pvr2fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
index 299ea7db9220..cf9cfdc5e685 100644
--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -990,7 +990,7 @@ static int __init pvr2fb_pci_init(void)
 	return pci_register_driver(&pvr2fb_pci_driver);
 }
 
-static void __exit pvr2fb_pci_exit(void)
+static void pvr2fb_pci_exit(void)
 {
 	pci_unregister_driver(&pvr2fb_pci_driver);
 }
-- 
2.20.0
