From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Thu, 20 Jul 2017 17:51:53 +0000
Subject: [PATCH 28/28] video: fbdev: vt8623fb: constify pci_device_id.
Message-Id: <1500572393-18844-29-git-send-email-arvind.yadav.cs@gmail.com>
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
  11790	   1913	      0	  13703	   3587	drivers/video/fbdev/vt8623fb.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  11854	   1849	      0	  13703	   3587	drivers/video/fbdev/vt8623fb.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/vt8623fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/vt8623fb.c b/drivers/video/fbdev/vt8623fb.c
index dd0f18e..9f34879 100644
--- a/drivers/video/fbdev/vt8623fb.c
+++ b/drivers/video/fbdev/vt8623fb.c
@@ -888,7 +888,7 @@ static int vt8623_pci_resume(struct pci_dev* dev)
 
 /* List of boards that we are trying to support */
 
-static struct pci_device_id vt8623_devices[] = {
+static const struct pci_device_id vt8623_devices[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_VIA, 0x3122)},
 	{0, 0, 0, 0, 0, 0, 0}
 };
-- 
2.7.4

