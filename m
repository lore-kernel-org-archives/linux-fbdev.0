From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Thu, 31 Mar 2016 07:07:09 +0000
Subject: Re: [PATCH v5 08/46] hwmon: pwm-fan: use pwm_get_args() where appropriate
Message-Id: <20160331090709.5c3bdf70@bbrezillon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-9-git-send-email-boris.brezillon@free-electrons.com>
 <20160330225244.GA24044@roeck-us.net>
In-Reply-To: <20160330225244.GA24044@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Milo Kim <milo.kim@ti.com>, Kamil Debski <k.debski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, linux-doc@vger.kernel.org, David Airlie <airlied@linux.ie>, Mike Turquette <mturquette@baylibre.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, Thierry Reding <thierry.reding@gmail.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org, linux-leds@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-samsung-soc@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>, Jonathan Corbet <corbet@lwn.net>, Robert Jarzmik <robert.jarzmik@free.fr>, lm-sensors@lm-sensors.org, linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi Guenter,

On Wed, 30 Mar 2016 15:52:44 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On Wed, Mar 30, 2016 at 10:03:31PM +0200, Boris Brezillon wrote:
> > The PWM framework has clarified the concept of reference PWM config
> > (the platform dependent config retrieved from the DT or the PWM
> > lookup table) and real PWM state.
> > 
> > Use pwm_get_args() when the PWM user wants to retrieve this reference
> > config and not the current state.
> > 
> > This is part of the rework allowing the PWM framework to support
> > hardware readout and expose real PWM state even when the PWM has
> > just been requested (before the user calls pwm_config/enable/disable()).
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  drivers/hwmon/pwm-fan.c | 19 +++++++++++++------
> >  1 file changed, 13 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> > index 3e23003..82c5656 100644
> > --- a/drivers/hwmon/pwm-fan.c
> > +++ b/drivers/hwmon/pwm-fan.c
> > @@ -40,15 +40,18 @@ struct pwm_fan_ctx {
> >  
> >  static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
> >  {
> > +	struct pwm_args pargs = { };
> 
> Hi Boris,
> 
> I guess I am missing some context; sorry for that. Unfortunately,
> I did not easily find an explanation, so please bear with me.
> 
> Two questions: Why do we need a local copy of struct pwm_args instead
> of a pointer to it ? If it can change while being used, isn't it
> inconsistent anyway ?

It cannot change after pwm_get() is called. For the reason behind
prototype: I just followed the Thierry's proposal, but I'm perfectly
fine returning a const struct pwm_args pointer intead of passing
pwm_args as a parameter.

Thierry, what's your opinion?


> 
> Also, assuming the local copy is necessary, why initialize pargs ? 
> After all, pwm_get_args() just overwrites it.

It's a leftover from a previous version where pwm_get_args was
implemented this way:

static inline void pwm_get_args(pwm, args)
{
	if (pwm)
		*args = pwm->args
}

and this implementation was generating a lot of 'uninitialized
variable' warnings.

I just decided to drop the 'if (pwm)' test, because, IMO, this
should be checked way before calling pwm_get_args() is called.

Anyway, apparently I forgot to modify a few patches after this
modification.

Thanks for the review.

Boris


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
