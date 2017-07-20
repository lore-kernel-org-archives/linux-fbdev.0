From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Thu, 20 Jul 2017 17:51:31 +0000
Subject: [PATCH 06/28] video: fbdev: intelfb: constify pci_device_id.
Message-Id: <1500572393-18844-7-git-send-email-arvind.yadav.cs@gmail.com>
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
  11749	    896	     24	  12669	   317d	video/fbdev/intelfb/intelfbdrv.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  12173	    472	     24	  12669	   317d	video/fbdev/intelfb/intelfbdrv.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/intelfb/intelfbdrv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/intelfb/intelfbdrv.c b/drivers/video/fbdev/intelfb/intelfbdrv.c
index 6b444400..0127e81 100644
--- a/drivers/video/fbdev/intelfb/intelfbdrv.c
+++ b/drivers/video/fbdev/intelfb/intelfbdrv.c
@@ -173,7 +173,7 @@ static int intelfb_set_fbinfo(struct intelfb_info *dinfo);
 #define INTELFB_CLASS_MASK 0
 #endif
 
-static struct pci_device_id intelfb_pci_table[] = {
+static const struct pci_device_id intelfb_pci_table[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_830M, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_830M },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_845G, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_845G },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_85XGM, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_85XGM },
-- 
2.7.4

