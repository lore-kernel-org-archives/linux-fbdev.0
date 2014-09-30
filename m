From: Michal Suchanek <hramrach@gmail.com>
Date: Tue, 30 Sep 2014 09:38:50 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <CAOMqctRM1YZBR+p=0R39BSX_GT6XagPcb4HBG1BqW1OqyB48zw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum>
 <20140929080637.GB12506@ulmo> <20140929092301.GC4388@lukather>
 <20140929101805.GB26008@ulmo> <20140929114643.GB4081@lukather>
 <20140929134708.GB30998@ulmo> <20140929162814.GE4081@lukather>
 <20140930052110.GC29874@ulmo> <20140930075258.GH4081@lukather>
 <20140930085429.GB4059@ulmo>
In-Reply-To: <20140930085429.GB4059@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 30 September 2014 10:54, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Tue, Sep 30, 2014 at 09:52:58AM +0200, Maxime Ripard wrote:
>> On Tue, Sep 30, 2014 at 07:21:11AM +0200, Thierry Reding wrote:
>> > On Mon, Sep 29, 2014 at 06:28:14PM +0200, Maxime Ripard wrote:
>> > > On Mon, Sep 29, 2014 at 03:47:15PM +0200, Thierry Reding wrote:
> [...]
>> > > > What happened in the Snow example is that regulators that were
>> > > > previously on would all of a sudden be automatically disabled on boot
>> > > > because there was now a driver that registered them with a generic
>> > > > framework.
>> > > >
>> > > > The same thing is going to happen with simplefb for your device. If you
>> > > > later realize that you need a regulator to keep the panel going, you'll
>> > > > have to add code to your firmware to populate the corresponding
>> > > > properties, otherwise the regulator will end up unused and will be
>> > > > automatically disabled. At the same time you're going to break upstream
>> > > > for all users of your old firmware because it doesn't add that property
>> > > > yet.
>> > > >
>> > > > And the same will continue to happen for every new type of resource
>> > > > you're going to add.
>> > >
>> > > Sure, we can add any resources we will need. Regulators, reset lines,
>> > > pm domains, allocated memory, but I'm not really sure this is what you
>> > > want, right?
>> >
>> > No it's not what I want. *You* want to add resource management to this
>> > driver. What I'm saying is that if we start adding clocks then we can no
>> > longer say no to resets or regulators or power domains either.
>>
>> Yes, because resource management can be more than just "keep the thing
>> enabled". It might also be about not modifying anything, just like we
>> saw for the clocks, but that might also apply to regulators voltage.
>
> We've already determined that simplefb can't do anything meaningful with
> the resources other than keep them in the status quo. It simply doesn't
> have enough knowledge to do so. It doesn't know the exact pixel clock or
> what voltage the attached panel needs.
>
>> And the only way I can think of to deal with that properly is to have
>> resources management in the driver.
>
> My point is that if we had a proper way to tell the kernel not to do
> anything with resources owned by firmware, then the driver wouldn't
> have to do anything with the resources.

The firmware on sunxi does not own any resources whatsoever. It ceases
running once it executes the kernel. This is different from ACPI and
UEFI where you have pieces of the firmware lingering indefinitely and
potentially getting invoked by user pressing some button or some other
hardware event. It is also different from rpi where the Linux kernel
effectively runs in a virtual environment created by the firmware
hypervisor.

So on sunxi and many other ARM machines the Linux kernel is the sole
owner of any resources that might happen to be available on the
machine. There is no firmware owning them when the Linux kernel is
running, ever.

And we do have a proper way to tell to the kernel what these resources
are used for - inserting description of them into the simplefb DT
node. Sure the simplefb cannot manage the resources in any way and but
it does own them. When it is running they are in use, when it stops
they are free to be reclaimed by the platform driver.

But you refuse to marge the kernel change for this proper management to happen.

The alternate proposal to stop the kernel from managing resources
while simplefb is running and refernce count drivers that cannot
manage resources is indeed a workable, general alternative.

It does however switch the kernel into special mode when resources are
not managed and will needlessly hinder eg. development and testing of
powermanagement and hotplug for drivers unrelated to kms in parallel
to kms.

But let's look at this special mode closer.

Under normal boot sequence when the built-in drivers are initialized
or around that time the kernel does a pass in which it disables unused
clocks and possibly reclaims other resources.

The boot has finished for the kernel and now it hands over to
userspace and it is up to the userspace to load any more drivers (such
as kms) or not. If at that point a driver like simplefb exists it
should have called that stop_managing_resources() which should replace
clk_ignore_unused() so that other resources are properly handled
without the driver ever having to know about them.

For clocks this should be simple. At least on sunxi the clock driver
can tell if the clock is gated and can potentially be in use. It can
even mark clocks that are used at this point to know not to ever
disable them. Also it should refuse to ever change a clock frequency
on these clocks since if one of them was used for simplefb it should
break. It does not matter it's a mmc bus clock completely unrelated to
display. If you assume no knowledge you cannot change the mmc clock
when a different card is inserted or when a card is inserted into an
empty slot. If the firmware probed the slot the clock might be running
anyway.

Other resources might be more difficult to tackle. Is it possible to
change voltage regulators? Even the fact that it is set to 0 does not
necessarily mean that it is unused and then other driver claiming it
later can change the voltage. So no changing the regulators, ever.

And there goes gpio. You cannot assume that you can change any pin
muxing or any pin level whatsoever. The pin might be connected to the
display. So no loading of drivers that need any pin assignment
changes.

I guess by now it's clear that if this mode that assumes no knowledge
of the underlying hardware and requires the kernel to not manage
resources in order to keep dumb drivers running  completely paralyzes
the kernel and will among other things prevent loading of the proper
kms driver.

>
>> > > I really start to consider adding a sunxi-uboot-fb, that would just
>> > > duplicate the source code of simplefb but also taking the
>> > > clocks. Somehow, I feel like it will be easier (and definitely less of
>> > > a hack than using the generic common clock API).
>> >
>> > You're not getting it are you? What makes you think sunxi-uboot-fb is
>> > going to be any different? This isn't about a name.
>>
>> At least, we would get to do any binding and resource management we
>> want. And that's a big win.
>
> So instead of trying to understand the concerns that I've expressed and
> constructively contribute to finding a solution that works for everybody
> you'd rather go and write a driver from scratch. Way to go.

It's the constructive thing to do when the existing driver cannot be
extended to work for everybody.

>
> I've already said that I'm not saying strictly no to these patches, but
> what I want to see happen is some constructive discussion about whether
> we can find better ways to do it. If we can't then I'm all for merging
> these patches. Fortunately other (sub)threads have been somewhat more
> constructive and actually come up with alternatives that should make
> everyone happier.

What are those alternatives?

>
> If you're going to do SoC-specific bindings and resource management you
> are in fact implementing what Grant suggested in a subthread. You're
> implementing a dummy driver only for resource management, which isn't
> really a bad thing. It can serve as a placeholder for now until you add
> the real driver. And you can also use the simplefb driver to provide
> the framebuffer.

Oh, so back to the proposal to make a driver that claims the required
resources and then instantiates an unextended simplefb that is
oblivious to the resources to be kept simple?

Did I not propose that way back?

Was it not already rejected?

Thanks

Michal
