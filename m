From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Date: Sun, 05 Oct 2014 17:09:52 +0000
Subject: Fixing boot-time hiccups in your display
Message-Id: <CAKON4OxRFCvMPMfZhxYNVaxscgAs5AX46YzK-4SU5o6E-iTD1w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

I edited the subject line to something more appropriate. This impacts
a lot of platforms and we should be getting more replies from people
on the ARM kernel list. This is likely something that deserves a
Kernel Summit discussion.

To summarize the problem....

The BIOS (uboot, etc) may have set various devices up into a working
state before handing off to the kernel.  The most obvious example of
this is the boot display.

So how do we transition onto the kernel provided device specific
drivers without interrupting these functioning devices?

This used to be simple, just build everything into the kernel. But
then along came multi-architecture kernels where most drivers are not
built in. Those kernels clean up everything (ie turn off unused
clocks, regulators, etc) right before user space starts. That's done
as a power saving measure.

Unfortunately that code turns off the clocks and regulators providing
the display on your screen. Which then promptly gets turned back on a
half second later when the boot scripts load the display driver. Let's
all hope the boot doesn't fail while the display is turned off.

Below is part of the discussion on how to fix this, but so far no
really good solution has been discovered.

For the whole history search for the simple-framebuffer threads. There
have been about 1,000 messages.

