From: Michal Suchanek <hramrach@gmail.com>
Date: Tue, 30 Sep 2014 14:12:26 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <CAOMqctRnhCdETg_rBvXhcNYFeUC8CQvy7xBYx0GynQR=otUdaA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140929080637.GB12506@ulmo> <20140929092301.GC4388@lukather>
 <20140929101805.GB26008@ulmo> <20140929114643.GB4081@lukather>
 <20140929134708.GB30998@ulmo> <20140929162814.GE4081@lukather>
 <20140930052110.GC29874@ulmo> <20140930075258.GH4081@lukather>
 <20140930085429.GB4059@ulmo>
 <CAOMqctRM1YZBR+p=0R39BSX_GT6XagPcb4HBG1BqW1OqyB48zw@mail.gmail.com>
 <20140930113144.GA19694@ulmo>
In-Reply-To: <20140930113144.GA19694@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 30 September 2014 13:31, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Tue, Sep 30, 2014 at 11:38:50AM +0200, Michal Suchanek wrote:
>> On 30 September 2014 10:54, Thierry Reding <thierry.reding@gmail.com> wrote:
>> > On Tue, Sep 30, 2014 at 09:52:58AM +0200, Maxime Ripard wrote:
>> >> On Tue, Sep 30, 2014 at 07:21:11AM +0200, Thierry Reding wrote:
>> >> > On Mon, Sep 29, 2014 at 06:28:14PM +0200, Maxime Ripard wrote:
>> >> > > On Mon, Sep 29, 2014 at 03:47:15PM +0200, Thierry Reding wrote:
>> > [...]
>> >> > > > What happened in the Snow example is that regulators that were
>> >> > > > previously on would all of a sudden be automatically disabled on boot
>> >> > > > because there was now a driver that registered them with a generic
>> >> > > > framework.
>> >> > > >
>> >> > > > The same thing is going to happen with simplefb for your device. If you
>> >> > > > later realize that you need a regulator to keep the panel going, you'll
>> >> > > > have to add code to your firmware to populate the corresponding
>> >> > > > properties, otherwise the regulator will end up unused and will be
>> >> > > > automatically disabled. At the same time you're going to break upstream
>> >> > > > for all users of your old firmware because it doesn't add that property
>> >> > > > yet.
>> >> > > >
>> >> > > > And the same will continue to happen for every new type of resource
>> >> > > > you're going to add.
>> >> > >
>> >> > > Sure, we can add any resources we will need. Regulators, reset lines,
>> >> > > pm domains, allocated memory, but I'm not really sure this is what you
>> >> > > want, right?
>> >> >
>> >> > No it's not what I want. *You* want to add resource management to this
>> >> > driver. What I'm saying is that if we start adding clocks then we can no
>> >> > longer say no to resets or regulators or power domains either.
>> >>
>> >> Yes, because resource management can be more than just "keep the thing
>> >> enabled". It might also be about not modifying anything, just like we
>> >> saw for the clocks, but that might also apply to regulators voltage.
>> >
>> > We've already determined that simplefb can't do anything meaningful with
>> > the resources other than keep them in the status quo. It simply doesn't
>> > have enough knowledge to do so. It doesn't know the exact pixel clock or
>> > what voltage the attached panel needs.
>> >
>> >> And the only way I can think of to deal with that properly is to have
>> >> resources management in the driver.
>> >
>> > My point is that if we had a proper way to tell the kernel not to do
>> > anything with resources owned by firmware, then the driver wouldn't
>> > have to do anything with the resources.
>>
>> The firmware on sunxi does not own any resources whatsoever. It ceases
>> running once it executes the kernel. This is different from ACPI and
>> UEFI where you have pieces of the firmware lingering indefinitely and
>> potentially getting invoked by user pressing some button or some other
>> hardware event. It is also different from rpi where the Linux kernel
>> effectively runs in a virtual environment created by the firmware
>> hypervisor.
>
> You know all that because you of course wrote every single firmware
> implementation that does and will ever exist for sunxi. There's nothing
> keeping anyone from running UEFI on a sunxi SoC.

The existing 'firmware' or rather loader for sunxi is u-boot.

I am not saying other solutions cannot exist. I am describing the
current situation.

>
>> So on sunxi and many other ARM machines the Linux kernel is the sole
>> owner of any resources that might happen to be available on the
>> machine. There is no firmware owning them when the Linux kernel is
>> running, ever.
>
> Of course this is part of the abstraction. The idea is that the device
> is a virtual one created by firmware. Therefore firmware owns the
> resources until the virtual device has been handed over to the kernel.
>
> If you're into splitting hairs, then the simplefb device shouldn't exist
> in the first place.

