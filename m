From: Yoichi Yuasa <yuasa@linux-mips.org>
Date: Thu, 15 Mar 2012 12:28:16 +0000
Subject: [PATCH] gma500: Fix mmap frambuffer
Message-Id: <20120315212816.475b0b18.yuasa@linux-mips.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alan@linux.intel.com
Cc: yuasa@linux-mips.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org


It cannot map correctly if page fault begins from a intermediate address.

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 drivers/gpu/drm/gma500/framebuffer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
index be61673..5154493 100644
--- a/drivers/gpu/drm/gma500/framebuffer.c
+++ b/drivers/gpu/drm/gma500/framebuffer.c
@@ -158,7 +158,7 @@ static int psbfb_vm_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
 	unsigned long phys_addr = (unsigned long)dev_priv->stolen_base;
 
 	page_num = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
-	address = (unsigned long)vmf->virtual_address;
+	address = (unsigned long)vmf->virtual_address - (vmf->pgoff << PAGE_SHIFT);
 
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
-- 
1.7.0.4
