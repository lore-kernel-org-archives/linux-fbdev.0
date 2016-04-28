From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Date: Thu, 28 Apr 2016 12:13:11 +0000
Subject: Re: [PATCH v4 2/2] drm: sti: Add ASoC generic hdmi codec support.
Message-Id: <5721FE57.7050409@st.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461252554-16522-1-git-send-email-arnaud.pouliquen@st.com>
 <1461252554-16522-3-git-send-email-arnaud.pouliquen@st.com>
In-Reply-To: <1461252554-16522-3-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, linux-fbdev@vger.kernel.org
Cc: Jean-Francois Moine <moinejf@free.fr>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@linux.ie>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.co>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

Add linux-fbdev diffusion list in loop for patch-set review.

On 04/21/2016 05:29 PM, Arnaud POULIQUEN wrote:
> Add the interface needed by audio hdmi-codec driver.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> Acked-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Acked-by: Vincent ABRIOU <vincent.abriou@st.com>
> ---
>  drivers/gpu/drm/sti/Kconfig    |   1 +
>  drivers/gpu/drm/sti/sti_hdmi.c | 248 ++++++++++++++++++++++++++++++++++++++---
>  drivers/gpu/drm/sti/sti_hdmi.h |  13 +++
>  3 files changed, 245 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sti/Kconfig b/drivers/gpu/drm/sti/Kconfig
> index 5ad43a1..494ab25 100644
> --- a/drivers/gpu/drm/sti/Kconfig
> +++ b/drivers/gpu/drm/sti/Kconfig
> @@ -7,5 +7,6 @@ config DRM_STI
>  	select DRM_KMS_CMA_HELPER
>  	select DRM_PANEL
>  	select FW_LOADER
> +	select SND_SOC_HDMI_CODEC if SND_SOC
>  	help
>  	  Choose this option to enable DRM on STM stiH41x chipset
> diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
> index 6ef0715..3a8bd47 100644
> --- a/drivers/gpu/drm/sti/sti_hdmi.c
> +++ b/drivers/gpu/drm/sti/sti_hdmi.c
> @@ -18,6 +18,8 @@
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_edid.h>
>  
> +#include <sound/hdmi-codec.h>
> +
>  #include "sti_hdmi.h"
>  #include "sti_hdmi_tx3g4c28phy.h"
>  #include "sti_hdmi_tx3g0c55phy.h"
> @@ -35,6 +37,8 @@
>  #define HDMI_DFLT_CHL0_DAT              0x0110
>  #define HDMI_DFLT_CHL1_DAT              0x0114
>  #define HDMI_DFLT_CHL2_DAT              0x0118
> +#define HDMI_AUDIO_CFG                  0x0200
> +#define HDMI_SPDIF_FIFO_STATUS          0x0204
>  #define HDMI_SW_DI_1_HEAD_WORD          0x0210
>  #define HDMI_SW_DI_1_PKT_WORD0          0x0214
>  #define HDMI_SW_DI_1_PKT_WORD1          0x0218
> @@ -44,6 +48,9 @@
>  #define HDMI_SW_DI_1_PKT_WORD5          0x0228
>  #define HDMI_SW_DI_1_PKT_WORD6          0x022C
>  #define HDMI_SW_DI_CFG                  0x0230
> +#define HDMI_SAMPLE_FLAT_MASK           0x0244
> +#define HDMI_AUDN                       0x0400
> +#define HDMI_AUD_CTS                    0x0404
>  #define HDMI_SW_DI_2_HEAD_WORD          0x0600
>  #define HDMI_SW_DI_2_PKT_WORD0          0x0604
>  #define HDMI_SW_DI_2_PKT_WORD1          0x0608
> @@ -103,6 +110,7 @@
>  #define HDMI_INT_DLL_LCK                BIT(5)
>  #define HDMI_INT_NEW_FRAME              BIT(6)
>  #define HDMI_INT_GENCTRL_PKT            BIT(7)
> +#define HDMI_INT_AUDIO_FIFO_XRUN        BIT(8)
>  #define HDMI_INT_SINK_TERM_PRESENT      BIT(11)
>  
>  #define HDMI_DEFAULT_INT (HDMI_INT_SINK_TERM_PRESENT \
> @@ -111,6 +119,7 @@
>  			| HDMI_INT_GLOBAL)
>  
>  #define HDMI_WORKING_INT (HDMI_INT_SINK_TERM_PRESENT \
> +			| HDMI_INT_AUDIO_FIFO_XRUN \
>  			| HDMI_INT_GENCTRL_PKT \
>  			| HDMI_INT_NEW_FRAME \
>  			| HDMI_INT_DLL_LCK \
> @@ -121,6 +130,27 @@
>  
>  #define HDMI_STA_SW_RST                 BIT(1)
>  
> +#define HDMI_AUD_CFG_8CH		BIT(0)
> +#define HDMI_AUD_CFG_SPDIF_DIV_2	BIT(1)
> +#define HDMI_AUD_CFG_SPDIF_DIV_3	BIT(2)
> +#define HDMI_AUD_CFG_SPDIF_CLK_DIV_4	(BIT(1) | BIT(2))
> +#define HDMI_AUD_CFG_CTS_CLK_256FS	BIT(12)
> +#define HDMI_AUD_CFG_DTS_INVALID	BIT(16)
> +#define HDMI_AUD_CFG_ONE_BIT_INVALID	(BIT(18) | BIT(19) | BIT(20) |  BIT(21))
> +#define HDMI_AUD_CFG_CH12_VALID	BIT(28)
> +#define HDMI_AUD_CFG_CH34_VALID	BIT(29)
> +#define HDMI_AUD_CFG_CH56_VALID	BIT(30)
> +#define HDMI_AUD_CFG_CH78_VALID	BIT(31)
> +
> +/* sample flat mask */
> +#define HDMI_SAMPLE_FLAT_NO	 0
> +#define HDMI_SAMPLE_FLAT_SP0 BIT(0)
> +#define HDMI_SAMPLE_FLAT_SP1 BIT(1)
> +#define HDMI_SAMPLE_FLAT_SP2 BIT(2)
> +#define HDMI_SAMPLE_FLAT_SP3 BIT(3)
> +#define HDMI_SAMPLE_FLAT_ALL (HDMI_SAMPLE_FLAT_SP0 | HDMI_SAMPLE_FLAT_SP1 |\
> +			      HDMI_SAMPLE_FLAT_SP2 | HDMI_SAMPLE_FLAT_SP3)
> +
>  #define HDMI_INFOFRAME_HEADER_TYPE(x)    (((x) & 0xff) <<  0)
>  #define HDMI_INFOFRAME_HEADER_VERSION(x) (((x) & 0xff) <<  8)
>  #define HDMI_INFOFRAME_HEADER_LEN(x)     (((x) & 0x0f) << 16)
> @@ -171,6 +201,10 @@ static irqreturn_t hdmi_irq_thread(int irq, void *arg)
>  		wake_up_interruptible(&hdmi->wait_event);
>  	}
>  
> +	/* Audio FIFO underrun IRQ */
> +	if (hdmi->irq_status & HDMI_INT_AUDIO_FIFO_XRUN)
> +		DRM_INFO("Warning: audio FIFO underrun occurs!");
> +
>  	return IRQ_HANDLED;
>  }
>  
> @@ -441,26 +475,29 @@ static int hdmi_avi_infoframe_config(struct sti_hdmi *hdmi)
>   */
>  static int hdmi_audio_infoframe_config(struct sti_hdmi *hdmi)
>  {
> -	struct hdmi_audio_infoframe infofame;
> +	struct hdmi_audio_params *audio = &hdmi->audio;
>  	u8 buffer[HDMI_INFOFRAME_SIZE(AUDIO)];
> -	int ret;
> -
> -	ret = hdmi_audio_infoframe_init(&infofame);
> -	if (ret < 0) {
> -		DRM_ERROR("failed to setup audio infoframe: %d\n", ret);
> -		return ret;
> -	}
> -
> -	infofame.channels = 2;
> -
> -	ret = hdmi_audio_infoframe_pack(&infofame, buffer, sizeof(buffer));
> -	if (ret < 0) {
> -		DRM_ERROR("failed to pack audio infoframe: %d\n", ret);
> -		return ret;
> +	int ret, val;
> +
> +	DRM_DEBUG_DRIVER("enter %s, AIF %s\n", __func__,
> +			 audio->enabled ? "enable" : "disable");
> +	if (audio->enabled) {
> +		/* set audio parameters stored*/
> +		ret = hdmi_audio_infoframe_pack(&audio->cea, buffer,
> +						sizeof(buffer));
> +		if (ret < 0) {
> +			DRM_ERROR("failed to pack audio infoframe: %d\n", ret);
> +			return ret;
> +		}
> +		hdmi_infoframe_write_infopack(hdmi, buffer, ret);
> +	} else {
> +		/*disable audio info frame transmission */
> +		val = hdmi_read(hdmi, HDMI_SW_DI_CFG);
> +		val &= ~HDMI_IFRAME_CFG_DI_N(HDMI_IFRAME_MASK,
> +					     HDMI_IFRAME_SLOT_AUDIO);
> +		hdmi_write(hdmi, val, HDMI_SW_DI_CFG);
>  	}
>  
> -	hdmi_infoframe_write_infopack(hdmi, buffer, ret);
> -
>  	return 0;
>  }
>  
> @@ -656,6 +693,10 @@ static int hdmi_dbg_show(struct seq_file *s, void *data)
>  	DBGFS_DUMP("", HDMI_SW_DI_CFG);
>  	hdmi_dbg_sw_di_cfg(s, hdmi_read(hdmi, HDMI_SW_DI_CFG));
>  
> +	DBGFS_DUMP("\n", HDMI_AUDIO_CFG);
> +	DBGFS_DUMP("\n", HDMI_SPDIF_FIFO_STATUS);
> +	DBGFS_DUMP("\n", HDMI_AUDN);
> +
>  	seq_printf(s, "\n AVI Infoframe (Data Island slot N=%d):",
>  		   HDMI_IFRAME_SLOT_AVI);
>  	DBGFS_DUMP_DI(HDMI_SW_DI_N_HEAD_WORD, HDMI_IFRAME_SLOT_AVI);
> @@ -861,6 +902,7 @@ static int sti_hdmi_connector_get_modes(struct drm_connector *connector)
>  
>  	count = drm_add_edid_modes(connector, edid);
>  	drm_mode_connector_update_edid_property(connector, edid);
> +	drm_edid_to_eld(connector, edid);
>  
>  	kfree(edid);
>  	return count;
> @@ -1049,6 +1091,160 @@ static struct drm_encoder *sti_hdmi_find_encoder(struct drm_device *dev)
>  	return NULL;
>  }
>  
> +static int hdmi_audio_configure(struct sti_hdmi *hdmi,
> +				struct hdmi_audio_params *params)
> +{
> +	int audio_cfg, n;
> +	struct hdmi_audio_infoframe *info = &params->cea;
> +
> +	DRM_DEBUG_DRIVER("\n");
> +
> +	if (!hdmi->enabled)
> +		return 0;
> +
> +	/* update N parameter */
> +	n = hdmi_audio_get_non_coherent_n(params->sample_rate);
> +
> +	DRM_DEBUG_DRIVER("Audio rate = %d Hz, TMDS clock = %d Hz, n = %d\n",
> +			 params->sample_rate, hdmi->mode.clock * 1000, n);
> +	hdmi_write(hdmi, n, HDMI_AUDN);
> +
> +	/* update HDMI registers according to configuration */
> +	audio_cfg = HDMI_AUD_CFG_SPDIF_DIV_2 | HDMI_AUD_CFG_DTS_INVALID |
> +		    HDMI_AUD_CFG_ONE_BIT_INVALID;
> +
> +	switch (info->channels) {
> +	case 8:
> +		audio_cfg |= HDMI_AUD_CFG_CH78_VALID;
> +	case 6:
> +		audio_cfg |= HDMI_AUD_CFG_CH56_VALID;
> +	case 4:
> +		audio_cfg |= HDMI_AUD_CFG_CH34_VALID | HDMI_AUD_CFG_8CH;
> +	case 2:
> +		audio_cfg |= HDMI_AUD_CFG_CH12_VALID;
> +		break;
> +	default:
> +		DRM_ERROR("ERROR: Unsupported number of channels (%d)!\n",
> +			  info->channels);
> +		return -EINVAL;
> +	}
> +
> +	hdmi_write(hdmi, audio_cfg, HDMI_AUDIO_CFG);
> +
> +	hdmi->audio = *params;
> +
> +	return hdmi_audio_infoframe_config(hdmi);
> +}
> +
> +static void hdmi_audio_shutdown(struct device *dev)
> +{
> +	struct sti_hdmi *hdmi = dev_get_drvdata(dev);
> +	int audio_cfg;
> +
> +	DRM_DEBUG_DRIVER("\n");
> +
> +	/* disable audio */
> +	audio_cfg = HDMI_AUD_CFG_SPDIF_DIV_2 | HDMI_AUD_CFG_DTS_INVALID |
> +		    HDMI_AUD_CFG_ONE_BIT_INVALID;
> +	hdmi_write(hdmi, audio_cfg, HDMI_AUDIO_CFG);
> +
> +	hdmi->audio.enabled = 0;
> +	hdmi_audio_infoframe_config(hdmi);
> +}
> +
> +static int hdmi_audio_hw_params(struct device *dev,
> +				struct hdmi_codec_daifmt *daifmt,
> +				struct hdmi_codec_params *params)
> +{
> +	struct sti_hdmi *hdmi = dev_get_drvdata(dev);
> +	int ret;
> +	struct hdmi_audio_params audio = {
> +		.sample_width = params->sample_width,
> +		.sample_rate = params->sample_rate,
> +		.cea = params->cea,
> +	};
> +
> +	DRM_DEBUG_DRIVER("\n");
> +
> +	if (!hdmi->enabled)
> +		return 0;
> +
> +	if ((daifmt->fmt != HDMI_I2S) || daifmt->bit_clk_inv ||
> +	    daifmt->frame_clk_inv || daifmt->bit_clk_master ||
> +	    daifmt->frame_clk_master) {
> +		dev_err(dev, "%s: Bad flags %d %d %d %d\n", __func__,
> +			daifmt->bit_clk_inv, daifmt->frame_clk_inv,
> +			daifmt->bit_clk_master,
> +			daifmt->frame_clk_master);
> +		return -EINVAL;
> +	}
> +
> +	audio.enabled = 1;
> +
> +	ret = hdmi_audio_configure(hdmi, &audio);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int hdmi_audio_digital_mute(struct device *dev, bool enable)
> +{
> +	struct sti_hdmi *hdmi = dev_get_drvdata(dev);
> +
> +	DRM_DEBUG_DRIVER("%s\n", enable ? "enable" : "disable");
> +
> +	if (enable)
> +		hdmi_write(hdmi, HDMI_SAMPLE_FLAT_ALL, HDMI_SAMPLE_FLAT_MASK);
> +	else
> +		hdmi_write(hdmi, HDMI_SAMPLE_FLAT_NO, HDMI_SAMPLE_FLAT_MASK);
> +
> +	return 0;
> +}
> +
> +static int hdmi_audio_get_eld(struct device *dev, uint8_t *buf, size_t len)
> +{
> +	struct sti_hdmi *hdmi = dev_get_drvdata(dev);
> +	struct drm_connector *connector = hdmi->drm_connector;
> +
> +	DRM_DEBUG_DRIVER("\n");
> +	memcpy(buf, connector->eld, min(sizeof(connector->eld), len));
> +
> +	return 0;
> +}
> +
> +static const struct hdmi_codec_ops audio_codec_ops = {
> +	.hw_params = hdmi_audio_hw_params,
> +	.audio_shutdown = hdmi_audio_shutdown,
> +	.digital_mute = hdmi_audio_digital_mute,
> +	.get_eld = hdmi_audio_get_eld,
> +};
> +
> +static int sti_hdmi_register_audio_driver(struct device *dev,
> +					  struct sti_hdmi *hdmi)
> +{
> +	struct hdmi_codec_pdata codec_data = {
> +		.ops = &audio_codec_ops,
> +		.max_i2s_channels = 8,
> +		.i2s = 1,
> +	};
> +
> +	DRM_DEBUG_DRIVER("\n");
> +
> +	hdmi->audio.enabled = 0;
> +
> +	hdmi->audio_pdev = platform_device_register_data(
> +		dev, HDMI_CODEC_DRV_NAME, PLATFORM_DEVID_AUTO,
> +		&codec_data, sizeof(codec_data));
> +
> +	if (IS_ERR(hdmi->audio_pdev))
> +		return PTR_ERR(hdmi->audio_pdev);
> +
> +	DRM_INFO("%s Driver bound %s\n", HDMI_CODEC_DRV_NAME, dev_name(dev));
> +
> +	return 0;
> +}
> +
>  static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
>  {
>  	struct sti_hdmi *hdmi = dev_get_drvdata(dev);
> @@ -1099,12 +1295,27 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
>  	if (err)
>  		goto err_connector;
>  
> +	hdmi->drm_connector = drm_connector;
> +
>  	err = drm_mode_connector_attach_encoder(drm_connector, encoder);
>  	if (err) {
>  		DRM_ERROR("Failed to attach a connector to a encoder\n");
>  		goto err_sysfs;
>  	}
>  
> +	err = sti_hdmi_register_audio_driver(dev, hdmi);
> +	if (err) {
> +		DRM_ERROR("Failed to attach an audio codec\n");
> +		goto err_sysfs;
> +	}
> +
> +	/* Initialize audio infoframe */
> +	err = hdmi_audio_infoframe_init(&hdmi->audio.cea);
> +	if (err) {
> +		DRM_ERROR("Failed to init audio infoframe\n");
> +		goto err_sysfs;
> +	}
> +
>  	/* Enable default interrupts */
>  	hdmi_write(hdmi, HDMI_DEFAULT_INT, HDMI_INT_EN);
>  
> @@ -1115,6 +1326,7 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
>  
>  err_sysfs:
>  	drm_connector_unregister(drm_connector);
> +	hdmi->drm_connector = NULL;
>  err_connector:
>  	drm_connector_cleanup(drm_connector);
>  
> @@ -1267,6 +1479,8 @@ static int sti_hdmi_remove(struct platform_device *pdev)
>  	struct sti_hdmi *hdmi = dev_get_drvdata(&pdev->dev);
>  
>  	i2c_put_adapter(hdmi->ddc_adapt);
> +	if (hdmi->audio_pdev)
> +		platform_device_unregister(hdmi->audio_pdev);
>  	component_del(&pdev->dev, &sti_hdmi_ops);
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/sti/sti_hdmi.h b/drivers/gpu/drm/sti/sti_hdmi.h
> index ef3a945..119bc35 100644
> --- a/drivers/gpu/drm/sti/sti_hdmi.h
> +++ b/drivers/gpu/drm/sti/sti_hdmi.h
> @@ -23,6 +23,13 @@ struct hdmi_phy_ops {
>  	void (*stop)(struct sti_hdmi *hdmi);
>  };
>  
> +struct hdmi_audio_params {
> +	bool enabled;
> +	unsigned int sample_width;
> +	unsigned int sample_rate;
> +	struct hdmi_audio_infoframe cea;
> +};
> +
>  /* values for the framing mode property */
>  enum sti_hdmi_modes {
>  	HDMI_MODE_HDMI,
> @@ -67,6 +74,9 @@ static const struct drm_prop_enum_list colorspace_mode_names[] = {
>   * @ddc_adapt: i2c ddc adapter
>   * @colorspace: current colorspace selected
>   * @hdmi_mode: select framing for HDMI or DVI
> + * @audio_pdev: ASoC hdmi-codec platform device
> + * @audio: hdmi audio parameters.
> + * @drm_connector: hdmi connector
>   */
>  struct sti_hdmi {
>  	struct device dev;
> @@ -89,6 +99,9 @@ struct sti_hdmi {
>  	struct i2c_adapter *ddc_adapt;
>  	enum hdmi_colorspace colorspace;
>  	enum sti_hdmi_modes hdmi_mode;
> +	struct platform_device *audio_pdev;
> +	struct hdmi_audio_params audio;
> +	struct drm_connector *drm_connector;
>  };
>  
>  u32 hdmi_read(struct sti_hdmi *hdmi, int offset);
> 
