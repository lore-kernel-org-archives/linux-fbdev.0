From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Thu, 27 Feb 2020 11:46:23 +0000
Subject: Re: [PATCH][V2] backlight: sky81452: insure while loop does not allow negative array indexing
Message-Id: <20200227114623.vaevrdwiduxa2mqs@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200226195826.6567-1-colin.king@canonical.com>
In-Reply-To: <20200226195826.6567-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Colin King <colin.king@canonical.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, kernel-janitors@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>, Bryan Wu <cooloney@gmail.com>, Gyungoh Yoo <jack.yoo@skyworksinc.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Lee Jones <lee.jones@linaro.org>

On Wed, Feb 26, 2020 at 07:58:26PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the unlikely event that num_entry is zero, the while loop
> pre-decrements num_entry to cause negative array indexing into the
> array sources. Fix this by iterating only if num_entry >= 0.
> 
> Addresses-Coverity: ("Out-of-bounds read")
> Fixes: f705806c9f35 ("backlight: Add support Skyworks SKY81452 backlight driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> 
> V2: fix typo in commit subject line

Isn't the correct spelling "ensure"?


> ---
>  drivers/video/backlight/sky81452-backlight.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/sky81452-backlight.c b/drivers/video/backlight/sky81452-backlight.c
> index 2355f00f5773..f456930ce78e 100644
> --- a/drivers/video/backlight/sky81452-backlight.c
> +++ b/drivers/video/backlight/sky81452-backlight.c
> @@ -200,7 +200,7 @@ static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
>  		}
>  
>  		pdata->enable = 0;
> -		while (--num_entry)
> +		while (--num_entry >= 0)
>  			pdata->enable |= (1 << sources[num_entry]);

This look still looks buggy to me (so I'd second Walter's request to
change it to a for loop). If the code genuinely does not contain a
bug then it probably needs a prominent comment explaining why it is
correct not to honour sources[0]!


Daniel.
