From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Mon, 20 Jul 2015 08:21:43 +0000
Subject: Re: [RFC PATCH 08/15] backlight: pwm_bl: remove useless call to pwm_set_period
Message-Id: <20150720102143.05949ca2@bbrezillon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-9-git-send-email-boris.brezillon@free-electrons.com>
 <20150720081559.GI29614@ulmo>
In-Reply-To: <20150720081559.GI29614@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, 20 Jul 2015 10:16:00 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Wed, Jul 01, 2015 at 10:21:54AM +0200, Boris Brezillon wrote:
> > The PWM period will be set when calling pwm_config. Remove this useless
> > call to pwm_set_period, which might mess up with the initial PWM state
> > once we have added proper support for PWM init state retrieval.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  drivers/video/backlight/pwm_bl.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> > index ae498c1..fe5597c 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -295,10 +295,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
> >  	 * via the PWM lookup table.
> >  	 */
> >  	pb->period = pwm_get_default_period(pb->pwm);
> > -	if (!pb->period && (data->pwm_period_ns > 0)) {
> > +	if (!pb->period && (data->pwm_period_ns > 0))
> >  		pb->period = data->pwm_period_ns;
> > -		pwm_set_period(pb->pwm, data->pwm_period_ns);
> > -	}
> >  
> >  	pb->lth_brightness = data->lth_brightness * (pb->period / pb->scale);
> 
> As far as I remember this line is there in order to pass in a period if
> the backlight driver is initialized from board setup files. In such a
> case there won't be an period associated with the PWM channel in the
> first place.
> 
> I think even with the introduction of a default period, we'd be missing
> out on the board setup case because there is no standard place where it
> is being set, so it must come from the platform data.

AFAICT, we don't need to explicitly set the period when probing the
backlight device, because it will be set next time we call
pwm_config(), and since we're passing pb->period when calling
pwm_config() everything should be fine.


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
