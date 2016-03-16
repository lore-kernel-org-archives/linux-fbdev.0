From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Wed, 16 Mar 2016 14:30:22 +0000
Subject: Re: [PATCH v4 01/24] pwm: rcar: make use of pwm_is_enabled()
Message-Id: <20160316153022.164105d1@bbrezillon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
 <1447664207-24370-2-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1447664207-24370-2-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Thierry,

Can you please apply this patch?
It's completely independent from the rest of the series.

Thanks,

Boris

On Mon, 16 Nov 2015 09:56:24 +0100
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> Commit 5c31252c4a86 ("pwm: Add the pwm_is_enabled() helper") introduced a
> new function to test whether a PWM device is enabled or not without
> manipulating PWM internal fields.
> Hiding this is necessary if we want to smoothly move to the atomic PWM
> config approach without impacting PWM drivers.
> Fix this driver to use pwm_is_enabled() instead of directly accessing the
> ->flags field.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/pwm/pwm-rcar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
> index 6e99a63..70899c9 100644
> --- a/drivers/pwm/pwm-rcar.c
> +++ b/drivers/pwm/pwm-rcar.c
> @@ -157,7 +157,7 @@ static int rcar_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  		return div;
>  
>  	/* Let the core driver set pwm->period if disabled and duty_ns = 0 */
> -	if (!test_bit(PWMF_ENABLED, &pwm->flags) && !duty_ns)
> +	if (!pwm_is_enabled(pwm) && !duty_ns)
>  		return 0;
>  
>  	rcar_pwm_update(rp, RCAR_PWMCR_SYNC, RCAR_PWMCR_SYNC, RCAR_PWMCR);



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
