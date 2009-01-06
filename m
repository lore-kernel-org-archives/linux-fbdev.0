From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: [RFC 2.6.27 1/1] gpiolib: add support for batch set of pins
Date: Tue, 6 Jan 2009 18:02:38 -0500
Message-ID: <200901061802.39072.rgetz@blackfin.uclinux.org>
References: <12276535632759-git-send-email-jayakumar.lkml@gmail.com> <200812281346.56703.rgetz@blackfin.uclinux.org> <1230501634.16910.57.camel@linux-51e8.site>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <1230501634.16910.57.camel@linux-51e8.site>
Content-Disposition: inline
Sender: linux-embedded-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Ben Nizette <bn@niasdigital.com>
Cc: Jaya Kumar <jayakumar.lkml@gmail.com>, David Brownell <david-b@pacbell.net>, Eric Miao <eric.y.miao@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Eric Miao <eric.miao@marvell.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <rmk@arm.linux.org.uk>, Ben Gardner <bgardner@wabtec.com>, Greg KH <greg@kroah.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-embedded@vger.kernel.org

On Sun 28 Dec 2008 17:00, Ben Nizette pondered:
> On Sun, 2008-12-28 at 13:46 -0500, Robin Getz wrote:
> > > gpio_set_batch(DB0, value, 0xFFFF, 16)
> > > 
> > > which has the nice performance benefit of skipping all the bit
> > > counting in the most common use case scenario.
> > 
> > but has the requirement that the driver know exactly the board level 
> > impmentation details (something that doesn't sound generic).
> 
> The original use case for these batch operations was in a fastpath -
> setting data lines on a framebuffer.  Sure it's arguably not as generic
> as may be, but it optimises for speed and current usage patterns - I'm
> OK with that.  Other usage patterns which don't have a speed requirement
> can be done using the individual pin operations and a loop.

The tradeoff for speed is always made with extensibility. If you want best
speed - you shouldn't be using the GPIO framework at all - just bang directly
on the registers yourself...

If you want something extensible/generic that serves multiple use cases - 
it will normally come with a performance tradeoff...

> > > While we are here, I was thinking about it, and its better if I give
> > > gpio_request/free/direction_batch a miss for now. Nothing prevents
> > > those features being added at a later point.
> > 
> > I don't think that request/free are optional.
> > 
> > For example - in most SoC implementations - gpios are implemented as
> > banks of 16 or 32. (a 16 or 32 bit register).
> > 
> > Are there facilities to span these registers? 
> >  - can you request 64 gpios as a 'bank'?
> >  - can you request gpio_8 -> gpio_40 as a 'bank' on a 32-bit system?
> > 
> > Are non-adjacent/non-contiguous gpios avaliable to be put into 
> > a 'bank/batch/bus'? can you use gpio_8 -> 11 &  28 -> 31 as a 8-bit
> > 'bus'? 
> > 
> > How do you know what is avaliable to be talked to as a bank/bus/batch
> > without the request/free operation?
> 
> I think the read/write operations should be able to fail if you give
> them invalid chunks of gpio, sure. 

Can you define "invalid"? what are the limitations?

Can I use gpio_8 -> 11 &  28 -> 31 as a chunk?

> Request/free are not really designed 
> for that operation - they just ensure exclusive access to a gpio if
> that's what the driver wants.  In the batch case the
> request/free/direction operations can once again be performed by single
> pin operations and iteration.

That depends on the semantics of "request". 

If it is "request & build up a monolithic chunk from xxx GPIO's" - then
my definition works.

 
> > I have seen various hardware designs (both at the PCB and SoC level)
> > require all of these options, and would like to see common infrastructure
> > which handles this.
>
> Yeah the request/free operation doesn't deal with muxing or any other
> platform-specific kinda gumph, that was an original design decision.
> They're really just a usage counter.

Sorry for bringing up the muxing - that wasn't the point.

It was really the issue of being non-contiguous, spanning various implementations.

> An example which comes to mind is the avr32-specific userspace gpio
> interface.  This takes a bitmask, loops over the set bits and fails if
> any of the gpio are previously requested or have been assigned to
> non-gpio peripherals. 

I'll have a look. I don't understand why everyone decided to make their own
userspace GPIO interface - can't we all just get along? :)

> I don't really see a need to streamline this. 



> > I would think that a 'bank' / 'bus' (whatever) would be a collection
> > of random/multiple GPIOs (a struct of gpio_port_t) rather than a
> > start/length (as you described) - or better yet - the request 
> > function takes a list (of individual GPIO's - defined in the 
> > platform data), and creates the struct itself.
> 
> Hmm, this seems a little overengineered for the basic use-cases I can
> think of. 

Not the ones I run into all the time...

More complex pin multiplexing results in less contiguous free GPIO.
(which again - has nothing to do with multiplexing - it is the result
that is the important thing).

> If this can be cranked up to the same speed as the current 
> proposition then OK maybe someone will like it but otherwise, once
> again, I think most people will be happy with individual operations and
> iteration.

It will be easier to maintain (from a end user perceptive - if someone 
wants a "chunk" of gpio's - they just define it in their platform data). 
It does put a bigger burden on the person writing things.

I would think that the overhead would only be at init - runtime shouldn't
be much different in the simple case, but allowing the complex usecases
with the same interface is better (since we only have to teach people one
thing) :)

-Robin
