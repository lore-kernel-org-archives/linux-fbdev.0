From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Thu, 20 Jul 2017 17:51:43 +0000
Subject: [PATCH 18/28] video: fbdev: mb862xx: constify pci_device_id.
Message-Id: <1500572393-18844-19-git-send-email-arvind.yadav.cs@gmail.com>
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
   7326	   1320	      0	   8646	   21c6	fbdev/mb862xx/mb862xxfbdrv.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   7454	   1192	      0	   8646	   21c6	fbdev/mb862xx/mb862xxfbdrv.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/mb862xx/mb862xxfbdrv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
index f9ec5c0..cd37252 100644
--- a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
+++ b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
@@ -982,7 +982,7 @@ static inline int mb862xx_pci_gdc_init(struct mb862xxfb_par *par)
 #define CHIP_ID(id)	\
 	{ PCI_DEVICE(PCI_VENDOR_ID_FUJITSU_LIMITED, id) }
 
-static struct pci_device_id mb862xx_pci_tbl[] = {
+static const struct pci_device_id mb862xx_pci_tbl[] = {
 	/* MB86295/MB86296 */
 	CHIP_ID(PCI_DEVICE_ID_FUJITSU_CORALP),
 	CHIP_ID(PCI_DEVICE_ID_FUJITSU_CORALPA),
-- 
2.7.4

