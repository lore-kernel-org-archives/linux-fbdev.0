From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Thu, 20 Jul 2017 17:51:50 +0000
Subject: [PATCH 25/28] video: fbdev: s3fb: constify pci_device_id.
Message-Id: <1500572393-18844-26-git-send-email-arvind.yadav.cs@gmail.com>
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
  20994	   2440	      8	  23442	   5b92	drivers/video/fbdev/s3fb.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  21506	   1928	      8	  23442	   5b92	drivers/video/fbdev/s3fb.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/s3fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/s3fb.c b/drivers/video/fbdev/s3fb.c
index 13b1090..d63f23e 100644
--- a/drivers/video/fbdev/s3fb.c
+++ b/drivers/video/fbdev/s3fb.c
@@ -1483,7 +1483,7 @@ static int s3_pci_resume(struct pci_dev* dev)
 
 /* List of boards that we are trying to support */
 
-static struct pci_device_id s3_devices[] = {
+static const struct pci_device_id s3_devices[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x8810), .driver_data = CHIP_XXX_TRIO},
 	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x8811), .driver_data = CHIP_XXX_TRIO},
 	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x8812), .driver_data = CHIP_M65_AURORA64VP},
-- 
2.7.4

