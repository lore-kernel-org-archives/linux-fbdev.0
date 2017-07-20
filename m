From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Thu, 20 Jul 2017 17:51:32 +0000
Subject: [PATCH 07/28] video: fbdev: pvr2fb: constify pci_device_id.
Message-Id: <1500572393-18844-8-git-send-email-arvind.yadav.cs@gmail.com>
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
   5155	   1312	     40	   6507	   196b	drivers/video/fbdev/pvr2fb.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   5219	   1248	     40	   6507	   196b	drivers/video/fbdev/pvr2fb.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/pvr2fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
index a2564ab..c6212ab 100644
--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -966,7 +966,7 @@ static void pvr2fb_pci_remove(struct pci_dev *pdev)
 	pci_release_regions(pdev);
 }
 
-static struct pci_device_id pvr2fb_pci_tbl[] = {
+static const struct pci_device_id pvr2fb_pci_tbl[] = {
 	{ PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_NEON250,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0, },
-- 
2.7.4

