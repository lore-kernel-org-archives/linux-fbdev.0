From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Thu, 20 Jul 2017 17:51:49 +0000
Subject: [PATCH 24/28] video: fbdev: neofb: constify pci_device_id.
Message-Id: <1500572393-18844-25-git-send-email-arvind.yadav.cs@gmail.com>
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
  12766	   1064	     21	  13851	   361b	drivers/video/fbdev/neofb.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  13086	    744	     21	  13851	   361b	drivers/video/fbdev/neofb.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/neofb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/neofb.c b/drivers/video/fbdev/neofb.c
index db023a9..5d3a444 100644
--- a/drivers/video/fbdev/neofb.c
+++ b/drivers/video/fbdev/neofb.c
@@ -2138,7 +2138,7 @@ static void neofb_remove(struct pci_dev *dev)
 	}
 }
 
-static struct pci_device_id neofb_devices[] = {
+static const struct pci_device_id neofb_devices[] = {
 	{PCI_VENDOR_ID_NEOMAGIC, PCI_CHIP_NM2070,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_NEOMAGIC_NM2070},
 
-- 
2.7.4

