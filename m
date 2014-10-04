From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Date: Sat, 04 Oct 2014 12:38:24 +0000
Subject: Re: [linux-sunxi] Re: [PATCH v3] dt-bindings: Add a clocks property to the simple-framebuffer bindin
Message-Id: <CAKON4Owg_ABPJ9JfXqZwj9TQQNSPa8LKgr7U762B6--NTrOVFQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1412345120-24588-1-git-send-email-hdegoede@redhat.com>
 <CAL_JsqKU2n8p=YfJua3k-mR40bG_4SiZY8_-SL-MXtuWN5NeHg@mail.gmail.com>
 <542EDE11.3010802@redhat.com>
 <CAL_Jsq+3c7ToCGaR4Nz7dDXvebBKzzMv85swzy2mzOou+gM5iw@mail.gmail.com>
 <CAKON4OxxQ3hp0npr1Zh6w-2-HwMyC+8OxOCBmFFmBZ0N+6N0dw@mail.gmail.com>
 <542FC2E6.5040800@redhat.com>
In-Reply-To: <542FC2E6.5040800@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sat, Oct 4, 2014 at 5:50 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 10/04/2014 12:56 AM, jonsmirl@gmail.com wrote:
>> On Fri, Oct 3, 2014 at 4:08 PM, Rob Herring <robherring2@gmail.com> wrote:
>>> On Fri, Oct 3, 2014 at 12:34 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>>>> Hi,
>>>>
>>>> On 10/03/2014 05:57 PM, Rob Herring wrote:
>>>>> On Fri, Oct 3, 2014 at 9:05 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>> A simple-framebuffer node represents a framebuffer setup by the firmware /
>>>>>> bootloader. Such a framebuffer may have a number of clocks in use, add a
>>>>>> property to communicate this to the OS.
>>>>>>
>>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>>> Reviewed-by: Mike Turquette <mturquette@linaro.org>
>>>>>>
>>>>>> --
>>>>>> Changes in v2:
>>>>>> -Added Reviewed-by: Mike Turquette <mturquette@linaro.org>
>>>>>> Changes in v3:
>>>>>> -Updated description to make clear simplefb deals with more then just memory
>>>>>
>>>>> NAK. "Fixing" the description is not what I meant and does not address
>>>>> my concerns. Currently, simplefb is configuration data. It is
>>>>> auxiliary data about how a chunk of memory is used. Using it or not
>>>>> has no side effects on the hardware setup, but you are changing that
>>>>> aspect. You are mixing in a hardware description that is simply
>>>>> inaccurate.
>>>>
>>>> Memory is hardware too, what simplefb is is best seen as a virtual device, and
>>>> even virtual devices have hardware resources they need, such as a chunk of memory,
>>>> which the kernel should not touch other then use it as a framebuffer, likewise
>>>> on some systems the virtual device needs clocks to keep running.
>>>>
>>>>> The kernel has made the decision to turn off "unused" clocks. If its
>>>>> determination of what is unused is wrong, then it is not a problem to
>>>>> fix in DT.
>>>>
>>>> No, it is up to DT to tell the kernel what clocks are used, that is how it works
>>>> for any other device. I don't understand why some people keep insisting simplefb
>>>> for some reason is o so very very special, because it is not special, it needs
>>>> resources, and it needs to tell the kernel about this or bad things happen.
>>>
>>> No, the DT describes the connections of clocks from h/w block to h/w
>>> block. Their use is implied by the connection.
>>>
>>> And yes, as the other thread mentioned DT is more than just hardware
>>> information. However, what you are adding IS hardware information and
>>> clearly has a place somewhere else. And adding anything which is not
>>> hardware description gets much more scrutiny.
>>>
>>>> More over it is a bit late to start making objections now. This has already been
>>>> discussed to death for weeks now, and every argument against this patch has already
>>>> been countered multiple times (including the one you are making now). Feel free to
>>>> read the entire thread in the archives under the subject:
>>>> "[PATCH 4/4] simplefb: add clock handling code"
>>>
>>> You are on v2 and I hardly see any consensus on the v1 thread. Others
>>> have made suggestions which I would agree with and you've basically
>>> ignored them.
>>>
>>>> At one point in time we need to stop bickering and make a decision, that time has
>>>> come now, so please lets get this discussion over with and merge this, so that
>>>> we can all move on and spend out time in a more productive manner.
>>>
>>> Not an effective argument to get things merged.
>>
>> If there is not good solution to deferring clock clean up in the
>> kernel, another approach is to change how simple-framebuffer is
>> described in the device tree....
>>
>> Right now it is a stand-alone item that looks like a device node, but
>> it isn't a device.
>>
>> framebuffer {
>>     compatible = "simple-framebuffer";
>>     reg = <0x1d385000 (1600 * 1200 * 2)>;
>>     width = <1600>;
>>     height = <1200>;
>>     stride = <(1600 * 2)>;
>>     format = "r5g6b5";
>> };
>>
>> How about something like this?
>>
>> reserved-memory {
>>     #address-cells = <1>;
>>     #size-cells = <1>;
>>     ranges;
>>
>>     display_reserved: framebuffer@78000000 {
>>         reg = <0x78000000  (1600 * 1200 * 2)>;
>>     };
>> };
>>
>> lcd0: lcd-controller@820000 {
>>     compatible = "marvell,dove-lcd";
>>     reg = <0x820000 0x1000>;
>>     interrupts = <47>;
>>     clocks = <&si5351 0>;
>>     clock-names = "ext_ref_clk_1";
>> };
>>
>> chosen {
>>     boot-framebuffer {
>>        compatible = "simple-framebuffer";
>>        device = <&lcd0>;
>>        framebuffer = <&display_reserved>;
>>        width = <1600>;
>>        height = <1200>;
>>        stride = <(1600 * 2)>;
>>        format = "r5g6b5";
>>     };
>> }
>>
>>
>> This moves the definition of the boot framebuffer setup into the area
>> where bootloader info is suppose to go. Then you can use the phandle
>> to follow the actual device chains and protect the clocks and
>> regulators. To make that work you are required to provide an accurate
>> description of the real video hardware so that this chain can be
>> followed.
>
> This will not work, first of all multiple blocks may be involved, so
> the device = in the boot-framebuffer would need to be a list. That in
> itself is not a problem, the problem is that the blocks used may have
> multiple clocks, of which the setup mode likely uses only a few.
>
> So if we do things this way, we end up keeping way to many clocks
> enabled.

