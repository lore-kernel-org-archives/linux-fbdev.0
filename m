From: Jyri Sarha <jsarha@ti.com>
Date: Fri, 23 May 2014 19:08:00 +0000
Subject: [PATCH 11/13] OMAPDSS: hdmi.h: Add HDMI_AUDIO_LAYOUT_6CH enum value
Message-Id: <c5ec3f922bb5ff84fecdc81c6516d42d9e388ec3.1400871999.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1400871999.git.jsarha@ti.com>
In-Reply-To: <cover.1400871999.git.jsarha@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

The OMAP5 HDMI audio implementation needs HDMI_AUDIO_LAYOUT_6CH in
hdmi_core_audio_layout enum. I found the correct value from ti-linux
3.8 tree.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index 3ddb5f8..c9efc92 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -159,7 +159,8 @@ enum hdmi_audio_blk_strt_end_sig {
 
 enum hdmi_core_audio_layout {
 	HDMI_AUDIO_LAYOUT_2CH = 0,
-	HDMI_AUDIO_LAYOUT_8CH = 1
+	HDMI_AUDIO_LAYOUT_8CH = 1,
+	HDMI_AUDIO_LAYOUT_6CH = 2
 };
 
 enum hdmi_core_cts_mode {
-- 
1.7.9.5

