From: Timur Tabi <timur@freescale.com>
Date: Tue, 16 Oct 2012 22:33:46 +0000
Subject: [PATCH 5/9] drivers/video: fsl-diu-fb: improve message displays
Message-Id: <1350426830-12140-5-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Add some debug and error messages that are useful during debugging.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |   34 +++++++++++++++++++++++++++++++++-
 1 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index f388c3a..6e32ba8 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -430,6 +430,22 @@ static struct mfb_info mfb_template[] = {
 	},
 };
 
+#ifdef DEBUG
+static void __attribute__ ((unused)) fsl_diu_dump(struct diu __iomem *hw)
+{
+	mb();
+	pr_debug("DIU: desc=%08x,%08x,%08x, gamma=%08x pallete=%08x "
+		 "cursor=%08x curs_pos=%08x diu_mode=%08x bgnd=%08x "
+		 "disp_size=%08x hsyn_para=%08x vsyn_para=%08x syn_pol=%08x "
+		 "thresholds=%08x int_mask=%08x plut=%08x\n",
+		 hw->desc[0], hw->desc[1], hw->desc[2], hw->gamma,
+		 hw->pallete, hw->cursor, hw->curs_pos, hw->diu_mode,
+		 hw->bgnd, hw->disp_size, hw->hsyn_para, hw->vsyn_para,
+		 hw->syn_pol, hw->thresholds, hw->int_mask, hw->plut);
+	rmb();
+}
+#endif
+
 /**
  * fsl_diu_name_to_port - convert a port name to a monitor port enum
  *
@@ -1108,6 +1124,12 @@ static int fsl_diu_ioctl(struct fb_info *info, unsigned int cmd,
 
 	if (!arg)
 		return -EINVAL;
+
+	dev_dbg(info->dev, "ioctl %08x (dir=%s%s type=%u nr=%u size=%u)\n", cmd,
+		_IOC_DIR(cmd) & _IOC_READ ? "R" : "",
+		_IOC_DIR(cmd) & _IOC_WRITE ? "W" : "",
+		_IOC_TYPE(cmd), _IOC_NR(cmd), _IOC_SIZE(cmd));
+
 	switch (cmd) {
 	case MFB_SET_PIXFMT_OLD:
 		dev_warn(info->dev,
@@ -1754,6 +1776,9 @@ static int __init fsl_diu_init(void)
 	coherence_data_size = be32_to_cpup(prop) * 13;
 	coherence_data_size /= 8;
 
+	pr_debug("fsl-diu-fb: coherence data size is %zu bytes\n",
+		 coherence_data_size);
+
 	prop = of_get_property(np, "d-cache-line-size", NULL);
 	if (prop = NULL) {
 		pr_err("fsl-diu-fb: missing 'd-cache-line-size' property' "
@@ -1763,10 +1788,17 @@ static int __init fsl_diu_init(void)
 	}
 	d_cache_line_size = be32_to_cpup(prop);
 
+	pr_debug("fsl-diu-fb: cache lines size is %u bytes\n",
+		 d_cache_line_size);
+
 	of_node_put(np);
 	coherence_data = vmalloc(coherence_data_size);
-	if (!coherence_data)
+	if (!coherence_data) {
+		pr_err("fsl-diu-fb: could not allocate coherence data "
+		       "(size=%zu)\n", coherence_data_size);
 		return -ENOMEM;
+	}
+
 #endif
 
 	ret = platform_driver_register(&fsl_diu_driver);
-- 
1.7.3.4


