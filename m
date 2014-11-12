From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 12 Nov 2014 11:52:17 +0000
Subject: [PATCH 15/22] OMAPDSS: HDMI5: disable interlace modes
Message-Id: <1415793144-11723-16-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

We don't support interlace modes properly on OMAP5+ HDMI, so we need to
reject interlace timings.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi5.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi5.c b/drivers/video/fbdev/omap2/dss/hdmi5.c
index 169b764bb9d4..c053d692ec16 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5.c
@@ -290,6 +290,10 @@ static int hdmi_display_check_timing(struct omap_dss_device *dssdev,
 {
 	struct omap_dss_device *out = &hdmi.output;
 
+	/* TODO: proper interlace support */
+	if (timings->interlace)
+		return -EINVAL;
+
 	if (!dispc_mgr_timings_ok(out->dispc_channel, timings))
 		return -EINVAL;
 
-- 
2.1.3

