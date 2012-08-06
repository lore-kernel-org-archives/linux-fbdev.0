From: Hideki EIRAKU <hdk@igel.co.jp>
Date: Mon, 06 Aug 2012 09:55:23 +0000
Subject: [PATCH v3 3/4] media: videobuf2-dma-contig: use dma_mmap_coherent if available
Message-Id: <1344246924-32620-4-git-send-email-hdk@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344246924-32620-1-git-send-email-hdk@igel.co.jp>
In-Reply-To: <1344246924-32620-1-git-send-email-hdk@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <linux@arm.linux.org.uk>, Pawel Osciak <pawel@osciak.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Katsuya MATSUBARA <matsu@igel.co.jp>, linux-fbdev@vger.kernel.org, Hideki EIRAKU <hdk@igel.co.jp>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org

Previously the vb2_dma_contig_mmap() function was using a dma_addr_t as a
physical address.  The two addressses are not necessarily the same.
For example, when using the IOMMU funtion on certain platforms, dma_addr_t
addresses are not directly mappable physical address.
dma_mmap_coherent() maps the address correctly.
It is available on ARM platforms.

Signed-off-by: Hideki EIRAKU <hdk@igel.co.jp>
---
 drivers/media/video/videobuf2-dma-contig.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/videobuf2-dma-contig.c b/drivers/media/video/videobuf2-dma-contig.c
index 4b71326..7eee9c5 100644
--- a/drivers/media/video/videobuf2-dma-contig.c
+++ b/drivers/media/video/videobuf2-dma-contig.c
@@ -101,14 +101,31 @@ static unsigned int vb2_dma_contig_num_users(void *buf_priv)
 static int vb2_dma_contig_mmap(void *buf_priv, struct vm_area_struct *vma)
 {
 	struct vb2_dc_buf *buf = buf_priv;
+#ifdef ARCH_HAS_DMA_MMAP_COHERENT
+	int ret;
+#endif
 
 	if (!buf) {
 		printk(KERN_ERR "No buffer to map\n");
 		return -EINVAL;
 	}
 
+#ifdef ARCH_HAS_DMA_MMAP_COHERENT
+	ret = dma_mmap_coherent(buf->conf->dev, vma, buf->vaddr, buf->dma_addr,
+				buf->size);
+	if (ret) {
+		pr_err("Remapping memory failed, error: %d\n", ret);
+		return ret;
+	}
+	vma->vm_flags |= VM_DONTEXPAND | VM_RESERVED;
+	vma->vm_private_data = &buf->handler;
+	vma->vm_ops = &vb2_common_vm_ops;
+	vma->vm_ops->open(vma);
+	return 0;
+#else
 	return vb2_mmap_pfn_range(vma, buf->dma_addr, buf->size,
 				  &vb2_common_vm_ops, &buf->handler);
+#endif
 }
 
 static void *vb2_dma_contig_get_userptr(void *alloc_ctx, unsigned long vaddr,
-- 
1.7.0.4

