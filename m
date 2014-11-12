From: Jyri Sarha <jsarha@ti.com>
Date: Wed, 12 Nov 2014 10:49:14 +0000
Subject: [PATCH v7 12/20] OMAPDSS: hdmi: Make hdmi_mode_has_audio() more user friedly
Message-Id: <97efa2bcd059396141c672971e22660c95d889c6.1415786458.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1415786458.git.jsarha@ti.com>
In-Reply-To: <cover.1415786458.git.jsarha@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, Jyri Sarha <jsarha@ti.com>

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index a6e08ff..6d129f2 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -345,9 +345,9 @@ void hdmi_wp_audio_config_format(struct hdmi_wp_data *wp,
 		struct hdmi_audio_format *aud_fmt);
 void hdmi_wp_audio_config_dma(struct hdmi_wp_data *wp,
 		struct hdmi_audio_dma *aud_dma);
-static inline bool hdmi_mode_has_audio(int mode)
+static inline bool hdmi_mode_has_audio(struct hdmi_config *cfg)
 {
-	return mode = HDMI_HDMI ? true : false;
+	return cfg->hdmi_dvi_mode = HDMI_HDMI ? true : false;
 }
 
 /* HDMI DRV data */
-- 
1.7.9.5

