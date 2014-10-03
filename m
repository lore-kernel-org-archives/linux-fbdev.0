From: Rob Herring <robherring2@gmail.com>
Date: Fri, 03 Oct 2014 20:08:25 +0000
Subject: Re: [linux-sunxi] Re: [PATCH v3] dt-bindings: Add a clocks property to the simple-framebuffer bindin
Message-Id: <CAL_Jsq+3c7ToCGaR4Nz7dDXvebBKzzMv85swzy2mzOou+gM5iw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1412345120-24588-1-git-send-email-hdegoede@redhat.com>
 <CAL_JsqKU2n8p=YfJua3k-mR40bG_4SiZY8_-SL-MXtuWN5NeHg@mail.gmail.com>
 <542EDE11.3010802@redhat.com>
In-Reply-To: <542EDE11.3010802@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Oct 3, 2014 at 12:34 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 10/03/2014 05:57 PM, Rob Herring wrote:
>> On Fri, Oct 3, 2014 at 9:05 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>> A simple-framebuffer node represents a framebuffer setup by the firmware /
>>> bootloader. Such a framebuffer may have a number of clocks in use, add a
>>> property to communicate this to the OS.
>>>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> Reviewed-by: Mike Turquette <mturquette@linaro.org>
>>>
>>> --
>>> Changes in v2:
>>> -Added Reviewed-by: Mike Turquette <mturquette@linaro.org>
>>> Changes in v3:
>>> -Updated description to make clear simplefb deals with more then just memory
>>
>> NAK. "Fixing" the description is not what I meant and does not address
>> my concerns. Currently, simplefb is configuration data. It is
>> auxiliary data about how a chunk of memory is used. Using it or not
>> has no side effects on the hardware setup, but you are changing that
>> aspect. You are mixing in a hardware description that is simply
>> inaccurate.
>
> Memory is hardware too, what simplefb is is best seen as a virtual device, and
> even virtual devices have hardware resources they need, such as a chunk of memory,
> which the kernel should not touch other then use it as a framebuffer, likewise
> on some systems the virtual device needs clocks to keep running.
>
>> The kernel has made the decision to turn off "unused" clocks. If its
>> determination of what is unused is wrong, then it is not a problem to
>> fix in DT.
>
> No, it is up to DT to tell the kernel what clocks are used, that is how it works
> for any other device. I don't understand why some people keep insisting simplefb
> for some reason is o so very very special, because it is not special, it needs
> resources, and it needs to tell the kernel about this or bad things happen.

No, the DT describes the connections of clocks from h/w block to h/w
block. Their use is implied by the connection.

And yes, as the other thread mentioned DT is more than just hardware
information. However, what you are adding IS hardware information and
clearly has a place somewhere else. And adding anything which is not
hardware description gets much more scrutiny.

> More over it is a bit late to start making objections now. This has already been
> discussed to death for weeks now, and every argument against this patch has already
> been countered multiple times (including the one you are making now). Feel free to
> read the entire thread in the archives under the subject:
> "[PATCH 4/4] simplefb: add clock handling code"

You are on v2 and I hardly see any consensus on the v1 thread. Others
have made suggestions which I would agree with and you've basically
ignored them.

> At one point in time we need to stop bickering and make a decision, that time has
> come now, so please lets get this discussion over with and merge this, so that
> we can all move on and spend out time in a more productive manner.

Not an effective argument to get things merged.

Rob
