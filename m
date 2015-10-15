From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 15 Oct 2015 12:17:37 +0000
Subject: Re: [PATCHv4 3/3] devicetree: Add led-backlight binding
Message-Id: <561F9961.30008@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ocAEPGIkEoUlbm8Jm3t64DEjfg6r2LfGd"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1443605522-1118-1-git-send-email-tomi.valkeinen@ti.com>
 <1443605522-1118-4-git-send-email-tomi.valkeinen@ti.com>
 <CAL_JsqJ+xYpX86DNHFCOEqV85FRh-Xzh1wg3p6guA0QeWG4+pg@mail.gmail.com>
In-Reply-To: <CAL_JsqJ+xYpX86DNHFCOEqV85FRh-Xzh1wg3p6guA0QeWG4+pg@mail.gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

--ocAEPGIkEoUlbm8Jm3t64DEjfg6r2LfGd
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On 13/10/15 17:21, Rob Herring wrote:
> On Wed, Sep 30, 2015 at 4:32 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
>> Add DT binding for led-backlight.
>=20
> Please use get_maintainers.pl.

At some point I got feedback that the DT maintainers don't have time to
look at each individual driver binding, but rely on the subsystem
maintainers to handle them. Maybe I misunderstood that.

>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Cc: devicetree@vger.kernel.org
>> ---
>>  .../bindings/video/backlight/led-backlight.txt     | 30 +++++++++++++=
+++++++++
>>  1 file changed, 30 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/video/backlight/=
led-backlight.txt
>>
>> diff --git a/Documentation/devicetree/bindings/video/backlight/led-bac=
klight.txt b/Documentation/devicetree/bindings/video/backlight/led-backli=
ght.txt
>> new file mode 100644
>> index 000000000000..d4621d7414bc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/video/backlight/led-backlight.=
txt
>> @@ -0,0 +1,30 @@
>> +led-backlight bindings
>> +
>> +Required properties:
>> +  - compatible: "led-backlight"
>> +  - leds: phandle to a led OF node [0]
>=20
> Why do we need 2 levels of LED nodes?

Sorry, didn't get that. What do you mean with 2 levels?

>> +  - brightness-levels: Array of distinct LED brightness levels. These=

>> +      are in the range from 0 to 255, passed to the LED class driver.=

>> +  - default-brightness-level: the default brightness level (index int=
o the
>> +      array defined by the "brightness-levels" property)
>> +
>> +Optional properties:
>> +  - power-supply: regulator for supply voltage
>> +  - enable-gpios: contains a single GPIO specifier for the GPIO which=
 enables
>> +                  and disables the backlight (see GPIO binding[1])
>=20
> Why are all of these not part of the LED node pointed to by leds?

These are for the backlight, not for the LED chip. So "LED" here is a
chip that produces (most likely) a PWM signal, and "backlight" is the
collection of components that use the PWM to produce the backlight
itself, and use the power-supply and gpios.

> Describe the h/w, not what you want for a driver.

I think this describes the HW quite well. The LED chip works fine
without any of the properties here, and these are specific to the
backlight part of the board.

 Tomi


--ocAEPGIkEoUlbm8Jm3t64DEjfg6r2LfGd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWH5liAAoJEPo9qoy8lh71RIMP/3JYbLaSpte3AzUOm0lKQT/D
gdys+5G1PRQjJvlmdN3LwxiCCRJMPg4OK2Mivm5SQYJ7TDMsipnqJ6qq+ZWV0Y0b
EfMNxL7HLEF/JAaL+HtqGA+GERXmfpoMfzeEIfZ6fUsTd6HrJdeupkVfRX38KlMn
ccmsu6cUnF3ZxQMvAZWiPTMNx/abuXZX466H5wQ/OHxUYvYKblrwX/etD0OrWpcx
iLXg4DjX9mzqybrxeOOotd/Uh70AoXBKuELRMT/RSunfIdPQCHb6QyG3Gq9QUeta
F7CjaifoU+Pj1puVYgqyIs0WqwZDWSq5b0gVZq4hNum8BVVqsCiwhkI8uFDaDsHc
osZvni6jYBhZ3IlLLBcLAAMTPrUR/IA4wT73qpxeWqa8dEKygGwQM9vesQBj6I6y
vmcRejxt617c8EyK22xMh9pik7INEQjYqAPxWeYOYWLlb3uldRJ+cDxQLSVSu4ns
yFmKUAwdDzH5Guifpd2dFWK7QtOsgyxJkScQg+2N8r0FygCUw1Q9XJ9Itp/JDYsl
FP3H1o9+/iO3qJ3a4G5wZkKbPtVmJumkhsfnxFyCxetsSv1u75Ugc44Mn7bXLn5n
ROjC9qHbrMBM7Dsbev0xw6fTWqvh6BJP6JKyE61roalUoUBx2q412Osroo5hBWep
xkojurpH5azy1B12Gcjp
=Gnho
-----END PGP SIGNATURE-----

--ocAEPGIkEoUlbm8Jm3t64DEjfg6r2LfGd--
