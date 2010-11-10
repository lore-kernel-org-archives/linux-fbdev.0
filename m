From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 10 Nov 2010 04:16:51 +0000
Subject: Re: [PATCH 4/4 v2] fbdev: sh_mobile_hdmi: add support for E-EDID parsing
Message-Id: <20101110041651.GB30715@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1011021145570.4552@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1011021145570.4552@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Nov 02, 2010 at 11:47:47AM +0100, Guennadi Liakhovetski wrote:
> --- a/drivers/video/sh_mobile_hdmi.c
> +++ b/drivers/video/sh_mobile_hdmi.c
> @@ -750,7 +753,38 @@ static int sh_hdmi_read_edid(struct sh_hdmi *hdmi, unsigned long *hdmi_rate,
>  	printk(KERN_CONT "\n");
>  #endif
>  
> -	fb_edid_to_monspecs(edid, &hdmi->monspec);
> +	if (!hdmi->edid_blocks) {
> +		fb_edid_to_monspecs(edid, &hdmi->monspec);
> +		hdmi->edid_blocks = edid[126] + 1;
> +
> +		dev_dbg(hdmi->dev, "%d main modes, %d extension blocks\n",
> +			hdmi->monspec.modedb_len, hdmi->edid_blocks - 1);
> +	} else {
> +		dev_dbg(hdmi->dev, "Extension %u detected, DTD start %u\n",
> +			edid[0], edid[2]);
> +		fb_edid_add_monspecs(edid, &hdmi->monspec);
> +	}
> +
Assuming fb_edid_add_monspecs() is changed to hand error values back,
this would probably benefit from being inverted. The fb_edid_to_monspecs()
case looks like a reasonable fallback if fb_did_add_monspecs() fails.
