From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Thu, 20 Jul 2017 17:51:42 +0000
Subject: [PATCH 17/28] video: fbdev: nvidia: constify pci_device_id.
Message-Id: <1500572393-18844-18-git-send-email-arvind.yadav.cs@gmail.com>
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
  12149	    768	     36	  12953	   3299	video/fbdev/nvidia/nvidia.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  12213	    704	     36	  12953	   3299	video/fbdev/nvidia/nvidia.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/nvidia/nvidia.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index ce7dab7..418a2d0 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -55,7 +55,7 @@
 /* HW cursor parameters */
 #define MAX_CURS		32
 
-static struct pci_device_id nvidiafb_pci_tbl[] = {
+static const struct pci_device_id nvidiafb_pci_tbl[] = {
 	{PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	 PCI_BASE_CLASS_DISPLAY << 16, 0xff0000, 0},
 	{ 0, }
-- 
2.7.4

