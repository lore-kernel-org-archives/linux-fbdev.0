From: Tony Lindgren <tony@atomide.com>
Date: Thu, 15 May 2014 18:25:48 +0000
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree support
Message-Id: <20140515182548.GD23659@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398815562-24113-4-git-send-email-tony@atomide.com>
 <5369EAE7.3030705@ti.com> <20140507150343.GA9502@atomide.com>
 <536A5920.1020908@ti.com> <20140507175919.GH9502@atomide.com>
 <20140508233300.GI2198@atomide.com> <536C924E.5000307@ti.com>
 <20140509153008.GC17814@atomide.com>
 <20140513212639.GA18001@atomide.com> <53747DD5.2030406@ti.com>
In-Reply-To: <53747DD5.2030406@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140515 01:42]:
> On 14/05/14 00:26, Tony Lindgren wrote:
> 
> > +	/* lcd MO */
> > +	ddata->mo_gpio = sharp_ls_get_gpio_of(&pdev->dev, 0, 1, "mode");
> > +	if (PTR_ERR(ddata->mo_gpio) = -EPROBE_DEFER)
> > +		return -EPROBE_DEFER;
> > +
> > +	if (!IS_ERR(ddata->mo_gpio))
> > +		if (gpiod_get_raw_value_cansleep(ddata->mo_gpio))
> > +			ddata->flags |= SHARP_LS_QVGA;
> 
> Shouldn't there be an explicit flag in the DT data for this? If the
> panel's MO pin is hardwired to, say, pull up, then the mode-gpios won't
> have MO gpio, right? So something like:
> 
> 
> mode-gpios = <0					/* high, lcd MO */
> 	      &gpio1 2 GPIO_ACTIVE_HIGH		/* gpio2, lcd LR */
> 	      &gpio1 3 GPIO_ACTIVE_HIGH>;	/* gpio3, lcd UD */
> 
> vga-mode;	/* MO hardwired high */
 
Yeah holes there are just fine. I figured let's keep the custom
vga-mode property out of the way until we actually run into a panel
that's not using a GPIO for mode.

So far it seems that mode GPIO is there for the panels I've seen,
just the scan direction pins seem to be hard wired on LDP. But
then again, maybe I'm still having trouble locating all the
GPIOs in the LDP schematics.
 
> Btw, the gpio.txt has each gpio inside <>:
> 
> chipsel-gpios = <&gpio1 12 0>,
> 		 <&gpio1 13 0>,
> 		 <0>, /* holes are permitted, means no GPIO 2 */
> 		 <&gpio2 2>;
> 
> Is that equivalent to having all gpios inside <>?

Yeah, just less <> braces. The number of elements for each
entry is what matters and that's known by the GPIO parsing
code.

Regards,

Tony
