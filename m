From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 08 Sep 2015 11:23:21 +0000
Subject: Re: [PATCH 1/3] leds: Add of_led_get() and led_put()
Message-Id: <55EEC529.4040104@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="o7GPNadffIOTlaTfKhh3tltxp6sIl9dsl"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440502442-19531-1-git-send-email-tomi.valkeinen@ti.com>
 <1440502442-19531-2-git-send-email-tomi.valkeinen@ti.com>
 <20150825121853.GB14871@lunn.ch>
In-Reply-To: <20150825121853.GB14871@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org

--o7GPNadffIOTlaTfKhh3tltxp6sIl9dsl
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

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

I just sent v2, but I don't use xlate there.

If I understand the purpose of xlate (in pwm, for example) correctly,
xlate is a function in the pwm chip to allow custom bindings for the pwm
outputs from that pwm chip.

The problem with LEDs is that there's no "LED chip". Each LED is
modelled as individual device, without a well defined parent. Thus
there's no place to add such an xlate function.

Do you have any thoughts on what the xlate for LEDs should look like?

 Tomi


--o7GPNadffIOTlaTfKhh3tltxp6sIl9dsl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV7sUpAAoJEPo9qoy8lh71xyEP/3dtOqRKfgUOirmAUGoDO6Ym
5y5IM9mg9ASuJNB1qjcdYF+xZiTna1TXj0ukQagIo+7uAg1lA+iOWJxfP8kk8WYf
Xtp2UmYEOjTkmFmLHLckXe852+VuctQ0CdPxXiGL5KUPG56NfsNBcTLPHVzUK7do
z9JUAO/iJyC+29hZKPZ+f86HEIhuKS530FgOTQ+1MulQWOVy8ReCJRAD2uQZn7ev
8Vr13i7hTN6TIilpxWqlmVLudcs7+OVAd0MwBr114p94ZllVMEKSp1wm6RrXhd9z
Coh5UikqTdvkD0yOYqlBZ/Um1TycOZwOnfyjELBJgLwLPRlBtAvYAM2O2UrTydFN
9F1u33AQ1NyYR/4atd3jb7HAU8nVIgyQkBNuxuvO5oQZEcQzj8vZK3fBIzYlNJ6M
8SbJvsj2ysTo/Xcj3Oa1dTXCoqvd2wIgGXVmAAgtvWQXSbyFysvV8Xy9SnGCMoWZ
3U2VS4jRTRUsBAoAmnc/M6vx2VGswPYeXIE/UAA2G93WyOm0+kv96uoK5kI5mMSY
PUTjihkpcLaClA+vdsdSr5ZSmZHJHsC18x/yPF8TG2O0/E/gFd8MaFZ92YGCzAVl
siLrGTDAGHou4B7IbfSb0w3ZAUdQ765MTfpjHUQMnmIyqiqPfyASJxkqEYiQU8i9
pSe7fmU5U25iQNadw3AR
=V35e
-----END PGP SIGNATURE-----

--o7GPNadffIOTlaTfKhh3tltxp6sIl9dsl--
