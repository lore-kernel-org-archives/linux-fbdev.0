From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Date: Thu, 01 Oct 2015 16:50:17 +0000
Subject: [PATCH RFC V2 1/5] video: hdmi: add helper function for N and CTS
Message-Id: <1443718221-5120-2-git-send-email-arnaud.pouliquen@st.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1443718221-5120-1-git-send-email-arnaud.pouliquen@st.com>
In-Reply-To: <1443718221-5120-1-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org
Cc: moinejf@free.fr, linux-fbdev@vger.kernel.org, linux@arm.linux.org.uk, bcousson@baylibre.com, David Airlie <airlied@linux.ie>, tomi.valkeinen@ti.com, arnaud.pouliquen@st.com, lgirdwood@gmail.com, Jyri Sarha <jsarha@ti.com>, peter.ujfalusi@ti.com, Takashi Iwai <tiwai@suse.de>, tony@atomide.com, broonie@kernel.org, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

Add helper function to compute HDMI CTS and N parameters
Implementation is based on HDMI 1.4b specification.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: linux-fbdev@vger.kernel.org
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/hdmi.c | 147 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/hdmi.h |  12 +++++
 2 files changed, 159 insertions(+)

diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
index 1626892..93e2fdf 100644
--- a/drivers/video/hdmi.c
+++ b/drivers/video/hdmi.c
@@ -1242,3 +1242,150 @@ int hdmi_infoframe_unpack(union hdmi_infoframe *frame, void *buffer)
 	return ret;
 }
 EXPORT_SYMBOL(hdmi_infoframe_unpack);
