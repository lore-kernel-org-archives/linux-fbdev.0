From: Pawel Moll <pawel.moll@arm.com>
Date: Tue, 03 Mar 2015 10:22:07 +0000
Subject: Re: [PATCH] video: ARM CLCD: Added dt support to set tim2 register
Message-Id: <1425378127.3092.38.camel@arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1424898082-1522-1-git-send-email-arun.ramamurthy@broadcom.com>
	 <1425312688.3092.10.camel@arm.com> <54F4B583.4000005@broadcom.com>
	 <1425376977.3092.26.camel@arm.com>
In-Reply-To: <1425376977.3092.26.camel-5wv7dgnIgG8@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arun Ramamurthy <arun.ramamurthy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Anatol Pomazau <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, "bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org" <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

On Tue, 2015-03-03 at 10:02 +0000, Pawel Moll wrote:
> On Mon, 2015-03-02 at 19:09 +0000, Arun Ramamurthy wrote:
> > > The existing bindings intentionally avoided quoting internal registers -
> > > they are supposed to describe how the hardware is wired up...
> > >
> > > So how about something like "arm,pl11x,tft-invert-clac"? Then the driver
> > > sets the bit or not, depending on the property existance?
> > >
> > Sure, I can change it to two properties called arm,pl11x,tft-invert-clac 
> > and arm,pl11x,tft-clksel. Would that be acceptable?
> 
> That would be fine by me :-)

Or (after having a look at the TRM) I should rather say: the invert-clac
is fine by me :-) but the tft-clksel doesn't work, I afraid.

If I'm not mistaken, there are two problems with it.

Number one: it's not TFT-specific, is it? So it certainly should not
have the "tft-" bit.

Number two: setting this bit says "do not use CLCDCLK for the logic; use
HCLK instead", correct? If so, have a look at the clock properties. They
say:

- clock-names: should contain "clcdclk" and "apb_pclk"

- clocks: contains phandle and clock specifier pairs for the entries
        in the clock-names property. See

So if your hardware has the reference clock wired to HCLK, and you
defining the clocks as "clcdclk", you are (no offence meant ;-)
lying :-)

So how about solving the problem by extending the clock-names definition
like this (feel free to use own wording):

- clock-names: should contain two clocks, either "clcdclk" or "hclk"
               (depending on which input is to be used as a reference
               clock by the controller logic) and "apb_pclk"

That way you're precisely describing the way the hardware is wired up.
And the driver simply tries to get clcdclk first, if it's defined -
cool, set clksel to 1, if not - try hclk and set clksel to 0. If neither
of them is present - bail out.

Does this make any sense?

Pawel

