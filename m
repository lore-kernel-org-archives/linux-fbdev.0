From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Mon, 01 Aug 2016 09:13:21 +0000
Subject: Re: [PATCH v3 10/12] gpu: ipu-v3: Add FSU channel linking support
Message-Id: <1470042801.3025.17.camel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1469994147-17549-1-git-send-email-steve_longerbeam@mentor.com>
	 <1469994147-17549-11-git-send-email-steve_longerbeam@mentor.com>
In-Reply-To: <1469994147-17549-11-git-send-email-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steve Longerbeam <slongerbeam@gmail.com>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Steve Longerbeam <steve_longerbeam@mentor.com>

Am Sonntag, den 31.07.2016, 12:42 -0700 schrieb Steve Longerbeam:
> Adds functions to link and unlink source channels to sink
> channels in the FSU:
> 
> int ipu_fsu_link(struct ipu_soc *ipu, int src_ch, int sink_ch);
> int ipu_fsu_unlink(struct ipu_soc *ipu, int src_ch, int sink_ch);
>
> The channels numbers are usually IDMAC channels, but they can also be
> channels that do not transfer data to or from memory. The following
> convenience functions can be used in place of ipu_fsu_link/unlink()
> when both source and sink channels are IDMAC channels:
> 
> int ipu_idmac_link(struct ipuv3_channel *src, struct ipuv3_channel *sink);
> int ipu_idmac_unlink(struct ipuv3_channel *src, struct ipuv3_channel *sink);
> 
> So far the following links are supported:
> 
> IPUV3_CHANNEL_IC_PRP_ENC_MEM -> IPUV3_CHANNEL_MEM_ROT_ENC
> PUV3_CHANNEL_IC_PRP_VF_MEM   -> IPUV3_CHANNEL_MEM_ROT_VF
> IPUV3_CHANNEL_IC_PP_MEM      -> IPUV3_CHANNEL_MEM_ROT_PP
> IPUV3_CHANNEL_CSI_DIRECT     -> IPUV3_CHANNEL_CSI_VDI_PREV

Looks good to me, thanks. Are you sure though that the target of the CSI
direct channel is VDI_PREV? I would have assumed the CSI input is fed
into VDI_NEXT, while CUR and PREV are read from memory.

regards
Philipp

