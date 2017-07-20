From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Thu, 20 Jul 2017 17:51:36 +0000
Subject: [PATCH 11/28] video: fbdev: savage: constify pci_device_id.
Message-Id: <1500572393-18844-12-git-send-email-arvind.yadav.cs@gmail.com>
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
  19916	   1240	      8	  21164	   52ac fbdev/savage/savagefb_driver.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  20684	    472	      8	  21164	   52ac fbdev/savage/savagefb_driver.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/savage/savagefb_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/savage/savagefb_driver.c b/drivers/video/fbdev/savage/savagefb_driver.c
index c30a91c..c204683 100644
--- a/drivers/video/fbdev/savage/savagefb_driver.c
+++ b/drivers/video/fbdev/savage/savagefb_driver.c
@@ -2429,7 +2429,7 @@ static int savagefb_resume(struct pci_dev* dev)
 }
 
 
-static struct pci_device_id savagefb_devices[] = {
+static const struct pci_device_id savagefb_devices[] = {
 	{PCI_VENDOR_ID_S3, PCI_CHIP_SUPSAV_MX128,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_SUPERSAVAGE},
 
-- 
2.7.4

