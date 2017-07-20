From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Thu, 20 Jul 2017 17:51:38 +0000
Subject: [PATCH 13/28] video: fbdev: i810: constify pci_device_id.
Message-Id: <1500572393-18844-14-git-send-email-arvind.yadav.cs@gmail.com>
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
  13132	    520	     56	  13708	   358c	video/fbdev/i810/i810_main.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  13356	    296	     56	  13708	   358c	video/fbdev/i810/i810_main.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/i810/i810_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/i810/i810_main.c b/drivers/video/fbdev/i810/i810_main.c
index 2488baa..f0a758a 100644
--- a/drivers/video/fbdev/i810/i810_main.c
+++ b/drivers/video/fbdev/i810/i810_main.c
@@ -107,7 +107,7 @@ static const char * const i810_pci_list[] = {
 	"Intel(R) 815 (Internal Graphics with AGP) Framebuffer Device"
 };
 
-static struct pci_device_id i810fb_pci_tbl[] = {
+static const struct pci_device_id i810fb_pci_tbl[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82810_IG1,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82810_IG3,
-- 
2.7.4