That doesn't hurt anything. Simplefb is not going to enable anything,
it is just protecting things from getting disabled. The whole point of
simplefb is to assume that the BIOS set things up correctly. When the
device specific driver loads everything will get sorted out and it
will own the correct clocks.

This does require a device specific driver to be written. Fairly easy
to do by providing a device specific framebuffer driver while we wait
on the KMS one.  I do not support letting the life of simplefb extend
past the initial boot window. For example - it is not going to came
back after suspend/resume.

It doesn't work for simplefb to just increment the ref count as a way
of protecting the clocks/regulator. If you inc the ref count and the
clock is off, the device specific driver can't turn it on. We have to
build a new 'protected' mechanism for the clocks/regulators. When a
clock/regulator is 'protected'  it can't turn off until both the ref
count is zero and the protected bit is off. 'protected' does not
impact turning it on.

And all of this is a problem up in the OS. Device trees are hardware
descriptions, they are not meant to be manipulated into fixing OS
level problems.

>
> This does nicely show why the clocks really belong in the simplefb
> node though. What you suggest above, would lead to simplefb having
> access to the hardware info / description of the display engine
> blocks, putting the clocks info in the display engine nodes, so
> keeping hardware description with hardware description as people
> want.
>
> But as said that does not tell the kernel which clocks are actually
> used for the setup mode, so it does not provide the info the kernel
> needs. What the kernel needs is not hardware description, but a
> list of clocks which are *actually used* by the setup mode.
>
> Thinking more about this the clocks property in the simplefb node
> is just like the reg property. Both are properties normally only
> found in real harware nodes, not in an informational node like
> simplefb.
>
> But for the kernel to be able to actually use the simplefb it
> needs to know which memory is used by the framebuffer. One could
> argue that a reg property is hardware description, and thus does not
> belong in the simplefb node, and that the kernel should just magically
> figure out which memory is used.

This is not a good parallel. That memory buffer has been given to the
hardware so my example DT is wrong, That's why we need to review these
things. It should be like this...

The device tree is reflecting ownership, not state.  If the buffer is
not under the hardware when simplefb disappears it would get freed and
the display controller still owns it and is still using it.

>> reserved-memory {
>>     #address-cells = <1>;
>>     #size-cells = <1>;
>>     ranges;
>>
>>     display_reserved: framebuffer@78000000 {
>>         reg = <0x78000000  (1600 * 1200 * 2)>;
>>     };
>> };
>>
>> lcd0: lcd-controller@820000 {
>>     compatible = "marvell,dove-lcd";
>>     reg = <0x820000 0x1000>;
>>     interrupts = <47>;
>>     clocks = <&si5351 0>;
>>     clock-names = "ext_ref_clk_1";
>>     framebuffer = <&display_reserved>;
>> };
>>
>> chosen {
>>     boot-framebuffer {
>>        compatible = "simple-framebuffer";
>>        device = <&lcd0>;
>>        width = <1600>;
>>        height = <1200>;
>>        stride = <(1600 * 2)>;
>>        format = "r5g6b5";
>>     };
>> }

It is questionable whether there should be a compatible string in the
chosen section. That compatible string is loading in a parser that
understands the section, not a device driver. The simplefb driver
could key off from 'boot-framebuffer' instead of the compatible
string.


>
> Everyone sees that the kernel cannot magically figure out which memory
> is used by the simplefb. Yet people expect the kernel to somehow
> magically figure out which clocks are used, to avoid accidentally turning
> them off.
>
> This is not consistent, either the kernel needs to be told these things,
> and then it needs to be told all of them, or hardware node properties
> like a reg property do not belong in an informational node, and then the
> reg property should not be in the simplefb node either, and the kernel
> should somehow magically figure out where the memory lives, just like
> some people are expecting the kernel to magically figure out which
> clocks are used.
>
> Regards,
>
> Hans



-- 
Jon Smirl
jonsmirl@gmail.com
