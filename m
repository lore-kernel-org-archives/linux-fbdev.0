From: Archit Taneja <archit@ti.com>
Date: Fri, 13 Sep 2013 10:41:32 +0000
Subject: [PATCH 1/7] OMAPDSS: HDMI: OMAP4: Complete register definitions for wrapper
Message-Id: <1379068178-17312-2-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1379068178-17312-1-git-send-email-archit@ti.com>
In-Reply-To: <1379068178-17312-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>, Archit Taneja <archit@ti.com>

From: Ricardo Neri <ricardo.neri@ti.com>

Add definitions for missing registers in the HDMI wrapper. Also, order
the registers by offset to improve readability.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
index 6ef2f92..469d436 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
@@ -31,9 +31,11 @@
 #define HDMI_WP_SYSCONFIG			0x10
 #define HDMI_WP_IRQSTATUS_RAW			0x24
 #define HDMI_WP_IRQSTATUS			0x28
-#define HDMI_WP_PWR_CTRL			0x40
 #define HDMI_WP_IRQENABLE_SET			0x2C
 #define HDMI_WP_IRQENABLE_CLR			0x30
+#define HDMI_WP_IRQWAKEEN			0x34
+#define HDMI_WP_PWR_CTRL			0x40
+#define HDMI_WP_DEBOUNCE			0x44
 #define HDMI_WP_VIDEO_CFG			0x50
 #define HDMI_WP_VIDEO_SIZE			0x60
 #define HDMI_WP_VIDEO_TIMING_H			0x68
-- 
1.8.1.2

