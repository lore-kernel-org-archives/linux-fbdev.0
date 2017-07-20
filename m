From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Thu, 20 Jul 2017 17:51:44 +0000
Subject: [PATCH 19/28] video: fbdev: tdfx: constify pci_device_id.
Message-Id: <1500572393-18844-20-git-send-email-arvind.yadav.cs@gmail.com>
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
   8432	   1456	     16	   9904	   26b0	drivers/video/fbdev/tdfxfb.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   8560	   1328	     16	   9904	   26b0	drivers/video/fbdev/tdfxfb.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/tdfxfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index d5fa313..dec1fed 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -120,7 +120,7 @@ static const struct fb_var_screeninfo tdfx_var = {
 static int tdfxfb_probe(struct pci_dev *pdev, const struct pci_device_id *id);
 static void tdfxfb_remove(struct pci_dev *pdev);
 
-static struct pci_device_id tdfxfb_id_table[] = {
+static const struct pci_device_id tdfxfb_id_table[] = {
 	{ PCI_VENDOR_ID_3DFX, PCI_DEVICE_ID_3DFX_BANSHEE,
 	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
 	  0xff0000, 0 },
-- 
2.7.4

