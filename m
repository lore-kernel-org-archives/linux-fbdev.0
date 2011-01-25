From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 25 Jan 2011 06:38:35 +0000
Subject: Re: [PATCH 3/4 v4] video, sm501: add OF binding to support SM501
Message-Id: <20110125063834.GE11673@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1291451028-22532-1-git-send-email-hs@denx.de> <1295863058-11168-1-git-send-email-hs@denx.de>
In-Reply-To: <1295863058-11168-1-git-send-email-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Heiko Schocher <hs@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org, devicetree-discuss@ozlabs.org, Ben Dooks <ben@simtec.co.uk>, Vincent Sanders <vince@simtec.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>

On Mon, Jan 24, 2011 at 10:57:38AM +0100, Heiko Schocher wrote:
> - changes since v1:
>   add Ben Dooks, Vincent Sanders and Samuel Ortiz to cc, as suggested from
>   Paul Mundt.
> - changes since v2:
>   add comments from Randy Dunlap:
>   - move parameter documentation to Documentation/fb/sm501.txt
> - changes since v3:
>   - rebased against v2.6.38-rc2
>   - split in 3 patches
>     - of support patch
>       - get rid of "#if defined(CONFIG_PPC_MPC52xx)" usage
>         hide this in DTS, as Paul suggested.
>     - i/o routine patch
>     - edid support patch
> 
[snip]

> diff --git a/drivers/video/sm501fb.c b/drivers/video/sm501fb.c
> index 30b53ae..2ae57aa 100644
> --- a/drivers/video/sm501fb.c
> +++ b/drivers/video/sm501fb.c
> @@ -1729,6 +1729,15 @@ static int sm501fb_init_fb(struct fb_info *fb,
>  		FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_FILLRECT |
>  		FBINFO_HWACCEL_XPAN | FBINFO_HWACCEL_YPAN;
>  
> +#if defined(CONFIG_PPC_MPC52xx)
> +#ifdef __BIG_ENDIAN
> +	if (of_get_property(info->dev->parent->of_node, "little-endian", NULL))
> +		fb->flags |= FBINFO_FOREIGN_ENDIAN;
> +#else
> +	if (of_get_property(info->dev->parent->of_node, "big-endian", NULL))
> +		fb->flags |= FBINFO_FOREIGN_ENDIAN;
> +#endif
> +#endif
>  	/* fixed data */
>  
>  	fb->fix.type		= FB_TYPE_PACKED_PIXELS;

Missed one?
