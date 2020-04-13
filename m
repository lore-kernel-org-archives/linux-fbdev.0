From: R Veera Kumar <vkor@vkten.in>
Date: Mon, 13 Apr 2020 16:19:53 +0000
Subject: [PATCH] staging: sm750fb: Make function arguments alignment match open parenthesis
Message-Id: <20200413160753.3787-1-vkor@vkten.in>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, R Veera Kumar <vkor@vkten.in>, Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Make function arguments alignment match open parenthesis.
Found using checkpatch.pl.

Signed-off-by: R Veera Kumar <vkor@vkten.in>
---
 drivers/staging/sm750fb/sm750.h    | 23 +++++++++++++----------
 drivers/staging/sm750fb/sm750_hw.c |  2 +-
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index ce90adcb449d..55fe5a28a174 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -59,16 +59,19 @@ struct lynx_accel {
 
 	int (*de_wait)(void);/* see if hardware ready to work */
 
-	int (*de_fillrect)(struct lynx_accel *, u32, u32, u32, u32,
-						u32, u32, u32, u32, u32);
-
-	int (*de_copyarea)(struct lynx_accel *, u32, u32, u32, u32,
-						u32, u32, u32, u32,
-						u32, u32, u32, u32);
-
-	int (*de_imageblit)(struct lynx_accel *, const char *, u32, u32, u32, u32,
-							       u32, u32, u32, u32,
-							       u32, u32, u32, u32);
+	int (*de_fillrect)(struct lynx_accel *,
+			   u32, u32, u32, u32,
+			   u32, u32, u32, u32, u32);
+
+	int (*de_copyarea)(struct lynx_accel *,
+			   u32, u32, u32, u32,
+			   u32, u32, u32, u32,
+			   u32, u32, u32, u32);
+
+	int (*de_imageblit)(struct lynx_accel *, const char *,
+			    u32, u32, u32, u32,
+			    u32, u32, u32, u32,
+			    u32, u32, u32, u32);
 
 };
 
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index b8d60701f898..7136d751cff5 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -51,7 +51,7 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 
 	/* now map mmio and vidmem */
 	sm750_dev->pvReg = ioremap(sm750_dev->vidreg_start,
-					   sm750_dev->vidreg_size);
+				   sm750_dev->vidreg_size);
 	if (!sm750_dev->pvReg) {
 		pr_err("mmio failed\n");
 		ret = -EFAULT;
-- 
2.20.1