Why shoudn't it?

It is properly created by u-boot and handed over to the kernel with
all the required information for the kernel to keep it running or shut
it down as it sees fit.

>
>> And we do have a proper way to tell to the kernel what these resources
>> are used for - inserting description of them into the simplefb DT
>> node. Sure the simplefb cannot manage the resources in any way and but
>> it does own them. When it is running they are in use, when it stops
>> they are free to be reclaimed by the platform driver.
>
> Yes. And again I'm not saying anything different. What I'm saying is
> that we shouldn't need to know about the resources and instead hide that
> within the firmware, for the same reason that we're already hiding the
> register programming in hardware, namely to create an abstraction that
> works irrespective of the underlying hardware.

So then hide those resources in the Linux kernel. Because if you are
into hair splitting then on sunxi currently the Linux kernel is the
firmware and u-boot is only one of the loader stages that ultimately
executes the final firmware which is Linux.

>> >> > > I really start to consider adding a sunxi-uboot-fb, that would just
>> >> > > duplicate the source code of simplefb but also taking the
>> >> > > clocks. Somehow, I feel like it will be easier (and definitely less of
>> >> > > a hack than using the generic common clock API).
>> >> >
>> >> > You're not getting it are you? What makes you think sunxi-uboot-fb is
>> >> > going to be any different? This isn't about a name.
>> >>
>> >> At least, we would get to do any binding and resource management we
>> >> want. And that's a big win.
>> >
>> > So instead of trying to understand the concerns that I've expressed and
>> > constructively contribute to finding a solution that works for everybody
>> > you'd rather go and write a driver from scratch. Way to go.
>>
>> It's the constructive thing to do when the existing driver cannot be
>> extended to work for everybody.
>
> No, it isn't. If a generic driver doesn't work for everybody then it
> isn't generic and we should fix it. Not duplicate it and add platform
> specific quirks.

What was proposed originally is not platform specific quirk.

It was a generic solution what works on every platform when you can
provide a list of resources that are needed for simplefb to run.

It's not like sunxi is the only platform that has exposed display clocks, it it?

>
>> > I've already said that I'm not saying strictly no to these patches, but
>> > what I want to see happen is some constructive discussion about whether
>> > we can find better ways to do it. If we can't then I'm all for merging
>> > these patches. Fortunately other (sub)threads have been somewhat more
>> > constructive and actually come up with alternatives that should make
>> > everyone happier.
>>
>> What are those alternatives?
>
> Sorry, you've got to do some of the work yourself. They've been
> mentioned in this thread and the one that Maxime pointed to the other
> day.

I did not notice any in this thread, sorry.

>
>> > If you're going to do SoC-specific bindings and resource management you
>> > are in fact implementing what Grant suggested in a subthread. You're
>> > implementing a dummy driver only for resource management, which isn't
>> > really a bad thing. It can serve as a placeholder for now until you add
>> > the real driver. And you can also use the simplefb driver to provide
>> > the framebuffer.
>>
>> Oh, so back to the proposal to make a driver that claims the required
>> resources and then instantiates an unextended simplefb that is
>> oblivious to the resources to be kept simple?
>
> Pretty much, yes.
>
>> Did I not propose that way back?
>
> Yes, I think you did.
>
>> Was it not already rejected?
>
> No, I don't think it was. In fact I don't think anything was really
> rejected yet, we're still in the middle of a discussion.
>
> Thierry

You personally were against it ...

Can we agree on that as acceptable solution then?

Thanks

Michal

On 28 August 2014 12:08, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Wed, Aug 27, 2014 at 10:57:29PM +0200, Michal Suchanek wrote:
>> On 27 August 2014 17:42, Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

>> > So, how would the clock driver would know about which use case we're
>> > in? How would it know about which display engine is currently running?
>> > How would it know about which video output is being set?
>> >
>> > Currently, we have two separate display engines, which can each output
>> > either to 4 different outputs (HDMI, RGB/LVDS, 2 DSI). Each and every
>> > one of these combinations would require different clocks. What clocks
>> > will we put in the driver? All of them?
>> >
>>
>> since simplefb cannot be extended how about adding, say, dtfb which
>> claims the resources from dt and then instantiates a simplefb once the
>> resources are claimed? That is have a dtfb which has the clocks
>> assigned and has simplefb as child dt node.
>
> I don't see how that changes anything. All you do is add another layer
> of indirection. The fundamental problem remains the same and isn't
> solved.
>
> Thierry
