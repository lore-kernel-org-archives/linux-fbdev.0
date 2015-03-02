From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Mon, 02 Mar 2015 16:11:22 +0000
Subject: Re: [PATCH] video: ARM CLCD: Added support for FBIOPAN_DISPLAY and virtual y resolution
Message-Id: <20150302161122.GP8656@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1424898082-1522-1-git-send-email-arun.ramamurthy@broadcom.com>
 <1424898082-1522-2-git-send-email-arun.ramamurthy@broadcom.com>
 <1425312509.3092.7.camel@arm.com>
In-Reply-To: <1425312509.3092.7.camel@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pawel Moll <pawel.moll@arm.com>
Cc: Arun Ramamurthy <arun.ramamurthy@broadcom.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Jonathan Richardson <jonathar@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>

On Mon, Mar 02, 2015 at 04:08:29PM +0000, Pawel Moll wrote:
> I'm not sure about this... The word "virtual" never works well with
> device tree nodes defined as "hardware description".
> 
> I understand what you're doing, but adding this property to the display
> controller's node doesn't sound right. How does this describe hardware?
> If anywhere, it's more like a job for the panel node?

A better description (and implementation) would be to describe the size
of the RAM available for video purposes.  The driver can then use the
requested virtual X resolution to limit (and/or compute) the virtual Y
resolution to allow Y panning/wrapping of the display.

This would match some hardware where the video RAM is indeed a separate
physical set of RAM (such as the IM-PD/1).

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
