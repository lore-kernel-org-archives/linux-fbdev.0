From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 10 Nov 2010 04:34:26 +0000
Subject: Re: [PATCH 2/4 v2] fbdev: export fb_edid_add_monspecs() for modules, improve algorithm
Message-Id: <20101110043426.GC30715@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1011021140390.4552@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1011021140390.4552@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Nov 02, 2010 at 11:47:36AM +0100, Guennadi Liakhovetski wrote:
> diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
> index a0b5a93..38b3c30 100644
> --- a/drivers/video/fbmon.c
> +++ b/drivers/video/fbmon.c
> @@ -973,58 +973,56 @@ void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *specs)
>  	DPRINTK("====================\n");
>  }
>  
> +/**
> + * fb_edid_add_monspecs() - add monitor video modes from E-EDID data
> + * @edid:	128 byte array with an E-EDID block
> + * @spacs:	monitor specs to be extended
> + */
>  void fb_edid_add_monspecs(unsigned char *edid, struct fb_monspecs *specs)
>  {
...

> +	u8 edt[(128 - 4) / DETAILED_TIMING_DESCRIPTION_SIZE];
>  
...
> -	if (edid[0] != 0x2)
> +	if (edid[0] != 0x2 ||
> +	    edid[2] < 4 || edid[2] > 128 - DETAILED_TIMING_DESCRIPTION_SIZE)
>  		return;
>  
...
> +	block = edid + edid[2];
>  
...
> +	for (i = 0; i < (128 - edid[2]) / DETAILED_TIMING_DESCRIPTION_SIZE;
> +	     i++, block += DETAILED_TIMING_DESCRIPTION_SIZE)
> +		if (!(block[0] = 0x00 && block[1] = 0x00))
> +			edt[num++] = block - edid;
>  
Can we also do something about these magic numbers? There is already a
drivers/video/edid.h that you can fill out as necessary. I realize that
these values are probably pretty obvious if you have a copy of the spec
in front of you, I don't.
