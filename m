From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Date: Sun, 05 Oct 2014 23:19:52 +0000
Subject: Re: [linux-sunxi] Re: Fixing boot-time hiccups in your display
Message-Id: <CAKON4OzO427-MU4FqmF8AP5V=CXHuGdV1GTptiaJiRY7DLfDRA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAKON4OxRFCvMPMfZhxYNVaxscgAs5AX46YzK-4SU5o6E-iTD1w@mail.gmail.com>
 <20141005200150.4379.28017@quantum>
 <CAKON4OxunQNC_Ebf5u9yh9EnGS2A+DdWCRyoFcJWS7GSNoLoqA@mail.gmail.com>
 <CAGRGNgUcHxWEZmdsM947UuKW-20u+T20ztNqgWxms6iK8-8ugw@mail.gmail.com>
In-Reply-To: <CAGRGNgUcHxWEZmdsM947UuKW-20u+T20ztNqgWxms6iK8-8ugw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sun, Oct 5, 2014 at 6:36 PM, Julian Calaby <julian.calaby@gmail.com> wrote:
> Hi Jon,
>
> On Mon, Oct 6, 2014 at 7:34 AM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
>> On Sun, Oct 5, 2014 at 4:01 PM, Mike Turquette <mturquette@linaro.org> wrote:
>>> Quoting jonsmirl@gmail.com (2014-10-05 10:09:52)
>>>> I edited the subject line to something more appropriate. This impacts
>>>> a lot of platforms and we should be getting more replies from people
>>>> on the ARM kernel list. This is likely something that deserves a
>>>> Kernel Summit discussion.
>>>
>>> ELC-E and LPC are just around the corner as well. I am attending both. I
>>> suppose some of the others interested in this topic will be present?
>>>
>>>>
>>>> To summarize the problem....
>>>>
>>>> The BIOS (uboot, etc) may have set various devices up into a working
>>>> state before handing off to the kernel.  The most obvious example of
>>>> this is the boot display.
>>>>
>>>> So how do we transition onto the kernel provided device specific
>>>> drivers without interrupting these functioning devices?
>>>>
>>>> This used to be simple, just build everything into the kernel. But
>>>> then along came multi-architecture kernels where most drivers are not
>>>> built in. Those kernels clean up everything (ie turn off unused
>>>> clocks, regulators, etc) right before user space starts. That's done
>>>> as a power saving measure.
>>>>
>>>> Unfortunately that code turns off the clocks and regulators providing
>>>> the display on your screen. Which then promptly gets turned back on a
>>>> half second later when the boot scripts load the display driver. Let's
>>>> all hope the boot doesn't fail while the display is turned off.
>>>
>>> I would say this is one half of the discussion. How do you ever really
>>> know when it is safe to disable these things? In a world with loadable
>>> modules the kernel cannot know that everything that is going to be
>>> loaded has been loaded. There really is no boundary that makes it easy
>>> to say, "OK, now it is truly safe for me to disable these things because
>>> I know every possible piece of code that might claim these resources has
>>> probed".
>>
>> Humans know where this boundary is and can insert the clean up command
>> at the right point in the bootscript. It is also not fatal if the
>> command is inserted at the wrong point, things will just needlessly
>> flicker. It not even fatal if you never run this command, you'll just
>> leave clocks/regulators turned on that could be turned off.
>
> What about distros? Would this "all clear" point be at the same point
> in the boot process for every sub-architecture? Would it ever change?

It is not really an "all clear". It is a "BIOS cleanup" command. All
this clean up does is potentially turn off some clocks/regulators that
the BIOS left on and no one cares about. It runs around to each
clock/regulator in the system that the kernel thinks is off, and runs
the code necessary to ensure that the clock/regulator is really off.

The timing of the "BIOS cleanup" point is not really critical.
Currently it is happening right before user space starts. There are a
bunch of late_initcalls() that turn off all of the clocks/regulators
that the BIOS enabled and no Linux driver has claimed.  Unfortunately
if your display driver hasn't loaded, it is going to turn off your
display. Of course your display will come right back as soon as the
device driver loads.

So the proposal is to turn these late_initcalls() into an IOCTL. The
power management frameworks would then get a command for calling that
IOCTL. The logical place to put this command is in your bootscript
right after all of the loadable drivers have loaded. But... it is not
critical. If you do it too early your display will still flicker. It
you don't do it at all you'll do is waste some power. Just move it
later in the scripts until the things you care about stop flickering.
Nothing fatal happens if you get it wrong - it is just a power saving
function.

So how does this get implemented? Is it enough just to add a single
bit on each clock/regulator that starts off as 1 (ie boot mode). Then
as the various drivers claim these clocks regulators this bit get
cleared.  A hole in this scheme is someone who turns off a root clock
which has children still in boot mode. You can't allow this clock to
be turned off until all of it's children are out of boot mode. Maybe
run the kids and look for boot mode? then turn the root clock boot
mode bit back on and ignore the request to turn it off? All of these
details need design work.

>
> Thanks,
>
> --
> Julian Calaby
>
> Email: julian.calaby@gmail.com
> Profile: http://www.google.com/profiles/julian.calaby/



-- 
Jon Smirl
jonsmirl@gmail.com
