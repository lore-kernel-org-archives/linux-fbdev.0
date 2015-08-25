From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 25 Aug 2015 12:53:03 +0000
Subject: Re: [PATCH 1/3] leds: Add of_led_get() and led_put()
Message-Id: <55DC652F.5080201@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="DewF7TrfsaOXLFXlwK3xtSQf09bUEVqL7"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440502442-19531-1-git-send-email-tomi.valkeinen@ti.com> <1440502442-19531-2-git-send-email-tomi.valkeinen@ti.com> <20150825121853.GB14871@lunn.ch>
In-Reply-To: <20150825121853.GB14871@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org

--DewF7TrfsaOXLFXlwK3xtSQf09bUEVqL7
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 25/08/15 15:18, Andrew Lunn wrote:
> On Tue, Aug 25, 2015 at 02:34:00PM +0300, Tomi Valkeinen wrote:
>> This patch adds basic support for a kernel driver to get a LED device.=

>> This will be used by the led-backlight driver.
>>
>> Only OF version is implemented for now, and the behavior is similar to=

>> PWM's of_pwm_get() and pwm_put().
>=20
> Hi Tomi
>=20
> Is this the correct way to do it?  I would of expected an xlate
> function.

I don't know. To be honest I haven't worked much with this kind of code,
and I didn't want to start writing full blown "of" support for leds. My
solution cuts the corners a bit... Probably this is more of an RFC than
a ready patch series.

I need to look what the of_xlate functions are doing in other frameworks.=


> I'm also wondering if this is the right place, in the class. Don't you
> just need the core?

I'm using the "static struct class *leds_class;" to find the actual
led_classdev, and that variable is local to led-class.c.

 Tomi


--DewF7TrfsaOXLFXlwK3xtSQf09bUEVqL7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV3GUvAAoJEPo9qoy8lh71nHUP/0Tpicr/0XmrgWo4XpYcqzCe
JuFMniYW7ILcBiKEewTCWZziT/Wnwz7WE+B4kG+danuvV49tkh8qbktikv4LVsVR
Fj5VCzOn+0DcPxIuIv1zpSGtoBdSFY+d4hOiJAbj/Eo2x4c/sqWlLMuplhw6kz6m
naQjlHWC0IN9DFKKeyXJBag0rhx5y9uO7pj6cbk4GxOtswpJRthpkBB0ZfA4wTpw
opab/wkZ8fs6l3ByTDyQn2l7hot/1tvhw0virYE728iA+ltFXKfTap4fE0/u6O1t
etOLSVJUoxLEveJR+/vbPw/gwbTM1DFIUpT2ekMHxWtD+zfS7EM+8k74209mCuZp
OYXupbj0JAyLNLAR5/AWQDBe7KyG+ZSP+RWdIpt8kbkQOHq2DV+e5Ukp/gQ0ER/O
zazh/9GSOp8s5L8hroDhOXkLUkjuREv6rf2czqMlMFYNaRWQ2MNWhdrwTJhVfDh6
yjjOb2QRsoIh+l9u38d/lwx041AtGbNx5TLkhQVXrHBrip17OA5jViwqx/Brw6Fc
J5UivlRbtuk9IJ39m9pVAaeHexeyS1e4u1ft6l7LmSfqpOIJ6X/SDDKcVPgh/y3G
TQEtGayFsvzyu843lQi3k2IQNUzjB4XOvV00TohkMpC474ftogeyoL+TyZ/Dt2Aw
akzMFU2rMS9/YSasoweH
=lwZc
-----END PGP SIGNATURE-----

--DewF7TrfsaOXLFXlwK3xtSQf09bUEVqL7--
