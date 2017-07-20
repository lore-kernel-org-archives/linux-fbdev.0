From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Thu, 20 Jul 2017 17:51:33 +0000
Subject: [PATCH 08/28] video: fbdev: tridentfb: constify pci_device_id.
Message-Id: <1500572393-18844-9-git-send-email-arvind.yadav.cs@gmail.com>
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
  13206	   1232	     40	  14478	   388e	video/fbdev/tridentfb.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  13910	    528	     40	  14478	   388e	video/fbdev/tridentfb.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/tridentfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/tridentfb.c b/drivers/video/fbdev/tridentfb.c
index 8a5bbc1..2847061 100644
--- a/drivers/video/fbdev/tridentfb.c
+++ b/drivers/video/fbdev/tridentfb.c
@@ -1737,7 +1737,7 @@ static void trident_pci_remove(struct pci_dev *dev)
 }
 
 /* List of boards that we are trying to support */
-static struct pci_device_id trident_devices[] = {
+static const struct pci_device_id trident_devices[] = {
 	{PCI_VENDOR_ID_TRIDENT,	BLADE3D, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEi7, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEi7D, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-- 
2.7.4

