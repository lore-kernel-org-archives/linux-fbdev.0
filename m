From: Jyri Sarha <jsarha@ti.com>
Date: Wed, 22 Apr 2015 13:23:01 +0000
Subject: [PATCH 5/5] ASoC: omap-hdmi-audio: Fix invalid combination of DM_INH and CA
Message-Id: <79f95cefe5f69f90698520adab90ce83b8539bf8.1429705991.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1429705991.git.jsarha@ti.com>
In-Reply-To: <cover.1429705991.git.jsarha@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, misael.lopez@ti.com, Jyri Sarha <jsarha@ti.com>

From: Misael Lopez Cruz <misael.lopez@ti.com>

DM_INH = 1 (stereo downmix prohibited) and CA = 0x00 (Channel
Allocation: FR, FL) is an invalid combination according to the
HDMI Compliance Test 7.31 "Audio InfoFrame".

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/omap/omap-hdmi-audio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/omap/omap-hdmi-audio.c b/sound/soc/omap/omap-hdmi-audio.c
index 8df303f..aeef25c 100644
--- a/sound/soc/omap/omap-hdmi-audio.c
+++ b/sound/soc/omap/omap-hdmi-audio.c
@@ -217,7 +217,11 @@ static int hdmi_dai_hw_params(struct snd_pcm_substream *substream,
 	else
 		cea->db4_ca = 0x13;
 
-	cea->db5_dminh_lsv = CEA861_AUDIO_INFOFRAME_DB5_DM_INH_PROHIBITED;
+	if (cea->db4_ca = 0x00)
+		cea->db5_dminh_lsv = CEA861_AUDIO_INFOFRAME_DB5_DM_INH_PERMITTED;
+	else
+		cea->db5_dminh_lsv = CEA861_AUDIO_INFOFRAME_DB5_DM_INH_PROHIBITED;
+
 	/* the expression is trivial but makes clear what we are doing */
 	cea->db5_dminh_lsv |= (0 & CEA861_AUDIO_INFOFRAME_DB5_LSV);
 
-- 
1.9.1

