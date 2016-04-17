From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sun, 17 Apr 2016 12:45:48 +0000
Subject: Re: [PATCH v5 13/24] input: misc: max8997: explicitly apply PWM config extracted from pwm_args
Message-Id: <20160417124548.GE33215@dtor-ws>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
 <1460661464-11216-14-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1460661464-11216-14-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones>

On Thu, Apr 14, 2016 at 09:17:33PM +0200, Boris Brezillon wrote:
> Call pwm_apply_args() just after requesting the PWM device so that the
> polarity and period are initialized according to the information provided
> in pwm_args.
> 
> This is an intermediate state, and pwm_apply_args() should be dropped as
> soon as the atomic PWM infrastructure is in place and the driver makes
> use of it.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/input/misc/max8997_haptic.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/input/misc/max8997_haptic.c b/drivers/input/misc/max8997_haptic.c
> index a806ba3..bf17f65 100644
> --- a/drivers/input/misc/max8997_haptic.c
> +++ b/drivers/input/misc/max8997_haptic.c
> @@ -304,6 +304,12 @@ static int max8997_haptic_probe(struct platform_device *pdev)
>  				error);
>  			goto err_free_mem;
>  		}
> +
> +		/*
> +		 * FIXME: pwm_apply_args() should be removed when switching to
> +		 * the atomic PWM API.
> +		 */
> +		pwm_apply_args(chip->pwm);

I do not understand. We did not fetch/modify any args, what are we
applying and why? Especially since we saying we want to remove this
later.

Thanks.

-- 
Dmitry
