From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Mon, 02 Nov 2015 16:30:47 +0000
Subject: Re: [PATCH] pwm-backlight: Avoid backlight flicker when probed from DT
Message-Id: <1446481847.3442.61.camel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1446133906-3076-1-git-send-email-p.zabel@pengutronix.de>
 <20151030182113.GH4058@x1>
In-Reply-To: <20151030182113.GH4058@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Lee,

Am Freitag, den 30.10.2015, 18:21 +0000 schrieb Lee Jones:
> > @@ -264,12 +266,32 @@ static int pwm_backlight_probe(struct platform_device *pdev)
> >  		pb->enable_gpio = gpio_to_desc(data->enable_gpio);
> >  	}
> >  
> > +	phandle = of_find_property(pdev->dev.of_node, "phandle", NULL) != NULL;
> 
> This is a little ugly.
> 
> If this is the only way to identify the probedness of a device then
> you probably want to neaten it up a little.  I suggest something along
> the lines of:
>
> if (of_find_property(pdev->dev.of_node, "phandle", NULL))
> 	already_probed = true;
> 
> Also, do you also want to check for "linux,phandle", as this is always
> catered for in drivers/of/*

Thanks for pointing this out. I suppose I should just check
pdev->dev.of_node->phandle != 0 instead. That will already be
initialized by unflatten_dt_node if either property was found.

regards
Philipp

