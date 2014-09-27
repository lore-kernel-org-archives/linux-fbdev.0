From: Mike Turquette <mturquette@linaro.org>
Date: Sat, 27 Sep 2014 23:56:01 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140927235601.19023.31593@quantum>
List-Id: <linux-fbdev.vger.kernel.org>
References: <53FCE704.4030103@redhat.com> <53FDB46C.5010609@redhat.com>
 <20140827125613.GF23186@ulmo> <53FDE0CE.5030807@redhat.com>
 <20140827141632.GB32243@ulmo> <53FF1D6C.6090205@redhat.com>
 <20140829070116.GC13106@ulmo> <20140829141244.GH15297@lukather>
 <20140829143812.GC31264@ulmo> <20140902092508.GR15297@lukather>
In-Reply-To: <20140902092508.GR15297@lukather>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Quoting Maxime Ripard (2014-09-02 02:25:08)
> On Fri, Aug 29, 2014 at 04:38:14PM +0200, Thierry Reding wrote:
> > On Fri, Aug 29, 2014 at 04:12:44PM +0200, Maxime Ripard wrote:
> > > On Fri, Aug 29, 2014 at 09:01:17AM +0200, Thierry Reding wrote:
> > > > I would think the memory should still be reserved anyway to make sure
> > > > nothing else is writing over it. And it's in the device tree anyway
> > > > because the driver needs to know where to put framebuffer content. So
> > > > the point I was trying to make is that we can't treat the memory in the
> > > > same way as clocks because it needs to be explicitly managed. Whereas
> > > > clocks don't. The driver is simply too generic to know what to do with
> > > > the clocks.
> > > 
> > > You agreed on the fact that the only thing we need to do with the
> > > clocks is claim them. Really, I don't find what's complicated there
> > > (or not generic).
> > 
> > That's not what I agreed on. What I said is that the only thing we need
> > to do with the clocks is nothing. They are already in the state that
> > they need to be.
> 
> Claim was probably a poor choice of words, but still. We have to keep
> the clock running, and both the solution you've been giving and this
> patch do so in a generic way.
> 
> > > > It doesn't know what frequency they should be running at
> > > 
> > > We don't care about that. Just like we don't care about which
> > > frequency is the memory bus running at. It will just run at whatever
> > > frequency is appropriate.
> > 
> > Exactly. And you shouldn't have to care about them at all. Firmware has
> > already configured the clocks to run at the correct frequencies, and it
> > has made sure that they are enabled.
> > 
> > > > or what they're used for
> > > 
> > > And we don't care about that either. You're not interested in what
> > > output the framebuffer is setup to use, which is pretty much the same
> > > here, this is the same thing here.
> > 
> > That's precisely what I've been saying. The only thing that simplefb
> > cares about is the memory it should be using and the format of the
> > pixels (and how many of them) it writes into that memory. Everything
> > else is assumed to have been set up.
> > 
> > Including clocks.
> 
> We're really discussing in circles here.
> 
> Mike?
> 

-EHIGHLATENCYRESPONSE

I forgot about this thread. Sorry.

In an attempt to provide the least helpful answer possible, I will stay
clear of all of the stuff relating to "how simple should simplefb be"
and the related reserved memory discussion.

A few times in this thread it is stated that we can't prevent unused
clocks from being disabled. That is only partially true.

The clock framework DOES provide a flag to prevent UNUSED clocks from
being disabled at late_initcall-time by a clock "garbage collector"
mechanism. Maxime and others familiar with the clock framework are aware
of this.

What the framework doesn't do is to allow for a magic flag in DT, in
platform_data or elsewhere that says, "don't let me get turned off until
the right driver claims me". That would be an external or alternative
method for preventing a clock from being disabled. We have a method for
preventing clocks from being disabled. It is as follows:

struct clk *my_clk = clk_get(...);
clk_prepare_enable(my_clk);

That is how it should be done. Period.

With that said I think that Luc's approach is very sensible. I'm not
sure what purpose in the universe DT is supposed to serve if not for
_this_exact_case_. We have a nice abstracted driver, usable by many
people. The hardware details of how it is hooked up at the board level
can all be hidden behind stable DT bindings that everyone already uses.

What more could you want?

Regards,
Mike

> Your opinion would be very valuable.
> 
> > > > so by any definition of what DT should describe they're useless for
> > > > this virtual device.
> > > >
> > > > Furthermore it's fairly likely that as your kernel support progresses
> > > > you'll find that the driver all of a sudden needs to manage some other
> > > > type of resource that you just haven't needed until now because it may
> > > > default to being always on. Then you'll have a hard time keeping
> > > > backwards-compatibility and will have to resort to the kinds of hacks
> > > > that you don't want to see in the kernel.
> > > 
> > > Not such a hard time. An older DT wouldn't define the new requirements
> > > anyway, so they wouldn't be used, and we would end up in pretty much
> > > the current case.
> > 
> > Except that you have firmware in the wild that sets up an incomplete
> > simplefb node and if you don't want to break compatibility you need to
> > provide fallbacks for the resources that aren't listed in the DT node.
> > And given that those fallbacks are all very board specific you'll need
> > to find ways to keep them enabled if you want to keep existing setups
> > working.
> 
> How would an *optional* property break those users?
> 
> If you don't need any clock to be kept running (or are hiding them
> under the carpet), of course you don't need such a property.
> 
> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
