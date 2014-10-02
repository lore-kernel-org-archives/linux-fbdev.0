From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Date: Thu, 02 Oct 2014 15:30:04 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <CAKON4OyvUeSidyR8OWk9BM4X3BmvzSLyZtbhnMaB75kr-AFuew@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140929101805.GB26008@ulmo> <20141001074139.GB18463@ulmo>
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
 <542D5C74.4050602@redhat.com>
 <CAKON4OxHeHszmcbMw_LRJbcaFW5JP7Atsa4RMRwWfqMrCueAnQ@mail.gmail.com>
 <542D5F62.60907@redhat.com>
 <CAKON4Oz8mL5jGzBHZeznd5NbPqq93q7PpTDqHHcV_HYSfqBVHA@mail.gmail.com>
 <542D6633.20907@redhat.com>
 <CAKON4OwMf-zXC_B=VqdVNrD_ExC3zGiGUm4j5KKgS-U4cPB2zg@mail.gmail.com>
In-Reply-To: <CAKON4OwMf-zXC_B=VqdVNrD_ExC3zGiGUm4j5KKgS-U4cPB2zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Oct 2, 2014 at 11:14 AM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
> On Thu, Oct 2, 2014 at 10:50 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 10/02/2014 04:41 PM, jonsmirl@gmail.com wrote:
>>> On Thu, Oct 2, 2014 at 10:21 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>>> Hi,
>>>>
>>>> On 10/02/2014 04:16 PM, jonsmirl@gmail.com wrote:
>>>>> On Thu, Oct 2, 2014 at 10:08 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> <snip>
>>
>>>>>>> So there are two ways to do this...
>>>>>>> 1) modify things like earlyconsole to protect device specific resource
>>>>>>> (I think this is a bad idea)
>>>>>>
>>>>>> Why is this a bad idea? If the bootloader tells us exactly which resources
>>>>>> are needed, then earlyconsole can claim them, and release them on
>>>>>> handover to the real display driver.
>>>>
>>>> Jon, can you please answer this ? I really really want to know why people
>>>> think this is such a bad idea. Understanding why people think this is a bad
>>>> idea is necessary to be able to come up with an alternative solution.
>>>
>>> The list of resources should not be duplicated in the device tree -
>>> once in the simplefb node and again in the real device node.
>>
>> It is not duplicated, the simplefb node will list the clocks used for the
>> mode / output as setup by the firmware, which are often not all clocks
>> which the display engine supports. Where as the real device node will list
>> all clocks the display engine may use.
>>
>>> Device
>>> tree is a hardware description and it is being twisted to solve a
>>> software issue.
>>
>> This is not true, various core devicetree developers have already said
>> that storing other info in the devicetree is fine, and being able to do so
>> is part of the original design.
>>
>>> This problem is not limited to clocks, same problem
>>> exists with regulators. On SGI systems this would exist with entire
>>> bus controllers (but they are x86 based, console is not on the root
>>> bus). This is a very messy problem and will lead to a Frankenstein
>>> sized driver over time.
>>
>> This is a "what if ..." argument, we can discuss potential hypothetical
>> problems all day long, what happens if the sky falls down?
>>
>>> But... I think this is a red herring which is masking the real
>>> problem. The real problem seems to be that there is no window for
>>> loading device specific drivers before the resource clean up phase
>>> happens. That's a real problem -- multi architecture distros are going
>>> to have lots of loadable device specific drivers.
>>
>> As Maxime pointed out to my alternative solution to fixing the clocks
>> problem, this is not strictly a when to do cleanup problem. If another
>> driver uses the same clocks, and does a clk_disable call after probing
>> (because the device is put in low power mode until used by userspace),
>> then the clk will be disabled even without any cleanup running at all.
>>
>> The real problem here is simply that to work the simplefb needs certain
>> resources, just like any other device. And while for any other device
>> simply listing the needed resources is an accepted practice, for simplefb
>> for some reason (which I still do not understand) people all of a sudden
>> see listing resources as a problem.
>
> Because you are creating two different device tree nodes describing a
> single piece of hardware and that's not suppose to happen in a device
> tree.  The accurate description of the hardware is being perverted to
> solve a software problem.
>
> One node describes the hardware in a format to make simplefb happy.
> Another node describes the same hardware in a format to make the
> device specific driver happy.

But... I think all of this device tree stuff is a red herring and not
the core problem.

Core problem.....

Bios sets stuff up
Built-in drivers initialize
Bios settings get cleaned up (display goes blank)
Loadable drivers initialize (display comes back)

In multi-architecture kernels almost all of the drivers are loadable.
We need to figure out how to change the order....

Bios sets stuff up
Built-in drivers initialize
Loadable drivers initialize
Bios settings get cleaned up

Maybe the Bios cleanup turns into a small app you place at the end of
your init scripts. It's just a power saving cleanup and shouldn't be
causing this much trouble.

I don't think leaving the order as is and using the device tree to
construct a big list of exceptions to the clean up process is the
right approach.

>
>
>>
>> Regards,
>>
>> Hans
>>
>> --
>> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
>> For more options, visit https://groups.google.com/d/optout.
>
>
>
> --
> Jon Smirl
> jonsmirl@gmail.com



-- 
Jon Smirl
jonsmirl@gmail.com
