From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 27 Aug 2014 13:44:46 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <53FDE0CE.5030807@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825141600.GA14763@ulmo.nvidia.com>
 <20140825145854.GA15297@lukather> <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825152232.GE15297@lukather> <20140826080432.GD17263@ulmo>
 <20140826135341.GM15297@lukather> <20140826143550.GB3027@ulmo>
 <53FCE704.4030103@redhat.com> <20140827093121.GA23186@ulmo>
 <53FDB46C.5010609@redhat.com> <20140827125613.GF23186@ulmo>
In-Reply-To: <20140827125613.GF23186@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 08/27/2014 02:56 PM, Thierry Reding wrote:
> On Wed, Aug 27, 2014 at 12:35:24PM +0200, Hans de Goede wrote:

<snip>

>>>> So second of all, Thierry, what exactly is the technical argument against
>>>> adding support for dealing with clocks to simplefb ?
>>>
>>> I've already stated technical arguments against it. You could just go
>>> back and read the thread again, or would you rather want me to repeat
>>> them for your convenience?
>>
>> It is a long thread, IIRC your main arguments against this are:
>>
>> 1) You don't want this kind of platform-specific knowledge in simplefb
>> 2) That simplefb is supposed to be simple, and this is not simple
>>
>> As for 1. several people have already argued that clocks as such are
>> an abstract concept, found one many platforms and as such are not
>> platform specific.
> 
> That alone doesn't justify this patch. SoCs often have a requirement to
> enable clocks in a specific order, for example. Other systems may need
> to coordinate clocks with resets in a specific order or enable power
> domains and such. All that is very SoC specific and if we don't make it
> very clear what this driver assumes about the state of the system, then
> we can't object to anybody adding support for those later on either. The
> result of that is going to be a driver that needs to handle all kinds of
> combinations of resources.

The problems your talking about here all have to do with ordering how
things are enabled, but what we're talking about here is keeping things
enabled which are already enabled by the bootloader, so there is no
ordering problem.

> So while clocks themselves are fairly generic the way in which they need
> to be used is highly platform-specific.
> 
> Let me also reiterate what I've said a couple of times already. The
> issue here isn't that simplefb needs to manage these clocks in any way.
> Firmware has already set them up so that display works. The reason why
> you need this patch is so that the clock framework doesn't automatically
> turn them off. With the proposed patch the driver enables these clocks,
> but that's not what it needs to do, they are already on. It's a work
> around to prevent the clock framework into not disabling them.
> 
> So as far as I'm concerned this points to a fundamental issue with how
> the clock framework handles unused clocks. Therefore that is the problem
> that should be solved, not worked around.

Hmm I see, in my mind the problem is not that the clk framework disables
unused clocks, but that no one is marking the clocks in question as used.
Someone should mark these clocks as used so that they do not get disabled.

We could add a clk_mark_in_use function and have the simplefb patch call
that instead of clk_prepare_and_enable, or maybe even better just only
claim the clks and teach the clk framework to not disable claimed clk
in its cleanup run. That would make it clear that simplefb is not enabling
anything, just claiming resource its need to avoid them getting removed
from underneath simplefb, would that work for you ?

>> Any generic hw driver dealing with embedded platforms, be it ahci, ohci,
>> ehci, etc. has ended up adding abstract support for things like clocks
>> (and other resources). I say abstract support here, since to all these
>> drivers the support was added in a way that no platform specific knowledge
>> is necessary, they just deal with clocks not caring about the specific
>> underlying clock implementation, clock names, etc.
> 
> Yes, I know that. You and I both had a very similar discussion not so
> long ago. But the above aren't quite the same as simplefb. The devices
> follow at least a well-known standard (EHCI, OHCI, AHCI), so there's
> bound to be more commonalities between them than between the various
> display devices that simplefb potentially can support.
> 
> Interestingly though, if you look at what hardware really is supported
> by the generic drivers that deal with embedded platforms, there isn't
> all that much diversity (I've manually stripped out non-DTS occurrences
> since they aren't relevant for this discussion):

That is because the generic platform drivers were only added recently
to stop the insanity where each new soc got its own ohci-soc.c /
ehci-soc.c file.

<snip>
> 	arch/arm/boot/dts/rk3288.dtsi:199:              compatible = "generic-ehci";
> 	arch/arm/boot/dts/rk3288.dtsi:210:              compatible = "generic-ehci";

(offtopic) And I see that despite the recent addition, we actually already have our
first non sunxi user, good, I didn't even know the rockchip guys were using this :)

And I know that there are quite a few more in the pipeline (waiting for their
usb phy and dt patches to get merged).

<snip>

> So there's a couple of SoCs and boards that actually are generic enough
> to work with a generic driver. And then there's a whole bunch of other
> drivers for hardware that's compliant with the same standard yet needs
> different drivers.

No, there are a lot of other drivers which were written before someone
decided that having 10-20 drivers which were 90% copy and paste of each
other was a bad idea, but we're really going offtopic here.

<snip>

>> This really is unavoidable. The framebuffer memory needed was mentioned
>> as another example of a resource in this thread. You suggested using the
>> new mem-reserve framework for this. I agree that that is the right thing
>> to do, but even then we still need a way to tie this reserved mem to
>> the simplefb, so that the kernel can know when it is no longer used
>> and can be added to the general memory pool.
> 
> Yes, memory handling seems like it isn't handled optimally by simplefb.
> To be fair the simplefb driver predates the reserved-memory bindings. I
> think it might be worthwhile to investigate on how to extend the binding
> to make use of that, though. I think the assumption currently is that
> the framebuffer memory will be lost forever (it needs to be carved out
> of the physical memory that the kernel gets to see). I couldn't find any
> code that returned reserved-memory to the kernel, but it's certainly a
> feature that I think we want. Especially if the firmware framebuffer is
> large (as in 1080p).

Ack.

>> If you look at how almost all dt bindings work, then the dt node for
>> a device specifies the resources needed, I don't see why simplefb would
>> be so special that it should be different here. I agree that it is
>> important to get the abstractions right here, but to me it seems that
>> the right abstraction is to be consistent with how all other devices
>> are abstracted and to add needed resources to the dt node for the
>> simplefb.
> 
> But simplefb is fundamentally different from other devices. It isn't a
> physical device at all. It's a virtual device that reuses resources as
> set up by some other piece of code (firmware). It implies that there's
> nothing that needs to be managed. It should only create a framebuffer
> with the given parameters and allow the kernel (and userspace) to render
> into it.
> 
> The only way you can deal with such virtual, completely generic devices
> is by being very explicit about the requirements. For simplefb the
> assumptions are that firmware set everything up and passes information
> about what it set up to the kernel so that it can be reused.

> None of the resources need to be explicitly managed because they have all
> been properly configured. For that reason, again, I think the right way is
> for the kernel not to switch off any of the used resources.

The key word here is "the used resources" to me this is not about simlefb
managing resources, but marking them as used as long as it needs them, like
it will need to do for the reserved mem chunk.

<snip>

>> As for 2. Yes this will add some more code to simplefb, more code but
>> code which is not complicated in anyway, so the simplefb code would
>> become larger but still stay simple. Were as all the suggested
>> alternatives sofar are at least an order of magnitude more complicated,
>> crossing many subsystems, demanding coordination with userspace, etc.
> 
> I'm not objecting to this patch because of the complexity, but because
> it is an illusion that the code is in any way generic.

Ok.

Regards,

Hans
