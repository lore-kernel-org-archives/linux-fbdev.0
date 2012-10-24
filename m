From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 24 Oct 2012 09:29:04 +0000
Subject: [PATCH 13/20] OMAPDSS: HDMI: add 1920x1200 video mode
Message-Id: <1351070951-18616-14-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Ricardo Neri <ricardo.neri@ti.com>

Add 1920x1200 video mode to hdmi driver's static modelist.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index b809490..dfbc1e7 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -295,6 +295,12 @@ static const struct hdmi_config vesa_timings[] = {
 			false, },
 		{ 0x55, HDMI_DVI },
 	},
+	{
+		{ 1920, 1200, 154000, 32, 48, 80, 6, 3, 26,
+			OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_HIGH,
+			false, },
+		{ 0x44, HDMI_DVI },
+	},
 };
 
 static int hdmi_runtime_get(void)
-- 
1.7.9.5

