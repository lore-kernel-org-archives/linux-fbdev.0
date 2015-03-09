From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Mon, 09 Mar 2015 16:16:57 +0000
Subject: Re: [PATCH] video: ARM CLCD: Added dt support to set tim2 register
Message-Id: <20150309161657.GV8656@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1424898082-1522-1-git-send-email-arun.ramamurthy@broadcom.com>
 <1425312688.3092.10.camel@arm.com>
 <54F4B583.4000005@broadcom.com>
 <1425376977.3092.26.camel@arm.com>
 <1425378127.3092.38.camel@arm.com>
In-Reply-To: <1425378127.3092.38.camel@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pawel Moll <pawel.moll@arm.com>
Cc: Arun Ramamurthy <arun.ramamurthy@broadcom.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Jonathan Richardson <jonathar@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>

On Tue, Mar 03, 2015 at 10:22:07AM +0000, Pawel Moll wrote:
> On Tue, 2015-03-03 at 10:02 +0000, Pawel Moll wrote:
> > On Mon, 2015-03-02 at 19:09 +0000, Arun Ramamurthy wrote:
> > > > The existing bindings intentionally avoided quoting internal registers -
> > > > they are supposed to describe how the hardware is wired up...
> > > >
> > > > So how about something like "arm,pl11x,tft-invert-clac"? Then the driver
> > > > sets the bit or not, depending on the property existance?
> > > >
> > > Sure, I can change it to two properties called arm,pl11x,tft-invert-clac 
> > > and arm,pl11x,tft-clksel. Would that be acceptable?
> > 
> > That would be fine by me :-)
> 
> Or (after having a look at the TRM) I should rather say: the invert-clac
> is fine by me :-) but the tft-clksel doesn't work, I afraid.
> 
> If I'm not mistaken, there are two problems with it.
> 
> Number one: it's not TFT-specific, is it? So it certainly should not
> have the "tft-" bit.
> 
> Number two: setting this bit says "do not use CLCDCLK for the logic; use
> HCLK instead", correct? If so, have a look at the clock properties. They
> say:
> 
> - clock-names: should contain "clcdclk" and "apb_pclk"
> 
> - clocks: contains phandle and clock specifier pairs for the entries
>         in the clock-names property. See
> 
> So if your hardware has the reference clock wired to HCLK, and you
> defining the clocks as "clcdclk", you are (no offence meant ;-)
> lying :-)

No.  The CLCD block always takes two clock signals - the AHB bus clock
(HCLK) for the slave interface, and a CLCD clock.

The CLCDCLKSEL is a bit which affects a signal sent to the world outside
of the CLCD block, which is used to drive an _external_ multiplexer to
select the CLCD clock source.  (See the description for bit 5 of the
LCDTiming2 register.)

So, the clock is still input to the CLCDCLK input, even if it is ultimately
derived from HCLK.

Remember, the clock API does not deal with names describing the source of
the clock, but the consumer of the clock.  The consumer in this case is
the PL11x CLCD block, which takes a CLCDCLK input.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
