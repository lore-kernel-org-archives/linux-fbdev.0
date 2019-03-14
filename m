From: Kangjie Lu <kjlu@umn.edu>
Date: Thu, 14 Mar 2019 07:33:17 +0000
Subject: [PATCH] video: fbdev: fix potential NULL pointer dereferences
Message-Id: <20190314073319.23209-1-kjlu@umn.edu>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kjlu@umn.edu
Cc: pakki001@umn.edu, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Finn Thain <fthain@telegraphics.com.au>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

In case ioremap fails, the fix releases resources and returns
-ENOMEM to avoid NULL pointer dereferences.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/video/fbdev/imsttfb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index 5d9670daf60e..2e321d73b3a5 100644
--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1515,6 +1515,11 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	info->fix.smem_start = addr;
 	info->screen_base = (__u8 *)ioremap(addr, par->ramdac = IBM ?
 					    0x400000 : 0x800000);
+	if (!info->screen_base) {
+		release_mem_region(addr, size);
+		framebuffer_release(info);
+		return -ENOMEM;
+	}
 	info->fix.mmio_start = addr + 0x800000;
 	par->dc_regs = ioremap(addr + 0x800000, 0x1000);
 	par->cmap_regs_phys = addr + 0x840000;
-- 
2.17.1
