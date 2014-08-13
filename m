From: Luc Verhaegen <libv@skynet.be>
Date: Wed, 13 Aug 2014 20:19:16 +0000
Subject: Re: [PATCH 3/4] simplefb: disable dt node upon remove
Message-Id: <20140813201916.GJ31326@skynet.be>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-4-git-send-email-libv@skynet.be>
 <CACxGe6vaPUa4QvYWBA-QY7MTmJYoeqnPt9Zh5jpky6S9UYbrvQ@mail.gmail.com>
 <CANq1E4ReOB87RX8VhnW1Ln=SK3Tw5V962ujcsfuz-2E9Uc61yQ@mail.gmail.com>
 <CACxGe6vQrhd8QOAyGnjRppmuANpT60Ao2+KmkDfF4FNeoZSZgw@mail.gmail.com>
 <20140813094524.GC31326@skynet.be> <20140813101923.GD31326@skynet.be>
 <CAKON4OwLOAq1EOzZmuefcnZ4hw0i35e3k0F6XGNRy-5jer2vyA@mail.gmail.com>
 <CACxGe6szX3LyhGHbVHrEFfaWGYUcgcxgkuhfc9ac-R0qJs-HXw@mail.gmail.com>
 <20140813192506.GH31326@skynet.be>
 <CACxGe6t3+7cqgOSjof60oCO_QD65Qx_cqtMSnSgU0jttyuK9tg@mail.gmail.com>
In-Reply-To: <CACxGe6t3+7cqgOSjof60oCO_QD65Qx_cqtMSnSgU0jttyuK9tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Aug 13, 2014 at 09:00:07PM +0100, Grant Likely wrote:
> 
> Both of which make sense and should be supported, so I agree we need
> to find a solution.
> 
> The problem I think comes down to the handoff mechanism. There are a
> lot of different video controllers which could all be configured for a
> simple framebuffer.
> 
> I don't think the "run this only once" test is the right approach.
> Sometimes the simple framebuffer will never be torn down. It is
> conceivable that a simple framebuffer will get /added/ at runtime with
> an overlay, or even rebound to the driver. The simple framebuffer
> driver really needs to be explicitly told from outside itself that it
> is being taken over since it doesn't actually have the information to
> know when a framebuffer becomes invalid. Only the real video driver
> can provide that information.

There really are two separate issues here:
1) making sure that nothing tries to use the freshly died simplefb 
again.
2) doing a clean handover to another, usually hw specific, driver.

1 is what i hoped to superficially solve with this patch.
2 can be very smart about things as the replacement driver actually 
should know the hw.

I kind of like the idea of an "only-once" (there must be a better name 
for this) property. This allows the driver/device infrastructure to 
handle things much more cleanly, and allows me to state this from u-boot 
for sunxi, while Stephen wouldn't need to for rpi. I currently don't 
know how or where this could be handled, i just know that this smells 
like a decent solution which could solve my concern while at least 
avoiding the probe issue you mentioned earlier.

> How does the sunxi driver currently take over from the simplefb?

Not at all. A big blob of KMS code exists for our sunxi-3.4 kernel, 
where i can load the original display driver quickly and easily. This 
tree predates most of DT. I was rather hoping that the simplefb stop-gap
didn't require me to have fully engineered everything yesterday already.

Luc Verhaegen.
