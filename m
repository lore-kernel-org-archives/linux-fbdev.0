From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 01 Mar 2012 12:26:35 +0000
Subject: [PATCH 7/7] OMAPDSS: HDMI: hot plug detect fix
Message-Id: <1330604795-29156-8-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1330604795-29156-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1330604795-29156-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: stable@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Rob Clark <rob@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

From: Rob Clark <rob@ti.com>

The "OMAPDSS: HDMI: PHY burnout fix" commit switched the HDMI driver
over to using a GPIO for plug detect.  Unfortunately the ->detect()
method was not also updated, causing HDMI to no longer work for the
omapdrm driver (because it would actually check if a connection was
detected before attempting to enable display).

Signed-off-by: Rob Clark <rob@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index 3683404..aad48a1 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -479,14 +479,7 @@ int ti_hdmi_4xxx_read_edid(struct hdmi_ip_data *ip_data,
 
 bool ti_hdmi_4xxx_detect(struct hdmi_ip_data *ip_data)
 {
-	int r;
-
-	void __iomem *base = hdmi_core_sys_base(ip_data);
-
-	/* HPD */
-	r = REG_GET(base, HDMI_CORE_SYS_SYS_STAT, 1, 1);
-
-	return r = 1;
+	return gpio_get_value(ip_data->hpd_gpio);
 }
 
 static void hdmi_core_init(struct hdmi_core_video_config *video_cfg,
-- 
1.7.4.1

