From: Julian Calaby <julian.calaby@gmail.com>
Date: Sun, 05 Oct 2014 22:36:00 +0000
Subject: Re: [linux-sunxi] Re: Fixing boot-time hiccups in your display
Message-Id: <CAGRGNgUcHxWEZmdsM947UuKW-20u+T20ztNqgWxms6iK8-8ugw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAKON4OxRFCvMPMfZhxYNVaxscgAs5AX46YzK-4SU5o6E-iTD1w@mail.gmail.com>
 <20141005200150.4379.28017@quantum>
 <CAKON4OxunQNC_Ebf5u9yh9EnGS2A+DdWCRyoFcJWS7GSNoLoqA@mail.gmail.com>
In-Reply-To: <CAKON4OxunQNC_Ebf5u9yh9EnGS2A+DdWCRyoFcJWS7GSNoLoqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Jon,

On Mon, Oct 6, 2014 at 7:34 AM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
> On Sun, Oct 5, 2014 at 4:01 PM, Mike Turquette <mturquette@linaro.org> wrote:
>> Quoting jonsmirl@gmail.com (2014-10-05 10:09:52)
>>> I edited the subject line to something more appropriate. This impacts
>>> a lot of platforms and we should be getting more replies from people
>>> on the ARM kernel list. This is likely something that deserves a
>>> Kernel Summit discussion.
>>
>> ELC-E and LPC are just around the corner as well. I am attending both. I
>> suppose some of the others interested in this topic will be present?
>>
>>>
>>> To summarize the problem....
>>>
>>> The BIOS (uboot, etc) may have set various devices up into a working
>>> state before handing off to the kernel.  The most obvious example of
>>> this is the boot display.
>>>
>>> So how do we transition onto the kernel provided device specific
>>> drivers without interrupting these functioning devices?
>>>
>>> This used to be simple, just build everything into the kernel. But
>>> then along came multi-architecture kernels where most drivers are not
>>> built in. Those kernels clean up everything (ie turn off unused
>>> clocks, regulators, etc) right before user space starts. That's done
>>> as a power saving measure.
>>>
>>> Unfortunately that code turns off the clocks and regulators providing
>>> the display on your screen. Which then promptly gets turned back on a
>>> half second later when the boot scripts load the display driver. Let's
>>> all hope the boot doesn't fail while the display is turned off.
>>
>> I would say this is one half of the discussion. How do you ever really
>> know when it is safe to disable these things? In a world with loadable
>> modules the kernel cannot know that everything that is going to be
>> loaded has been loaded. There really is no boundary that makes it easy
>> to say, "OK, now it is truly safe for me to disable these things because
>> I know every possible piece of code that might claim these resources has
>> probed".
>
> Humans know where this boundary is and can insert the clean up command
> at the right point in the bootscript. It is also not fatal if the
> command is inserted at the wrong point, things will just needlessly
> flicker. It not even fatal if you never run this command, you'll just
> leave clocks/regulators turned on that could be turned off.

What about distros? Would this "all clear" point be at the same point
in the boot process for every sub-architecture? Would it ever change?

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
