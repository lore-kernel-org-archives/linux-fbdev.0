From: Archit Taneja <archit@ti.com>
Date: Fri, 13 Sep 2013 10:41:33 +0000
Subject: [PATCH 2/7] OMAPDSS: HDMI: OMAP4: Complete dumping of wrapper registers
Message-Id: <1379068178-17312-3-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1379068178-17312-1-git-send-email-archit@ti.com>
In-Reply-To: <1379068178-17312-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>, Archit Taneja <archit@ti.com>

From: Ricardo Neri <ricardo.neri@ti.com>

Add missing registers when dumping the HDMI wrapper. Also, order the dump by
offset to improve readability.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index 3dfe009..ecadd7a 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -859,8 +859,11 @@ void ti_hdmi_4xxx_wp_dump(struct hdmi_ip_data *ip_data, struct seq_file *s)
 	DUMPREG(HDMI_WP_SYSCONFIG);
 	DUMPREG(HDMI_WP_IRQSTATUS_RAW);
 	DUMPREG(HDMI_WP_IRQSTATUS);
-	DUMPREG(HDMI_WP_PWR_CTRL);
 	DUMPREG(HDMI_WP_IRQENABLE_SET);
+	DUMPREG(HDMI_WP_IRQENABLE_CLR);
+	DUMPREG(HDMI_WP_IRQWAKEEN);
+	DUMPREG(HDMI_WP_PWR_CTRL);
+	DUMPREG(HDMI_WP_DEBOUNCE);
 	DUMPREG(HDMI_WP_VIDEO_CFG);
 	DUMPREG(HDMI_WP_VIDEO_SIZE);
 	DUMPREG(HDMI_WP_VIDEO_TIMING_H);
-- 
1.8.1.2

