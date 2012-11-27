From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 27 Nov 2012 11:54:21 +0000
Subject: Re: [PATCH 1/5] backlight: Add GPIO-based backlight driver
Message-Id: <2946045.hrxh3VjFfi@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <33110366.44811353978636788.JavaMail.weblogic@epv6ml07>
In-Reply-To: <33110366.44811353978636788.JavaMail.weblogic@epv6ml07>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jg1.han@samsung.com
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Hi Jingoo,

On Tuesday 27 November 2012 01:10:36 Jingoo Han wrote:
> On Saturday, November 24, 2012 1:35 AM, Laurent Pinchart wrote
> 
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > 
> >  drivers/video/backlight/Kconfig          |    7 ++
> >  drivers/video/backlight/Makefile         |    1 +
> >  drivers/video/backlight/gpio_backlight.c |  158 +++++++++++++++++++++++++
> >  include/video/gpio_backlight.h           |   21 ++++
> >  4 files changed, 187 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/video/backlight/gpio_backlight.c
> >  create mode 100644 include/video/gpio_backlight.h
> 
> 
> [...]
> 
> 
> > +static int __devinit gpio_backlight_probe(struct platform_device *pdev)
> > +{
> > +	struct gpio_backlight_platform_data *pdata = pdev->dev.platform_data;
> > +	struct backlight_properties props;
> > +	struct backlight_device *bl;
> > +	struct gpio_backlight *gbl;
> > +	int ret;
> > +
> > +	gbl = devm_kzalloc(&pdev->dev, sizeof(*gbl), GFP_KERNEL);
> > +	if (gbl = NULL)
> > +		return -ENOMEM;
> > +
> > +	gbl->dev = &pdev->dev;
> > +
> > +	if (!pdata) {
> > +		dev_err(&pdev->dev, "failed to find platform data\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	gbl->fbdev = pdata->fbdev;
> > +	gbl->gpio = pdata->gpio;
> > +	gbl->active = pdata->active_low ? 0 : 1;
> > +
> > +	ret = devm_gpio_request_one(gbl->dev, gbl->gpio, GPIOF_DIR_OUT,
> > +				    pdata->name);
> 
> 
> Please use GPIOF_INIT flags if you want to turn off GPIO backlight.
> If gbl->active is inverted, GPIOF_INIT_HIGH can be used as below:
> 
> 	ret = devm_gpio_request_one(gbl->dev, gbl->gpio,
> 				    GPIOF_DIR_OUT | (gbl->active ?
> 				    GPIOF_INIT_LOW : GPIOF_INIT_HIGH),
> 				    pdata->name);

Good point, thank you. I'll fix that.

> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "unable to request GPIO\n");
> > +		return ret;
> > +	}
> > +
> > +	memset(&props, 0, sizeof(props));
> > +	props.type = BACKLIGHT_RAW;
> > +	props.max_brightness = 1;
> > +	bl = backlight_device_register(dev_name(&pdev->dev), &pdev->dev, gbl,
> > +				       &gpio_backlight_ops, &props);
> > +	if (IS_ERR(bl)) {
> > +		dev_err(&pdev->dev, "failed to register backlight\n");
> > +		return PTR_ERR(bl);
> > +	}
> > +
> > +	bl->props.brightness = pdata->def_value;
> > +	backlight_update_status(bl);
> > +
> > +	platform_set_drvdata(pdev, bl);
> > +	return 0;
> > +}

-- 
Regards,

Laurent Pinchart

