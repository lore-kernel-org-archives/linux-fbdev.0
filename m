From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 21 Dec 2011 21:44:02 +0000
Subject: Re: [PATCH] s3fb: fix Virge/VX
Message-Id: <4EF25322.1000408@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201112192339.52676.linux@rainbow-software.org>
In-Reply-To: <201112192339.52676.linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Paul Mundt <lethal@linux-sh.org>, Ondrej Zajicek <santiago@crfreenet.org>, linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

On 12/19/2011 10:39 PM, Ondrej Zary wrote:
> Add memory size detection for Virge/VX and small delay in mode setting (same
> as in X.org driver) to fix blank screen problem.
> 
> Also adjust DTPC position to fix garbled screen in some modes (tested that
> this adjustment does not break other cards - at least Trio32, Trio64V+,
> Trio64V2/DX, Virge, Virge/DX).
> 
> Tested on ELSA Winner 2000AVI/3D.
> 
> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

Applied.


Thanks,

Florian Tobias Schandinat

> 
> --- linux-3.1-orig/drivers/video/s3fb.c	2011-10-24 09:10:05.000000000 +0200
> +++ linux-3.1/drivers/video/s3fb.c	2011-12-19 23:28:34.000000000 +0100
> @@ -727,7 +727,7 @@
>  	if (par->chip = CHIP_988_VIRGE_VX) {
>  		vga_wcrt(par->state.vgabase, 0x50, 0x00);
>  		vga_wcrt(par->state.vgabase, 0x67, 0x50);
> -
> +		msleep(10); /* screen remains blank sometimes without this */
>  		vga_wcrt(par->state.vgabase, 0x63, (mode <= 2) ? 0x90 : 0x09);
>  		vga_wcrt(par->state.vgabase, 0x66, 0x90);
>  	}
> @@ -901,7 +901,8 @@
>  
>  	/* Set Data Transfer Position */
>  	hsstart = ((info->var.xres + info->var.right_margin) * hmul) / 8;
> -	value = clamp((htotal + hsstart + 1) / 2, hsstart + 4, htotal + 1);
> +	/* + 2 is needed for Virge/VX, does no harm on other cards */
> +	value = clamp((htotal + hsstart + 1) / 2 + 2, hsstart + 4, htotal + 1);
>  	svga_wcrt_multi(par->state.vgabase, s3_dtpc_regs, value);
>  
>  	memset_io(info->screen_base, 0x00, screen_size);
> @@ -1215,6 +1216,31 @@
>  			info->screen_size = 2 << 20;
>  			break;
>  		}
> +	} else if (par->chip = CHIP_988_VIRGE_VX) {
> +		switch ((regval & 0x60) >> 5) {
> +		case 0: /* 2MB */
> +			info->screen_size = 2 << 20;
> +			break;
> +		case 1: /* 4MB */
> +			info->screen_size = 4 << 20;
> +			break;
> +		case 2: /* 6MB */
> +			info->screen_size = 6 << 20;
> +			break;
> +		case 3: /* 8MB */
> +			info->screen_size = 8 << 20;
> +			break;
> +		}
> +		/* off-screen memory */
> +		regval = vga_rcrt(par->state.vgabase, 0x37);
> +		switch ((regval & 0x60) >> 5) {
> +		case 1: /* 4MB */
> +			info->screen_size -= 4 << 20;
> +			break;
> +		case 2: /* 2MB */
> +			info->screen_size -= 2 << 20;
> +			break;
> +		}
>  	} else
>  		info->screen_size = s3_memsizes[regval >> 5] << 10;
>  	info->fix.smem_len = info->screen_size;
> 
> 

