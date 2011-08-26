From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 26 Aug 2011 18:02:05 +0000
Subject: Re: [PATCH] fbdev: fix parsing of standard timings
Message-Id: <4E57DF9D.2060102@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1314362328-30456-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1314362328-30456-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Tomi,

On 08/26/2011 12:38 PM, Tomi Valkeinen wrote:
> The standard timings parses uses 1:1 dimensions when the ratio in the
> EDID data is 0. However, for EDID 1.3 and later the dimensions are 16:10
> when the ratio is 0.
> 
> Pass the version and revision numbers to get_std_timing() which can then
> make the right decision about dimensions.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Thanks, looks good to me.
I'd be happy if someone with access to the original EDID specs could confirm
this and add his reviewed by.
I also think adding a comment explaining this change would be helpful.

> ---
>  drivers/video/fbmon.c |   20 ++++++++++++++------
>  1 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
> index 4f57485..6a6f92e 100644
> --- a/drivers/video/fbmon.c
> +++ b/drivers/video/fbmon.c
> @@ -493,7 +493,8 @@ static int get_est_timing(unsigned char *block, struct fb_videomode *mode)
>  	return num;
>  }
>  
> -static int get_std_timing(unsigned char *block, struct fb_videomode *mode)
> +static int get_std_timing(unsigned char *block, struct fb_videomode *mode,
> +		int ver, int rev)
>  {
>  	int xres, yres = 0, refresh, ratio, i;
>  
> @@ -504,7 +505,10 @@ static int get_std_timing(unsigned char *block, struct fb_videomode *mode)
>  	ratio = (block[1] & 0xc0) >> 6;
>  	switch (ratio) {
>  	case 0:
> -		yres = xres;

/* in EDID 1.3 the meaning of 0 changed to 16:10 (prior 1:1) */

> +		if (ver < 1 || (ver = 1 && rev < 3))
> +			yres = xres;
> +		else
> +			yres = (xres * 10)/16;
>  		break;
>  	case 1:
>  		yres = (xres * 3)/4;
> @@ -533,12 +537,12 @@ static int get_std_timing(unsigned char *block, struct fb_videomode *mode)
>  }
>  
>  static int get_dst_timing(unsigned char *block,
> -			  struct fb_videomode *mode)
> +			  struct fb_videomode *mode, int ver, int rev)
>  {
>  	int j, num = 0;
>  
>  	for (j = 0; j < 6; j++, block += STD_TIMING_DESCRIPTION_SIZE)
> -		num += get_std_timing(block, &mode[num]);
> +		num += get_std_timing(block, &mode[num], ver, rev);
>  
>  	return num;
>  }
> @@ -599,6 +603,10 @@ static struct fb_videomode *fb_create_modedb(unsigned char *edid, int *dbsize)
>  	struct fb_videomode *mode, *m;
>  	unsigned char *block;
>  	int num = 0, i, first = 1;
> +	int ver, rev;
> +
> +	ver = edid[EDID_STRUCT_VERSION];
> +	rev = edid[EDID_STRUCT_REVISION];
>  
>  	mode = kzalloc(50 * sizeof(struct fb_videomode), GFP_KERNEL);
>  	if (mode = NULL)
> @@ -632,12 +640,12 @@ static struct fb_videomode *fb_create_modedb(unsigned char *edid, int *dbsize)
>  	DPRINTK("   Standard Timings\n");
>  	block = edid + STD_TIMING_DESCRIPTIONS_START;
>  	for (i = 0; i < STD_TIMING; i++, block += STD_TIMING_DESCRIPTION_SIZE)
> -		num += get_std_timing(block, &mode[num]);
> +		num += get_std_timing(block, &mode[num], ver, rev);
>  
>  	block = edid + DETAILED_TIMING_DESCRIPTIONS_START;
>  	for (i = 0; i < 4; i++, block+= DETAILED_TIMING_DESCRIPTION_SIZE) {
>  		if (block[0] = 0x00 && block[1] = 0x00 && block[3] = 0xfa)
> -			num += get_dst_timing(block + 5, &mode[num]);
> +			num += get_dst_timing(block + 5, &mode[num], ver, rev);
>  	}
>  
>  	/* Yikes, EDID data is totally useless */

Thanks,

Florian Tobias Schandinat

