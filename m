From: Johan Hovold <jhovold@gmail.com>
Date: Tue, 29 Oct 2013 13:32:05 +0000
Subject: Re: [PATCH 1/9] backlight: atmel-pwm-bl: fix reported brightness
Message-Id: <20131029133205.GD29615@localhost>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382522143-32072-1-git-send-email-jhovold@gmail.com>
 <1382522143-32072-2-git-send-email-jhovold@gmail.com>
 <20131025110836.GQ18477@ns203013.ovh.net>
In-Reply-To: <20131025110836.GQ18477@ns203013.ovh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Johan Hovold <jhovold@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jingoo Han <jg1.han@samsung.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Fri, Oct 25, 2013 at 01:08:36PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 11:55 Wed 23 Oct     , Johan Hovold wrote:
> > The driver supports 16-bit brightness values, but the value returned
> > from get_brightness was truncated to eight bits.
> > 
> > Cc: stable@vger.kernel.org
> > Acked-by: Jingoo Han <jg1.han@samsung.com>
> > Signed-off-by: Johan Hovold <jhovold@gmail.com>
> > ---
> >  drivers/video/backlight/atmel-pwm-bl.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/video/backlight/atmel-pwm-bl.c b/drivers/video/backlight/atmel-pwm-bl.c
> > index 66885fb..8aac273 100644
> > --- a/drivers/video/backlight/atmel-pwm-bl.c
> > +++ b/drivers/video/backlight/atmel-pwm-bl.c
> > @@ -70,7 +70,7 @@ static int atmel_pwm_bl_set_intensity(struct backlight_device *bd)
> >  static int atmel_pwm_bl_get_intensity(struct backlight_device *bd)
> >  {
> >  	struct atmel_pwm_bl *pwmbl = bl_get_data(bd);
> > -	u8 intensity;
> > +	u32 intensity;
> >  
> >  	if (pwmbl->pdata->pwm_active_low) {
> >  		intensity = pwm_channel_readl(&pwmbl->pwmc, PWM_CDTY) -
> > @@ -80,7 +80,7 @@ static int atmel_pwm_bl_get_intensity(struct backlight_device *bd)
> >  			pwm_channel_readl(&pwmbl->pwmc, PWM_CDTY);
> >  	}
> >  
> > -	return intensity;
> > +	return (u16)intensity;
> no cast mask it

Yeah, perhaps that is better. I discussed this a bit with Jingoo Han in
the thread of the original post. I'll respin.

Thanks,
Johan

> >  }
> >  
> >  static int atmel_pwm_bl_init_pwm(struct atmel_pwm_bl *pwmbl)
> > -- 
> > 1.8.4
> > 
