From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Thu, 20 Jul 2017 17:51:29 +0000
Subject: [PATCH 04/28] video: fbdev: sunxvr2500: constify pci_device_id.
Message-Id: <1500572393-18844-5-git-send-email-arvind.yadav.cs@gmail.com>
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
    390	    552	      0	    942	    3ae	drivers/video/fbdev/sunxvr2500.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
    686	    256	      0	    942	    3ae	drivers/video/fbdev/sunxvr2500.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/sunxvr2500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sunxvr2500.c b/drivers/video/fbdev/sunxvr2500.c
index 1a05329..544465b 100644
--- a/drivers/video/fbdev/sunxvr2500.c
+++ b/drivers/video/fbdev/sunxvr2500.c
@@ -220,7 +220,7 @@ static int s3d_pci_register(struct pci_dev *pdev,
 	return err;
 }
 
-static struct pci_device_id s3d_pci_table[] = {
+static const struct pci_device_id s3d_pci_table[] = {
 	{	PCI_DEVICE(PCI_VENDOR_ID_3DLABS, 0x002c),	},
 	{	PCI_DEVICE(PCI_VENDOR_ID_3DLABS, 0x002d),	},
 	{	PCI_DEVICE(PCI_VENDOR_ID_3DLABS, 0x002e),	},
-- 
2.7.4

