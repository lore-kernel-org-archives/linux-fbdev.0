From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 20 Jun 2017 10:52:30 +0000
Subject: Re: [PATCH] backlight: pwm_bl: make of_device_ids const
Message-Id: <2574238d-640f-79b3-4650-c51766b4a478@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <b9daeb15d40f6682803d8dafde3bc3dcb63909ff.1497940816.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <b9daeb15d40f6682803d8dafde3bc3dcb63909ff.1497940816.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, thierry.reding@gmail.com, lee.jones@linaro.org, jingoohan1@gmail.com, b.zolnierkie@samsung.com
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 20/06/17 08:52, Arvind Yadav wrote:
> of_device_ids are not supposed to change at runtime. All functions
> working with of_device_ids provided by <linux/of.h> work with const
> of_device_ids. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>   drivers/video/backlight/pwm_bl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 002f1ce..9bd1768 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -178,7 +178,7 @@ static int pwm_backlight_parse_dt(struct device *dev,
>   	return 0;
>   }
>   
> -static struct of_device_id pwm_backlight_of_match[] = {
> +static const struct of_device_id pwm_backlight_of_match[] = {
>   	{ .compatible = "pwm-backlight" },
>   	{ }
>   };
> 

