From: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
Date: Mon, 02 Mar 2015 19:09:51 +0000
Subject: Re: [PATCH] video: ARM CLCD: Added support for FBIOPAN_DISPLAY and virtual y resolution
Message-Id: <54F4B57F.3030306@broadcom.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1424898082-1522-1-git-send-email-arun.ramamurthy@broadcom.com> <1424898082-1522-2-git-send-email-arun.ramamurthy@broadcom.com> <1425312509.3092.7.camel@arm.com> <20150302161122.GP8656@n2100.arm.linux.org.uk>
In-Reply-To: <20150302161122.GP8656@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Jonathan Richardson <jonathar@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>



On 15-03-02 08:11 AM, Russell King - ARM Linux wrote:
> On Mon, Mar 02, 2015 at 04:08:29PM +0000, Pawel Moll wrote:
>> I'm not sure about this... The word "virtual" never works well with
>> device tree nodes defined as "hardware description".
>>
>> I understand what you're doing, but adding this property to the display
>> controller's node doesn't sound right. How does this describe hardware?
>> If anywhere, it's more like a job for the panel node?
>
I see what you are saying Pawel, I can follow Russell's recommendation 
of adding a RAM size node called max-memory-available or something similar
> A better description (and implementation) would be to describe the size
> of the RAM available for video purposes.  The driver can then use the
> requested virtual X resolution to limit (and/or compute) the virtual Y
> resolution to allow Y panning/wrapping of the display.
>

In this scenario, where would I specify the virtual X resolution? I am 
assuming it would be in the panel-timing node as Pawel suggested?

> This would match some hardware where the video RAM is indeed a separate
> physical set of RAM (such as the IM-PD/1).
>
