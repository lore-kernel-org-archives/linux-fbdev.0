From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Date: Thu, 28 Aug 2014 13:22:21 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <CAKON4OyXPjXx4q828kFgMsC_u7u3nqLPLxOp-kRZbS27yRKOEg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825152232.GE15297@lukather> <20140826080432.GD17263@ulmo>
 <20140826135341.GM15297@lukather> <20140826143550.GB3027@ulmo>
 <53FCE704.4030103@redhat.com> <20140827093121.GA23186@ulmo>
 <53FDB46C.5010609@redhat.com> <20140827125613.GF23186@ulmo>
 <53FDE0CE.5030807@redhat.com> <20140827141632.GB32243@ulmo>
 <53FF1D6C.6090205@redhat.com>
In-Reply-To: <53FF1D6C.6090205@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Aug 28, 2014 at 8:15 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 08/27/2014 04:16 PM, Thierry Reding wrote:
>
> <snip>
>
>>> The problems your talking about here all have to do with ordering how
>>> things are enabled, but what we're talking about here is keeping things
>>> enabled which are already enabled by the bootloader, so there is no
>>> ordering problem.
>>
>> See what I did there? I tricked you into saying what I've been saying
>> all along. =)
>
> He he :)
>
>> It's about keeping things enabled which have been enabled
>> by the bootloader. That's the root of the problem.
>
> Ok so we all seem to largely agree on most things here:
>
> 1) Somehow some clks must be marked used so as to not get disabled
> 2) We don't want to hardcode these clocks into the kernel (sunxi) clk
> driver, instead the bootloader should tell the kernel about these clocks.
>
> So the only point of discussion left seems to be how to do 2...

Wouldn't it be a lot simpler just to use existing fbdev (not KMS) and
whip together a device specific driver that claims the proper
resources? And just implement the minimal about of fbdev possible?
fbdev already is a driver library.

---

An independent issue is the early printk equivalent. For that you need
an address and the x/y layout

>
> <snip>
>
>>> Hmm I see, in my mind the problem is not that the clk framework disables
>>> unused clocks, but that no one is marking the clocks in question as used.
>>> Someone should mark these clocks as used so that they do not get disabled.
>>>
>>> We could add a clk_mark_in_use function and have the simplefb patch call
>>> that instead of clk_prepare_and_enable, or maybe even better just only
>>> claim the clks and teach the clk framework to not disable claimed clk
>>> in its cleanup run. That would make it clear that simplefb is not enabling
>>> anything, just claiming resource its need to avoid them getting removed
>>> from underneath simplefb, would that work for you ?
>>
>> That would be more accurate, but it boils down to the same problem where
>> we still need a driver to claim the resources in some way whereas the
>> problem is fundamentally one where the bootloader should be telling the
>> kernel not to disable it. It's in fact the bootloader that's claiming
>> the resources.
>
> Yes, but those resources do not belong to the bootloader in a sense
> that traditional bootloader / firmware claimed resources (e.g. acpi
> reserved resources) do. These traditional resources are claimed for ever.
>
> Where as these resources are claimed by the bootloader to keep the simplefb
> it provides working, as soon as the simplefb is no longer used, they become
> unused.
>
> <snip off-topic generic-ehci discussion>
>
>>> No, there are a lot of other drivers which were written before someone
>>> decided that having 10-20 drivers which were 90% copy and paste of each
>>> other was a bad idea, but we're really going offtopic here.
>>
>> The copy and paste is for code that's platform specific. The clocks have
>> different names, resets are different, supplies are different. The fact
>> that many can currently use the same driver is likely just coincidence
>> rather than design and it's entirely possible that at some point they'll
>> add support for a more advanced feature that makes them incompatible
>> with the rest of the generic drivers. And then you have a big mess
>> because you need to add quirks all over the place.
>>
>> And this isn't all that far off-topic, since simplefb also needs to deal
>> with this kind of situation. And what I've been arguing is that in order
>> to really be generic it has to make assumptions, one of which is that it
>> uses only resources that it doesn't need to explicitly handle.
>
> I can understand that you're worried about generic ?hci drivers dealing with
> clocks / resets / etc. As there may be strict ordering requirements there,
> but for simplefb that is not the case.
>
> All we're asking for is for a way to communicate 2 things to the kernel:
>
> 1) These resources are in use (we are not asking the kernel to do anything
> with them, rather the opposite, we're asking to leave them alone so no
> ordering issues)
>
> 2) Tie these resources to simplefb so that the kernel can know when they
> are no longer in use, and it may e.g. re-use the memory
>
> To me the most logical and also most "correct" way of modelling this is to
> put the resources inside the simplefb dt node.
>
> <snip>
>
>>> The key word here is "the used resources" to me this is not about simlefb
>>> managing resources, but marking them as used as long as it needs them, like
>>> it will need to do for the reserved mem chunk.
>>
>> The difference between the clocks and the memory resource is that the
>> driver needs to directly access the memory (it needs to map it and
>> provide a userspace mapping for it) whereas it doesn't need to touch the
>> clocks (except to workaround a Linux-specific implementation detail).
>
> Erm, no, the need to map the memory and the memory being a resource
> which may be released are an orthogonal problem. E.g. a system with
> dedicated framebuffer memory won't need to use a reserved main-memory
> chunk, nor need to worry about returning that mem when simplefb is no
> longer in use.
>
> Regards,
>
> Hans
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.



-- 
Jon Smirl
jonsmirl@gmail.com
