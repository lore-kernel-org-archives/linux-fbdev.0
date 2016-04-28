From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Date: Thu, 28 Apr 2016 12:13:06 +0000
Subject: Re: [PATCH v4 1/2] video: hdmi: add helper functions for N and CTS
Message-Id: <5721FE52.9020705@st.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461252554-16522-1-git-send-email-arnaud.pouliquen@st.com>
 <1461252554-16522-2-git-send-email-arnaud.pouliquen@st.com>
In-Reply-To: <1461252554-16522-2-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, linux-fbdev@vger.kernel.org
Cc: Jean-Francois Moine <moinejf@free.fr>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@linux.ie>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.co>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

Add linux-fbdev diffusion list in loop for patch-set review.

On 04/21/2016 05:29 PM, Arnaud POULIQUEN wrote:
> Add helper functions to compute HDMI CTS and N parameters.
> Implementation is based on HDMI 1.4b specification.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> Acked-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Acked-by: Vincent ABRIOU <vincent.abriou@st.com>
> ---
>  drivers/video/hdmi.c | 208 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/hdmi.h |  24 ++++++
>  2 files changed, 232 insertions(+)
> 
> diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
> index 1626892..5d124ef 100644
> --- a/drivers/video/hdmi.c
> +++ b/drivers/video/hdmi.c
> @@ -1242,3 +1242,211 @@ int hdmi_infoframe_unpack(union hdmi_infoframe *frame, void *buffer)
>  	return ret;
>  }
>  EXPORT_SYMBOL(hdmi_infoframe_unpack);
> +
> +/*
> + * audio clock regeneration (acr) parameters
> + * N and CTS computation are based on HDMI specification 1.4b
> + */
> +enum hdmi_audio_rate {
> +	HDMI_AUDIO_N_CTS_32KHZ,
> +	HDMI_AUDIO_N_CTS_44_1KHZ,
> +	HDMI_AUDIO_N_CTS_48KHZ,
> +};
> +
> +struct hdmi_audio_acr {
> +	unsigned int tmds_clk;
> +	struct hdmi_audio_n_cts n_cts;
> +};
> +
> +static const struct hdmi_audio_acr hdmi_audio_standard_acr[3][13] = {
> +	[HDMI_AUDIO_N_CTS_32KHZ] = {
> +		/* N and CTS values for 32 kHz rate*/
> +		{  25174825, {  4576,  28125, 0 } }, /* 25.20/1.001  MHz */
> +		{  25200000, {  4096,  25200, 0 } }, /* 25.20        MHz */
> +		{  27000000, {  4096,  27000, 0 } }, /* 27.00        MHz */
> +		{  27027000, {  4096,  27027, 0 } }, /* 27.00*1.001  MHz */
> +		{  54000000, {  4096,  54000, 0 } }, /* 54.00        MHz */
> +		{  54054000, {  4096,  54054, 0 } }, /* 54.00*1.001  MHz */
> +		{  74175824, { 11648, 210937, 50 } }, /* 74.25/1.001 MHz */
> +		{  74250000, {  4096,  74250, 0 } }, /* 74.25        MHz */
> +		{ 148351648, { 11648, 421875, 0 } }, /* 148.50/1.001 MHz */
> +		{ 148500000, {  4096, 148500, 0 } }, /* 148.50       MHz */
> +		{ 296703296, {  5824, 421875, 0 } }, /* 297/1.001 MHz (truncated)*/
> +		{ 296703297, {  5824, 421875, 0 } }, /* 297/1.001 MHz (rounded)*/
> +		{ 297000000, {  3072, 222750, 0 } }, /* 297          MHz */
> +	},
> +	[HDMI_AUDIO_N_CTS_44_1KHZ] = {
> +		/* N and CTS values for 44.1 kHz, 88.2 kHz and 176.4 kHz rates*/
> +		{  25174825, {  7007,  31250, 0 } }, /* 25.20/1.001  MHz */
> +		{  25200000, {  6272,  28000, 0 } }, /* 25.20        MHz */
> +		{  27000000, {  6272,  30000, 0 } }, /* 27.00        MHz */
> +		{  27027000, {  6272,  30030, 0 } }, /* 27.00*1.001  MHz */
> +		{  54000000, {  6272,  60000, 0 } }, /* 54.00        MHz */
> +		{  54054000, {  6272,  60060, 0 } }, /* 54.00*1.001  MHz */
> +		{  74175824, { 17836, 234375, 0 } }, /* 74.25/1.001  MHz */
> +		{  74250000, {  6272,  82500, 0 } }, /* 74.25        MHz */
> +		{ 148351648, {  8918, 234375, 0 } }, /* 148.50/1.001 MHz */
> +		{ 148500000, {  6272, 165000, 0 } }, /* 148.50       MHz */
> +		{ 296703296, {  4459, 234375, 0 } }, /* 297/1.001 MHz (truncated) */
> +		{ 296703297, {  4459, 234375, 0 } }, /* 297/1.001 MHz (rounded) */
> +		{ 297000000, {  4704, 247500, 0 } }, /* 297          MHz */
> +	},
> +	[HDMI_AUDIO_N_CTS_48KHZ] = {
> +		/* N and CTS values for 48 kHz, 96 kHz and 192 kHz rates*/
> +		{  25174825, {  6864,  28125, 0 } }, /* 25.20/1.001  MHz */
> +		{  25200000, {  6144,  25200, 0 } }, /* 25.20        MHz */
> +		{  27000000, {  6144,  27000, 0 } }, /* 27.00        MHz */
> +		{  27027000, {  6144,  27027, 0 } }, /* 27.00*1.001  MHz */
> +		{  54000000, {  6144,  54000, 0 } }, /* 54.00        MHz */
> +		{  54054000, {  6144,  54054, 0 } }, /* 54.00*1.001  MHz */
> +		{  74175824, { 11648, 140625, 0 } }, /* 74.25/1.001  MHz */
> +		{  74250000, {  6144,  74250, 0 } }, /* 74.25        MHz */
> +		{ 148351648, {  5824, 140625, 0 } }, /* 148.50/1.001 MHz */
> +		{ 148500000, {  6144, 148500, 0 } }, /* 148.50       MHz */
> +		{ 296703296, {  5824, 281250, 0 } }, /* 297/1.001 MHz (truncated) */
> +		{ 296703297, {  5824, 281250, 0 } }, /* 297/1.001 MHz (rounded) */
> +		{ 297000000, {  5120, 247500, 0 } }, /* 297          MHz */
> +	}
> +};
> +
> +/**
> + * hdmi_audio_get_coherent_n_cts() - compute N and CTS parameters for coherent
> + * clocks. Coherent clock means that audio and TMDS clocks have the same
> + * source (no drifts between clocks).
> + *
> + * @audio_fs: audio frame clock frequency in Hz
> + * @tmds_clk: HDMI TMDS clock frequency in Hz
> + * @n_cts: N and CTS parameter returned to user
> + *
> + * Values computed are based on table described in HDMI specification 1.4b
> + *
> + * Returns 0 on success or a negative error code on failure.
> + */
> +int hdmi_audio_get_coherent_n_cts(unsigned int audio_fs,
> +				  unsigned int tmds_clk,
> +				  struct hdmi_audio_n_cts *n_cts)
> +{
> +	int audio_freq_id, i;
> +	int rate_coeff = 1;
> +	u64 val, min;
> +	const struct hdmi_audio_acr  *acr_table;
> +	const struct hdmi_audio_n_cts *predef_n_cts = NULL;
> +
> +	switch (audio_fs) {
> +	case 32000:
> +		audio_freq_id = HDMI_AUDIO_N_CTS_32KHZ;
> +		n_cts->n = 4096;
> +		break;
> +	case 44100:
> +		audio_freq_id = HDMI_AUDIO_N_CTS_44_1KHZ;
> +		n_cts->n = 6272;
> +		break;
> +	case 48000:
> +		audio_freq_id = HDMI_AUDIO_N_CTS_48KHZ;
> +		n_cts->n = 6144;
> +		break;
> +	case 88200:
> +		audio_freq_id = HDMI_AUDIO_N_CTS_44_1KHZ;
> +		rate_coeff = 2;
> +		n_cts->n = 6272 * 2;
> +		break;
> +	case 96000:
> +		audio_freq_id = HDMI_AUDIO_N_CTS_48KHZ;
> +		rate_coeff = 2;
> +		n_cts->n = 6144 * 2;
> +		break;
> +	case 176400:
> +		audio_freq_id = HDMI_AUDIO_N_CTS_44_1KHZ;
> +		rate_coeff = 4;
> +		n_cts->n = 6272 * 4;
> +		break;
> +	case 192000:
> +		audio_freq_id = HDMI_AUDIO_N_CTS_48KHZ;
> +		rate_coeff = 4;
> +		n_cts->n = 6144 * 4;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	acr_table = hdmi_audio_standard_acr[audio_freq_id];
> +	for (i = 0; i < ARRAY_SIZE(hdmi_audio_standard_acr[0]); i++) {
> +		if (tmds_clk = acr_table[i].tmds_clk) {
> +			predef_n_cts = &acr_table[i].n_cts;
> +			n_cts->n = predef_n_cts->n * rate_coeff;
> +			n_cts->cts = predef_n_cts->cts;
> +			n_cts->cts_1_ratio = predef_n_cts->cts_1_ratio;
> +			return 0;
> +		}
> +	}
> +
> +	/*
> +	 * Pre-defined frequency not found. Compute CTS using formula:
> +	 * CTS = (Ftdms_clk * N) / (128 * audio_fs)
> +	 */
> +	val = (u64)tmds_clk * n_cts->n;
> +	n_cts->cts = div64_u64(val, 128UL * audio_fs);
> +
> +	n_cts->cts_1_ratio = 0;
> +	min = (u64)n_cts->cts * 128UL * audio_fs;
> +	if (min < val) {
> +		/*
> +		 * Non-accurate value for CTS
> +		 * compute ratio, needed by user to alternate in ACR
> +		 * between CTS and CTS + 1 value.
> +		 */
> +		n_cts->cts_1_ratio = ((u32)(val - min)) * 100 /
> +				     (128 * audio_fs);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(hdmi_audio_get_coherent_n_cts);
> +
> +/**
> + * hdmi_audio_get_non_coherent_n() - get N parameter for non-coherent
> + * clocks. None-coherent clocks means that audio and TMDS clocks have not the
> + * same source (drifts between clocks). In this case assumption is that CTS is
> + * automatically calculated by hardware.
> + *
> + * @audio_fs: audio frame clock frequency in Hz
> + *
> + * Values computed are based on table described in HDMI specification 1.4b
> + *
> + * Returns n value.
> + */
> +int hdmi_audio_get_non_coherent_n(unsigned int audio_fs)
> +{
> +	unsigned int n;
> +
> +	switch (audio_fs) {
> +	case 32000:
> +		n = 4096;
> +		break;
> +	case 44100:
> +		n = 6272;
> +		break;
> +	case 48000:
> +		n = 6144;
> +		break;
> +	case 88200:
> +		n = 6272 * 2;
> +		break;
> +	case 96000:
> +		n = 6144 * 2;
> +		break;
> +	case 176400:
> +		n = 6272 * 4;
> +		break;
> +	case 192000:
> +		n = 6144 * 4;
> +		break;
> +	default:
> +		/* Not pre-defined, recommended value: 128 * fs / 1000 */
> +		n = (audio_fs * 128) / 1000;
> +	}
> +
> +	return n;
> +}
> +EXPORT_SYMBOL(hdmi_audio_get_non_coherent_n);
> +
> diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
> index e974420..088d09f8 100644
> --- a/include/linux/hdmi.h
> +++ b/include/linux/hdmi.h
> @@ -333,4 +333,28 @@ int hdmi_infoframe_unpack(union hdmi_infoframe *frame, void *buffer);
>  void hdmi_infoframe_log(const char *level, struct device *dev,
>  			union hdmi_infoframe *frame);
>  
> +/**
> + * struct hdmi_audio_n_cts - n and cts parameter for ACR packets
> + * @n: N parameter
> + * @cts: CTS parameter
> + * @cts_1_ratio: ratio from 0 to 99 to alternate "CTS" and "CTS + 1" values
> + *  ratio = 0: CTS parameter is accurate, no need to alternate with "CTS + 1"
> + *             value
> + *  ratio = x: Need to alternate with ACR "CTS + 1" value x percent of the time
> + *             to generate accurate audio clock
> + *  as exemple: if cts_1_ratio = 30: to have an accurate value, user
> + *  should transfer CTS value 70% of the time and (CTS+1) value 30% of the time
> + */
> +struct hdmi_audio_n_cts {
> +	unsigned int n;
> +	unsigned int cts;
> +	unsigned int cts_1_ratio;
> +};
> +
> +int hdmi_audio_get_coherent_n_cts(unsigned int audio_fs,
> +				  unsigned int tmds_clk,
> +				  struct hdmi_audio_n_cts *n_cts);
> +
> +int hdmi_audio_get_non_coherent_n(unsigned int audio_fs);
> +
>  #endif /* _DRM_HDMI_H */
> 
