From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 02 Nov 2010 10:47:47 +0000
Subject: [PATCH 4/4 v2] fbdev: sh_mobile_hdmi: add support for E-EDID parsing
Message-Id: <Pine.LNX.4.64.1011021145570.4552@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Many HDMI clients implement enhanced EDID blocks, which often contain
additional supported video modes. This patch implements parsing of such
E-EDID blocks.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v2: no change

 drivers/video/sh_mobile_hdmi.c |   60 ++++++++++++++++++++++++++++++++-------
 1 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index c474b0bd..b3241dd 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -210,6 +210,9 @@ struct sh_hdmi {
 	void __iomem *base;
 	enum hotplug_state hp_state;	/* hot-plug status */
 	bool preprogrammed_mode;	/* use a pre-programmed VIC or the external mode */
+	u8 edid_block_addr;
+	u8 edid_segment_nr;
+	u8 edid_blocks;
 	struct clk *hdmi_clk;
 	struct device *dev;
 	struct fb_info *info;
@@ -750,7 +753,38 @@ static int sh_hdmi_read_edid(struct sh_hdmi *hdmi, unsigned long *hdmi_rate,
 	printk(KERN_CONT "\n");
 #endif
 
-	fb_edid_to_monspecs(edid, &hdmi->monspec);
+	if (!hdmi->edid_blocks) {
+		fb_edid_to_monspecs(edid, &hdmi->monspec);
+		hdmi->edid_blocks = edid[126] + 1;
+
+		dev_dbg(hdmi->dev, "%d main modes, %d extension blocks\n",
+			hdmi->monspec.modedb_len, hdmi->edid_blocks - 1);
+	} else {
+		dev_dbg(hdmi->dev, "Extension %u detected, DTD start %u\n",
+			edid[0], edid[2]);
+		fb_edid_add_monspecs(edid, &hdmi->monspec);
+	}
+
+	if (hdmi->edid_blocks > hdmi->edid_segment_nr * 2 +
+	    (hdmi->edid_block_addr >> 7) + 1) {
+		/* More blocks to read */
+		if (hdmi->edid_block_addr) {
+			hdmi->edid_block_addr = 0;
+			hdmi->edid_segment_nr++;
+		} else {
+			hdmi->edid_block_addr = 0x80;
+		}
+		/* Set EDID word address  */
+		hdmi_write(hdmi, hdmi->edid_block_addr, HDMI_EDID_WORD_ADDRESS);
+		/* Enable EDID interrupt */
+		hdmi_write(hdmi, 0xC6, HDMI_INTERRUPT_MASK_1);
+		/* Set EDID segment pointer - starts reading EDID */
+		hdmi_write(hdmi, hdmi->edid_segment_nr, HDMI_EDID_SEGMENT_POINTER);
+		return -EAGAIN;
+	}
+
+	/* All E-EDID blocks ready */
+	dev_dbg(hdmi->dev, "%d main and extended modes\n", hdmi->monspec.modedb_len);
 
 	fb_get_options("sh_mobile_lcdc", &forced);
 	if (forced && *forced) {
@@ -889,32 +923,34 @@ static irqreturn_t sh_hdmi_hotplug(int irq, void *dev_id)
 		/* Check, if hot plug & MSENS pin status are both high */
 		if ((msens & 0xC0) = 0xC0) {
 			/* Display plug in */
+			hdmi->edid_segment_nr = 0;
+			hdmi->edid_block_addr = 0;
+			hdmi->edid_blocks = 0;
 			hdmi->hp_state = HDMI_HOTPLUG_CONNECTED;
 
 			/* Set EDID word address  */
 			hdmi_write(hdmi, 0x00, HDMI_EDID_WORD_ADDRESS);
-			/* Set EDID segment pointer */
-			hdmi_write(hdmi, 0x00, HDMI_EDID_SEGMENT_POINTER);
 			/* Enable EDID interrupt */
 			hdmi_write(hdmi, 0xC6, HDMI_INTERRUPT_MASK_1);
+			/* Set EDID segment pointer - starts reading EDID */
+			hdmi_write(hdmi, 0x00, HDMI_EDID_SEGMENT_POINTER);
 		} else if (!(status1 & 0x80)) {
 			/* Display unplug, beware multiple interrupts */
-			if (hdmi->hp_state != HDMI_HOTPLUG_DISCONNECTED)
+			if (hdmi->hp_state != HDMI_HOTPLUG_DISCONNECTED) {
+				hdmi->hp_state = HDMI_HOTPLUG_DISCONNECTED;
 				schedule_delayed_work(&hdmi->edid_work, 0);
-
-			hdmi->hp_state = HDMI_HOTPLUG_DISCONNECTED;
+			}
 			/* display_off will switch back to mode_a */
 		}
 	} else if (status1 & 2) {
 		/* EDID error interrupt: retry */
 		/* Set EDID word address  */
-		hdmi_write(hdmi, 0x00, HDMI_EDID_WORD_ADDRESS);
+		hdmi_write(hdmi, hdmi->edid_block_addr, HDMI_EDID_WORD_ADDRESS);
 		/* Set EDID segment pointer */
-		hdmi_write(hdmi, 0x00, HDMI_EDID_SEGMENT_POINTER);
+		hdmi_write(hdmi, hdmi->edid_segment_nr, HDMI_EDID_SEGMENT_POINTER);
 	} else if (status1 & 4) {
 		/* Disable EDID interrupt */
 		hdmi_write(hdmi, 0xC0, HDMI_INTERRUPT_MASK_1);
-		hdmi->hp_state = HDMI_HOTPLUG_EDID_DONE;
 		schedule_delayed_work(&hdmi->edid_work, msecs_to_jiffies(10));
 	}
 
@@ -1043,7 +1079,7 @@ static void sh_hdmi_edid_work_fn(struct work_struct *work)
 
 	mutex_lock(&hdmi->mutex);
 
-	if (hdmi->hp_state = HDMI_HOTPLUG_EDID_DONE) {
+	if (hdmi->hp_state = HDMI_HOTPLUG_CONNECTED) {
 		unsigned long parent_rate = 0, hdmi_rate;
 
 		/* A device has been plugged in */
@@ -1053,6 +1089,8 @@ static void sh_hdmi_edid_work_fn(struct work_struct *work)
 		if (ret < 0)
 			goto out;
 
+		hdmi->hp_state = HDMI_HOTPLUG_EDID_DONE;
+
 		/* Reconfigure the clock */
 		ret = sh_hdmi_clk_configure(hdmi, hdmi_rate, parent_rate);
 		if (ret < 0)
@@ -1103,7 +1141,7 @@ static void sh_hdmi_edid_work_fn(struct work_struct *work)
 	}
 
 out:
-	if (ret < 0)
+	if (ret < 0 && ret != -EAGAIN)
 		hdmi->hp_state = HDMI_HOTPLUG_DISCONNECTED;
 	mutex_unlock(&hdmi->mutex);
 
-- 
1.7.2.3

