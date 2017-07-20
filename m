From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Thu, 20 Jul 2017 17:51:28 +0000
Subject: [PATCH 03/28] video: fbdev: aty128fb: constify pci_device_id.
Message-Id: <1500572393-18844-4-git-send-email-arvind.yadav.cs@gmail.com>
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
  11525	   2048	      8	  13581	   350d	video/fbdev/aty/aty128fb.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  13061	    512	      8	  13581	   350d	video/fbdev/aty/aty128fb.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/aty/aty128fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty/aty128fb.c
index fa07242..ba64e26 100644
--- a/drivers/video/fbdev/aty/aty128fb.c
+++ b/drivers/video/fbdev/aty/aty128fb.c
@@ -166,7 +166,7 @@ static int aty128_pci_resume(struct pci_dev *pdev);
 static int aty128_do_resume(struct pci_dev *pdev);
 
 /* supported Rage128 chipsets */
-static struct pci_device_id aty128_pci_tbl[] = {
+static const struct pci_device_id aty128_pci_tbl[] = {
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_LE,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_M3_pci },
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_LF,
-- 
2.7.4

