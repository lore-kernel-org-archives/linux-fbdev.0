From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Thu, 20 Jul 2017 17:51:40 +0000
Subject: [PATCH 15/28] video: fbdev: kyro: constify pci_device_id.
Message-Id: <1500572393-18844-16-git-send-email-arvind.yadav.cs@gmail.com>
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
   3190	   2704	     24	   5918	   171e	video/fbdev/kyro/fbdev.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   3290	   2640	     24	   5918	   171e	video/fbdev/kyro/fbdev.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/kyro/fbdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/kyro/fbdev.c b/drivers/video/fbdev/kyro/fbdev.c
index f77478f..a7bd9f2 100644
--- a/drivers/video/fbdev/kyro/fbdev.c
+++ b/drivers/video/fbdev/kyro/fbdev.c
@@ -633,7 +633,7 @@ static int kyrofb_ioctl(struct fb_info *info,
 	return 0;
 }
 
-static struct pci_device_id kyrofb_pci_tbl[] = {
+static const struct pci_device_id kyrofb_pci_tbl[] = {
 	{ PCI_VENDOR_ID_ST, PCI_DEVICE_ID_STG4000,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0, }
-- 
2.7.4

