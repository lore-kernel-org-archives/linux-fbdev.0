From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Thu, 29 Oct 2015 15:40:59 +0000
Subject: Re: [PATCH v2] pwm-backlight: fix the panel power sequence
Message-Id: <1446133259.3274.52.camel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1444987060-48202-1-git-send-email-yh.huang@mediatek.com>
 <1444988219.3541.3.camel@pengutronix.de>
 <1445526750.27586.8.camel@mtksdaap41>
In-Reply-To: <1445526750.27586.8.camel@mtksdaap41>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi YH,

Am Donnerstag, den 22.10.2015, 23:12 +0800 schrieb YH Huang:
> In the case of the panel disabled by the bootloader,
> your patch still has the following code and always enables the backlight
> in the probe function.
> pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
> -						  GPIOD_OUT_HIGH);

You are right.

> What do you think if I remove these two lines in my patch?
> if (pb->enable_gpio)
> 	gpiod_direction_output(pb->enable_gpio, 0);

That won't work if the gpio is still configured as input. How about I
add the GPIOD_ASIS change to my patch you remove that and the above from
yours?

best regards
Philipp

