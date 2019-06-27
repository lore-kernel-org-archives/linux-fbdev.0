From: Greg KH <greg@kroah.com>
Date: Thu, 27 Jun 2019 16:44:05 +0000
Subject: Re: [PATCH] fbtft: Cleanup line over 80 character warnings
Message-Id: <20190627164405.GB9692@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190627121240.31584-1-lukas.s.schneider@fau.de>
In-Reply-To: <20190627121240.31584-1-lukas.s.schneider@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lukas Schneider <lukas.s.schneider@fau.de>
Cc: leobras.c@gmail.com, digholebhagyashri@gmail.com, bhanusreemahesh@gmail.com, daniel.vetter@ffwll.ch, der_wolf_@web.de, payal.s.kshirsagar.98@gmail.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Jannik Moritz <jannik.moritz@fau.de>, linux-kernel@i4.cs.fau.de

On Thu, Jun 27, 2019 at 02:12:40PM +0200, Lukas Schneider wrote:
> Cleanup the line over 80 character warnings, reported by checkpatch
> 
> Signed-off-by: Lukas Schneider <lukas.s.schneider@fau.de>
> Signed-off-by: Jannik Moritz <jannik.moritz@fau.de>
> Cc: <linux-kernel@i4.cs.fau.de>
> ---
>  drivers/staging/fbtft/fbtft-sysfs.c |  3 ++-
>  drivers/staging/fbtft/fbtft.h       | 26 ++++++++++++++++++++++----
>  2 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft-sysfs.c b/drivers/staging/fbtft/fbtft-sysfs.c
> index 2a5c630dab87..78d2b81ea2e7 100644
> --- a/drivers/staging/fbtft/fbtft-sysfs.c
> +++ b/drivers/staging/fbtft/fbtft-sysfs.c
> @@ -68,7 +68,8 @@ int fbtft_gamma_parse_str(struct fbtft_par *par, u32 *curves,
>  			ret = get_next_ulong(&curve_p, &val, " ", 16);
>  			if (ret)
>  				goto out;
> -			curves[curve_counter * par->gamma.num_values + value_counter] = val;
> +			curves[curve_counter * par->gamma.num_values
> +				+ value_counter] = val;

Ick, that's horrible to read now, right?

>  			value_counter++;
>  		}
>  		if (value_counter != par->gamma.num_values) {
> diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
> index 9b6bdb62093d..cddbfd4ffa10 100644
> --- a/drivers/staging/fbtft/fbtft.h
> +++ b/drivers/staging/fbtft/fbtft.h
> @@ -348,9 +348,25 @@ module_exit(fbtft_driver_module_exit);
>  
>  /* shorthand debug levels */
>  #define DEBUG_LEVEL_1	DEBUG_REQUEST_GPIOS
> -#define DEBUG_LEVEL_2	(DEBUG_LEVEL_1 | DEBUG_DRIVER_INIT_FUNCTIONS | DEBUG_TIME_FIRST_UPDATE)
> -#define DEBUG_LEVEL_3	(DEBUG_LEVEL_2 | DEBUG_RESET | DEBUG_INIT_DISPLAY | DEBUG_BLANK | DEBUG_REQUEST_GPIOS | DEBUG_FREE_GPIOS | DEBUG_VERIFY_GPIOS | DEBUG_BACKLIGHT | DEBUG_SYSFS)
> -#define DEBUG_LEVEL_4	(DEBUG_LEVEL_2 | DEBUG_FB_READ | DEBUG_FB_WRITE | DEBUG_FB_FILLRECT | DEBUG_FB_COPYAREA | DEBUG_FB_IMAGEBLIT | DEBUG_FB_BLANK)
> +#define DEBUG_LEVEL_2	(DEBUG_LEVEL_1 |		\
> +			 DEBUG_DRIVER_INIT_FUNCTIONS |	\
> +			 DEBUG_TIME_FIRST_UPDATE)
> +#define DEBUG_LEVEL_3	(DEBUG_LEVEL_2 |		\
> +			 DEBUG_RESET |			\
> +			 DEBUG_INIT_DISPLAY |		\
> +			 DEBUG_BLANK |			\
> +			 DEBUG_REQUEST_GPIOS |		\
> +			 DEBUG_FREE_GPIOS |		\
> +			 DEBUG_VERIFY_GPIOS |		\
> +			 DEBUG_BACKLIGHT |		\
> +			 DEBUG_SYSFS)
> +#define DEBUG_LEVEL_4	(DEBUG_LEVEL_2 |		\
> +			 DEBUG_FB_READ |		\
> +			 DEBUG_FB_WRITE |		\
> +			 DEBUG_FB_FILLRECT |		\
> +			 DEBUG_FB_COPYAREA |		\
> +			 DEBUG_FB_IMAGEBLIT |		\
> +			 DEBUG_FB_BLANK)
>  #define DEBUG_LEVEL_5	(DEBUG_LEVEL_3 | DEBUG_UPDATE_DISPLAY)
>  #define DEBUG_LEVEL_6	(DEBUG_LEVEL_4 | DEBUG_LEVEL_5)
>  #define DEBUG_LEVEL_7	0xFFFFFFFF

All of these special debug "levels" need to go away now that the drivers
are working, and just use the in-kernel debugging macros instead.

thanks,

greg k-h
