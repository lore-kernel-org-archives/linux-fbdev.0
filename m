From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Thu, 20 Jul 2017 17:51:27 +0000
Subject: [PATCH 02/28] video: fbdev: atyfb: constify pci_device_id.
Message-Id: <1500572393-18844-3-git-send-email-arvind.yadav.cs@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1500572393-18844-1-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1500572393-18844-1-git-send-email-arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, paulus@samba.org, benh@kernel.crashing.org, adaplas@gmail.com, mbroemme@libmpq.org, FlorianSchandinat@gmx.de
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

pci_device_id are not supposed to change at runtime. All functions
working with pci_device_id provided by <linux/pci.h> work with
const pci_device_id. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
  17534	   1824	     48	  19406	   4bce	video/fbdev/aty/atyfb_base.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  18686	    672	     48	  19406	   4bce	video/fbdev/aty/atyfb_base.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/aty/atyfb_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 11026e7..d38cfc6 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -3762,7 +3762,7 @@ static void atyfb_pci_remove(struct pci_dev *pdev)
 	atyfb_remove(info);
 }
 
-static struct pci_device_id atyfb_pci_tbl[] = {
+static const struct pci_device_id atyfb_pci_tbl[] = {
 #ifdef CONFIG_FB_ATY_GX
 	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64GX) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64CX) },
-- 
2.7.4

