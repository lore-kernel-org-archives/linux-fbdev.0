From: Rob Herring <robh@kernel.org>
Date: Thu, 15 Oct 2015 18:55:51 +0000
Subject: Re: [PATCHv4 3/3] devicetree: Add led-backlight binding
Message-Id: <CAL_JsqJ0JUuwkVKtWbzqEWemx7wME61KYxgvv=vNUT8FiMtGYw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1443605522-1118-1-git-send-email-tomi.valkeinen@ti.com>
 <1443605522-1118-4-git-send-email-tomi.valkeinen@ti.com> <CAL_JsqJ+xYpX86DNHFCOEqV85FRh-Xzh1wg3p6guA0QeWG4+pg@mail.gmail.com>
 <561F9961.30008@ti.com> <CAL_Jsq+trQ3jLczxvtzqfpUKBgxaazPdGyjLg+NT2YFva0_xbA@mail.gmail.com>
 <561FBC4F.6030306@ti.com>
In-Reply-To: <561FBC4F.6030306@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Thu, Oct 15, 2015 at 9:46 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> Hi Rob,
>
> On 15/10/15 16:46, Rob Herring wrote:
>
>>> At some point I got feedback that the DT maintainers don't have time to
>>> look at each individual driver binding, but rely on the subsystem
>>> maintainers to handle them. Maybe I misunderstood that.
>>
>> True, but that doesn't mean to not copy us. If we didn't want to be
>> copied, we would update MAINTAINERS.
>
> Ok.
>
>>>> Why do we need 2 levels of LED nodes?
>>>
>>> Sorry, didn't get that. What do you mean with 2 levels?
>>
>> You have the node the "leds" phandle points to which is the actual LED
>> device and then this node which is just backlight properties. And then
>> presumably another phandle in the panel device to point to the
>> backlight device.
>
> Ok, I see what you mean.
>
> Well, I have to say this is far from perfect. I initially pushed for a
> PWM driver for the LED chip we use (tlc591xx), which would have allowed
> us to use pwm-backlight driver. But Andrew was using the same chip for
> more LED-ish use cases, for which a LED driver was more suitable.
>
> But what I think we really should have is a more generic way to
> represent output pins, so that GPIOs (well, GPOs really), PWMs and
> current controlled outputs would all be done the same way.
>
> It was rather difficult to use the LED driver and LED bindings for this,
> as (afaics) they were really never designed to be used for anything else
> than for simple LEDs (i.e. a LED connected directly to the LED chip).
> The flash support was added later, but that's almost as simple as the
> first case.

There's still room to extend it though.

>>> These are for the backlight, not for the LED chip. So "LED" here is a
>>> chip that produces (most likely) a PWM signal, and "backlight" is the
>>> collection of components that use the PWM to produce the backlight
>>> itself, and use the power-supply and gpios.
>>
>> Okay, it wasn't clear that leds points to the LED controller node. The
>
> No, it doesn't point to the main LED node (the one having 'compatible').
> It points to a child node.
>
>> example made it seem as it was the device. We already have a way to
>> describe LEDs and that is as child nodes of the LED controller node.
>
> True, but those child nodes are very limited. As I see it, those child
> nodes really describe the outputs of the LED chip, not what's on the
> other end of the lines.

The child nodes are supposed to be the other end. In the flash case,
the properties are constraints on the flash LED (i.e. different flash
LEDs will have different max currents).

>
> If on the other end of the lines is a more complex device, we need a
> proper device driver for it, with a proper DT node with compatible
> property etc.
>
> Now, one could argue that a "backlight" that gets the LED signal from a
> LED chip is really just a simple LED. But there are complications:

I would say backlights are a complex example of LEDs. Of course, there
are backlights not based on LEDs, but we're not talking about those
here.

> - Our board needs a GPIO to enable the backlight. I can't say what
> exactly the GPIO does as my HW skills don't go far enough, but all this
> is after the LED chip. I also see the circuitry using powers, which in
> our case happen to be always on so we don't need to enable them explicitly.

The GPIO is probably controlling a transistor to connect the LED anode
to ground and therefore turn it on. These have nothing to do with
backlights really, but really are common to LEDs. Every LED needs a
supply rail too. This may come for a regulator or directly from an LED
driver IC.

If the flash LED binding doesn't have these, then it is only a matter of time.

>
> - We need a backlight device/driver (because of the Linux SW stack).

From a binding perspective, not my problem. The problem with the
driver needs driving the binding definition is the drivers can change
over time. IIRC there has been some discussion of combining the 2
subsystems in the kernel, so we don't want to create something defined
by current kernel needs.

> So, maybe it would be possible to construct all that in a LED child
> node, and the LED driver would create a child device for the nodes which
> have 'compatible' property. But then, that would be very different from
> pwm-backlight, and the parent-child relationships are usually used to
> indicate a control relationship, right?

This is along the lines I was thinking, but don't see how it is very
different at the binding level. The parent-child relationship is
typically control path or just what is downstream from the parent
device. Some bindings like GPIO and PWM don't follow this, but that is
often because they are just additional sideband interfaces on top of
the main control interface. I think simply making the "backlight" node
from the pwm-backlight binding a child works. We probably need a
different compatible string though (led-backlight is as good as
anything). I also think we should require child nodes to have a
compatible string which we didn't do for flash devices. It's probably
not too late to fix that.

I think there are 2 cases of PWM connection to LEDs to consider. The
PWM is an input to a LED driver chip or the PWM directly controls the
LED (attached to the anode). The current pwm-backlight binding covers
the latter. In the former case, pwms should probably be in the parent
(LED driver IC node). Of course, if the driver IC has no s/w
controllable interface beyond PWM, then it probably doesn't need to be
modeled at all in DT.

> The led-backlight in these patches is very much similar to pwm-backlight.

Yes, I think we're really only debating the structure of nodes.

>
>> Please follow what was done for flash LEDs (leds/common.txt).
>
> The flash support is quite simple. I'm not sure how I could do the same
> for the backlight, as I described above.
>
>> What's wrong with the existing pwm-backlight binding in the PWM case?
>
> Nothing, if there's a PWM driver. But if the LED chip is modelled as a
> LED driver, pwm-backlight is out. I think there are two kinds of LED
> chips, PWM ones and current-controlling ones. And then there are the PWM
> devices which are clearly PWM ones.
>
>>>> Describe the h/w, not what you want for a driver.
>>>
>>> I think this describes the HW quite well. The LED chip works fine
>>> without any of the properties here, and these are specific to the
>>> backlight part of the board.
>>
>> A more complete example would be helpful here.
>
> Of our HW? I can't give the schematics but I hope I described it enough
> above.

I just meant the relationship of all the nodes involved.

Rob
