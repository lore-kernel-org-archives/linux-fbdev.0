From: Ondrej Zary <linux@rainbow-software.org>
Date: Wed, 02 Sep 2015 12:04:37 +0000
Subject: Re: [PATCH 4/4] [resend #2] tridentfb: Add DDC support
Message-Id: <201509021404.37885.linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440445048-24694-1-git-send-email-linux@rainbow-software.org> <1440445048-24694-4-git-send-email-linux@rainbow-software.org> <55E6DDC3.3030709@ti.com>
In-Reply-To: <55E6DDC3.3030709@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Krzysztof Helt <krzysztof.h1@wp.pl>, linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

On Wednesday 02 September 2015, Tomi Valkeinen wrote:
> Hi,
>
> On 24/08/15 22:37, Ondrej Zary wrote:
> > Add DDC support for Trident cards.
> >
> > Tested on TGUI9440, TGUI9680, 3DImage 9750, Blade3D 9880 and Blade XP.
> >
> > Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
> > ---
> >  drivers/video/fbdev/Kconfig     |    9 ++
> >  drivers/video/fbdev/tridentfb.c |  192
> > ++++++++++++++++++++++++++++++++++++++- 2 files changed, 196
> > insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> > index 2d98de5..e2531b8 100644
> > --- a/drivers/video/fbdev/Kconfig
> > +++ b/drivers/video/fbdev/Kconfig
> > @@ -1680,6 +1680,15 @@ config FB_TRIDENT
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called tridentfb.
> >
> > +config FB_TRIDENT_DDC
> > +	bool "DDC for Trident support"
> > +	depends on FB_TRIDENT
> > +	select FB_DDC
> > +	select FB_MODE_HELPERS
> > +	default y
> > +	help
> > +	  Say Y here if you want DDC support for your Trident graphics card.
> > +
>
> Why would somebody not want this enabled? Is there some drawback if it's
> enabled?

It's probably an useless config option but many fbdev drivers have it. I have 
no problem removing it.

-- 
Ondrej Zary
