From: Timur Tabi <timur@freescale.com>
Date: Wed, 05 Oct 2011 00:36:45 +0000
Subject: [PATCH 2/9] drivers/video: fsl-diu-fb: move some definitions out of the header file
Message-Id: <1317775012-9797-2-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Move several macros and structures from the Freescale DIU driver's header
file into the source file, because they're only used by that file.  Also
delete a few unused macros.

The diu and diu_ad structures cannot be moved because they're being used
by the MPC5121 platform file.  A future patch eliminate the need for
the platform file to access these structs, so they'll be moved also.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |   39 ++++++++++++++++++++++++++++++++++++
 include/linux/fsl-diu-fb.h |   47 --------------------------------------------
 2 files changed, 39 insertions(+), 47 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 9a1f6d2..9b3891a 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -30,11 +30,50 @@
 #include <linux/clk.h>
 #include <linux/uaccess.h>
 #include <linux/vmalloc.h>
+#include <linux/spinlock.h>
 
 #include <sysdev/fsl_soc.h>
 #include <linux/fsl-diu-fb.h>
 #include "edid.h"
 
+#define FSL_AOI_NUM	6	/* 5 AOIs and one dummy AOI */
+				/* 1 for plane 0, 2 for plane 1&2 each */
+
+/* HW cursor parameters */
+#define MAX_CURS		32
+
+/* INT_STATUS/INT_MASK field descriptions */
+#define INT_VSYNC	0x01	/* Vsync interrupt  */
+#define INT_VSYNC_WB	0x02	/* Vsync interrupt for write back operation */
+#define INT_UNDRUN	0x04	/* Under run exception interrupt */
+#define INT_PARERR	0x08	/* Display parameters error interrupt */
+#define INT_LS_BF_VS	0x10	/* Lines before vsync. interrupt */
+
+/* Panels'operation modes */
+#define MFB_TYPE_OUTPUT	0	/* Panel output to display */
+#define MFB_TYPE_OFF	1	/* Panel off */
+#define MFB_TYPE_WB	2	/* Panel written back to memory */
+#define MFB_TYPE_TEST	3	/* Panel generate color bar */
+
+struct diu_hw {
+	struct diu __iomem *diu_reg;
+	spinlock_t reg_lock;
+	unsigned int mode;		/* DIU operation mode */
+};
+
+struct diu_addr {
+	void *vaddr;		/* Virtual address */
+	dma_addr_t paddr;	/* Physical address */
+	__u32 offset;
+};
+
+struct diu_pool {
+	struct diu_addr ad;
+	struct diu_addr gamma;
+	struct diu_addr pallete;
+	struct diu_addr cursor;
+};
+
 /*
  * List of supported video modes
  *
diff --git a/include/linux/fsl-diu-fb.h b/include/linux/fsl-diu-fb.h
index e19c531..363d5e2 100644
--- a/include/linux/fsl-diu-fb.h
+++ b/include/linux/fsl-diu-fb.h
@@ -56,7 +56,6 @@ struct aoi_display_offset {
 #define MFB_GET_PIXFMT_OLD	0x40014d08
 
 #ifdef __KERNEL__
-#include <linux/spinlock.h>
 
 /*
  * These are the fields of area descriptor(in DDR memory) for every plane
@@ -154,39 +153,6 @@ struct diu {
 	__be32 plut;
 } __attribute__ ((packed));
 
-struct diu_hw {
-	struct diu *diu_reg;
-	spinlock_t reg_lock;
-
-	__u32 mode;		/* DIU operation mode */
-};
-
-struct diu_addr {
-	void *vaddr;		/* Virtual address */
-	dma_addr_t paddr;	/* Physical address */
-	__u32 	   offset;
-};
-
-struct diu_pool {
-	struct diu_addr ad;
-	struct diu_addr gamma;
-	struct diu_addr pallete;
-	struct diu_addr cursor;
-};
-
-#define FSL_DIU_BASE_OFFSET	0x2C000	/* Offset of DIU */
-#define INT_LCDC		64	/* DIU interrupt number */
-
-#define FSL_AOI_NUM	6	/* 5 AOIs and one dummy AOI */
-				/* 1 for plane 0, 2 for plane 1&2 each */
-
-/* Minimum X and Y resolutions */
-#define MIN_XRES	64
-#define MIN_YRES	64
-
-/* HW cursor parameters */
-#define MAX_CURS		32
-
 /* Modes of operation of DIU */
 #define MFB_MODE0	0	/* DIU off */
 #define MFB_MODE1	1	/* All three planes output to display */
@@ -194,18 +160,5 @@ struct diu_pool {
 #define MFB_MODE3	3	/* All three planes written back to memory */
 #define MFB_MODE4	4	/* Color bar generation */
 
-/* INT_STATUS/INT_MASK field descriptions */
-#define INT_VSYNC	0x01	/* Vsync interrupt  */
-#define INT_VSYNC_WB	0x02	/* Vsync interrupt for write back operation */
-#define INT_UNDRUN	0x04	/* Under run exception interrupt */
-#define INT_PARERR	0x08	/* Display parameters error interrupt */
-#define INT_LS_BF_VS	0x10	/* Lines before vsync. interrupt */
-
-/* Panels'operation modes */
-#define MFB_TYPE_OUTPUT	0	/* Panel output to display */
-#define MFB_TYPE_OFF	1	/* Panel off */
-#define MFB_TYPE_WB	2	/* Panel written back to memory */
-#define MFB_TYPE_TEST	3	/* Panel generate color bar */
-
 #endif /* __KERNEL__ */
 #endif /* __FSL_DIU_FB_H__ */
-- 
1.7.4.4


