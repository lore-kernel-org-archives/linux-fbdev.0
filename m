From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Mon, 16 Nov 2015 12:23:59 +0000
Subject: Re: [PATCH v4 09/24] regulator: pwm: use pwm_get/set_default_xxx() helpers where appropriate
Message-Id: <20151116132359.39d84279@bbrezillon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
 <1447664207-24370-10-git-send-email-boris.brezillon@free-electrons.com>
 <20151116105558.GB31303@sirena.org.uk>
In-Reply-To: <20151116105558.GB31303@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Mark,

On Mon, 16 Nov 2015 10:55:58 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Mon, Nov 16, 2015 at 09:56:32AM +0100, Boris Brezillon wrote:
> 
> > +++ b/drivers/regulator/pwm-regulator.c
> > @@ -56,7 +56,7 @@ static int pwm_regulator_set_voltage_sel(struct regulator_dev *rdev,
> >  	int dutycycle;
> >  	int ret;
> >  
> > -	pwm_reg_period = pwm_get_period(drvdata->pwm);
> > +	pwm_reg_period = pwm_get_default_period(drvdata->pwm);
> >  
> >  	dutycycle = (pwm_reg_period *
> >  		    drvdata->duty_cycle_table[selector].dutycycle) / 100;
> 
> It's not clear to me that we're not looking for the current period here
> or in the other use.  Won't configuring based on a period other than the
> one that has been set give the wrong answer?

Hm, maybe that's naming problem. What I call the 'default' period here
is actually the period configured in your board file (using a PWM lookup
table) or your DT. This value represent the period requested by the PWM
user not a default value specified by the PWM chip driver.

The reason we're not using the 'current' period value is because it may
have been set by the bootloader, and may be inappropriate for our use
case (ie. the period may be to small to represent the different
voltages).
ITOH, we're using the current period value when calculating the current
voltage, because we want to get the correct voltage value, and the PWM
device may still use the configuration set by the bootloader (not the
default one specified in your board or DT files).

I hope this clarifies the differences between the current and default
period, and why we should use the default value here.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
