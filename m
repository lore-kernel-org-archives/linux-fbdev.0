From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Date: Mon, 21 Sep 2015 15:16:20 +0000
Subject: Re: [PATCH] backlight: pwm: reject legacy pwm request for device defined in dt
Message-Id: <56001F44.30703@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434292172-22129-1-git-send-email-vladimir_zapolskiy@mentor.com>
In-Reply-To: <1434292172-22129-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Jingoo Han <jg1.han@samsung.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org

Lee, Thierry,

On 14.06.2015 17:29, Vladimir Zapolskiy wrote:
> Platform PWM backlight data provided by board's device tree should be
> complete enough to successfully request a pwm device using pwm_get()
> API. This change fixes a bug, when an arbitrary (first found) PWM is
> connected to a "pwm-backlight" compatible device, when explicit PWM
> device reference is not given.
> 
> Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
> already describes "pwms" as a required property, instead of blind
> selection of a potentially wrong PWM reject legacy PWM device
> registration request, leave legacy API only for non-dt cases.
> 
> Based on initial implementation done by Dmitry Eremin-Solenikov.
> 
> Reported-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> Acked-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  drivers/video/backlight/pwm_bl.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 57cb9ec..9991cdb 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -271,15 +271,16 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  	}
>  
>  	pb->pwm = devm_pwm_get(&pdev->dev, NULL);
> -	if (IS_ERR(pb->pwm)) {
> +	if (IS_ERR(pb->pwm) && !pdev->dev.of_node) {
>  		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
>  		pb->legacy = true;
>  		pb->pwm = pwm_request(data->pwm_id, "pwm-backlight");
> -		if (IS_ERR(pb->pwm)) {
> -			dev_err(&pdev->dev, "unable to request legacy PWM\n");
> -			ret = PTR_ERR(pb->pwm);
> -			goto err_alloc;
> -		}
> +	}
> +
> +	if (IS_ERR(pb->pwm)) {
> +		dev_err(&pdev->dev, "unable to request PWM\n");
> +		ret = PTR_ERR(pb->pwm);
> +		goto err_alloc;
>  	}
>  
>  	dev_dbg(&pdev->dev, "got pwm for backlight\n");
> 


could you please apply this reviewed and acked change?

Thank you in advance.

--
With best wishes,
Vladimir
