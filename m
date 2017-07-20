From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Thu, 20 Jul 2017 17:51:47 +0000
Subject: [PATCH 22/28] video: fbdev: pm2fb: constify pci_device_id.
Message-Id: <1500572393-18844-23-git-send-email-arvind.yadav.cs@gmail.com>
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
  11940	    660	     16	  12616	   3148	drivers/video/fbdev/pm2fb.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  12068	    532	     16	  12616	   3148	drivers/video/fbdev/pm2fb.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/pm2fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/pm2fb.c b/drivers/video/fbdev/pm2fb.c
index 1a4070f..bd6c2f5 100644
--- a/drivers/video/fbdev/pm2fb.c
+++ b/drivers/video/fbdev/pm2fb.c
@@ -1732,7 +1732,7 @@ static void pm2fb_remove(struct pci_dev *pdev)
 	framebuffer_release(info);
 }
 
-static struct pci_device_id pm2fb_id_table[] = {
+static const struct pci_device_id pm2fb_id_table[] = {
 	{ PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_TVP4020,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_3DLABS, PCI_DEVICE_ID_3DLABS_PERMEDIA2,
-- 
2.7.4

