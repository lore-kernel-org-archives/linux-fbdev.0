From: Jyri Sarha <jsarha@ti.com>
Date: Wed, 22 Apr 2015 13:23:00 +0000
Subject: [PATCH 4/5] ASoC: omap-hdmi-audio: Force channel allocation only for OMAP4
Message-Id: <24329adf0076ff2ac004817a602c12db2ccc477d.1429705991.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1429705991.git.jsarha@ti.com>
In-Reply-To: <cover.1429705991.git.jsarha@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, misael.lopez@ti.com, Jyri Sarha <jsarha@ti.com>

From: Misael Lopez Cruz <misael.lopez@ti.com>

There is a constraint in the OMAP4 HDMI IP that requires to use
the 8-channel code when transmitting more than two channels.

The constraint doesn't apply for OMAP5 so don't force the channel
allocation in the sound driver as it can be done specifically for
OMAP4 later in the hdmi4 core.

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi4_core.c | 7 +++++++
 sound/soc/omap/omap-hdmi-audio.c           | 6 ++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi4_core.c b/drivers/video/fbdev/omap2/dss/hdmi4_core.c
index 2b8bd22..fa72e73 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4_core.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi4_core.c
@@ -654,6 +654,13 @@ static void hdmi_core_audio_infoframe_cfg(struct hdmi_core_data *core,
 	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(2), info_aud->db3);
 	sum += info_aud->db3;
 
+	/*
+	 * The OMAP HDMI IP requires to use the 8-channel channel code when
+	 * transmitting more than two channels.
+	 */
+	if (info_aud->db4_ca != 0x00)
+		info_aud->db4_ca = 0x13;
+
 	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(3), info_aud->db4_ca);
 	sum += info_aud->db4_ca;
 
diff --git a/sound/soc/omap/omap-hdmi-audio.c b/sound/soc/omap/omap-hdmi-audio.c
index 4775da4..8df303f 100644
--- a/sound/soc/omap/omap-hdmi-audio.c
+++ b/sound/soc/omap/omap-hdmi-audio.c
@@ -210,12 +210,10 @@ static int hdmi_dai_hw_params(struct snd_pcm_substream *substream,
 
 	cea->db3 = 0; /* not used, all zeros */
 
-	/*
-	 * The OMAP HDMI IP requires to use the 8-channel channel code when
-	 * transmitting more than two channels.
-	 */
 	if (params_channels(params) = 2)
 		cea->db4_ca = 0x0;
+	else if (params_channels(params) = 6)
+		cea->db4_ca = 0xb;
 	else
 		cea->db4_ca = 0x13;
 
-- 
1.9.1

