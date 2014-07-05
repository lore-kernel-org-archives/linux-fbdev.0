From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sat, 05 Jul 2014 12:40:06 +0000
Subject: [PATCH] video: fbdev: omap2: dss: hdmi4_core.c:  Cleaning up variable that is never used
Message-Id: <1404564007-21024-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rickard Strandqvist <rickard.strandqvist@sonymobile.com>, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Archit Taneja <archit@ti.com>, Ricardo Neri <ricardo.neri@ti.com>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Mythri P K <mythripk@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Rickard Strandqvist <rickard.strandqvist@sonymobile.com>

Variable ar assigned a value that is never used.
I have also removed all the code that thereby serves no purpose.

This was found using a static code analysis program called cppcheck

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/fbdev/omap2/dss/hdmi4_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi4_core.c b/drivers/video/fbdev/omap2/dss/hdmi4_core.c
index 8bde7b7..0af76d2 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4_core.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi4_core.c
@@ -796,7 +796,7 @@ int hdmi4_audio_config(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
 	struct hdmi_audio_format audio_format;
 	struct hdmi_audio_dma audio_dma;
 	struct hdmi_core_audio_config acore;
-	int err, n, cts, channel_count;
+	int n, cts, channel_count;
 	unsigned int fs_nr;
 	bool word_length_16b = false;
 
@@ -858,7 +858,7 @@ int hdmi4_audio_config(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
 		return -EINVAL;
 	}
 
-	err = hdmi_compute_acr(pclk, fs_nr, &n, &cts);
+	hdmi_compute_acr(pclk, fs_nr, &n, &cts);
 
 	/* Audio clock regeneration settings */
 	acore.n = n;
-- 
1.7.10.4

