From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 08 May 2012 04:06:54 +0000
Subject: [PATCH 1/4] fbdev: sh_mobile_hdmi: add hdmi_bit_set() function
Message-Id: <87k40nmi3o.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/video/sh_mobile_hdmi.c |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index eafb19d..e201d6f 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -236,6 +236,16 @@ static u8 hdmi_read(struct sh_hdmi *hdmi, u8 reg)
 	return ioread8(hdmi->base + reg);
 }
 
+static void hdmi_bit_set(struct sh_hdmi *hdmi, u8 mask, u8 data, u8 reg)
+{
+	u8 val = hdmi_read(hdmi, reg);
+
+	val &= ~mask;
+	val |= (data & mask);
+
+	hdmi_write(hdmi, val, reg);
+}
+
 /*
  *	HDMI sound
  */
@@ -693,11 +703,11 @@ static void sh_hdmi_configure(struct sh_hdmi *hdmi)
 	msleep(10);
 
 	/* PS mode b->d, reset PLLA and PLLB */
-	hdmi_write(hdmi, 0x4C, HDMI_SYSTEM_CTRL);
+	hdmi_bit_set(hdmi, 0xFC, 0x4C, HDMI_SYSTEM_CTRL);
 
 	udelay(10);
 
-	hdmi_write(hdmi, 0x40, HDMI_SYSTEM_CTRL);
+	hdmi_bit_set(hdmi, 0xFC, 0x40, HDMI_SYSTEM_CTRL);
 }
 
 static unsigned long sh_hdmi_rate_error(struct sh_hdmi *hdmi,
@@ -917,13 +927,13 @@ static irqreturn_t sh_hdmi_hotplug(int irq, void *dev_id)
 	u8 status1, status2, mask1, mask2;
 
 	/* mode_b and PLLA and PLLB reset */
-	hdmi_write(hdmi, 0x2C, HDMI_SYSTEM_CTRL);
+	hdmi_bit_set(hdmi, 0xFC, 0x2C, HDMI_SYSTEM_CTRL);
 
 	/* How long shall reset be held? */
 	udelay(10);
 
 	/* mode_b and PLLA and PLLB reset release */
-	hdmi_write(hdmi, 0x20, HDMI_SYSTEM_CTRL);
+	hdmi_bit_set(hdmi, 0xFC, 0x20, HDMI_SYSTEM_CTRL);
 
 	status1 = hdmi_read(hdmi, HDMI_INTERRUPT_STATUS_1);
 	status2 = hdmi_read(hdmi, HDMI_INTERRUPT_STATUS_2);
@@ -1001,7 +1011,7 @@ static int sh_hdmi_display_on(struct sh_mobile_lcdc_entity *entity)
 	 */
 	if (hdmi->hp_state = HDMI_HOTPLUG_EDID_DONE) {
 		/* PS mode d->e. All functions are active */
-		hdmi_write(hdmi, 0x80, HDMI_SYSTEM_CTRL);
+		hdmi_bit_set(hdmi, 0xFC, 0x80, HDMI_SYSTEM_CTRL);
 		dev_dbg(hdmi->dev, "HDMI running\n");
 	}
 
@@ -1016,7 +1026,7 @@ static void sh_hdmi_display_off(struct sh_mobile_lcdc_entity *entity)
 
 	dev_dbg(hdmi->dev, "%s(%p)\n", __func__, hdmi);
 	/* PS mode e->a */
-	hdmi_write(hdmi, 0x10, HDMI_SYSTEM_CTRL);
+	hdmi_bit_set(hdmi, 0xFC, 0x10, HDMI_SYSTEM_CTRL);
 }
 
 static const struct sh_mobile_lcdc_entity_ops sh_hdmi_ops = {
-- 
1.7.5.4

