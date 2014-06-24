From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 24 Jun 2014 10:03:49 +0000
Subject: [PATCH 04/15] OMAPDSS: HDMI: fix name conflict
Message-Id: <1403604240-16738-5-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

OMAP HDMI driver has an 'enum hdmi_audio_sample_size', which conflicts
with the common include/linux/hdmi.h.

Change the name of the OMAP specific enum with '_omap" postfix.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index fbee07816337..1a62dc3fe54e 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -142,7 +142,7 @@ enum hdmi_audio_samples_perword {
 	HDMI_AUDIO_ONEWORD_TWOSAMPLES = 1
 };
 
-enum hdmi_audio_sample_size {
+enum hdmi_audio_sample_size_omap {
 	HDMI_AUDIO_SAMPLE_16BITS = 0,
 	HDMI_AUDIO_SAMPLE_24BITS = 1
 };
@@ -260,7 +260,7 @@ struct hdmi_audio_format {
 	enum hdmi_audio_justify			justification;
 	enum hdmi_audio_sample_order		sample_order;
 	enum hdmi_audio_samples_perword		samples_per_word;
-	enum hdmi_audio_sample_size		sample_size;
+	enum hdmi_audio_sample_size_omap	sample_size;
 	enum hdmi_audio_blk_strt_end_sig	en_sig_blk_strt_end;
 };
 
-- 
1.9.1

