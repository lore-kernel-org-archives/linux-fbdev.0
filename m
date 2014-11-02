From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 02 Nov 2014 14:39:34 +0000
Subject: Re: [linux-sunxi] Re: [PATCH v4 0/5] simplefb: add clock handling code
Message-Id: <54564226.5030409@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413996311-4287-1-git-send-email-hdegoede@redhat.com>
 <544F737A.7000109@ti.com>
 <CAL_JsqJ2JRg7k21CEVe4-At7enD+y3TN_7wfqhY0OHZm-_j17w@mail.gmail.com>
 <544F7E5D.60104@redhat.com> <5450CAA5.5020205@ti.com>
 <CAL_JsqKWqq+H5ymUW3n8tkmLJHEUGaKDLX5+orJmGUQ3ECQwUQ@mail.gmail.com>
In-Reply-To: <CAL_JsqKWqq+H5ymUW3n8tkmLJHEUGaKDLX5+orJmGUQ3ECQwUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 10/31/2014 09:47 PM, Rob Herring wrote:
> On Wed, Oct 29, 2014 at 7:08 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> Hi Hans, Rob,
>>
>> On 28/10/14 13:30, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 10/28/2014 12:11 PM, Rob Herring wrote:
>>
>>>> Yes, I object to the binding still as it has not changed from what was
>>>> previously posted.
>>>
>>> It would be helpful if you could explain why you object. Last time you
>>> said: " You are mixing in a hardware description that is simply inaccurate."
>>>
>>> I then explained that this is not hardware description, but runtime state
>>> information, as it tells the kernel which clocks were chosen to drive the
>>> display (out of typically a list of possible options, depending on which
>>> output is used, etc.). Just like which memory address the bootloader has
>>> chosen to scan out the video image from.
>>>
>>> Then you got quiet, so sorry, but this time your objection really is too
>>> late. You cannot simply go quiet halfway through a discussion and then pop
>>> up again when a new version is posted to say "I object" yet another time,
>>> you've had your chance to make your arguments last time, and chose to stay
>>> quiet after I explained in detail that this is not hardware description but
>>> state information, so now it is simply too late.
>>>
>>> These bindings have been discussed at Plumbers with various interested people
>>> present, and the conclusion was that this really is the best way to handle this,
>>> so this patch is:
>>>
>>>     Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>     Reviewed-by: Mike Turquette <mturquette@linaro.org>
>>>     Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>>     Reviewed-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>>
>>> And David Herrman who is working on simpledrm, which will be merged soon, which
>>> will also use the simplefb bindings also agrees. So we have the simplefb maintainer,
>>> simpledrm maintainer, and the clk subsystem maintainer + 2 other maintainers all
>>> agreeing on a way forward, the time for bikeshedding now really really really is
>>> over.
>>>
>>> Tomi, can you please let us know how you plan to proceed with this ?
>>
>> I won't merge DT bindings via fbdev tree, if a DT maintainer says no.
>>
>> I took Rob's silence to the earlier series as a silent ack for your
>> explanation. Obviously that was not the case.
>>
>> Rob, please advice asap what should be done to the bindings to get your
>> ack. As Hans explained above, this discussion has been going on for a
>> long time, and afaik this series is the best way forward of all the
>> options discussed.
> 
> I still think for the most part this is a kernel problem. It is a
> kernel policy to turn off unused clocks. The clock framework could
> just as easily decide that any clocks enabled at boot and left
> un-managed (i.e. w/o a driver) are kept on until they are managed.

This is not just about being unmanaged, clocks can be shared, and another
driver can actively claim the clock and turn it off, we need to protect
against this too.

> I'm not saying this can't be in DT, only that DT is not the only solution
> here.

Basically the problem is that we must keep the clock enabled for the lifetime
of the simplefb device. We've been over this in 2 very long threads already,
and many alternatives have been evaluated and found wanting.

The only 100% safe way to ensure clocks are not turned off is to tie there
lifetime to that of the simplefb device, and the only reliable way to do
that is through a clocks property.

It really is that simple, and I don't understand why people keep insisting
there must be another way, while they fail to offer a (reliable, working)
other way.

> This problem is not unique to simplefb. A serial console could
> stop working if no serial driver is loaded before unused clocks are
> disabled. CPU core clocks have a similar issue as well (often enabled
> in platform code). I want to see this solved in a generic way for any
> clock.
> 
> As regulators were also mentioned, they already have a
> "regulator-boot-on" property defined. Perhaps this is suitable to be
> mirrored for clocks. If it is not, then I'm wondering why we have it.
> A key difference here is that the property is part of the provider and
> can be dealt with in the clock driver rather than requiring a
> temporary driver.

"regulator-boot-on" tells the regulator framework to enable a regulator
at boot, but it does not protect it from getting turned of by another
driver later (it does not increase use_count).

So this is the same none solution as not turning off unmanaged clocks,
what if another driver who shares the clock, enables it during probe,
then disables it while done probing (to put things in low power state
until userspace uses the device).

This is not about not turning the clock off, this is about keeping
the clock on for the lifetime of the simplefb device, which is a different
problem, cause we must not remove a single calling point of clock_off,
put we must block all attempts to turn the clock off, which is done
by increasing its use-count, which is done by claiming + enabling it,
which needs a phandle to the clock ...

Regards,

Hans
