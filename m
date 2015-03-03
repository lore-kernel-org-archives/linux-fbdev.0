From: Pawel Moll <pawel.moll@arm.com>
Date: Tue, 03 Mar 2015 10:02:57 +0000
Subject: Re: [PATCH] video: ARM CLCD: Added dt support to set tim2 register
Message-Id: <1425376977.3092.26.camel@arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1424898082-1522-1-git-send-email-arun.ramamurthy@broadcom.com>
	 <1425312688.3092.10.camel@arm.com> <54F4B583.4000005@broadcom.com>
In-Reply-To: <54F4B583.4000005@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Jonathan Richardson <jonathar@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>

On Mon, 2015-03-02 at 19:09 +0000, Arun Ramamurthy wrote:
> > The existing bindings intentionally avoided quoting internal registers -
> > they are supposed to describe how the hardware is wired up...
> >
> > So how about something like "arm,pl11x,tft-invert-clac"? Then the driver
> > sets the bit or not, depending on the property existance?
> >
> Sure, I can change it to two properties called arm,pl11x,tft-invert-clac 
> and arm,pl11x,tft-clksel. Would that be acceptable?

That would be fine by me :-)

Pawel

