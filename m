From: Michal Suchanek <hramrach@gmail.com>
Date: Mon, 29 Sep 2014 18:06:30 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <CAOMqctToACLOPL5jamJikkywzLJwuoez61DUGrHsgSqEavNwNw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <53FDB46C.5010609@redhat.com> <20140827125613.GF23186@ulmo>
 <53FDE0CE.5030807@redhat.com> <20140827141632.GB32243@ulmo>
 <53FF1D6C.6090205@redhat.com> <20140829070116.GC13106@ulmo>
 <20140829141244.GH15297@lukather> <20140829143812.GC31264@ulmo>
 <20140902092508.GR15297@lukather> <20140927235601.19023.31593@quantum>
 <20140929080637.GB12506@ulmo>
 <CAKON4Oy13uu1FTjCwH5EPa0UF9kRs7DqQf2Jcc2E_XKLfXX4_Q@mail.gmail.com>
In-Reply-To: <CAKON4Oy13uu1FTjCwH5EPa0UF9kRs7DqQf2Jcc2E_XKLfXX4_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 29 September 2014 19:51, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
> On Mon, Sep 29, 2014 at 4:06 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
>>
>> On Sat, Sep 27, 2014 at 04:56:01PM -0700, Mike Turquette wrote:
>> > Quoting Maxime Ripard (2014-09-02 02:25:08)
>> > > On Fri, Aug 29, 2014 at 04:38:14PM +0200, Thierry Reding wrote:
>> > > > On Fri, Aug 29, 2014 at 04:12:44PM +0200, Maxime Ripard wrote:
>> > > > > On Fri, Aug 29, 2014 at 09:01:17AM +0200, Thierry Reding wrote:
>> > > > > > I would think the memory should still be reserved anyway to make sure
>> > > > > > nothing else is writing over it. And it's in the device tree anyway
>> > > > > > because the driver needs to know where to put framebuffer content. So
>> > > > > > the point I was trying to make is that we can't treat the memory in the
>> > > > > > same way as clocks because it needs to be explicitly managed. Whereas
>> > > > > > clocks don't. The driver is simply too generic to know what to do with
>> > > > > > the clocks.
>> > > > >
>> > > > > You agreed on the fact that the only thing we need to do with the
>> > > > > clocks is claim them. Really, I don't find what's complicated there
>> > > > > (or not generic).
>> > > >
>> > > > That's not what I agreed on. What I said is that the only thing we need
>> > > > to do with the clocks is nothing. They are already in the state that
>> > > > they need to be.
>> > >
>> > > Claim was probably a poor choice of words, but still. We have to keep
>> > > the clock running, and both the solution you've been giving and this
>> > > patch do so in a generic way.
>> > >
>> > > > > > It doesn't know what frequency they should be running at
>> > > > >
>> > > > > We don't care about that. Just like we don't care about which
>> > > > > frequency is the memory bus running at. It will just run at whatever
>> > > > > frequency is appropriate.
>> > > >
>> > > > Exactly. And you shouldn't have to care about them at all. Firmware has
>> > > > already configured the clocks to run at the correct frequencies, and it
>> > > > has made sure that they are enabled.
>> > > >
>> > > > > > or what they're used for
>> > > > >
>> > > > > And we don't care about that either. You're not interested in what
>> > > > > output the framebuffer is setup to use, which is pretty much the same
>> > > > > here, this is the same thing here.
>> > > >
>> > > > That's precisely what I've been saying. The only thing that simplefb
>> > > > cares about is the memory it should be using and the format of the
>> > > > pixels (and how many of them) it writes into that memory. Everything
>> > > > else is assumed to have been set up.
>> > > >
>> > > > Including clocks.
>> > >
>> > > We're really discussing in circles here.
>> > >
>> > > Mike?
>> > >
>> >
>> > -EHIGHLATENCYRESPONSE
>> >
>> > I forgot about this thread. Sorry.
>> >
>> > In an attempt to provide the least helpful answer possible, I will stay
>> > clear of all of the stuff relating to "how simple should simplefb be"
>> > and the related reserved memory discussion.
>> >
>> > A few times in this thread it is stated that we can't prevent unused
>> > clocks from being disabled. That is only partially true.
>> >
>> > The clock framework DOES provide a flag to prevent UNUSED clocks from
>> > being disabled at late_initcall-time by a clock "garbage collector"
>> > mechanism. Maxime and others familiar with the clock framework are aware
>> > of this.
>> >
>> > What the framework doesn't do is to allow for a magic flag in DT, in
>> > platform_data or elsewhere that says, "don't let me get turned off until
>> > the right driver claims me". That would be an external or alternative
>> > method for preventing a clock from being disabled. We have a method for
>> > preventing clocks from being disabled. It is as follows:
>> >
>> > struct clk *my_clk = clk_get(...);
>> > clk_prepare_enable(my_clk);
>> >
>> > That is how it should be done. Period.
>> >
>> > With that said I think that Luc's approach is very sensible. I'm not
>> > sure what purpose in the universe DT is supposed to serve if not for
>> > _this_exact_case_. We have a nice abstracted driver, usable by many
>> > people. The hardware details of how it is hooked up at the board level
>> > can all be hidden behind stable DT bindings that everyone already uses.
>>
>> simplefb doesn't deal at all with hardware details. It simply uses what
>> firmware has set up, which is the only reason why it will work for many
>> people. What is passed in via its device tree node is the minimum amount
>> of information needed to draw something into the framebuffer. Also note
>> that the simplefb device tree node is not statically added to a DTS file
>> but needs to be dynamically generated by firmware at runtime.
>>
>> If we start extending the binding with board-level details we end up
>> duplicating the device tree node for the proper video device. Also note
>> that it won't stop at clocks. Other setups will require regulators to be
>
>
> This is the key point -- if a design requires duplicating information
> in the device tree, the design is broken. The list of clocks is being
> duplicated, that is broken design.
>
> Device trees are supposed to reflect the hardware. They are not
> supposed to be manipulated into supporting a specific feature on a
> single OS.

Where is the duplication?

If the firmware sets up some clocks in order to scan out a memory
buffer to a display the firmware knows which clocks it used and can
record this in the DT. Presumably the OS then does not need to know
about display hardware and can just read the list. If the OS happens
to have (or later load) a KMS driver that driver has a list of clocks
it uses for driving the display. This will be a superset of what the
firmware used to set up the scanout buffer - for example, the firmware
will probably not turn on any graphics accelerator, and it will
probably configure only one of multiple possible output
configurations.

You can, of course, record some or all of this information statically
and just have the firmware set up what is in the DT without even
reading it. This is however not very flexible - if the firmware can
select to enable different display outputs or set different resolution
it should record that in the DT so that the kernel knows what it set
up. Also if the DT does not match your firmware settings you have a
problem. That's why it is more desirable for the firmware to be able
to record the hardware state it hands over in the DT at boot time.

Thanks

Michal
