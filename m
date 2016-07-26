From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Tue, 26 Jul 2016 10:06:35 +0000
Subject: Re: [PATCH v2 05/13] gpu: ipu-v3: Add IDMA channel linking support
Message-Id: <1469527595.3041.82.camel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1467932621-358-1-git-send-email-steve_longerbeam@mentor.com>
 <1468977071-29240-1-git-send-email-steve_longerbeam@mentor.com>
 <1468977071-29240-6-git-send-email-steve_longerbeam@mentor.com>
In-Reply-To: <1468977071-29240-6-git-send-email-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steve Longerbeam <slongerbeam@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Steve Longerbeam <steve_longerbeam@mentor.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, tomi.valkeinen@ti.com, plagnioj@jcrosoft.com

Am Dienstag, den 19.07.2016, 18:11 -0700 schrieb Steve Longerbeam:
> Adds functions to link and unlink IDMAC source channels to sink
> channels.
> 
> So far the following links are supported:
> 
> IPUV3_CHANNEL_IC_PRP_ENC_MEM -> IPUV3_CHANNEL_MEM_ROT_ENC
> PUV3_CHANNEL_IC_PRP_VF_MEM   -> IPUV3_CHANNEL_MEM_ROT_VF
> IPUV3_CHANNEL_IC_PP_MEM      -> IPUV3_CHANNEL_MEM_ROT_PP
> 
> More links can be added to the idmac_link_info[] array.
> 
> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>

This patch looks good to me, but the Frame Synchronisation Unit supports
also linking the internal channels, not only the IDMAC channels.

[...]
> +++ b/drivers/gpu/ipu-v3/ipu-common.c
[...]
> +static const struct idmac_link_info idmac_link_info[] = {
> +	{
> +		.src  = { IPUV3_CHANNEL_IC_PRP_ENC_MEM, IPU_FS_PROC_FLOW1,
> +			  0, 4, 7 },
> +		.sink = { IPUV3_CHANNEL_MEM_ROT_ENC, IPU_FS_PROC_FLOW2,
> +			  0, 4, 1 },
> +	}, {
> +		.src =  { IPUV3_CHANNEL_IC_PRP_VF_MEM, IPU_FS_PROC_FLOW1,
> +			  8, 4, 8 },
> +		.sink = { IPUV3_CHANNEL_MEM_ROT_VF, IPU_FS_PROC_FLOW2,
> +			  4, 4, 1 },
> +	}, {
> +		.src =  { IPUV3_CHANNEL_IC_PP_MEM, IPU_FS_PROC_FLOW1,
> +			  16, 4, 5 },
> +		.sink = { IPUV3_CHANNEL_MEM_ROT_PP, IPU_FS_PROC_FLOW2,
> +			  12, 4, 3 },
> +	},
> +};

How about adding new (internal) channel numbers for the CSI->VDI link
and having something like:

	{
		.src =  { IPUV3_CHANNEL_CSI_DIRECT, IPU_FS_PROC_FLOW1,
			  FS_VDI_SRC_SEL_OFFSET, 2, 1 },
		.sink = { IPUV3_CHANNEL_VDI_CUR, 0, 0, 0 },
	},

instead of ipu_set_vdi_src_mux? Then in addition to

[...]
> +int ipu_idmac_link(struct ipuv3_channel *src, struct ipuv3_channel *sink)

We could have a lower level

ipu_fsu_link(int channel1, int channel2)

which could be called like

ipu_fsu_link(IPUV3_CHANNEL_CSI_DIRECT, IPUV3_CHANNEL_VDI_CUR);

Come to think of it, could we replace shift,bits,sel with mask,value and
add #defines for the FSU bit fields and values? I'm thinking:

/* FS_PROC_FLOW1 */
#define FS_PRPENC_ROT_SRC_SEL_MASK	(0xf << 0)
#define FS_PRPENC_ROT_SRC_SEL_ENC		(0x7 << 0)
#define FS_PRPVF_ROT_SRC_SEL_MASK	(0xf << 8)
#define FS_PRPVF_ROT_SRC_SEL_VF			(0x8 << 8)
#define FS_PP_SRC_SEL_MASK		(0xf << 12)
#define FS_PP_ROT_SRC_SEL_MASK		(0xf << 16)
#define FS_PP_ROT_SRC_SEL_PP			(0x5 << 16)
#define FS_VDI1_SRC_SEL_MASK		(0x3 << 20)
#define FS_VDI3_SRC_SEL_MASK		(0x3 << 20)
#define FS_PRP_SRC_SEL_MASK		(0xf << 24)
#define FS_VDI_SRC_SEL_MASK		(0x3 << 28)

/* FS_PROC_FLOW2 */
#define FS_PRP_ENC_DEST_SEL_MASK	(0xf << 0)
#define FS_PRP_ENC_DEST_SEL_IRT_ENC		(0x1 << 0)
#define FS_PRPVF_DEST_SEL_MASK		(0xf << 4)
#define FS_PRPVF_DEST_SEL_IRT_VF		(0x1 << 4)
#define FS_PRPVF_ROT_DEST_SEL_MASK	(0xf << 8)
#define FS_PP_DEST_SEL_MASK		(0xf << 12)
#define FS_PP_DEST_SEL_IRT_PP			(0x3 << 12)
#define FS_PP_ROT_DEST_SEL_MASK		(0xf << 16)
#define FS_PRPENC_ROT_DEST_SEL_MASK	(0xf << 20)
#define FS_PRP_DEST_SEL_MASK		(0xf << 24)

struct idmac_link_reg_info {
	int chno;
	u32 reg;
	u32 mask;
	u32 val;
};

static const struct idmac_link_info idmac_link_info[] = {
	{
		.src  = { IPUV3_CHANNEL_IC_PRP_ENC_MEM, IPU_FS_PROC_FLOW1,
			  FS_PRPENC_ROT_SRC_SEL_MASK, FS_PRPENC_ROT_SRC_SEL_ENC },
		.sink = { IPUV3_CHANNEL_MEM_ROT_ENC, IPU_FS_PROC_FLOW2,
			  FS_PRP_ENC_DEST_SEL_MASK, FS_PRP_ENC_DEST_SEL_IRT_ENC },
	}, {
               .src =  { IPUV3_CHANNEL_IC_PRP_VF_MEM, IPU_FS_PROC_FLOW1,
                         FS_PRPVF_ROT_SRC_SEL_MASK, FS_PRPVF_ROT_SRC_SEL_VF },
               .sink = { IPUV3_CHANNEL_MEM_ROT_VF, IPU_FS_PROC_FLOW2,
                         FS_PRPVF_DEST_SEL_MASK, FS_PRPVF_DEST_SEL_IRT_VF },
	}, {
               .src =  { IPUV3_CHANNEL_IC_PP_MEM, IPU_FS_PROC_FLOW1,
                         FS_PP_ROT_SRC_SEL_MASK, FS_PP_ROT_SRC_SEL_PP },
               .sink = { IPUV3_CHANNEL_MEM_ROT_PP, IPU_FS_PROC_FLOW2,
                         FS_PP_DEST_SEL_MASK, FS_PP_DEST_SEL_IRT_PP },
	},
};

regards
Philipp

