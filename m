From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Wed, 01 Jul 2015 12:19:12 +0000
Subject: Re: [RFC PATCH 14/15] regulator: pwm: implement ->enable(), ->disable() and ->is_enabled methods
Message-Id: <20150701141912.52f995a5@bbrezillon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <3495901.qMzLCVWCDl@diego> <20150701140531.2041b05c@bbrezillon>
 <3530235.H11CYEfk28@diego>
In-Reply-To: <3530235.H11CYEfk28@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

On Wed, 01 Jul 2015 14:08:18 +0200
Heiko Stübner <heiko@sntech.de> wrote:

> Am Mittwoch, 1. Juli 2015, 14:05:31 schrieb Boris Brezillon:
> > Hi Heiko,
> > 
> > On Wed, 01 Jul 2015 13:58:09 +0200
> > 
> > Heiko Stübner <heiko@sntech.de> wrote:
> > > Am Mittwoch, 1. Juli 2015, 10:22:00 schrieb Boris Brezillon:
> > > > Implement the ->enable(), ->disable() and ->is_enabled methods and
> > > > remove
> > > > the PWM call in ->set_voltage_sel().
> > > > This is particularly important for critical regulators tagged as
> > > > always-on,
> > > > because not claiming the PWM (and its dependencies) might lead to
> > > > unpredictable behavior (like a system hang because the PWM clk is only
> > > > claimed when the PWM device is enabled).
> > > > 
> > > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > > ---
> > > > 
> > > >  drivers/regulator/pwm-regulator.c | 32 ++++++++++++++++++++++++++------
> > > >  1 file changed, 26 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/drivers/regulator/pwm-regulator.c
> > > > b/drivers/regulator/pwm-regulator.c index 12b4d9d..8159518 100644
> > > > --- a/drivers/regulator/pwm-regulator.c
> > > > +++ b/drivers/regulator/pwm-regulator.c
> > > > @@ -59,12 +59,6 @@ static int pwm_regulator_set_voltage_sel(struct
> > > > regulator_dev *rdev,
> > > > 
> > > >  	drvdata->state = selector;
> > > > 
> > > > -	ret = pwm_enable(drvdata->pwm);
> > > > -	if (ret) {
> > > > -		dev_err(&rdev->dev, "Failed to enable PWM\n");
> > > > -		return ret;
> > > > -	}
> > > > -
> > > > 
> > > >  	return 0;
> > > >  
> > > >  }
> > > > 
> > > > @@ -79,11 +73,37 @@ static int pwm_regulator_list_voltage(struct
> > > > regulator_dev *rdev, return drvdata->duty_cycle_table[selector].uV;
> > > > 
> > > >  }
> > > > 
> > > > +static int pwm_regulator_enable(struct regulator_dev *dev)
> > > > +{
> > > > +	struct pwm_regulator_data *drvdata = rdev_get_drvdata(dev);
> > > > +
> > > > +	return pwm_enable(drvdata->pwm);
> > > > +}
> > > > +
> > > > +static int pwm_regulator_disable(struct regulator_dev *dev)
> > > > +{
> > > > +	struct pwm_regulator_data *drvdata = rdev_get_drvdata(dev);
> > > > +
> > > > +	pwm_disable(drvdata->pwm);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int pwm_regulator_is_enabled(struct regulator_dev *dev)
> > > > +{
> > > > +       struct pwm_regulator_data *drvdata = rdev_get_drvdata(dev);
> > > > +
> > > > +       return pwm_is_enabled(drvdata->pwm);
> > > > +}
> > > 
> > > nit: indentation is wrong in pwm_regulator_is_enabled (spaces instead of
> > > tabs)
> > Yep, I noticed checkpatch warnings/errors before sending the patch, but
> > since this is just an RFC I decided to fix them for the next version ;-)
> 
> ok, so I'll just skip over any more style issues for now. Making my way 
> through your series and trying it on my veyron right now :-)

Also note that I haven't tested the series on a real board (just compile
tested) because I don't have the board with me right now, but I wanted
to post the RFC early so that we can discuss the concepts.

Anyway, any feedback on the implementation (including bug reports) is
welcome.

This is the version I actually tested on the veyron board:

https://github.com/bbrezillon/linux-rk/tree/rk-3.14

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
