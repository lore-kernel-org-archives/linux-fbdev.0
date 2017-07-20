From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Thu, 20 Jul 2017 17:51:51 +0000
Subject: [PATCH 26/28] video: fbdev: pm3fb: constify pci_device_id.
Message-Id: <1500572393-18844-27-git-send-email-arvind.yadav.cs@gmail.com>
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
  10332	    596	     16	  10944	   2ac0	drivers/video/fbdev/pm3fb.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  10396	    532	     16	  10944	   2ac0	drivers/video/fbdev/pm3fb.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/pm3fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/pm3fb.c b/drivers/video/fbdev/pm3fb.c
index 6ff5077..6130aa5 100644
--- a/drivers/video/fbdev/pm3fb.c
+++ b/drivers/video/fbdev/pm3fb.c
@@ -1479,7 +1479,7 @@ static void pm3fb_remove(struct pci_dev *dev)
 	}
 }
 
-static struct pci_device_id pm3fb_id_table[] = {
+static const struct pci_device_id pm3fb_id_table[] = {
 	{ PCI_VENDOR_ID_3DLABS, 0x0a,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0, }
-- 
2.7.4

