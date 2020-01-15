From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 15 Jan 2020 16:19:04 +0000
Subject: Re: [PATCH] video: fbdev: nvidia: clean up indentation issues and comment block
Message-Id: <26ccc9eb-6edb-3ec6-5714-0bb470366b17@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200113144633eucas1p191c367b401a4c984fbf593794534aa7a@eucas1p1.samsung.com>
 <20200113144627.219967-1-colin.king@canonical.com>
In-Reply-To: <20200113144627.219967-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Colin King <colin.king@canonical.com>
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org


On 1/13/20 3:46 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a hunk of code that is incorrectly indented, clean up the
> indentation and a comment block. Also remove block braces around a
> one line statement on an if condition and add missing spaces after
> if keywords.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch queued for v5.6, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/nvidia/nvidia.c | 41 ++++++++++++++---------------
>  1 file changed, 20 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
> index c583c018304d..c24de9107958 100644
> --- a/drivers/video/fbdev/nvidia/nvidia.c
> +++ b/drivers/video/fbdev/nvidia/nvidia.c
> @@ -168,27 +168,26 @@ static int nvidia_panel_tweak(struct nvidia_par *par,
>  {
>  	int tweak = 0;
>  
> -   if (par->paneltweak) {
> -	   tweak = par->paneltweak;
> -   } else {
> -	   /* begin flat panel hacks */
> -	   /* This is unfortunate, but some chips need this register
> -	      tweaked or else you get artifacts where adjacent pixels are
> -	      swapped.  There are no hard rules for what to set here so all
> -	      we can do is experiment and apply hacks. */
> -
> -	   if(((par->Chipset & 0xffff) = 0x0328) && (state->bpp = 32)) {
> -		   /* At least one NV34 laptop needs this workaround. */
> -		   tweak = -1;
> -	   }
> -
> -	   if((par->Chipset & 0xfff0) = 0x0310) {
> -		   tweak = 1;
> -	   }
> -	   /* end flat panel hacks */
> -   }
> -
> -   return tweak;
> +	if (par->paneltweak) {
> +		tweak = par->paneltweak;
> +	} else {
> +		/* Begin flat panel hacks.
> +		 * This is unfortunate, but some chips need this register
> +		 * tweaked or else you get artifacts where adjacent pixels are
> +		 * swapped.  There are no hard rules for what to set here so all
> +		 * we can do is experiment and apply hacks.
> +		 */
> +		if (((par->Chipset & 0xffff) = 0x0328) && (state->bpp = 32)) {
> +			/* At least one NV34 laptop needs this workaround. */
> +			tweak = -1;
> +		}
> +
> +		if ((par->Chipset & 0xfff0) = 0x0310)
> +			tweak = 1;
> +		/* end flat panel hacks */
> +	}
> +
> +	return tweak;
>  }
>  
>  static void nvidia_screen_off(struct nvidia_par *par, int on)
> 
