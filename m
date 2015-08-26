From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 26 Aug 2015 09:11:32 +0000
Subject: Re: [PATCH 3/3] devicetree: Add led-backlight binding
Message-Id: <55DD82C4.50405@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1TV7gFhu5iNwJOm92hLdH2LKQEG0vfUJ2"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440502442-19531-1-git-send-email-tomi.valkeinen@ti.com> <1440502442-19531-4-git-send-email-tomi.valkeinen@ti.com> <55DC700C.4030802@samsung.com> <55DC8C9D.4050007@ti.com> <55DD65BE.4050308@samsung.com>
In-Reply-To: <55DD65BE.4050308@samsung.com>
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

--1TV7gFhu5iNwJOm92hLdH2LKQEG0vfUJ2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 26/08/15 10:07, Jacek Anaszewski wrote:
> On 08/25/2015 05:41 PM, Tomi Valkeinen wrote:
>>
>>
>> On 25/08/15 16:39, Jacek Anaszewski wrote:
>>
>>>> +Example:
>>>> +
>>>> +    backlight {
>>>> +        compatible =3D "led-backlight";
>>>> +        leds =3D <&backlight_led>;
>>>> +
>>>> +        brightness-levels =3D <0 4 8 16 32 64 128 255>;
>>>
>>> brightness level is not a suitable unit for describing LED brightness=

>>> in a Device Tree, as it is not a physical unit. We have led-max-micro=
amp
>>> property for this, expressed in microamperes, please refer to [0] fro=
m
>>> linux-next.
>>
>> Hmm, ok, but what should the driver do with microamperes? As far as I
>> see, "enum led_brightness" (which is between 0-255) is used to set the=

>> brightness to LEDs. I don't see any function accepting microamperes.
>=20
> This is implementation detail. You can convert microamperes to
> enum led_brightness in the driver. Please refer to the discussion [1].

The led_set_brightness() takes "enum led_brightness", so I don't
understand what this driver would do with the microampere value. It
could, of course, do an arbitrary conversion, say, direct mapping of the
mA value to brightness, but that would just confuse things further.

If there was a led_set_microampere(), supported by all led devices, then
yes, the above should be microamperes.

Or are you saying that I should have the binding use microamperes, and
just do a naive microampere -> brightness conversion in this driver, and
hope that in the future this driver can be changes to pass the
micrompere value directly to the underlying LED driver?

And speaking of microamperes for LED drivers, what's a meaningful
microampere conversion for LED drivers that don't deal with microamperes
at all? For example, the LED chip we're using, TLC59108, is basically a
PWM chip. Can we somehow calculate microamperes if we know duty cycle
and period?

 Tomi


--1TV7gFhu5iNwJOm92hLdH2LKQEG0vfUJ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV3YLEAAoJEPo9qoy8lh717qYP/1tQQ9UT87K18fYvFtxcnxft
xhD9hT0Rt8xVk9ujJ8v7DmDvl9Cub9ujDjRwUCb2V+Xm9AjL6+Hh3l27nAQVvAcQ
GofpQDUWR5ubWuHGB2/seXIB0ff0CoOhc+gqiwZ23fioOsOl5jCCQPQFojLYveGT
PNRzdjPfu7g+44CpGL7xutcMcVadxt8Iion6Ow+FZKV8yOCRYoiwdJjyHvPVylV/
BoTRvI6pd0BlbWgbARVihboOkmcr0dZHL1z+UyyknNwW+39vcK+hRcttpXNjTNYX
4WmkBt4M2fSkYrzzDubiIihOYrAZ1XrlCw6IQQmeM4v/wuR6pyFTnVcI03pp9pVA
zr+z6YfyA8hc7Sz1n8q8Mrm4Xsl9FHHD9XkZz5lEnm0I+Lg84v2rqBHAwN9Ber7x
Ou9blK7jmbVbaQOM7RUoZ8OLLgP97abzFUvTQtAxPjgRNObcaNVodaJEsVXRAKZC
V3OWuaAdQ20lCRntsd753zaO3LB/b6mz1yzGbkalCGx7dIXcH258rOEgVQ0ZVv9F
WTQqn5S59TcJBceksLFlPk3oAjRil7JiOIse7JTvRoUN4ySF9/F4FQaqEh+8Fk0D
5lCwwFTWuyP24NrrwIOKMM6ZOGv32eRsJRKgUs8UfAzxh2N8UAnwDSSxw7W6xjEf
qixjDD3NEsDcDDwPqWcq
=TpaO
-----END PGP SIGNATURE-----

--1TV7gFhu5iNwJOm92hLdH2LKQEG0vfUJ2--
