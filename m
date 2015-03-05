From: Pawel Moll <pawel.moll@arm.com>
Date: Thu, 05 Mar 2015 10:59:14 +0000
Subject: Re: [PATCH] video: ARM CLCD: Added dt support to set tim2 register
Message-Id: <1425553154.3092.76.camel@arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1424898082-1522-1-git-send-email-arun.ramamurthy@broadcom.com>
	 <1425312688.3092.10.camel@arm.com> <54F4B583.4000005@broadcom.com>
	 <1425376977.3092.26.camel@arm.com> <1425378127.3092.38.camel@arm.com>
	 <54F653B9.4010507@broadcom.com>
In-Reply-To: <54F653B9.4010507@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Jonathan Richardson <jonathar@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>

On Wed, 2015-03-04 at 00:37 +0000, Arun Ramamurthy wrote:
> > That way you're precisely describing the way the hardware is wired up.
> > And the driver simply tries to get clcdclk first, if it's defined -
> > cool, set clksel to 1, if not - try hclk and set clksel to 0. If neither
> > of them is present - bail out.
> >
> > Does this make any sense?
> >
> This makes sense to me, thank you for the suggestions. I will fix it all 
> up in V2

Cool. Just a word of comment to my own words ;-) The "bail out" case was
a bad idea - the non-DT use cases more likely than not will have no
clock name defined. So, to maintain backward compatibility, the driver
will still have to work when no named clock is available. I think the
simplest way to do that is to check if "hclk" is available, and use it
if it is (setting the clksel accordingly). Otherwise - proceed as it was
the case previously.

Pawel

