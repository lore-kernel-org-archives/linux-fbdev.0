From: Michal Suchanek <hramrach@gmail.com>
Date: Thu, 02 Oct 2014 14:17:09 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <CAOMqctQdPpNRDwciw2oriTskXzcRm7eqsXv2zipP3JrKdyw9gQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140929101805.GB26008@ulmo> <20140929114643.GB4081@lukather>
 <20140929134708.GB30998@ulmo> <20140929155517.GR16977@sirena.org.uk>
 <20140930050923.GB29874@ulmo> <20140930173928.GH4273@sirena.org.uk>
 <20141001074139.GB18463@ulmo>
 <CABxcv=nKErHGPRLM5yer2YnOc2VJPWLmeKgwXbXEU3r_XvsCyg@mail.gmail.com>
 <20141001123250.GY4273@sirena.org.uk> <20141001124800.GA21733@ulmo>
 <20141001170517.GF4273@sirena.org.uk> <542C3934.3040409@redhat.com>
 <CAKON4OxzerMyuza-GSfmYiLMqA=Y3HOXko7a8rOcP_8PkHVF3w@mail.gmail.com>
 <542C4404.8040501@wwwdotorg.org> <542CF3C3.2050708@redhat.com>
 <CAKON4Oy8sZ-d6JzWLi7pUeNFE5ge0fr5Tgoc_PSpKcOoiN-0yQ@mail.gmail.com>
 <542D476D.50004@redhat.com>
 <CAKON4OwOFVFZjxN-SJpDJLcyCpNOT4_mjjr9OpgGXmTYvZwT+A@mail.gmail.com>
 <542D4FB9.6090805@redhat.com>
 <CAKON4Oyb3KBWhGgKfwNop7+cwR=p=ZpVs-jfH0iQwm5scfOJ-A@mail.gmail.com>
 <542D5444.8090903@redhat.com>
 <CAKON4OxTmNRxSJum17RZGLLku5dAFPauzqyP0BOF-VC=bD=Hng@mail.gmail.com>
