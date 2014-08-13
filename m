From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 13 Aug 2014 20:00:07 +0000
Subject: Re: [PATCH 3/4] simplefb: disable dt node upon remove
Message-Id: <CACxGe6t3+7cqgOSjof60oCO_QD65Qx_cqtMSnSgU0jttyuK9tg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-4-git-send-email-libv@skynet.be>
 <CACxGe6vaPUa4QvYWBA-QY7MTmJYoeqnPt9Zh5jpky6S9UYbrvQ@mail.gmail.com>
 <CANq1E4ReOB87RX8VhnW1Ln=SK3Tw5V962ujcsfuz-2E9Uc61yQ@mail.gmail.com>
 <CACxGe6vQrhd8QOAyGnjRppmuANpT60Ao2+KmkDfF4FNeoZSZgw@mail.gmail.com>
 <20140813094524.GC31326@skynet.be> <20140813101923.GD31326@skynet.be>
 <CAKON4OwLOAq1EOzZmuefcnZ4hw0i35e3k0F6XGNRy-5jer2vyA@mail.gmail.com>
 <CACxGe6szX3LyhGHbVHrEFfaWGYUcgcxgkuhfc9ac-R0qJs-HXw@mail.gmail.com>
 <20140813192506.GH31326@skynet.be>
In-Reply-To: <20140813192506.GH31326@skynet.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Aug 13, 2014 at 8:25 PM, Luc Verhaegen <libv@skynet.be> wrote:
> On Wed, Aug 13, 2014 at 08:14:37PM +0100, Grant Likely wrote:
>>
>> BTW, Is anyone currently using the simple framebuffer for early
>> console? For early console we would want to start using it well before
>> setting up platform devices.
>
> The code that sets up simplefb for sunxi is primarily for providing a
> console in u-boot (using the ancient cfbconsole infrastructure). From
> what i can tell, the u-boot code for rpi is about showing a splash
> screen (using the much newer lcd infrastructure).
>
> With u-boot showing a console, it really seemed only a small step to add
> simplefb. And quite a few people in our sunxi community are interested
> in it, primarily for u-boot and early console, and only secondarily as a
> stop-gap for a full driver.

Both of which make sense and should be supported, so I agree we need
to find a solution.

The problem I think comes down to the handoff mechanism. There are a
lot of different video controllers which could all be configured for a
simple framebuffer.

I don't think the "run this only once" test is the right approach.
Sometimes the simple framebuffer will never be torn down. It is
conceivable that a simple framebuffer will get /added/ at runtime with
an overlay, or even rebound to the driver. The simple framebuffer
driver really needs to be explicitly told from outside itself that it
is being taken over since it doesn't actually have the information to
know when a framebuffer becomes invalid. Only the real video driver
can provide that information.

How does the sunxi driver currently take over from the simplefb?

g.
