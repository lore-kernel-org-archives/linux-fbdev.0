From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Thu, 20 Jul 2017 17:51:46 +0000
Subject: [PATCH 21/28] video: fbdev: imsttfb: constify pci_device_id.
Message-Id: <1500572393-18844-22-git-send-email-arvind.yadav.cs@gmail.com>
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
   6736	    856	      0	   7592	   1da8	drivers/video/fbdev/imsttfb.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   6832	    760	      0	   7592	   1da8	drivers/video/fbdev/imsttfb.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/imsttfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index 4363c64..ecdcf35 100644
--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1318,7 +1318,7 @@ imsttfb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
 	}
 }
 
-static struct pci_device_id imsttfb_pci_tbl[] = {
+static const struct pci_device_id imsttfb_pci_tbl[] = {
 	{ PCI_VENDOR_ID_IMS, PCI_DEVICE_ID_IMS_TT128,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IBM },
 	{ PCI_VENDOR_ID_IMS, PCI_DEVICE_ID_IMS_TT3D,
-- 
2.7.4

