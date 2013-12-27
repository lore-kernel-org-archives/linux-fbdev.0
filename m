From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 27 Dec 2013 02:21:04 +0000
Subject: Re: [PATCH] drivers: video: Remove unused function genericbl_limit_intensity() in generic_bl.c
Message-Id: <000301cf02aa$4b1afef0$e150fcd0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20131216112110.GA4849@rashika> <20131216142423.GB24172@leaf>
In-Reply-To: <20131216142423.GB24172@leaf>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: 'Rashika Kheria' <rashika.kheria@gmail.com>, 'Andrew Morton' <akpm@linux-foundation.org>
Cc: 'Josh Triplett' <josh@joshtriplett.org>, linux-kernel@vger.kernel.org, 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Eric Miao' <eric.y.miao@gmail.com>

On Monday, December 16, 2013 11:24 PM, Josh Triplett wrote:
> On Mon, Dec 16, 2013 at 04:51:10PM +0530, Rashika Kheria wrote:
> > Removes unused function genericbl_limit_intensity() in
> > backlight/generic_bl.c.
> >
> > This eliminates the following warning in backlight/generic_bl.c:
> > drivers/video/backlight/generic_bl.c:59:6: warning: no previous prototype for
> ‘genericbl_limit_intensity’ [-Wmissing-prototypes]
> >
> > Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
> 
> Reviewed-by: Josh Triplett <josh@joshtriplett.org>

(+cc Andrew Morton, Eric Miao)

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> 
> >  drivers/video/backlight/generic_bl.c |   18 ------------------
> >  1 file changed, 18 deletions(-)
> >
> > diff --git a/drivers/video/backlight/generic_bl.c b/drivers/video/backlight/generic_bl.c
> > index 5d8d652..67dfb93 100644
> > --- a/drivers/video/backlight/generic_bl.c
> > +++ b/drivers/video/backlight/generic_bl.c
> > @@ -52,24 +52,6 @@ static int genericbl_get_intensity(struct backlight_device *bd)
> >  	return genericbl_intensity;
> >  }
> >
> > -/*
> > - * Called when the battery is low to limit the backlight intensity.
> > - * If limit=0 clear any limit, otherwise limit the intensity
> > - */
> > -void genericbl_limit_intensity(int limit)
> > -{
> > -	struct backlight_device *bd = generic_backlight_device;
> > -
> > -	mutex_lock(&bd->ops_lock);
> > -	if (limit)
> > -		bd->props.state |= GENERICBL_BATTLOW;
> > -	else
> > -		bd->props.state &= ~GENERICBL_BATTLOW;
> > -	backlight_update_status(generic_backlight_device);
> > -	mutex_unlock(&bd->ops_lock);
> > -}
> > -EXPORT_SYMBOL(genericbl_limit_intensity);
> > -
> >  static const struct backlight_ops genericbl_ops = {
> >  	.options = BL_CORE_SUSPENDRESUME,
> >  	.get_brightness = genericbl_get_intensity,
> > --
> > 1.7.9.5
> >

