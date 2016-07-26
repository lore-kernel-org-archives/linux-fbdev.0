From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Tue, 26 Jul 2016 10:06:32 +0000
Subject: Re: [PATCH v2 01/13] gpu: ipu-v3: Add Video Deinterlacer unit
Message-Id: <1469527592.3041.81.camel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1467932621-358-1-git-send-email-steve_longerbeam@mentor.com>
	 <1468977071-29240-1-git-send-email-steve_longerbeam@mentor.com>
	 <1468977071-29240-2-git-send-email-steve_longerbeam@mentor.com>
In-Reply-To: <1468977071-29240-2-git-send-email-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steve Longerbeam <slongerbeam@gmail.com>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Steve Longerbeam <steve_longerbeam@mentor.com>

Am Dienstag, den 19.07.2016, 18:10 -0700 schrieb Steve Longerbeam:
> Adds the Video Deinterlacer (VDIC) unit.
> 
> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
[...]
> +++ b/drivers/gpu/ipu-v3/ipu-vdi.c
[...]
> +static void __ipu_vdi_set_top_field_man(struct ipu_vdi *vdi, bool top_field_0)
> +{
> +	u32 reg;
> +
> +	reg = ipu_vdi_read(vdi, VDI_C);
> +	if (top_field_0)
> +		reg &= ~VDI_C_TOP_FIELD_MAN_1;
> +	else
> +		reg |= VDI_C_TOP_FIELD_MAN_1;
> +	ipu_vdi_write(vdi, reg, VDI_C);
> +}
[...]
> +void ipu_vdi_toggle_top_field_man(struct ipu_vdi *vdi)
> +{
> +	unsigned long flags;
> +	u32 reg;
> +	u32 mask_reg;
> +
> +	spin_lock_irqsave(&vdi->lock, flags);
> +
> +	reg = ipu_vdi_read(vdi, VDI_C);
> +	mask_reg = reg & VDI_C_TOP_FIELD_MAN_1;
> +	if (mask_reg = VDI_C_TOP_FIELD_MAN_1)
> +		reg &= ~VDI_C_TOP_FIELD_MAN_1;
> +	else
> +		reg |= VDI_C_TOP_FIELD_MAN_1;
> +
> +	ipu_vdi_write(vdi, reg, VDI_C);
> +
> +	spin_unlock_irqrestore(&vdi->lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(ipu_vdi_toggle_top_field_man);

Why not export set top field man? Does it make sense to keep the user of
this API in the dark about the current setting?

regards
Philipp

