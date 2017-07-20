From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Thu, 20 Jul 2017 17:51:52 +0000
Subject: [PATCH 27/28] video: fbdev: matroxfb: constify pci_device_id.
Message-Id: <1500572393-18844-28-git-send-email-arvind.yadav.cs@gmail.com>
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
  19884	   3036	     96	  23016	   59e8	fbdev/matrox/matroxfb_base.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  20300	   2620	     96	  23016	   59e8	fbdev/matrox/matroxfb_base.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/matrox/matroxfb_base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/matrox/matroxfb_base.c b/drivers/video/fbdev/matrox/matroxfb_base.c
index 11eb094..a582907 100644
--- a/drivers/video/fbdev/matrox/matroxfb_base.c
+++ b/drivers/video/fbdev/matrox/matroxfb_base.c
@@ -1623,7 +1623,7 @@ static int initMatrox2(struct matrox_fb_info *minfo, struct board *b)
 	unsigned int memsize;
 	int err;
 
-	static struct pci_device_id intel_82437[] = {
+	static const struct pci_device_id intel_82437[] = {
 		{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82437) },
 		{ },
 	};
@@ -2116,7 +2116,7 @@ static void pci_remove_matrox(struct pci_dev* pdev) {
 	matroxfb_remove(minfo, 1);
 }
 
-static struct pci_device_id matroxfb_devices[] = {
+static const struct pci_device_id matroxfb_devices[] = {
 #ifdef CONFIG_FB_MATROX_MILLENIUM
 	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_MIL,
 		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
-- 
2.7.4

