From: Pavel Machek <pavel@ucw.cz>
Date: Sun, 15 Sep 2019 16:52:04 +0000
Subject: Re: [PATCH 1/2] backlight: lm3630a: add an enable gpio for the HWEN pin
Message-Id: <20190915165204.GA4857@bug>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190908203704.30147-1-andreas@kemnade.info>
 <20190908203704.30147-2-andreas@kemnade.info>
 <20190909105729.w5552rtop7rhghy2@holly.lan>
 <20190909221349.46ca5a1f@aktux>
 <20190910102156.vmprsjebmlphkv34@holly.lan>
 <20190910210648.3594912d@kemnade.info>
In-Reply-To: <20190910210648.3594912d@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, lee.jones@linaro.org, jingoohan1@gmail.com, jacek.anaszewski@gmail.com, dmurphy@ti.com, robh+dt@kernel.org, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>

Hi!

> > > > Is this needed?
> > > > 
> > > > This is a remove path, not a power management path, and we have no idea
> > > > what the original status of the pin was anyway?
> > > >   
> > > 
> > > Looking at Ishdn on page 5 of the datasheet, switching it off everytime
> > > possible seems not needed. We would need to call chip_init() everytime
> > > we enable the gpio or live with default values.
> > > Therefore I did decide to not put it into any power management path.
> > > But switching it on and not switching it off feels so unbalanced.   
> > 
> > Either the power consumed by the controller when strings aren't lit up
> > matters, in which case the driver should implement proper power
> > management or it doesn't matter and changing the pin state isn't needed.
> > 
> > I'm happy with either of the above but this looks like a third way,
> > where eager users could hack in a bit of extra power management by
> > forcing drivers to unbind. 
> > 
> I think I will take the simple way. I am quite sure that the power
> consumption with HWEN on and leds off does not matter. If someone
> later comes up and finds out that I misread the datasheet, things
> are prepared to be improved.

Dunno.. if the power consumption does not matter, why does the chip have the enable
pin in the first place, and why do we bother supporting it? We could hardcode the
pin to enabled as well..
									Pavel


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
