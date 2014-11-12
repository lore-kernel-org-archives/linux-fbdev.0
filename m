From: Jyri Sarha <jsarha@ti.com>
Date: Wed, 12 Nov 2014 10:49:08 +0000
Subject: [PATCH v7 06/20] OMAPDSS: omapdss.h: Remove audio_state member of struct omap_dss_device
Message-Id: <2c129e22e96eba98ec1d825d01c25571272da13b.1415786458.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1415786458.git.jsarha@ti.com>
In-Reply-To: <cover.1415786458.git.jsarha@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, Jyri Sarha <jsarha@ti.com>

The audio_state member is not used.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 include/video/omapdss.h |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 069dfca..9f2699f 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -166,13 +166,6 @@ enum omap_dss_display_state {
 	OMAP_DSS_DISPLAY_ACTIVE,
 };
 
-enum omap_dss_audio_state {
-	OMAP_DSS_AUDIO_DISABLED = 0,
-	OMAP_DSS_AUDIO_ENABLED,
-	OMAP_DSS_AUDIO_CONFIGURED,
-	OMAP_DSS_AUDIO_PLAYING,
-};
-
 struct omap_dss_audio {
 	struct snd_aes_iec958 *iec;
 	struct snd_cea_861_aud_if *cea;
@@ -783,8 +776,6 @@ struct omap_dss_device {
 
 	enum omap_dss_display_state state;
 
-	enum omap_dss_audio_state audio_state;
-
 	/* OMAP DSS output specific fields */
 
 	struct list_head list;
-- 
1.7.9.5

