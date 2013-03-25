From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 25 Mar 2013 04:29:09 +0000
Subject: Re: [PATCH -next] backlight: adp8860: fix error return code in adp8860_led_probe()
Message-Id: <00c801ce2911$4b3db080$e1b91180$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAPgLHd-wxGVKjMpWPDeKqWM+Va6dLnu_spwyb=QUybxjOo=AWA@mail.gmail.com>
In-Reply-To: <CAPgLHd-wxGVKjMpWPDeKqWM+Va6dLnu_spwyb=QUybxjOo=AWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Wei Yongjun' <weiyj.lk@gmail.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, michael.hennerich@analog.com, rpurdie@rpsys.net, FlorianSchandinat@gmx.de, yongjun_wei@trendmicro.com.cn, device-drivers-devel@blackfin.uclinux.org, linux-fbdev@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

On Friday, March 22, 2013 8:30 PM, Wei Yongjun wrote:
> 
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fix to return a negative error code from the error handling
> case instead of 0, as returned elsewhere in this function.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

CC'ed Andrdew Morton, linux-kernel@vger.kernel.org


Acked-by: Jingoo Han <jg1.han@samsung.com>

> ---
>  drivers/video/backlight/adp8860_bl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/backlight/adp8860_bl.c b/drivers/video/backlight/adp8860_bl.c
> index 6bb7f36..75b10f8 100644
> --- a/drivers/video/backlight/adp8860_bl.c
> +++ b/drivers/video/backlight/adp8860_bl.c
> @@ -249,12 +249,14 @@ static int adp8860_led_probe(struct i2c_client *client)
>  		if (led_dat->id > 7 || led_dat->id < 1) {
>  			dev_err(&client->dev, "Invalid LED ID %d\n",
>  				led_dat->id);
> +			ret = -EINVAL;
>  			goto err;
>  		}
> 
>  		if (pdata->bl_led_assign & (1 << (led_dat->id - 1))) {
>  			dev_err(&client->dev, "LED %d used by Backlight\n",
>  				led_dat->id);
> +			ret = -EBUSY;
>  			goto err;
>  		}
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

