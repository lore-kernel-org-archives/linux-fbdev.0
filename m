From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 15 Oct 2015 14:46:39 +0000
Subject: Re: [PATCHv4 3/3] devicetree: Add led-backlight binding
Message-Id: <561FBC4F.6030306@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="vgCfwctCbkDO0Djs3TL5UTJQm7iFhRNxI"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1443605522-1118-1-git-send-email-tomi.valkeinen@ti.com>
 <1443605522-1118-4-git-send-email-tomi.valkeinen@ti.com>
 <CAL_JsqJ+xYpX86DNHFCOEqV85FRh-Xzh1wg3p6guA0QeWG4+pg@mail.gmail.com>
 <561F9961.30008@ti.com>
 <CAL_Jsq+trQ3jLczxvtzqfpUKBgxaazPdGyjLg+NT2YFva0_xbA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+trQ3jLczxvtzqfpUKBgxaazPdGyjLg+NT2YFva0_xbA@mail.gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

--vgCfwctCbkDO0Djs3TL5UTJQm7iFhRNxI
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On 15/10/15 16:46, Rob Herring wrote:

>> At some point I got feedback that the DT maintainers don't have time t=
o
>> look at each individual driver binding, but rely on the subsystem
>> maintainers to handle them. Maybe I misunderstood that.
>=20
> True, but that doesn't mean to not copy us. If we didn't want to be
> copied, we would update MAINTAINERS.

Ok.

>>> Why do we need 2 levels of LED nodes?
>>
>> Sorry, didn't get that. What do you mean with 2 levels?
>=20
> You have the node the "leds" phandle points to which is the actual LED
> device and then this node which is just backlight properties. And then
> presumably another phandle in the panel device to point to the
> backlight device.

Ok, I see what you mean.

Well, I have to say this is far from perfect. I initially pushed for a
PWM driver for the LED chip we use (tlc591xx), which would have allowed
us to use pwm-backlight driver. But Andrew was using the same chip for
more LED-ish use cases, for which a LED driver was more suitable.

But what I think we really should have is a more generic way to
represent output pins, so that GPIOs (well, GPOs really), PWMs and
current controlled outputs would all be done the same way.

It was rather difficult to use the LED driver and LED bindings for this,
as (afaics) they were really never designed to be used for anything else
than for simple LEDs (i.e. a LED connected directly to the LED chip).
The flash support was added later, but that's almost as simple as the
first case.

>> These are for the backlight, not for the LED chip. So "LED" here is a
>> chip that produces (most likely) a PWM signal, and "backlight" is the
>> collection of components that use the PWM to produce the backlight
>> itself, and use the power-supply and gpios.
>=20
> Okay, it wasn't clear that leds points to the LED controller node. The

No, it doesn't point to the main LED node (the one having 'compatible').
It points to a child node.

> example made it seem as it was the device. We already have a way to
> describe LEDs and that is as child nodes of the LED controller node.

True, but those child nodes are very limited. As I see it, those child
nodes really describe the outputs of the LED chip, not what's on the
other end of the lines.

If on the other end of the lines is a more complex device, we need a
proper device driver for it, with a proper DT node with compatible
property etc.

Now, one could argue that a "backlight" that gets the LED signal from a
LED chip is really just a simple LED. But there are complications:

- Our board needs a GPIO to enable the backlight. I can't say what
exactly the GPIO does as my HW skills don't go far enough, but all this
is after the LED chip. I also see the circuitry using powers, which in
our case happen to be always on so we don't need to enable them explicitl=
y.

- We need a backlight device/driver (because of the Linux SW stack).

So, maybe it would be possible to construct all that in a LED child
node, and the LED driver would create a child device for the nodes which
have 'compatible' property. But then, that would be very different from
pwm-backlight, and the parent-child relationships are usually used to
indicate a control relationship, right?

The led-backlight in these patches is very much similar to pwm-backlight.=


> Please follow what was done for flash LEDs (leds/common.txt).

The flash support is quite simple. I'm not sure how I could do the same
for the backlight, as I described above.

> What's wrong with the existing pwm-backlight binding in the PWM case?

Nothing, if there's a PWM driver. But if the LED chip is modelled as a
LED driver, pwm-backlight is out. I think there are two kinds of LED
chips, PWM ones and current-controlling ones. And then there are the PWM
devices which are clearly PWM ones.

>>> Describe the h/w, not what you want for a driver.
>>
>> I think this describes the HW quite well. The LED chip works fine
>> without any of the properties here, and these are specific to the
>> backlight part of the board.
>=20
> A more complete example would be helpful here.

Of our HW? I can't give the schematics but I hope I described it enough
above.

 Tomi


--vgCfwctCbkDO0Djs3TL5UTJQm7iFhRNxI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWH7xPAAoJEPo9qoy8lh71lW0P/2oCBNmn8dGg34glPwFMiUkV
QUX7qGo0DnJMqwKqa+ftS9lSuAPNxrLUflxjLhBWEXIuvSB+3V5GP+tcNeuMeZiQ
fad3ROhMjUALf67oJcLxSk5lNYptsLFJJkg4Tw9Mp78wHsGV0xbUV+Nhx6uGzV7B
EUvokkKqaFthIZ/w6/svQx6wtWjqRtYVk9Axqf58Ga8oRX8yqXW+cm+akr9ajdFv
aWJvSOSJvK0dEEd9JAMkB/AYo8Jw7ScZZ0Tn2q0T0yHxl9HY+ErfTpYK1HUO4rkr
kkDDsJtQCzod9HJwaA9zAry46EwVs6U4icgjZL9dnhUGgzOt5U4Wwh0KGucbrwHx
9LBVdEOVhWlLVfNbUr8lkNZp0VNCayH2khpOmQcbGOQWEbijDFv2VdJlnVkQX1t5
9uownQNn3cEUawp8mYQFKD1MwvdgW6iqx6REEaOVnpRl9OQ73KwmS5CYPUkU17mX
Xz6N85MUb5zHXU0VR55nKGmQ4eHHKu3kWxy/qjWk2jmiuhIKM/XsY5rLjTxOj3yu
/3zS/QVSrdJF8Y+jgl5AjI8Fjb0G8UoCnf9zWpp3ouVN+2HeQUWJrFkrKL8aHwEI
kM6rDZuIAleGSfccnC0LH/sLYROTg8KyChROTzZzctxmMDRGKkrcJOssvDPr25jr
8PY/Sa7p8tAz9koUkHeS
=V8fJ
-----END PGP SIGNATURE-----

--vgCfwctCbkDO0Djs3TL5UTJQm7iFhRNxI--
