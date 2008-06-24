From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] fsl-diu-fb: Update Freescale DIU driver
	to use page_alloc_exact()
Date: Tue, 24 Jun 2008 11:44:13 -0500
Message-ID: <1214325853-26150-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KBBdA-0007dv-6d for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 24 Jun 2008 09:44:32 -0700
Received: from de01egw02.freescale.net ([192.88.165.103])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KBBd8-0000hr-Nv
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 24 Jun 2008 09:44:32 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org

Update the Freescale DIU driver to use page_alloc_exact() to allocate a
DMA buffer.  This also eliminates the rheap-based memory allocator.  We
can do this now because commit 6ccf61f9 allows us to allocate 8MB physically-
contiguous memory blocks.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

My other patch, "Add alloc_pages_exact() and free_pages_exact()", must be
applied first, otherwise drivers/video/fsl-diu-fb.c will not compile.

 drivers/video/fsl-diu-fb.c |   59 +++++++++++++++----------------------------
 1 files changed, 21 insertions(+), 38 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 0a27853..d15d265 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -279,58 +279,41 @@ static struct diu_hw dr = {
 
 static struct diu_pool pool;
 
-/*	To allocate memory for framebuffer. First try __get_free_pages(). If it
- *	fails, try rh_alloc. The reason is __get_free_pages() cannot allocate
- *	very large memory (more than 4MB). We don't want to allocate all memory
- *	in rheap since small memory allocation/deallocation will fragment the
- *	rheap and make the furture large allocation fail.
+/**
+ * fsl_diu_alloc - allocate memory for the DIU
+ * @size: number of bytes to allocate
+ * @param: returned physical address of memory
+ *
+ * This function allocates a physically-contiguous block of memory.
  */
-
-void *fsl_diu_alloc(unsigned long size, phys_addr_t *phys)
+static void *fsl_diu_alloc(size_t size, phys_addr_t *phys)
 {
 	void *virt;
 
-	pr_debug("size=%lu\n", size);
+	pr_debug("size=%u\n", size);
 
-	virt = (void *)__get_free_pages(GFP_DMA | __GFP_ZERO, get_order(size));
+	virt = alloc_pages_exact(size, GFP_DMA | __GFP_ZERO);
 	if (virt) {
 		*phys = virt_to_phys(virt);
-		pr_debug("virt %p, phys=%llx\n", virt, (uint64_t) *phys);
-		return virt;
-	}
-	if (!diu_ops.diu_mem) {
-		printk(KERN_INFO "%s: no diu_mem."
-			" To reserve more memory, put 'diufb=15M' "
-			"in the command line\n", __func__);
-		return NULL;
-	}
-
-	virt = (void *)rh_alloc(&diu_ops.diu_rh_info, size, "DIU");
-	if (virt) {
-		*phys = virt_to_bus(virt);
-		memset(virt, 0, size);
+		pr_debug("virt=%p, phys=%llx\n", virt, (uint64_t) *phys);
 	}
 
-	pr_debug("rh virt=%p phys=%lx\n", virt, *phys);
-
 	return virt;
 }
 
-void fsl_diu_free(void *p, unsigned long size)
+/**
+ * fsl_diu_free - release DIU memory
+ * @virt: pointer returned by fsl_diu_alloc()
+ * @size: number of bytes allocated by fsl_diu_alloc()
+ *
+ * This function releases memory allocated by fsl_diu_alloc().
+ */
+static void fsl_diu_free(void *virt, size_t size)
 {
-	pr_debug("p=%p size=%lu\n", p, size);
+	pr_debug("virt=%p size=%u\n", virt, size);
 
-	if (!p)
-		return;
-
-	if ((p >= diu_ops.diu_mem) &&
-	    (p < (diu_ops.diu_mem + diu_ops.diu_size))) {
-		pr_debug("rh\n");
-		rh_free(&diu_ops.diu_rh_info, (unsigned long) p);
-	} else {
-		pr_debug("dma\n");
-		free_pages((unsigned long)p, get_order(size));
-	}
+	if (virt && size)
+		free_pages_exact(virt, size);
 }
 
 static int fsl_diu_enable_panel(struct fb_info *info)
-- 
1.5.5


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
