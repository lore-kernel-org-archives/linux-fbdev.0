From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Date: Fri, 03 Oct 2014 22:56:32 +0000
Subject: Re: [linux-sunxi] Re: [PATCH v3] dt-bindings: Add a clocks property to the simple-framebuffer bindin
Message-Id: <CAKON4OxxQ3hp0npr1Zh6w-2-HwMyC+8OxOCBmFFmBZ0N+6N0dw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1412345120-24588-1-git-send-email-hdegoede@redhat.com>
 <CAL_JsqKU2n8p=YfJua3k-mR40bG_4SiZY8_-SL-MXtuWN5NeHg@mail.gmail.com>
 <542EDE11.3010802@redhat.com>
 <CAL_Jsq+3c7ToCGaR4Nz7dDXvebBKzzMv85swzy2mzOou+gM5iw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+3c7ToCGaR4Nz7dDXvebBKzzMv85swzy2mzOou+gM5iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Oct 3, 2014 at 4:08 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Fri, Oct 3, 2014 at 12:34 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 10/03/2014 05:57 PM, Rob Herring wrote:
>>> On Fri, Oct 3, 2014 at 9:05 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>>> A simple-framebuffer node represents a framebuffer setup by the firmware /
>>>> bootloader. Such a framebuffer may have a number of clocks in use, add a
>>>> property to communicate this to the OS.
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> Reviewed-by: Mike Turquette <mturquette@linaro.org>
>>>>
>>>> --
>>>> Changes in v2:
>>>> -Added Reviewed-by: Mike Turquette <mturquette@linaro.org>
>>>> Changes in v3:
>>>> -Updated description to make clear simplefb deals with more then just memory
>>>
>>> NAK. "Fixing" the description is not what I meant and does not address
>>> my concerns. Currently, simplefb is configuration data. It is
>>> auxiliary data about how a chunk of memory is used. Using it or not
>>> has no side effects on the hardware setup, but you are changing that
>>> aspect. You are mixing in a hardware description that is simply
>>> inaccurate.
>>
>> Memory is hardware too, what simplefb is is best seen as a virtual device, and
>> even virtual devices have hardware resources they need, such as a chunk of memory,
>> which the kernel should not touch other then use it as a framebuffer, likewise
>> on some systems the virtual device needs clocks to keep running.
>>
>>> The kernel has made the decision to turn off "unused" clocks. If its
>>> determination of what is unused is wrong, then it is not a problem to
>>> fix in DT.
>>
>> No, it is up to DT to tell the kernel what clocks are used, that is how it works
>> for any other device. I don't understand why some people keep insisting simplefb
>> for some reason is o so very very special, because it is not special, it needs
>> resources, and it needs to tell the kernel about this or bad things happen.
>
> No, the DT describes the connections of clocks from h/w block to h/w
> block. Their use is implied by the connection.
>
> And yes, as the other thread mentioned DT is more than just hardware
> information. However, what you are adding IS hardware information and
> clearly has a place somewhere else. And adding anything which is not
> hardware description gets much more scrutiny.
>
>> More over it is a bit late to start making objections now. This has already been
>> discussed to death for weeks now, and every argument against this patch has already
>> been countered multiple times (including the one you are making now). Feel free to
>> read the entire thread in the archives under the subject:
>> "[PATCH 4/4] simplefb: add clock handling code"
>
> You are on v2 and I hardly see any consensus on the v1 thread. Others
> have made suggestions which I would agree with and you've basically
> ignored them.
>
>> At one point in time we need to stop bickering and make a decision, that time has
>> come now, so please lets get this discussion over with and merge this, so that
>> we can all move on and spend out time in a more productive manner.
>
> Not an effective argument to get things merged.

If there is not good solution to deferring clock clean up in the
kernel, another approach is to change how simple-framebuffer is
described in the device tree....

Right now it is a stand-alone item that looks like a device node, but
it isn't a device.

framebuffer {
    compatible = "simple-framebuffer";
    reg = <0x1d385000 (1600 * 1200 * 2)>;
    width = <1600>;
    height = <1200>;
    stride = <(1600 * 2)>;
    format = "r5g6b5";
};

How about something like this?

reserved-memory {
    #address-cells = <1>;
    #size-cells = <1>;
    ranges;

    display_reserved: framebuffer@78000000 {
        reg = <0x78000000  (1600 * 1200 * 2)>;
    };
};

lcd0: lcd-controller@820000 {
    compatible = "marvell,dove-lcd";
    reg = <0x820000 0x1000>;
    interrupts = <47>;
    clocks = <&si5351 0>;
    clock-names = "ext_ref_clk_1";
};

chosen {
    boot-framebuffer {
       compatible = "simple-framebuffer";
       device = <&lcd0>;
       framebuffer = <&display_reserved>;
       width = <1600>;
       height = <1200>;
       stride = <(1600 * 2)>;
       format = "r5g6b5";
    };
}


This moves the definition of the boot framebuffer setup into the area
where bootloader info is suppose to go. Then you can use the phandle
to follow the actual device chains and protect the clocks and
regulators. To make that work you are required to provide an accurate
description of the real video hardware so that this chain can be
followed.

The main assumption here is that the syntax for clock and regulators
is standardized enough that the generic simplefb code can run the
phandle chain and discover them all. If they aren't then we messed up
and simplefb gains some complexity to handle the irregular
descriptions. That is something having a schema for device tree would
have prevented.

The compatible string should trigger simple-fb into making a 'struct
device' that isn't hooked to any real hardware. Not clear that we
should use a compatible = "" here. The device = <> points to the real
hardware. Run that phandle chain and figure out what clocks need to be
protected.

Now when the driver for dove-lcd loads there won't be anything already
attached to the hardware so there is no complex hand off needed.
dove-lcd will just need to signal simple-fb to exit Exiting will
decrement the ref counts on clocks/regulators.

The memory region also allows for a ref count mechanism which allows
it to be passed from simplefb to dove-lcd. If the ref count goes to
zero when simplefb exits, it can be reclaimed.

>
> Rob
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.



-- 
Jon Smirl
jonsmirl@gmail.com
