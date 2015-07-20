From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Date: Mon, 20 Jul 2015 17:45:32 +0000
Subject: Re: [PATCH] backlight: pm8941-wled: Move PM8941 WLED driver to backlight
Message-Id: <20150720174532.GA4753@usrtlx11787.corpusers.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1436990540-23354-1-git-send-email-bjorn.andersson@sonymobile.com>
 <004501d0c2f7$7ee51f40$7caf5dc0$@com>
In-Reply-To: <004501d0c2f7$7ee51f40$7caf5dc0$@com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: 'Rob Herring' <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, 'Pawel Moll' <pawel.moll-5wv7dgnIgG8@public.gmane.org>, 'Mark Rutland' <mark.rutland-5wv7dgnIgG8@public.gmane.org>, 'Ian Campbell' <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, 'Kumar Gala' <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, 'Bryan Wu' <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 'Richard Purdie' <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, 'Jacek Anaszewski' <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Lee Jones' <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Jean-Christophe Plagniol-Villard' <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, 'Tomi Valkeinen' <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, 'Rob Clark' <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mon 20 Jul 07:22 PDT 2015, Jingoo Han wrote:

> On Thursday, July 16, 2015 5:02 AM, Bjorn Andersson wrote:
> > 
> > The Qualcomm PM8941 WLED block is used for backlight and should therefor
> > be in the backlight framework and not in the LED framework. This moves
> > the driver and adapts to the backlight api instead.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> > ---
> >  .../devicetree/bindings/leds/leds-pm8941-wled.txt  |  5 +-
> >  drivers/leds/Kconfig                               |  8 ---
> >  drivers/leds/Makefile                              |  1 -
> >  drivers/video/backlight/Kconfig                    |  8 +++
> >  drivers/video/backlight/Makefile                   |  1 +
> >  .../backlight/pm8941-wled.c}                       | 59 ++++++++++------------
> >  6 files changed, 36 insertions(+), 46 deletions(-)
> >  rename drivers/{leds/leds-pm8941-wled.c => video/backlight/pm8941-wled.c} (90%)
> > 
> > diff --git a/Documentation/devicetree/bindings/leds/leds-pm8941-wled.txt
> > b/Documentation/devicetree/bindings/leds/leds-pm8941-wled.txt
> > index a85a964d61f5..424f8444a6cd 100644
> > --- a/Documentation/devicetree/bindings/leds/leds-pm8941-wled.txt
> > +++ b/Documentation/devicetree/bindings/leds/leds-pm8941-wled.txt
> 
> Please move this txt file to 'backlight' directory.
> 

Of course

[..]

> > diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> > index 0505b796d743..6c67c5430933 100644
> > --- a/drivers/video/backlight/Kconfig
> > +++ b/drivers/video/backlight/Kconfig
> > @@ -299,6 +299,14 @@ config BACKLIGHT_TOSA
> >  	  If you have an Sharp SL-6000 Zaurus say Y to enable a driver
> >  	  for its backlight
> > 
> > +config BACKLIGHT_PM8941_WLED
> > +	tristate "Qualcomm PM8941 WLED Driver"
> > +	depends on LEDS_CLASS
> 
> LEDS_CLASS?
> Please check your patch carefully.
> 

Sorry about that.

> One more thing,
> Did you test this patch with the board?
> If not, I will not accept this patch, unless other people send 'Tested-by'.

I've tested the driver on the Sony Xperia Z3 and it visually behaves as
expected.

I'll send you an updated patch shortly.

Thank you,
Bjorn
