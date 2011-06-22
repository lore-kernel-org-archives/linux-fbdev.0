From: Mythri P K <mythripk@ti.com>
Date: Wed, 22 Jun 2011 11:55:10 +0000
Subject: [PATCH 2/8] OMAP4 : DSS : HDMI : Move the EDID portion from HDMI IP
Message-Id: <1308742996-19230-3-git-send-email-mythripk@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Clean up to move the EDID definition to hdmi.c from the header file which is IP
dependent.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |   10 ++++++++++
 drivers/video/omap2/dss/hdmi.h |   10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 1d16ee2..4ee879a 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -49,6 +49,16 @@
 #define HDMI_PLLCTRL		0x200
 #define HDMI_PHY		0x300
 
+/* HDMI EDID Length move this */
+#define HDMI_EDID_MAX_LENGTH			256
+#define EDID_TIMING_DESCRIPTOR_SIZE		0x12
+#define EDID_DESCRIPTOR_BLOCK0_ADDRESS		0x36
+#define EDID_DESCRIPTOR_BLOCK1_ADDRESS		0x80
+#define EDID_SIZE_BLOCK0_TIMING_DESCRIPTOR	4
+#define EDID_SIZE_BLOCK1_TIMING_DESCRIPTOR	4
+
+#define OMAP_HDMI_TIMINGS_NB			34
+
 static struct {
 	struct mutex lock;
 	struct omap_display_platform_data *pdata;
diff --git a/drivers/video/omap2/dss/hdmi.h b/drivers/video/omap2/dss/hdmi.h
index 2281823..f57ef4a 100644
--- a/drivers/video/omap2/dss/hdmi.h
+++ b/drivers/video/omap2/dss/hdmi.h
@@ -182,16 +182,6 @@ struct hdmi_reg { u16 idx; };
 #define HDMI_TXPHY_POWER_CTRL			HDMI_REG(0x8)
 #define HDMI_TXPHY_PAD_CFG_CTRL			HDMI_REG(0xC)
 
-/* HDMI EDID Length  */
-#define HDMI_EDID_MAX_LENGTH			256
-#define EDID_TIMING_DESCRIPTOR_SIZE		0x12
-#define EDID_DESCRIPTOR_BLOCK0_ADDRESS		0x36
-#define EDID_DESCRIPTOR_BLOCK1_ADDRESS		0x80
-#define EDID_SIZE_BLOCK0_TIMING_DESCRIPTOR	4
-#define EDID_SIZE_BLOCK1_TIMING_DESCRIPTOR	4
-
-#define OMAP_HDMI_TIMINGS_NB			34
-
 #define REG_FLD_MOD(base, idx, val, start, end) \
 	hdmi_write_reg(base, idx, FLD_MOD(hdmi_read_reg(base, idx),\
 							val, start, end))
-- 
1.7.5.4

