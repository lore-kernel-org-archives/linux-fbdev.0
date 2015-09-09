From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 09 Sep 2015 12:16:12 +0000
Subject: Re: [PATCHv2 1/3] leds: Add of_led_get() and led_put()
Message-Id: <55F0230C.9000309@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="HacurFFcC9U78BXTD4BIxt1QvfTvxMWk2"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1441711176-4258-1-git-send-email-tomi.valkeinen@ti.com>
 <1441711176-4258-2-git-send-email-tomi.valkeinen@ti.com>
 <55EEE0A1.5070000@samsung.com> <55EEEB04.3090207@samsung.com>
In-Reply-To: <55EEEB04.3090207@samsung.com>
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

--HacurFFcC9U78BXTD4BIxt1QvfTvxMWk2
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 08/09/15 17:04, Jacek Anaszewski wrote:

>>> +#endif /* __LINUX_LEDS_OF_H_INCLUDED */
>>> diff --git a/include/linux/leds.h b/include/linux/leds.h
>>> index b122eeafb5dc..0fce71a06d68 100644
>>> --- a/include/linux/leds.h
>>> +++ b/include/linux/leds.h
>>> @@ -113,6 +113,8 @@ extern void devm_led_classdev_unregister(struct
>>> device *parent,
>>>   extern void led_classdev_suspend(struct led_classdev *led_cdev);
>>>   extern void led_classdev_resume(struct led_classdev *led_cdev);
>>>
>>> +extern void led_put(struct led_classdev *led_cdev);
>>> +
>=20
> This also needs no-op version.

Ok, but... I think other already existing functions need no-ops also. If
there's a driver that uses of_led_get and led_put, it's sure to use some
other led_* functions also.

So if we want that driver to be compilable when LED support is disabled
in the kernel, we need to provide no-ops for all those functions.

Probably:

led_set_brightness
led_blink_set_oneshot
led_blink_set

 Tomi


--HacurFFcC9U78BXTD4BIxt1QvfTvxMWk2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV8CMMAAoJEPo9qoy8lh71ubQP/3KohGDC3pUzpjRINATDfmbe
Pbe0C6zPHYSh/SFjZVNpWrTSdCQtLuZFTDzvfcYOl+xqSSpe+Tq75SNmWp2g6czr
Q1OVsvT1A3mWVOFwvTPNvGEXIKa22VARCpPVxLAI3Q3efw4GOp5+NXTjpVK//Q+K
EqQOLol9rTtfZ7rBCMktamgga1WG+amhZrzKfJXIokKkMuREAx6ZGb2HULkEwg1U
clymtovP7+9FGbCJ5/5Tu3weYOgOWhM2MSQVOfGmLX/Bxvbx20LKsmggB4uc5YSW
tHR9Qj5GllRSi9qDq5tLN7e36nsF86W7U1p4/4Cvmjr8D4N2QCZBOTideZoiCh8J
KfWAYeCgDh/uiMkCPbl/IW47YW4+wp9hz0wvsfJyt3zhFdvlCmuYB5FcpOSY5AJf
hZVN9Zq8OxGAt9juU2dI6/9GaDwk0kUHez1TZhjmLxSRZ172249risYeQ3/ck44N
RGuPqqnor+ZdO6r1/yhmcRH8YKx1UHJSY4KCNDoisBu5SV6AFmk6z3PiNgE6qR3z
ELbVw2auPvLohBMtwiE1Se3/VXaLCIJVrVBkRvwggvNIy6neMesiifRtvSLQaV/X
5JmXSRCvegsFCXkvxdMqI8fe3+YnuzVfdkBeXGkdPiiHdWlpKKLHKnr2HH7OXF+b
e4fqOnetPQLajMOkMNP3
=9tMN
-----END PGP SIGNATURE-----

--HacurFFcC9U78BXTD4BIxt1QvfTvxMWk2--
