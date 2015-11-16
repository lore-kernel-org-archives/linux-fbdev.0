From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Mon, 16 Nov 2015 19:28:13 +0000
Subject: Re: [PATCH v4 09/24] regulator: pwm: use pwm_get/set_default_xxx() helpers where appropriate
Message-Id: <20151116202813.5a2114b9@bbrezillon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
 <1447664207-24370-10-git-send-email-boris.brezillon@free-electrons.com>
 <20151116105558.GB31303@sirena.org.uk>
 <20151116132359.39d84279@bbrezillon>
 <20151116184238.GJ31303@sirena.org.uk>
In-Reply-To: <20151116184238.GJ31303@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, 16 Nov 2015 18:42:38 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Mon, Nov 16, 2015 at 01:23:59PM +0100, Boris Brezillon wrote:
> > Mark Brown <broonie@kernel.org> wrote:
> > > On Mon, Nov 16, 2015 at 09:56:32AM +0100, Boris Brezillon wrote:
> 
> > > > -	pwm_reg_period = pwm_get_period(drvdata->pwm);
> > > > +	pwm_reg_period = pwm_get_default_period(drvdata->pwm);
> 
> > > It's not clear to me that we're not looking for the current period here
> > > or in the other use.  Won't configuring based on a period other than the
> > > one that has been set give the wrong answer?
> 
> > Hm, maybe that's naming problem. What I call the 'default' period here
> > is actually the period configured in your board file (using a PWM lookup
> > table) or your DT. This value represent the period requested by the PWM
> > user not a default value specified by the PWM chip driver.
> 
> > The reason we're not using the 'current' period value is because it may
> > have been set by the bootloader, and may be inappropriate for our use
> > case (ie. the period may be to small to represent the different
> > voltages).
> 
> > ITOH, we're using the current period value when calculating the current
> > voltage, because we want to get the correct voltage value, and the PWM
> > device may still use the configuration set by the bootloader (not the
> > default one specified in your board or DT files).
> 
> > I hope this clarifies the differences between the current and default
> > period, and why we should use the default value here.
> 
> To be honest I'm still a bit confused here.  When do we actually apply
> the default setting and why do we keep on having to constantly override
> it rather than doing this once at boot?

That's why I said the 'default' name may be inappropriate. The
default values are actually never directly applied by the PWM framework.
It's the default value for a specific PWM user, so it can be applied by
the PWM user when he wants. It's more here as a reference, nothing
forces the PWM user to use this specific value.

> It feels wrong to be using it
> every time we set anything.  I'd expect it to be something we only need
> to do at probe time or which would automatically be handled by the PWM
> framework (but that'd have issues changing the state and potentially
> breaking things if done in an uncoordiated fashion).

The whole point of this series is to smoothly take over the bootloader
config. This is why we are keeping the PWM untouched until someone
really wants to change the regulator output. We should be able to apply
the 'default' PWM period when probing the device, but this means first
extracting the current voltage from the PWM state and then applying a
new dutycycle and the default period in a single operation. Not sure
it's worth the trouble.

Doing it in the PWM framework is not really possible, because the PWM
lookup table and DT definitions are only defining the 'default' period
value not the 'default' dutycycle, and applying that automatically when
requesting the PWM means generating a glitch on the PWM signal
(dutycycle will be set to 0 until the user changes it using
pwm_config() or pwm_apply_state()) which is exactly what we're trying to
solve here.

Also, note that you have to pass the period anyway when configuring the
PWM, so passing the default one or the current one should be pretty
much the same in term of performances (unless the PWM driver is able
to optimize its setting if the period does not change).

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
