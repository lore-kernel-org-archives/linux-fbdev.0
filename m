From: Timur Tabi <timur@freescale.com>
Date: Thu, 15 Sep 2011 21:44:57 +0000
Subject: [PATCH 12/13] drivers/video: fsl-diu-fb: the video buffer is not I/O memory
Message-Id: <1316123098-30967-13-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The video buffer is not uncached memory-mapped I/O, so don't tag the virtual
address as __iomem.  It's also not a u8*.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 include/linux/fsl-diu-fb.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/fsl-diu-fb.h b/include/linux/fsl-diu-fb.h
index 5ebffa6..35ac0c5 100644
--- a/include/linux/fsl-diu-fb.h
+++ b/include/linux/fsl-diu-fb.h
@@ -162,7 +162,7 @@ struct diu_hw {
 };
 
 struct diu_addr {
-	__u8 __iomem *vaddr;	/* Virtual address */
+	void *vaddr;		/* Virtual address */
 	dma_addr_t paddr;	/* Physical address */
 	__u32 	   offset;
 };
-- 
1.7.3.4