In-Reply-To: <CAKON4OxTmNRxSJum17RZGLLku5dAFPauzqyP0BOF-VC=bD=Hng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 2 October 2014 15:40, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
> On Thu, Oct 2, 2014 at 9:33 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 10/02/2014 03:27 PM, jonsmirl@gmail.com wrote:
>>> On Thu, Oct 2, 2014 at 9:14 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>>> Hi,
>>>>
>>>> On 10/02/2014 02:56 PM, jonsmirl@gmail.com wrote:
>>>>> On Thu, Oct 2, 2014 at 8:39 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 10/02/2014 02:22 PM, jonsmirl@gmail.com wrote:
>>>>>>> On Thu, Oct 2, 2014 at 2:42 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> On 10/01/2014 08:12 PM, Stephen Warren wrote:
>>>>>>>>> On 10/01/2014 11:54 AM, jonsmirl@gmail.com wrote:
>>>>>>>>>> On Wed, Oct 1, 2014 at 1:26 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>>>>> ...
>>>>>>>>>>> We've been over all this again and again and again.
>>>>>>>>>>>
>>>>>>>>>>> AAAARRRRRGGGGGGGGGGGGGGGGGHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH!
>>>>>>>>>>>
>>>>>>>>>>> All solutions provided sofar are both tons more complicated, then the
>>>>>>>>>>> simple solution of simply having the simplefb dt node declare which
>>>>>>>>>>> clocks it needs. And to make things worse all of them sofar have
>>>>>>>>>>> unresolved issues (due to their complexity mostly).
>>>>>>>>>>>
>>>>>>>>>>> With the clocks in the simplefb node, then all a real driver has to do,
>>>>>>>>>>> is claim those same clocks before unregistering the simplefb driver,
>>>>>>>>>>> and everything will just work.
>>>>>>>>>>>
>>>>>>>>>>> Yet we've been discussing this for months, all because of some
>>>>>>>>>>> vague worries from Thierry, and *only* from Thierry that this will
>>>>>>>>>>> make simplefb less generic / not abstract enough, while a simple
>>>>>>>>>>> generic clocks property is about as generic as things come.
>>>>>>>>>
>>>>>>>>> Note: I haven't been following this thread, and really don't have the time to get involved, but I did want to point out one thing:
>>>>>>>>>
>>>>>>>>> As I think I mentioned very early on in this thread, one of the big concerns when simplefb was merged was that it would slowly grow and become a monster. As such, a condition of merging it was that it would not grow features like resource management at all. That means no clock/regulator/... support. It's intended as a simple stop-gap between early platform bringup and whenever a real driver exists for the HW. If you need resource management, write a HW-specific driver. The list archives presumably have a record of the discussion, but I don't know the links off the top of my head. If nobody
>>>>>>>>> other than Thierry is objecting, presumably the people who originally objected simply haven't noticed this patch/thread. I suppose it's possible they changed their mind.
>>>>>>>>>
>>>>>>>>> BTW, there's no reason that the simplefb code couldn't be refactored out into a support library that's used by both the simplefb we currently have and any new HW-specific driver. It's just that the simplefb binding and driver shouldn't grow.
>>>>>>>>
>>>>>>>> The whole reason why we want to use simplefb is not just to get things
>>>>>>>> running until HW specific driver is in place, but also to have early console
>>>>>>>> output (to help debugging boot problems on devices without a serial console),
>>>>>>>> in a world where most video drivers are build as loadable modules, so we
>>>>>>>> won't have video output until quite late into the boot process.
>>>>>>>
>>>>>>> You need both.
>>>>>>>
>>>>>>> 1) temporary early boot console -- this is nothing but an address in
>>>>>>> RAM and the x/y layout. The character set from framebuffer is built
>>>>>>> into the kernel.  The parallel to this is early-printk and how it uses
>>>>>>> the UARTs without interrupts. This console vaporizes late in the boot
>>>>>>> process -- the same thing happens with the early printk UART driver.
>>>>>>> EARLYPRINTK on the command line enables this.
>>>>>>>
>>>>>>> 2) a device specific driver -- this sits on initrd and it loaded as
>>>>>>> soon as possible. The same thing happens with the real UART driver for
>>>>>>> the console. CONSOLE= on the command line causes the transition. There
>>>>>>> is an API in the kernel to do this transition, I believe it is called
>>>>>>> set_console() but it's been a while.
>>>>>>
>>>>>> Eventually we need both, yes. But 1) should stay working until 2) loads,
>>>>>> not until some phase of the bootup is completed, but simply until 2) loads.
>>>>>
>>>>> No, that is where you get into trouble. The device specific driver has
>>>>> to go onto initrd where it can be loaded as early in the boot process
>>>>> as possible.
>>>>
>>>> This is an argument in the "you cannot do that" / "your use case is not valid"
>>>> category, IOW this is not a technical argument. You say I cannot do that I
>>>> say I can, deadlock.
>>>
>>> It is certainly possible to extend an earlyframebuffer to be able to
>>> run as a user space console. It is just going to turn into a
>>> Frankenmonster driver with piles of device specific, special case code
>>> in it.
>>
>> There is nothing hardware specific about a framebuffer needing some
>> clocks to not be disabled. Tons of SoC's will have this. Which clocks,
>> that is hardware specific, but the framebuffer driver does not need to
>> worry about that, it just sees a clocks property with some random clocks
>> in there, and that is as generic as it gets.
>>
>>> I think that device specific code belongs in a device specific driver
>>> and earlyframebuffer should handoff to it as soon as possible.
>>>
>>>>
>>>> I've already explained that we not only can do that (we already have working
>>>> code proving that), but also that this is something which we absolutely need:
>>>>
>>>>>> One example why this is necessary is e.g. to debug things where the problem
>>>>>> is that the right module is not included in the initrd.
>>>
>>> A generic earlyframebuffer would show this error.
>>
>> If it reserves the clocks it needs, yes. If it does not then the clocks will
>> be disabled before the initrd starts, and the screen will be black from then
>
> I thought the clock/regulator clean up happened after initrd loading,
> but maybe that is not the case.
>
> A cleaner solution would then be to modify the clock/regulator clean
> up to happen after driver loading is finished from initrd. Deferring
> until after that completes is a fixed limit, everything is sitting
> there in RAM. I would not propose extending it until harddisk based
> loading happens.
>
> So there are two ways to do this...
> 1) modify things like earlyconsole to protect device specific resource
> (I think this is a bad idea)
> 2) delay the clock/regulator cleanup until after there is a fixed
> window for device specific drivers to load in. Loading from initrd is
> a fixed window.

Fixed window is timeout.

Time and time again timeouts break.

How is loading a module from harddisk different form loading from initrd?

How is even the kernel going to tell?

How should systems that run completely off initrd behave?

How should the kernel behave during this 'fixed window'? If it cannot
touch resources that were in enabled or unknown state at boot how can
it allocate resources for newly loaded drivers?

Or to put it differently: when the firmware inserts dynamically at
boot time or the DT writer statically at compile time the resources
which are needed by console then kernel knows that the *other* stuff
that has been enabled by firmware or for which it cannot be determined
if it's enabled or not can be reused.

For example, if the firmware loaded the kernel from mmc or just probed
mmc the mmc clocks have been likely left enabled. You need to
reprogram mmc clocks to access mmc most of the time. If you assume no
knowledge of hardware then you cannot know that mmc clocks are not
used for console and cannot touch them. Hence if loading a kms driver
fails in initrd you are needlessly locked out of loading system from
mmc.

I am sure you can find other examples for both clocks or other
resources so the solution to properly name what you need for the
console to keep running is more scalable.

If your board is simple you might get away with a static DT. If you do
not care about early graphics you can just drop it.

BTW this has *also* been discussed here, at length.

Thanks

Michal
