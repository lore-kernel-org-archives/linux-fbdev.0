From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 08 May 2012 04:07:20 +0000
Subject: [PATCH 2/4] fbdev: sh_mobile_hdmi: add interrupt output option
Message-Id: <87ipg7mi2z.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/video/sh_mobile_hdmi.c |    7 +++++++
 include/video/sh_mobile_hdmi.h |    8 +++++++-
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index e201d6f..0bc39bc 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -1186,6 +1186,13 @@ static int __init sh_hdmi_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
+	/* init interrupt polarity */
+	if (pdata->flags & HDMI_OUTPUT_PUSH_PULL)
+		hdmi_bit_set(hdmi, 0x02, 0x02, HDMI_SYSTEM_CTRL);
+
+	if (pdata->flags & HDMI_OUTPUT_POLARITY_HI)
+		hdmi_bit_set(hdmi, 0x01, 0x01, HDMI_SYSTEM_CTRL);
+
 	/* Product and revision IDs are 0 in sh-mobile version */
 	dev_info(&pdev->dev, "Detected HDMI controller 0x%x:0x%x\n",
 		 hdmi_read(hdmi, HDMI_PRODUCT_ID), hdmi_read(hdmi, HDMI_REVISION_ID));
diff --git a/include/video/sh_mobile_hdmi.h b/include/video/sh_mobile_hdmi.h
index 728f9de..2699635 100644
--- a/include/video/sh_mobile_hdmi.h
+++ b/include/video/sh_mobile_hdmi.h
@@ -18,9 +18,10 @@ struct clk;
 /*
  * flags format
  *
- * 0x0000000A
+ * 0x000000BA
  *
  * A: Audio source select
+ * B: Int output option
  */
 
 /* Audio source select */
@@ -30,6 +31,11 @@ struct clk;
 #define HDMI_SND_SRC_DSD	(2 << 0)
 #define HDMI_SND_SRC_HBR	(3 << 0)
 
+/* Int output option */
+#define HDMI_OUTPUT_PUSH_PULL	(1 << 4) /* System control : output mode */
+#define HDMI_OUTPUT_POLARITY_HI	(1 << 5) /* System control : output polarity */
+
+
 struct sh_mobile_hdmi_info {
 	unsigned int			 flags;
 	long (*clk_optimize_parent)(unsigned long target, unsigned long *best_freq,
-- 
1.7.5.4

