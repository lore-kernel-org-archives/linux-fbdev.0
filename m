From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 25 Aug 2015 13:00:10 +0000
Subject: Re: [PATCH 2/3] backlight: add led-backlight driver
Message-Id: <55DC66DA.5030000@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="PKn9cOg9kAwbQikwc5vMj8PrpjTPxSLLB"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440502442-19531-1-git-send-email-tomi.valkeinen@ti.com> <1440502442-19531-3-git-send-email-tomi.valkeinen@ti.com> <20150825123952.GA18009@lunn.ch>
In-Reply-To: <20150825123952.GA18009@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org

--PKn9cOg9kAwbQikwc5vMj8PrpjTPxSLLB
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 25/08/15 15:39, Andrew Lunn wrote:
> On Tue, Aug 25, 2015 at 02:34:01PM +0300, Tomi Valkeinen wrote:
>> This patch adds a led-backlight driver (led_bl), which is similar to
>> pwm_bl except the driver uses a LED class driver to adjust the
>> brightness in the HW.
>=20
> Shouldn't this be sending an event to drivers/leds/trigger/kedtrig-back=
light.c
>
> Calling led_set_brightness() from outside of drivers/leds is pretty
> much unheard of. It is normal to have a trigger to do this. So why not
> use the exiting backlight trigger?

ledtrig-backlight.c is based on fbdev, and I want the backlight to work
also with DRM. And I want the backlight device to be a proper backlight
device, i.e. something I can pass data to from the DT.

So, I could create a new trigger, say, "bldev" trigger, which would
create a backlight device. But then I could not pass any info to it via D=
T.

This patch was the only working solution I could figure out, but I don't
have much experience with leds, so I might be missing something.

 Tomi


--PKn9cOg9kAwbQikwc5vMj8PrpjTPxSLLB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV3GbaAAoJEPo9qoy8lh71eZ4P/01NJGiImirIqpFPh+2EbTig
w2tvj2GBvmZTObJ06zObIEAsNz5PnpwrD89bCnOV7cQG73maBzTx2OzPlcpv56fA
8tnG+gKUtZ2cTn12EhR1RZXmj9S5I4gIU2B2sw7ZROC0Qe/hgcWK8rbMWi2JQ611
pQJ1Mi6tHJXQ+wC9mzIuB7o6TgOeXvJjBwp21HATpPFSiLlPBJFPbyRCNKWdXdh4
mL1DSxgAO40hvJ95R7nC1qA9woRReo5bnn1YR23C9QFwlWFN0itoyELDihYnrOyS
NT7DzjdL4+0q24ZjrpvUL0bgvf+ivN2RetSOcbpiZ0/d7Z2FOcds+24JILnKid0i
YvMWPxO6Xg7oIIJ0QKej52AUXV+WGIMSa9nnuuJK1fVq37S5+rEKO6imppawXZ7G
VI7r2SiVhOOtGvWVMptYswrhVN0rEYRCf7KynOHh9ttkt3kuscgizu5zqPv5zt9Y
Qxy0qV4hExkk36BhieJM0504T5y2LVx9cZAjKt0X2ftdjSUksWWNtx7HhCIajZEB
QHIODd57MtoaC36ssU3Y2MjnvQwILcvc2A7DQBCqWb5IsBanloEklJPAWW+TqAmW
E7pUMtETiLYmgX865kuGlwXDz+ZRCCKT5DmWg9JS3fSBa+O4vqzf8vbH1ZqYlxMT
PYKWzfYYGXPn20vU3ImJ
=VWOW
-----END PGP SIGNATURE-----

--PKn9cOg9kAwbQikwc5vMj8PrpjTPxSLLB--
