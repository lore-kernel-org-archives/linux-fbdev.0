From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Thu, 20 Jul 2017 17:51:26 +0000
Subject: [PATCH 01/28] video: fbdev: radeon: constify pci_device_id.
Message-Id: <1500572393-18844-2-git-send-email-arvind.yadav.cs@gmail.com>
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
  19709	   5024	     32	  24765	   60bd	video/fbdev/aty/radeon_base.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  22893	   1840	     32	  24765	   60bd	video/fbdev/aty/radeon_base.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/aty/radeon_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index 6b4c787..dba479e 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -96,7 +96,7 @@
 #define CHIP_DEF(id, family, flags)					\
 	{ PCI_VENDOR_ID_ATI, id, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (flags) | (CHIP_FAMILY_##family) }
 
-static struct pci_device_id radeonfb_pci_table[] = {
+static const struct pci_device_id radeonfb_pci_table[] = {
         /* Radeon Xpress 200m */
 	CHIP_DEF(PCI_CHIP_RS480_5955,   RS480,  CHIP_HAS_CRTC2 | CHIP_IS_IGP | CHIP_IS_MOBILITY),
 	CHIP_DEF(PCI_CHIP_RS482_5975,	RS480,	CHIP_HAS_CRTC2 | CHIP_IS_IGP | CHIP_IS_MOBILITY),
-- 
2.7.4

