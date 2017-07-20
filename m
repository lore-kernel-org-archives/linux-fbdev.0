From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Thu, 20 Jul 2017 17:51:35 +0000
Subject: [PATCH 10/28] video: fbdev: via: constify pci_device_id.
Message-Id: <1500572393-18844-11-git-send-email-arvind.yadav.cs@gmail.com>
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
   3856	    968	    128	   4952	   1358	video/fbdev/via/via-core.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   4304	    520	    128	   4952	   1358	video/fbdev/via/via-core.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/via/via-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/via/via-core.c b/drivers/video/fbdev/via/via-core.c
index 1d28e16..77774d8 100644
--- a/drivers/video/fbdev/via/via-core.c
+++ b/drivers/video/fbdev/via/via-core.c
@@ -724,7 +724,7 @@ static void via_pci_remove(struct pci_dev *pdev)
 }
 
 
-static struct pci_device_id via_pci_table[] = {
+static const struct pci_device_id via_pci_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, UNICHROME_CLE266_DID),
 	  .driver_data = UNICHROME_CLE266 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, UNICHROME_K400_DID),
-- 
2.7.4

