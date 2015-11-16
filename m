From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Mon, 16 Nov 2015 18:06:46 +0000
Subject: Re: [PATCH v4 02/24] pwm: use pwm_get_xxx() helpers where appropriate
Message-Id: <20151116190646.1d5ba16e@bbrezillon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
 <1447664207-24370-3-git-send-email-boris.brezillon@free-electrons.com>
 <CAGhQ9VwEuwazF5Kdw=9R60EovVoiwen6fXiVjL+=EddXPYVGAg@mail.gmail.com>
In-Reply-To: <CAGhQ9VwEuwazF5Kdw=9R60EovVoiwen6fXiVjL+=EddXPYVGAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Joachim,

On Mon, 16 Nov 2015 18:46:44 +0100
Joachim  Eastwood <manabian@gmail.com> wrote:

> Hi Boris
> 
> (Adding Ariel for pwm-lpc18xx-sct)
> 
> On 16 November 2015 at 09:56, Boris Brezillon
> <boris.brezillon@free-electrons.com> wrote:
> > Use pwm_get_xxx() helpers instead of directly accessing the pwm->xxx field.
> > Doing that will ease adaptation of the PWM framework to support atomic
> > update.
> >
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> > Patch generated with the following coccinelle script:
> >
> > --->8---
> > virtual patch
> >
> > @@
> > struct pwm_device *p;
> > expression e;
> > @@
> > (
> > -(p)->polarity = e;
> > +pwm_set_polarity((p), e);
> > |
> > -(p)->polarity
> > +pwm_get_polarity((p))
> > |
> > -(p)->period = e;
> > +pwm_set_period((p), e);
> > |
> > -(p)->period
> > +pwm_get_period((p))
> > |
> > -(p)->duty_cycle = e;
> > +pwm_set_duty_cycle((p), e);
> > |
> > -(p)->duty_cycle
> > +pwm_get_duty_cycle((p))
> > )
> > --->8---
> > ---
> >  drivers/pwm/pwm-crc.c         | 2 +-
> >  drivers/pwm/pwm-lpc18xx-sct.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
> > index 7101c70..2f88543 100644
> > --- a/drivers/pwm/pwm-crc.c
> > +++ b/drivers/pwm/pwm-crc.c
> > @@ -75,7 +75,7 @@ static int crc_pwm_config(struct pwm_chip *c, struct pwm_device *pwm,
> >                 return -EINVAL;
> >         }
> >
> > -       if (pwm->period != period_ns) {
> > +       if (pwm_get_period((pwm)) != period_ns) {
> >                 int clk_div;
> >
> >                 /* changing the clk divisor, need to disable fisrt */
> > diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
> > index 9163085..091fa13 100644
> > --- a/drivers/pwm/pwm-lpc18xx-sct.c
> > +++ b/drivers/pwm/pwm-lpc18xx-sct.c
> > @@ -249,7 +249,7 @@ static int lpc18xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> >                            LPC18XX_PWM_EVSTATEMSK(lpc18xx_data->duty_event),
> >                            LPC18XX_PWM_EVSTATEMSK_ALL);
> >
> > -       if (pwm->polarity = PWM_POLARITY_NORMAL) {
> > +       if (pwm_get_polarity((pwm)) = PWM_POLARITY_NORMAL) {
> 
> What is the deal with the double parentheses?
> 
> Think I saw that in some of the other patches as well.

It comes from a typo in my coccinelle script. I already fixed it and
regenerated the faulty patches, so please ignore this aspect while
reviewing (this will be addressed in the next version).

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