On Sun, Oct 5, 2014 at 12:34 PM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
> On Sun, Oct 5, 2014 at 11:36 AM, Chen-Yu Tsai <wens@csie.org> wrote:
>> On Sun, Oct 5, 2014 at 11:29 PM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
>>> On Sun, Oct 5, 2014 at 11:17 AM, Chen-Yu Tsai <wens@csie.org> wrote:
>>>> On Sun, Oct 5, 2014 at 11:07 PM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
>>>>> On Sun, Oct 5, 2014 at 10:27 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 10/05/2014 02:52 PM, jonsmirl@gmail.com wrote:
>>>>>>> On Sun, Oct 5, 2014 at 5:03 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> On 10/04/2014 02:38 PM, jonsmirl@gmail.com wrote:
>>>>>>>>> On Sat, Oct 4, 2014 at 5:50 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> On 10/04/2014 12:56 AM, jonsmirl@gmail.com wrote:
>>>>>>>>>>> On Fri, Oct 3, 2014 at 4:08 PM, Rob Herring <robherring2@gmail.com> wrote:
>>>>>>>>>>>> On Fri, Oct 3, 2014 at 12:34 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 10/03/2014 05:57 PM, Rob Herring wrote:
>>>>>>>>>>>>>> On Fri, Oct 3, 2014 at 9:05 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>>>>>>>>>>> A simple-framebuffer node represents a framebuffer setup by the firmware /
>>>>>>>>>>>>>>> bootloader. Such a framebuffer may have a number of clocks in use, add a
>>>>>>>>>>>>>>> property to communicate this to the OS.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>>>>>>>>>>>> Reviewed-by: Mike Turquette <mturquette@linaro.org>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> --
>>>>>>>>>>>>>>> Changes in v2:
>>>>>>>>>>>>>>> -Added Reviewed-by: Mike Turquette <mturquette@linaro.org>
>>>>>>>>>>>>>>> Changes in v3:
>>>>>>>>>>>>>>> -Updated description to make clear simplefb deals with more then just memory
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> NAK. "Fixing" the description is not what I meant and does not address
>>>>>>>>>>>>>> my concerns. Currently, simplefb is configuration data. It is
>>>>>>>>>>>>>> auxiliary data about how a chunk of memory is used. Using it or not
>>>>>>>>>>>>>> has no side effects on the hardware setup, but you are changing that
>>>>>>>>>>>>>> aspect. You are mixing in a hardware description that is simply
>>>>>>>>>>>>>> inaccurate.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Memory is hardware too, what simplefb is is best seen as a virtual device, and
>>>>>>>>>>>>> even virtual devices have hardware resources they need, such as a chunk of memory,
>>>>>>>>>>>>> which the kernel should not touch other then use it as a framebuffer, likewise
>>>>>>>>>>>>> on some systems the virtual device needs clocks to keep running.
>>>>>>>>>>>>>
>>>>>>>>>>>>>> The kernel has made the decision to turn off "unused" clocks. If its
>>>>>>>>>>>>>> determination of what is unused is wrong, then it is not a problem to
>>>>>>>>>>>>>> fix in DT.
>>>>>>>>>>>>>
>>>>>>>>>>>>> No, it is up to DT to tell the kernel what clocks are used, that is how it works
>>>>>>>>>>>>> for any other device. I don't understand why some people keep insisting simplefb
>>>>>>>>>>>>> for some reason is o so very very special, because it is not special, it needs
>>>>>>>>>>>>> resources, and it needs to tell the kernel about this or bad things happen.
>>>>>>>>>>>>
>>>>>>>>>>>> No, the DT describes the connections of clocks from h/w block to h/w
>>>>>>>>>>>> block. Their use is implied by the connection.
>>>>>>>>>>>>
>>>>>>>>>>>> And yes, as the other thread mentioned DT is more than just hardware
>>>>>>>>>>>> information. However, what you are adding IS hardware information and
>>>>>>>>>>>> clearly has a place somewhere else. And adding anything which is not
>>>>>>>>>>>> hardware description gets much more scrutiny.
>>>>>>>>>>>>
>>>>>>>>>>>>> More over it is a bit late to start making objections now. This has already been
>>>>>>>>>>>>> discussed to death for weeks now, and every argument against this patch has already
>>>>>>>>>>>>> been countered multiple times (including the one you are making now). Feel free to
>>>>>>>>>>>>> read the entire thread in the archives under the subject:
>>>>>>>>>>>>> "[PATCH 4/4] simplefb: add clock handling code"
>>>>>>>>>>>>
>>>>>>>>>>>> You are on v2 and I hardly see any consensus on the v1 thread. Others
>>>>>>>>>>>> have made suggestions which I would agree with and you've basically
>>>>>>>>>>>> ignored them.
>>>>>>>>>>>>
>>>>>>>>>>>>> At one point in time we need to stop bickering and make a decision, that time has
>>>>>>>>>>>>> come now, so please lets get this discussion over with and merge this, so that
>>>>>>>>>>>>> we can all move on and spend out time in a more productive manner.
>>>>>>>>>>>>
>>>>>>>>>>>> Not an effective argument to get things merged.
>>>>>>>>>>>
>>>>>>>>>>> If there is not good solution to deferring clock clean up in the
>>>>>>>>>>> kernel, another approach is to change how simple-framebuffer is
>>>>>>>>>>> described in the device tree....
>>>>>>>>>>>
>>>>>>>>>>> Right now it is a stand-alone item that looks like a device node, but
>>>>>>>>>>> it isn't a device.
>>>>>>>>>>>
>>>>>>>>>>> framebuffer {
>>>>>>>>>>>     compatible = "simple-framebuffer";
>>>>>>>>>>>     reg = <0x1d385000 (1600 * 1200 * 2)>;
>>>>>>>>>>>     width = <1600>;
>>>>>>>>>>>     height = <1200>;
>>>>>>>>>>>     stride = <(1600 * 2)>;
>>>>>>>>>>>     format = "r5g6b5";
>>>>>>>>>>> };
>>>>>>>>>>>
>>>>>>>>>>> How about something like this?
>>>>>>>>>>>
>>>>>>>>>>> reserved-memory {
>>>>>>>>>>>     #address-cells = <1>;
>>>>>>>>>>>     #size-cells = <1>;
>>>>>>>>>>>     ranges;
>>>>>>>>>>>
>>>>>>>>>>>     display_reserved: framebuffer@78000000 {
>>>>>>>>>>>         reg = <0x78000000  (1600 * 1200 * 2)>;
>>>>>>>>>>>     };
>>>>>>>>>>> };
>>>>>>>>>>>
>>>>>>>>>>> lcd0: lcd-controller@820000 {
>>>>>>>>>>>     compatible = "marvell,dove-lcd";
>>>>>>>>>>>     reg = <0x820000 0x1000>;
>>>>>>>>>>>     interrupts = <47>;
>>>>>>>>>>>     clocks = <&si5351 0>;
>>>>>>>>>>>     clock-names = "ext_ref_clk_1";
>>>>>>>>>>> };
>>>>>>>>>>>
>>>>>>>>>>> chosen {
>>>>>>>>>>>     boot-framebuffer {
>>>>>>>>>>>        compatible = "simple-framebuffer";
>>>>>>>>>>>        device = <&lcd0>;
>>>>>>>>>>>        framebuffer = <&display_reserved>;
>>>>>>>>>>>        width = <1600>;
>>>>>>>>>>>        height = <1200>;
>>>>>>>>>>>        stride = <(1600 * 2)>;
>>>>>>>>>>>        format = "r5g6b5";
>>>>>>>>>>>     };
>>>>>>>>>>> }
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> This moves the definition of the boot framebuffer setup into the area
>>>>>>>>>>> where bootloader info is suppose to go. Then you can use the phandle
>>>>>>>>>>> to follow the actual device chains and protect the clocks and
>>>>>>>>>>> regulators. To make that work you are required to provide an accurate
>>>>>>>>>>> description of the real video hardware so that this chain can be
>>>>>>>>>>> followed.
>>>>>>>>>>
>>>>>>>>>> This will not work, first of all multiple blocks may be involved, so
>>>>>>>>>> the device = in the boot-framebuffer would need to be a list. That in
>>>>>>>>>> itself is not a problem, the problem is that the blocks used may have
>>>>>>>>>> multiple clocks, of which the setup mode likely uses only a few.
>>>>>>>>>>
>>>>>>>>>> So if we do things this way, we end up keeping way to many clocks
>>>>>>>>>> enabled.
>>>>>>>>>
>>>>>>>>> That doesn't hurt anything.
>>>>>>>>
>>>>>>>> <snip lots of stuff based on the above>
>>>>>>>>
>>>>>>>> Wrong, that does hurt things. As already discussed simply stopping the
>>>>>>>> clocks from being disabled by the unused_clks mechanism is not enough,
>>>>>>>> since clocks may be shared, and we must stop another device driver
>>>>>>>> sharing the clock and doing clk_enable; probe; clk_disable; disabling
>>>>>>>> the shared clk, which means calling clk_enable on it to mark it as
>>>>>>>> being in use. So this will hurt cause it will cause us to enable a bunch
>>>>>>>> of clks which should not be enabled.
>>>>>>>
>>>>>>> I said earlier that you would need to add a protected mechanism to
>>>>>>> clocks to handle this phase. When a clock/regulator is protected you
>>>>>>> can turn it on but you can't turn it off. When simplefb exits it will
>>>>>>> clear this protected status. When the protected status gets cleared
>>>>>>> treat it as a ref count decrement and turn off the clock/regulator if
>>>>>>> indicated to do so. If a clock is protected, all of it parents get the
>>>>>>> protected bit set too.
>>>>>>>
>>>>>>> Protected mode
>>>>>>>    you can turn clocks on, but not off
>>>>>>>    it is ref counted
>>>>>>>   when it hits zero, look at the normal refcount and set that state
>>>>>>>
>>>>>>> Protected mode is not long lived. It only hangs around until the real
>>>>>>> device driver loads.
>>>>>>
>>>>>> And that has already been nacked by the clk maintainer because it is
>>>>>> too complicated, and I agree this is tons more complicated then simply
>>>>>> adding the list of clocks to the simplefb node.
>>>>>>
>>>>>>>> I've been thinking more about this, and I understand that people don't
>>>>>>>> want to put hardware description in the simplefb node, but this is
>>>>>>>> not hardware description.
>>>>>>>>
>>>>>>>> u-boot sets up the display-pipeline to scan out of a certain part of
>>>>>>>> memory, in order to do this it writes the memory address to some registers
>>>>>>>> in the display pipeline, so what it is passing is not hardware description
>>>>>>>> (it is not passing all possible memory addresses for the framebuffer), but
>>>>>>>> it is passing information about the state in which it has left the display
>>>>>>>> pipeline, iow it is passing state information.
>>>>>>>
>>>>>>> Giving the buffer to a piece of hardware is more than setting state.
>>>>>>> The hardware now owns that buffer.  That ownership needs to be managed
>>>>>>> so that if the hardware decides it doesn't want the buffer it can be
>>>>>>> returned to the global pool.
>>>>>>>
>>>>>>> That's why the buffer has to go into that reserved memory section, not
>>>>>>> the chosen section.
>>>>>>
>>>>>> But is not in the reserved memory section, it is in the simplefb
>>>>>> section, and we're stuck with this because of backward compatibility.
>>>>>>
>>>>>>  An OS doesn't have to process chosen, it is just
>>>>>>> there for informational purposes. To keep the OS from thinking it owns
>>>>>>> the memory in that video buffer and can use it for OS purposes, it has
>>>>>>> to go into that reserved memory section.
>>>>>>>
>>>>>>> The clocks are different. We know exactly who owns those clocks, the
>>>>>>> graphics hardware.
>>>>>>>
>>>>>>> You want something like this where the state of the entire video path
>>>>>>> is encoded into the chosen section. But that info is going to vary all
>>>>>>> over the place with TV output, HDMI output, LCD panels, etc. simplefb
>>>>>>> isn't going to be simple any more. Plus the purposes of adding all of
>>>>>>> this complexity is just to handle the half second transition from boot
>>>>>>> loader control to real driver.
>>>>>>>
>>>>>>>  reserved-memory {
>>>>>>>      #address-cells = <1>;
>>>>>>>      #size-cells = <1>;
>>>>>>>      ranges;
>>>>>>>
>>>>>>>      display_reserved: framebuffer@78000000 {
>>>>>>>          reg = <0x78000000  (1600 * 1200 * 2)>;
>>>>>>>      };
>>>>>>>  };
>>>>>>>
>>>>>>>  lcd0: lcd-controller@820000 {
>>>>>>>      compatible = "marvell,dove-lcd";
>>>>>>>      reg = <0x820000 0x1000>;
>>>>>>>      interrupts = <47>;
>>>>>>>      framebuffer = <&display_reserved>;
>>>>>>>      clocks = <&si5351 0>;
>>>>>>>      clock-names = "ext_ref_clk_1";
>>>>>>>  };
>>>>>>>
>>>>>>>  chosen {
>>>>>>>      boot-framebuffer {
>>>>>>>         compatible = "simple-framebuffer";
>>>>>>>         state {
>>>>>>>             device = <&lcd0>;
>>>>>>>             width = <1600>;
>>>>>>>             height = <1200>;
>>>>>>>             stride = <(1600 * 2)>;
>>>>>>>             format = "r5g6b5";
>>>>>>>             clocks = <&si5351 on 10mhz>;
>>>>>>
>>>>>> Right, so here we get a list of clocks which are actually in use
>>>>>> by the simplefb, just as I've been advocating all the time already.
>>>>>>
>>>>>> Note that the clock speed is not necessary, all the kernel needs to
>>>>>> know is that it must not change it.
>>>>>>
>>>>>> So as you seem to agree that we need to pass some sort of clock state
>>>>>> info, then all we need to agree on now is where to put it, as said adding
>>>>>> the reg property to a reserved-memory node is out of the question because
>>>>>> of backward compat, likewise storing width, height and format in a state
>>>>>> sub-node are out of the question for the same reason. But other then that
>>>>>> I'm fine with putting the simplefb node under chosen and putting clocks
>>>>>> in there (without the state subnode) as you suggest above.
>>>>>>
>>>>>> So we seem to be in agreement here :)
>>>>>>
>>>>>>>            output = "hdmi";
>>>>>>>            state {
>>>>>>>                  device = <&hdmi>
>>>>>>>                  clocks = <&xyz on 12mhz>;
>>>>>>>           }
>>>>>>
>>>>>> That level of detail won't be necessary, simplefb is supposed to be
>>>>>> simple, the kernel does not need to know which outputs there are, there
>>>>>> will always be only one for simplefb.
>>>>>
>>>>> I don't agree, but you are going to do it any way so I'll try and help
>>>>> tkeep problem side effects I know of to a minimum. You are relying on
>>>>> the BIOS to provide detailed, accurate information. Relying on BIOSes
>>>>> to do that has historically been a very bad idea.
>>>>>
>>>>> If you go the way of putting this info into the chosen section you are
>>>>> going to have to mark the clocks/regulators in use for all of the
>>>>> outputs too -- hdmi, TV, LCD, backlights, etc, etc. Not going to be
>>>>> useful if the backlight turns off because simplefb hasn't grabbed it.
>>>>>
>>>>> This is the only real difference between the proposals - you want
>>>>> uboot to enumerate what needs to be protected. I don't trust the BIOS
>>>>> to do that reliably so I'd preferred to just protect everything in the
>>>>> device hardware chain until the device specific drivers load.
>>>>>
>>>>> -------------------------------------------------------
>>>>>
>>>>> I also still believe this is a problem up in Linux that we shouldn't
>>>>> be using the device tree to fix.
>>>>>
>>>>> It seems to me that the need for something like a 'protected' mode is
>>>>> a generic problem that could be extended to all hardware. In protected
>>>>> mode things can be turned on but nothing can be turned off.  Only
>>>>> after the kernel has all of the necessary drivers loaded would a small
>>>>> app run that hits an IOCTL and says, ok protected mode is over now
>>>>> clean up these things wasting power.
>>>>
>>>> What happens if some clock needs to be disabled?
>>>> Like clocks that must be gated before setting a new clock rate
>>>> or reparenting. The kernel supports these, and it wouldn't surprise me
>>>> if some driver actually requires this. You might end up blocking that driver
>>>> or breaking its probe function.
>>>
>>> Arggh, using those phandles in the chosen section means uboot is going
>>> to have to get recompiled every time the DTS changes. I think we need
>>> to come up with a scheme that doesn't need for uboot to be aware of
>>> phandles.
>>
>> Why is that? U-boot is perfectly capable of patching device tree blobs.
>>
>> Mainline u-boot already updates the memory node, and if needed,
>> the reserved-memory node as well.
>>
>> Someone just has to write the (ugly) code to do it, which Luc
>> has already done for clock phandles for sunxi.
>
> So uboot is going to contain code to hunt through the Linux provided
> DTB to find the correct phandles for the clocks/regulators and then
> patch those phandles into the chosen section? How is uboot going to
> reconcile it's concept of what those clock/regulators are with a Linux
> provided DTB that is constant state of flux?
>
> I think trying to get uboot to manipulate phandles in a Linux provided
> DTB is an incredibly fragile mechanism that will be prone to breakage.
>
> Much better to come with a scheme where uboot just inserts fixed
> strings into the DTB. That last example device tree I posted removed
> all of the phandles from the chosen section, but it relies on the
> kernel gaining 'boot' mode.
>
>
>>
>> U-boot itself does not need to use the dtb, though that seems
>> like the direction it's headed.
>>
>>> Something like this...
>>> uboot adds the chosen section then Linux would error out if the
>>> framebuffer in the chosen section doesn't match the reserved memory it
>>> is expecting.  Or make uboot smart enough to hunt down the reserved
>>> memory section and patch it like it does with dramsize.
>>
>> And someone probably will. Why is that a problem?
>>
>>
>> ChenYu
>>
>>
>>>
>>>  reserved-memory {
>>>      #address-cells = <1>;
>>>      #size-cells = <1>;
>>>      ranges;
>>>
>>>      display_reserved: framebuffer@78000000 {
>>>          reg = <0x78000000  (1600 * 1200 * 2)>;
>>>      };
>>>  };
>>>
>>>  lcd0: lcd-controller@820000 {
>>>      compatible = "marvell,dove-lcd";
>>>      reg = <0x820000 0x1000>;
>>>      interrupts = <47>;
>>>      framebuffer = <&display_reserved>;
>>>      clocks = <&si5351 0>;
>>>      clock-names = "ext_ref_clk_1";
>>>  };
>>>
>>>  chosen {
>>>      boot-framebuffer {
>>>         framebuffer = <0x78000000>;
>>>         width = <1600>;
>>>         height = <1200>;
>>>         stride = <(1600 * 2)>;
>>>         format = "r5g6b5";
>>>      };
>>>  }
>>>
>>>
>>>
>>>>
>>>> And what if reset controls are asserted then de-asserted in the probe function?
>>>> IIRC there are drivers that do this to reset the underlying hardware.
>>>>
>>>>> Maybe it should be renamed 'boot' mode. To implement this the various
>>>>> 'turn off' functions would get a 'boot' mode flag. In boot mode they
>>>>> track the ref counts but don't turn things off when the ref count hits
>>>>> zero.  Then that ioctl() that the user space app calls runs the chains
>>>>> of all of the clocks/regulators/etc and if the ref count is zero turns
>>>>> them off again and clears 'boot' mode. Doesn't matter if you turn off
>>>>> something again that is already off.
>>>>
>>>> And what if something just happened to be left on that some driver
>>>> wants to turn off? You are assuming everything not used is off,
>>>> which is not always the case.
>
>
>
> --
> Jon Smirl
> jonsmirl@gmail.com



-- 
Jon Smirl
jonsmirl@gmail.com
