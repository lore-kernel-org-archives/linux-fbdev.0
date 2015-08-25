From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 25 Aug 2015 15:41:17 +0000
Subject: Re: [PATCH 3/3] devicetree: Add led-backlight binding
Message-Id: <55DC8C9D.4050007@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="wmGoInHECcIXbDmCg9TGr7A3l5A0et3si"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440502442-19531-1-git-send-email-tomi.valkeinen@ti.com> <1440502442-19531-4-git-send-email-tomi.valkeinen@ti.com> <55DC700C.4030802@samsung.com>
In-Reply-To: <55DC700C.4030802@samsung.com>
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

--wmGoInHECcIXbDmCg9TGr7A3l5A0et3si
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 25/08/15 16:39, Jacek Anaszewski wrote:

>> +Example:
>> +
>> +    backlight {
>> +        compatible =3D "led-backlight";
>> +        leds =3D <&backlight_led>;
>> +
>> +        brightness-levels =3D <0 4 8 16 32 64 128 255>;
>=20
> brightness level is not a suitable unit for describing LED brightness
> in a Device Tree, as it is not a physical unit. We have led-max-microam=
p
> property for this, expressed in microamperes, please refer to [0] from
> linux-next.

Hmm, ok, but what should the driver do with microamperes? As far as I
see, "enum led_brightness" (which is between 0-255) is used to set the
brightness to LEDs. I don't see any function accepting microamperes.

>> +        default-brightness-level =3D <6>;
>=20
> This also should be microamperes.

This is an index to the above brightness-levels array. It's not LED
brightness, but backlight brightness, between 0 and
ARRAY_SIZE(brightness-levels) - 1.

 Tomi


--wmGoInHECcIXbDmCg9TGr7A3l5A0et3si
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV3IydAAoJEPo9qoy8lh71QBsQAKKTPMb6bZDkWX8JJvKAF0Nq
bE3OalrC12ueYFByGTPWTdsq+FbUiidEvsOFqgnDQzFs4/U9CBF98cFuFtrzNyTi
qBYJv+WXaaxYSy2TGEvR1E6TZnodQ+12vMgJdNbCxf55c+18ive0V5WeaanesrUt
eWSqCsRteZX6QppDStP028lRpxXm2NsypD8u9RHWXFp7tsuewhnFY2WpzD43lwCs
iIYofWJnwPWQo80Kd0xx3bvL07b9kqdcEgNqd0aCiMIteSR9QxUOKvAnXlYChm9c
bvFMbtigS0TqFLaAbDkVrmxj8szoCvYZJtqKvKYarYPa9XhtyH/FnID16jenGpoP
v7W4OOLZTXesCcWgl1IOf0eBcYdbMJz9029kgLcVgC4Ua//9O+h2ZFR4gxpjImDS
duurhEut8SbhsrgZ0mmvEhgiDqSh9h7pNDXys9IYSxy6RVePX/mttwHiHH8b42ba
KejCBLImpTUbUWe3q3qnixl3b2W5tycFqKoccRV8fVoDvIIXNuhwcB74mboEF+hE
0VE9fiZ4N4uG7vafSmrDeAkndoT3ykgUiVVYal9Ps5Q8UiKFw4whapiMopa/D2uU
g5hdd6sfaojvgOxpjy8wuVbo3sDx9LG3b/fbbk7nmU5PU4dtM8EkjXmlaeVZ9Kkl
KNbeVCV5xYHCipze6Ymh
=7pMF
-----END PGP SIGNATURE-----

--wmGoInHECcIXbDmCg9TGr7A3l5A0et3si--
