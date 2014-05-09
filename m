From: Tony Lindgren <tony@atomide.com>
Date: Fri, 09 May 2014 15:37:23 +0000
Subject: Re: [PATCH 4/4] ARM: dts: Add LCD panel sharp ls037v7dw01 support for omap3-evm and ldp
Message-Id: <20140509153723.GD17814@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-5-git-send-email-tony@atomide.com>
 <CAGhQ9Vwa8xXQEo5dNEKAvmaS9DoBjVSthtd8=owk+atVdFuiiA@mail.gmail.com>
 <20140430174751.GA12362@atomide.com>
 <20140505183919.GA15463@atomide.com>
 <20140508233628.GJ2198@atomide.com> <536C7EA7.5000306@ti.com>
In-Reply-To: <536C7EA7.5000306@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140509 00:08]:
> On 09/05/14 02:36, Tony Lindgren wrote:
> 
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/omap-panel-sharp-ls037v7dw01.dtsi
> > @@ -0,0 +1,82 @@
> > +/*
> > + * Common file for omap dpi panels with QVGA and reset pins
> > + *
> > + * Note that the board specifc DTS file needs to specify
> > + * at minimum the GPIO enable-gpios for display, and
> > + * gpios for gpio-backlight.
> > + */
> 
> This looks very board specific to me... The regulator and the use of
> mcspi1 depend on the board, so this file can't be used on just any omap
> board with the same panel. And this can (probably) only be used on
> boards with a single display. Do those boards have tv-out?

Yes there's also TV out and DVI on omap3-evm, LDP just has DVI.

It seems that all omap3 boards using this are pretty much wired
the same way.
 
> So I have nothing against having common files, but shouldn't this be
> named something more specific? If the boards involved are TI's OMAP3
> development boards, maybe this should be something like...
> omap3-ti-dev-panel-sharp-ls037v7dw01.dtsi. Well, that's a quite long one.

Yeah let's use omap3-panel-sharp-ls037v7dw01.dtsi. Looking at the
legacy board files that should cover quite a few of them.

I guess it might also work on 2430sdp, but let's assume omap3
for now.
 
> > +/ {
> > +	aliases {
> > +		display0 = &lcd0;
> > +	};
> > +
> > +	backlight0: backlight {
> > +		compatible = "gpio-backlight";
> > +	};
> > +
> > +	/* 3.3V GPIO controlled regulator for LCD_ENVDD */
> > +	lcd_3v3: regulator-lcd-3v3 {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "lcd_3v3";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		startup-delay-us = <70000>;
> > +		regulator-always-on;
> 
> Why always-on?

Oops, yeah that should not be there. The GPIO is board specific.

Regards,

Tony