+
+/**
+ * audio clock regeneration (acr) parameters
+ * N and CTS computation are based on HDMI specification 1.4b
+ */
+enum audio_rate {
+	HDMI_AUDIO_N_CTS_32KHZ,
+	HDMI_AUDIO_N_CTS_44_1KHZ,
+	HDMI_AUDIO_N_CTS_48KHZ,
+};
+
+struct hdmi_audio_acr {
+	unsigned long pixel_clk;
+	struct hdmi_audio_n_cts n_cts;
+};
+
+static const struct hdmi_audio_acr hdmi_audio_standard_acr[3][12] = {
+	{ /*32 kHz*/
+		{  25175, {  4576,  28125 } }, /* 25,20/1.001  MHz */
+		{  25200, {  4096,  25200 } }, /* 25.20        MHz */
+		{  27000, {  4096,  27000 } }, /* 27.00        MHz */
+		{  27027, {  4096,  27027 } }, /* 27.00*1.001  MHz */
+		{  54000, {  4096,  54000 } }, /* 54.00        MHz */
+		{  54054, {  4096,  54054 } }, /* 54.00*1.001  MHz */
+		{  74176, { 11648, 310938 } }, /* 74.25/1.001  MHz */
+		{  74250, {  4096,  74250 } }, /* 74.25        MHz */
+		{ 148352, { 11648, 421875 } }, /* 148.50/1.001 MHz */
+		{ 148500, {  4096, 148500 } }, /* 148.50       MHz */
+		{ 296703, {  5824, 421875 } }, /* 297/1.001    MHz */
+		{ 297000, {  3072, 222750 } }, /* 297          MHz */
+	},
+	{ /*44.1 kHz, 88.2 kHz  176.4 kHz*/
+		{  25175, {  7007,  31250 } }, /* 25,20/1.001  MHz */
+		{  25200, {  6272,  28000 } }, /* 25.20        MHz */
+		{  27000, {  6272,  30000 } }, /* 27.00        MHz */
+		{  27027, {  6272,  30030 } }, /* 27.00*1.001  MHz */
+		{  54000, {  6272,  60000 } }, /* 54.00        MHz */
+		{  54054, {  6272,  60060 } }, /* 54.00*1.001  MHz */
+		{  74176, { 17836, 234375 } }, /* 74.25/1.001  MHz */
+		{  74250, {  6272,  82500 } }, /* 74.25        MHz */
+		{ 148352, {  8918, 234375 } }, /* 148.50/1.001 MHz */
+		{ 148500, {  6272, 165000 } }, /* 148.50       MHz */
+		{ 296703, {  4459, 234375 } }, /* 297/1.001    MHz */
+		{ 297000, {  4704, 247500 } }, /* 297          MHz */
+	},
+	{ /*48 kHz, 96 kHz  192 kHz*/
+		{  25175, {  6864,  28125 } }, /* 25,20/1.001  MHz */
+		{  25200, {  6144,  25200 } }, /* 25.20        MHz */
+		{  27000, {  6144,  27000 } }, /* 27.00        MHz */
+		{  27027, {  6144,  27027 } }, /* 27.00*1.001  MHz */
+		{  54000, {  6144,  54000 } }, /* 54.00        MHz */
+		{  54054, {  6144,  54054 } }, /* 54.00*1.001  MHz */
+		{  74176, { 11648, 140625 } }, /* 74.25/1.001  MHz */
+		{  74250, {  6144,  74250 } }, /* 74.25        MHz */
+		{ 148352, {  5824, 140625 } }, /* 148.50/1.001 MHz */
+		{ 148500, {  6144, 148500 } }, /* 148.50       MHz */
+		{ 296703, {  5824, 281250 } }, /* 297/1.001    MHz */
+		{ 297000, {  5120, 247500 } }, /* 297          MHz */
+	}
+};
+
+/**
+ * hdmi_compute_n_cts() - compute N and CTS parameters
+ * @audio_fs: audio frame clock frequency in KHz
+ * @pixel_clk: pixel cloack frequency in kHz
+ * @n_cts: N and CTS parameter returned to user
+ *
+ * Values computed are based on table described in HDMI specification 1.4b
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int hdmi_audio_compute_n_cts(enum hdmi_audio_sample_frequency audio_fs,
+			     unsigned long pixel_clk,
+			     struct hdmi_audio_n_cts *n_cts)
+{
+	int audio_freq_id, i;
+	int ratio = 1;
+	const struct hdmi_audio_acr  *acr_table;
+	const struct hdmi_audio_n_cts *predef_n_cts = NULL;
+
+	switch (audio_fs) {
+	case HDMI_AUDIO_SAMPLE_FREQUENCY_32000:
+		audio_freq_id = HDMI_AUDIO_N_CTS_32KHZ;
+		n_cts->n = 4096;
+		break;
+
+	case HDMI_AUDIO_SAMPLE_FREQUENCY_44100:
+		audio_freq_id = HDMI_AUDIO_N_CTS_44_1KHZ;
+		n_cts->n = 6272;
+		break;
+
+	case HDMI_AUDIO_SAMPLE_FREQUENCY_48000:
+		audio_freq_id = HDMI_AUDIO_N_CTS_48KHZ;
+		n_cts->n = 6144;
+		break;
+
+	case HDMI_AUDIO_SAMPLE_FREQUENCY_88200:
+		audio_freq_id = HDMI_AUDIO_N_CTS_44_1KHZ;
+		ratio = 2;
+		n_cts->n = 6272 * 2;
+		break;
+
+	case HDMI_AUDIO_SAMPLE_FREQUENCY_96000:
+		audio_freq_id = HDMI_AUDIO_N_CTS_48KHZ;
+		ratio = 2;
+		n_cts->n = 6144 * 2;
+		break;
+
+	case HDMI_AUDIO_SAMPLE_FREQUENCY_176400:
+		audio_freq_id = HDMI_AUDIO_N_CTS_44_1KHZ;
+		ratio = 2;
+		n_cts->n = 6272 * 4;
+		break;
+
+	case HDMI_AUDIO_SAMPLE_FREQUENCY_192000:
+		audio_freq_id = HDMI_AUDIO_N_CTS_48KHZ;
+		ratio = 4;
+		n_cts->n = 6144 * 4;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	acr_table = hdmi_audio_standard_acr[audio_freq_id];
+	for (i = 0; i < ARRAY_SIZE(hdmi_audio_standard_acr[0]); i++) {
+		if (pixel_clk = acr_table[i].pixel_clk) {
+			predef_n_cts = &acr_table[i].n_cts;
+			break;
+		}
+	}
+
+	if (!predef_n_cts) {
+		/*
+		 * predefined frequency not found. Compute CTS using formula:
+		 * CTS = (Ftdms_clk * N) / (128* audio_fs)
+		 */
+		n_cts->cts =  pixel_clk * n_cts->n / (128 * audio_fs);
+	} else {
+		n_cts->n = predef_n_cts->n * ratio;
+		n_cts->cts = predef_n_cts->cts;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(hdmi_audio_compute_n_cts);
+
diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
index e974420..95c2b12 100644
--- a/include/linux/hdmi.h
+++ b/include/linux/hdmi.h
@@ -333,4 +333,16 @@ int hdmi_infoframe_unpack(union hdmi_infoframe *frame, void *buffer);
 void hdmi_infoframe_log(const char *level, struct device *dev,
 			union hdmi_infoframe *frame);
 
+/**
+ * struct hdmi_audio_n_cts - n and cts parameter for ACR packets
+ */
+struct hdmi_audio_n_cts {
+	unsigned int n;
+	unsigned int cts;
+};
+
+int hdmi_audio_compute_n_cts(enum hdmi_audio_sample_frequency audio_fs,
+			     unsigned long pixel_clk,
+			     struct hdmi_audio_n_cts *n_cts);
+
 #endif /* _DRM_HDMI_H */
-- 
1.9.1

