From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 20 Mar 2014 07:08:32 +0000
Subject: Re: [PATCH v2] lcd: Provide dummy functions if CONFIG_LCD_CLASS_DEVICE is not set
Message-Id: <532A93F0.6050209@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="xEgSJm7GcTX4ptJVWpbicKpeaoplPr5JB"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394795353-1931-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1394795353-1931-1-git-send-email-shc_work@mail.ru>
To: linux-fbdev@vger.kernel.org

--xEgSJm7GcTX4ptJVWpbicKpeaoplPr5JB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 20/03/14 08:41, Alexander Shiyan wrote:
> Hello.
>=20
> Wed, 19 Mar 2014 15:31:49 +0200 =D0=BE=D1=82 Tomi Valkeinen <tomi.valke=
inen@ti.com>:
>> Hi,
>>
>> On 14/03/14 13:09, Alexander Shiyan wrote:
>>> Provide dummy functions for LCD register()/unregister() if
>>> CONFIG_LCD_CLASS_DEVICE is not set.
>>> This allows us to use the LCD class as an optional.
>>>
>>> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
>>> ---
>>>  include/linux/lcd.h | 37 ++++++++++++++++++++++++++++++-------
>>>  1 file changed, 30 insertions(+), 7 deletions(-)
>>
>> I'm still not convinced about this. Isn't it simpler to just
>> select/depend on LCD_CLASS_DEVICE? The lcd.c is a bit less than 9 kB, =
so
>> it's not like you're adding a huge amount of code into the kernel even=

>> if the driver doesn't happen to use it for a particular display.
>=20
> Ie we prefer to increase the size of the kernel, even for functions whi=
ch are optional?

How often can LCD_CLASS_DEVICE be turned off when using imxfb? How often
will it be turned off in practice? I fear this is a micro optimization
for cases that never happen in real life.

I'm fine with micro optimizing the kernel when it comes for free. In
this case I see drawback: usually (correct me if I'm wrong) if a fb
driver uses LCD_CLASS_DEVICE funcs, it requires it. Currently it's easy
to catch missing LCD_CLASS_DEVICE as the kernel won't compile. This
patch hides it until you try to run the driver. And compile time
checking is much, much better than runtime checking.

We have components that use the method you use in this patch, like
gpio.h. However, the difference with gpio and this one is that the
selection of gpio comes from the platform code, while the
LCD_CLASS_DEVICE is selected by the fb driver in question. So the fb
driver can easily select LCD_CLASS_DEVICE, while it cannot select GPIO.
My point here is that for gpios we more or less need such functionality,
whereas for LCD_CLASS_DEVICE we don't.

I'm not strongly against this patch. But, as I said, I see a small
drawback with it, so I'd like to either hear "yes, this is good" from
other people, or see information showing that this optimization will
actually help in lots of cases in real life.

 Tomi



--xEgSJm7GcTX4ptJVWpbicKpeaoplPr5JB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTKpPwAAoJEPo9qoy8lh71grkP/iVAam4TSwF3i3QXfoF1ZruC
8VNN3+GblLO+aiLHIlaSuTERts2KaUY6xsUOroloVeN8sdss/tMpcsYo0DmugSQ0
u0yUMPT1Xv7eqRdoPQCEK4L27nsl9YCcasgd48fc8+EXneNhhOoqcki6QoiIEErk
OulSR7pSGGMjv3/+fbUnOhq0pCic2FcPjyabU8154FZlmF/26mQCBO7igH289toh
BH42S1073L4oUPPlwGNX5z//1fplrDqiRRS8KzvYDr+3x6EcfYTJg+scvrINdpCi
2yFvIBMkEGVnWZmzAD9PSyJJQWMtL0HEB8QyfUZYMz/6cTWTeIQzb7+nGFPLnrZ6
EZ23VVwkSVaMZus+BDS4DY2cJXppUzdiYbJa0cbStSUsk2ghGoK3r5UT2sAP75+/
/KHbH06VMLROC0zC7z5YtUAtlxpHyLc3pSDtSWA65KctU82CyM0g6Es36+xQraUB
GhZKvqL8oOyZGlzhDfE08i71TkuJE3Hs9wlRyvTMvcaLQycMDIBWeUPVmRdPjrr6
8VGxLctjcB314vomM4xEtvVY8pMWeLpJfNGjwMs4RVUI6SbNsmghFiRaqP2VlhZ9
ohQRQaatINcNqZUzEdRudt8hLe0nyDyxTpRjD5JFnr2jgev73nwiKdX1xApTYEIC
XaJdl6yAMjmPSpLYE7s0
=5GIc
-----END PGP SIGNATURE-----

--xEgSJm7GcTX4ptJVWpbicKpeaoplPr5JB--
