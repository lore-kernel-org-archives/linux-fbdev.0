From: Rob Herring <robh@kernel.org>
Date: Thu, 15 Oct 2015 13:46:32 +0000
Subject: Re: [PATCHv4 3/3] devicetree: Add led-backlight binding
Message-Id: <CAL_Jsq+trQ3jLczxvtzqfpUKBgxaazPdGyjLg+NT2YFva0_xbA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1443605522-1118-1-git-send-email-tomi.valkeinen@ti.com>
 <1443605522-1118-4-git-send-email-tomi.valkeinen@ti.com> <CAL_JsqJ+xYpX86DNHFCOEqV85FRh-Xzh1wg3p6guA0QeWG4+pg@mail.gmail.com>
 <561F9961.30008@ti.com>
In-Reply-To: <561F9961.30008@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Thu, Oct 15, 2015 at 7:17 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> Hi Rob,
>
> On 13/10/15 17:21, Rob Herring wrote:
>> On Wed, Sep 30, 2015 at 4:32 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>>> Add DT binding for led-backlight.
>>
>> Please use get_maintainers.pl.
>
> At some point I got feedback that the DT maintainers don't have time to
> look at each individual driver binding, but rely on the subsystem
> maintainers to handle them. Maybe I misunderstood that.

True, but that doesn't mean to not copy us. If we didn't want to be
copied, we would update MAINTAINERS.

I wouldn't call this one an individual driver either. This is very
much a generic binding which we do want to review.

>
>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>> Cc: devicetree@vger.kernel.org
>>> ---
>>>  .../bindings/video/backlight/led-backlight.txt     | 30 ++++++++++++++++++++++
>>>  1 file changed, 30 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/video/backlight/led-backlight.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/video/backlight/led-backlight.txt b/Documentation/devicetree/bindings/video/backlight/led-backlight.txt
>>> new file mode 100644
>>> index 000000000000..d4621d7414bc
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/video/backlight/led-backlight.txt
>>> @@ -0,0 +1,30 @@
>>> +led-backlight bindings
>>> +
>>> +Required properties:
>>> +  - compatible: "led-backlight"
>>> +  - leds: phandle to a led OF node [0]
>>
>> Why do we need 2 levels of LED nodes?
>
> Sorry, didn't get that. What do you mean with 2 levels?

You have the node the "leds" phandle points to which is the actual LED
device and then this node which is just backlight properties. And then
presumably another phandle in the panel device to point to the
backlight device.

>>> +  - brightness-levels: Array of distinct LED brightness levels. These
>>> +      are in the range from 0 to 255, passed to the LED class driver.
>>> +  - default-brightness-level: the default brightness level (index into the
>>> +      array defined by the "brightness-levels" property)
>>> +
>>> +Optional properties:
>>> +  - power-supply: regulator for supply voltage
>>> +  - enable-gpios: contains a single GPIO specifier for the GPIO which enables
>>> +                  and disables the backlight (see GPIO binding[1])
>>
>> Why are all of these not part of the LED node pointed to by leds?
>
> These are for the backlight, not for the LED chip. So "LED" here is a
> chip that produces (most likely) a PWM signal, and "backlight" is the
> collection of components that use the PWM to produce the backlight
> itself, and use the power-supply and gpios.

Okay, it wasn't clear that leds points to the LED controller node. The
example made it seem as it was the device. We already have a way to
describe LEDs and that is as child nodes of the LED controller node.
Please follow what was done for flash LEDs (leds/common.txt).

What's wrong with the existing pwm-backlight binding in the PWM case?

>
>> Describe the h/w, not what you want for a driver.
>
> I think this describes the HW quite well. The LED chip works fine
> without any of the properties here, and these are specific to the
> backlight part of the board.

A more complete example would be helpful here.

Rob
