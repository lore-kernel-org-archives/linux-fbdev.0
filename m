From: Johan Hovold <jhovold@gmail.com>
Date: Tue, 29 Oct 2013 13:08:11 +0000
Subject: Re: [PATCH 2/9] backlight: atmel-pwm-bl: fix gpio polarity in remove
Message-Id: <20131029130811.GA29615@localhost>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382522143-32072-1-git-send-email-jhovold@gmail.com>
 <1382522143-32072-3-git-send-email-jhovold@gmail.com>
 <20131025110928.GR18477@ns203013.ovh.net>
In-Reply-To: <20131025110928.GR18477@ns203013.ovh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Johan Hovold <jhovold@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jingoo Han <jg1.han@samsung.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Fri, Oct 25, 2013 at 01:09:28PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 11:55 Wed 23 Oct     , Johan Hovold wrote:
> > Make sure to honour gpio polarity also at remove so that the backlight
> > is actually disabled on boards with active-low enable pin.
> > 
> > Cc: stable@vger.kernel.org
> > Acked-by: Jingoo Han <jg1.han@samsung.com>
> > Signed-off-by: Johan Hovold <jhovold@gmail.com>
> > ---
> >  drivers/video/backlight/atmel-pwm-bl.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/video/backlight/atmel-pwm-bl.c b/drivers/video/backlight/atmel-pwm-bl.c
> > index 8aac273..3cb0094 100644
> > --- a/drivers/video/backlight/atmel-pwm-bl.c
> > +++ b/drivers/video/backlight/atmel-pwm-bl.c
> > @@ -205,8 +205,10 @@ static int atmel_pwm_bl_remove(struct platform_device *pdev)
> >  {
> >  	struct atmel_pwm_bl *pwmbl = platform_get_drvdata(pdev);
> >  
> > -	if (pwmbl->gpio_on != -1)
> > -		gpio_set_value(pwmbl->gpio_on, 0);
> > +	if (pwmbl->gpio_on != -1) {
> here we need to use gpio_is_valid

That is a different issue which is fixed by patch 7/9. It doesn't make
sense to only change one of the gpio-validity tests.

Johan

> > +		gpio_set_value(pwmbl->gpio_on,
> > +					0 ^ pwmbl->pdata->on_active_low);
> > +	}
> >  	pwm_channel_disable(&pwmbl->pwmc);
> >  	pwm_channel_free(&pwmbl->pwmc);
> >  
> > -- 
> > 1.8.4
> > 
