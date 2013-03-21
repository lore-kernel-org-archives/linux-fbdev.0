From: Haiyang Zhang <haiyangz@microsoft.com>
Date: Thu, 21 Mar 2013 21:32:57 +0000
Subject: [PATCH] video: fix a type warning in hyperv_fb.c
Message-Id: <1363901577-16064-1-git-send-email-haiyangz@microsoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: FlorianSchandinat@gmx.de, akpm@linux-foundation.org, linux-fbdev@vger.kernel.org
Cc: haiyangz@microsoft.com, kys@microsoft.com, olaf@aepfle.de, jasowang@redhat.com, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: K. Y. Srinivasan <kys@microsoft.com>

---
 drivers/video/hyperv_fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/hyperv_fb.c b/drivers/video/hyperv_fb.c
index ceb33b0..d4d2c5f 100644
--- a/drivers/video/hyperv_fb.c
+++ b/drivers/video/hyperv_fb.c
@@ -624,7 +624,7 @@ static int hvfb_getmem(struct fb_info *info)
 {
 	struct pci_dev *pdev;
 	ulong fb_phys;
-	void *fb_virt;
+	void __iomem *fb_virt;
 
 	pdev = pci_get_device(PCI_VENDOR_ID_MICROSOFT,
 			      PCI_DEVICE_ID_HYPERV_VIDEO, NULL);
-- 
1.7.4.1

