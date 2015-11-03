From: YH Huang <yh.huang@mediatek.com>
Date: Tue, 03 Nov 2015 08:11:39 +0000
Subject: Re: [PATCH v2] pwm-backlight: fix the panel power sequence
Message-Id: <1446538299.2449.8.camel@mtksdaap41>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1444987060-48202-1-git-send-email-yh.huang@mediatek.com>
 <1444988219.3541.3.camel@pengutronix.de>
 <1445526750.27586.8.camel@mtksdaap41>
 <1446133259.3274.52.camel@pengutronix.de>
 <1446190900.17558.16.camel@mtksdaap41>
 <1446201271.3334.22.camel@pengutronix.de>
In-Reply-To: <1446201271.3334.22.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, 2015-10-30 at 11:34 +0100, Philipp Zabel wrote:
> Am Freitag, den 30.10.2015, 15:41 +0800 schrieb YH Huang:
> > > That won't work if the gpio is still configured as input. How about I
> > > add the GPIOD_ASIS change to my patch you remove that and the above from
> > > yours?
> > 
> > I revise these two lines 
> > if (pb->enable_gpio)
> > 	gpiod_direction_output(pb->enable_gpio, 0);
> > into
> > if (pb->enable_gpio) {
> > 	if(gpiod_get_value(pb->enable_gpio) = 0)
> > 		gpiod_direction_output(pb->enable_gpio, 0);
> > 	else
> > 		gpiod_direction_output(pb->enable_gpio, 1);
> > }
> 
> If the GPIO is still configured as an input, the return value of
> gpiod_get_value could be random.
> 
> > I am not sure what "phandle" is working for.
> 
> The reasoning is that devices where there is no phandle link pointing to
> the backlight (for example from a simple-panel node), we should keep the
> current default behaviour (enable during probe).

I have a little problem for the current default behaviour.
Should we enable during probe?

Before this patch ( http://patchwork.ozlabs.org/patch/324690/ ),
we disable "enable-gpio" in the probe function.

Do you have any idea of this?

Regards,
YH Huang


