From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 03 Oct 2014 07:56:27 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <542E56AB.40208@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140929101805.GB26008@ulmo> <20141001124800.GA21733@ulmo>
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
 <CAGRGNgUUG6TOzC5YJgqqKfCM_iK9KcDXW9DPEr1P5OoO1qwd8w@mail.gm!
 ail.com>
In-Reply-To: <CAGRGNgUUG6TOzC5YJgqqKfCM_iK9KcDXW9DPEr1P5OoO1qwd8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 10/03/2014 01:31 AM, Julian Calaby wrote:
> Hi,
> 
> On Fri, Oct 3, 2014 at 1:14 AM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
>> On Thu, Oct 2, 2014 at 10:50 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>> Hi,
>>>
>>> On 10/02/2014 04:41 PM, jonsmirl@gmail.com wrote:
>>>> On Thu, Oct 2, 2014 at 10:21 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>> Hi,
>>>>>
>>>>> On 10/02/2014 04:16 PM, jonsmirl@gmail.com wrote:
>>>>>> On Thu, Oct 2, 2014 at 10:08 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> <snip>
>>>
>>>>>>>> So there are two ways to do this...
>>>>>>>> 1) modify things like earlyconsole to protect device specific resource
>>>>>>>> (I think this is a bad idea)
>>>>>>>
>>>>>>> Why is this a bad idea? If the bootloader tells us exactly which resources
>>>>>>> are needed, then earlyconsole can claim them, and release them on
>>>>>>> handover to the real display driver.
>>>>>
>>>>> Jon, can you please answer this ? I really really want to know why people
>>>>> think this is such a bad idea. Understanding why people think this is a bad
>>>>> idea is necessary to be able to come up with an alternative solution.
>>>>
>>>> The list of resources should not be duplicated in the device tree -
>>>> once in the simplefb node and again in the real device node.
>>>
>>> It is not duplicated, the simplefb node will list the clocks used for the
>>> mode / output as setup by the firmware, which are often not all clocks
>>> which the display engine supports. Where as the real device node will list
>>> all clocks the display engine may use.
>>>
>>>> Device
>>>> tree is a hardware description and it is being twisted to solve a
>>>> software issue.
>>>
>>> This is not true, various core devicetree developers have already said
>>> that storing other info in the devicetree is fine, and being able to do so
>>> is part of the original design.
>>>
>>>> This problem is not limited to clocks, same problem
>>>> exists with regulators. On SGI systems this would exist with entire
>>>> bus controllers (but they are x86 based, console is not on the root
>>>> bus). This is a very messy problem and will lead to a Frankenstein
>>>> sized driver over time.
>>>
>>> This is a "what if ..." argument, we can discuss potential hypothetical
>>> problems all day long, what happens if the sky falls down?
>>>
>>>> But... I think this is a red herring which is masking the real
>>>> problem. The real problem seems to be that there is no window for
>>>> loading device specific drivers before the resource clean up phase
>>>> happens. That's a real problem -- multi architecture distros are going
>>>> to have lots of loadable device specific drivers.
>>>
>>> As Maxime pointed out to my alternative solution to fixing the clocks
>>> problem, this is not strictly a when to do cleanup problem. If another
>>> driver uses the same clocks, and does a clk_disable call after probing
>>> (because the device is put in low power mode until used by userspace),
>>> then the clk will be disabled even without any cleanup running at all.
>>>
>>> The real problem here is simply that to work the simplefb needs certain
>>> resources, just like any other device. And while for any other device
>>> simply listing the needed resources is an accepted practice, for simplefb
>>> for some reason (which I still do not understand) people all of a sudden
>>> see listing resources as a problem.
>>
>> Because you are creating two different device tree nodes describing a
>> single piece of hardware and that's not suppose to happen in a device
>> tree.  The accurate description of the hardware is being perverted to
>> solve a software problem.
>>
>> One node describes the hardware in a format to make simplefb happy.
>> Another node describes the same hardware in a format to make the
>> device specific driver happy.
> 
> Stupid question: What about mangling an existing device node to be
> simplefb compatible, and writing simplefb to be binding agnostic?

That will not work, with simplefb a single node represents the currently
active video output. While in real hardware that may involve multiple
blocks, e.g on sunxi for hdmi out this involves the compositor (which
generates video data from 1 or more layers) which feeds into the
lcd-controller (which in this case is only used to generate hsync + vsync)
signals really, which feeds into the hdmi encoder, all 3 of which are
separate hardware blocks with their own clocks, etc.

And which hardware blocks exactly are involved will differ depending
on which video output of the device has been setup by the firmware.

The simplefb node is a virtual device, describing what the firmware
has setup, where as the hardware nodes are describing the real hardware.

I can see that people see this as duplicate info, but really it is not,
one is runtime information passed from the bootloader/firmware to the
kernel, the other is standard hardware description as people are used
to seeing in devicetree.

Regards,

Hans

