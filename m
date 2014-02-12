From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 12 Feb 2014 11:26:08 +0000
Subject: Re: [PATCH 1/1] video: exynos: Fix S6E8AX0 LCD driver build error
Message-Id: <52FB5A50.8070007@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="6GQRfutIxAIrmFxj3kQcgcNvS9GHSNvdn"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1392198583-1828-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1392198583-1828-1-git-send-email-sachin.kamat@linaro.org>
To: linux-fbdev@vger.kernel.org

--6GQRfutIxAIrmFxj3kQcgcNvS9GHSNvdn
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/02/14 11:55, Sachin Kamat wrote:
> On 12 February 2014 15:19, Sachin Kamat <sachin.kamat@linaro.org> wrote=
:
>> Enable S6E8AX0 LCD driver only if LCD_CLASS_DEVICE is a built-in drive=
r.
>> Else we get the following errors due to missing symbols:
>> drivers/built-in.o: In function `s6e8ax0_probe':
>> :(.text+0x51aec): undefined reference to `lcd_device_register'
>> :(.text+0x51c44): undefined reference to `lcd_device_unregister'
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> ---
>>  drivers/video/exynos/Kconfig |    3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/exynos/Kconfig b/drivers/video/exynos/Kconf=
ig
>> index 976594d578a9..eb6f2b059821 100644
>> --- a/drivers/video/exynos/Kconfig
>> +++ b/drivers/video/exynos/Kconfig
>> @@ -22,7 +22,8 @@ config EXYNOS_MIPI_DSI
>>
>>  config EXYNOS_LCD_S6E8AX0
>>         bool "S6E8AX0 MIPI AMOLED LCD Driver"
>> -       depends on (EXYNOS_MIPI_DSI && BACKLIGHT_CLASS_DEVICE && LCD_C=
LASS_DEVICE)
>> +       depends on EXYNOS_MIPI_DSI && BACKLIGHT_CLASS_DEVICE
>> +       depends on (LCD_CLASS_DEVICE =3D y)
>>         default n
>>         help
>>           If you have an S6E8AX0 MIPI AMOLED LCD Panel, say Y to enabl=
e its
>> --
>> 1.7.9.5
>>
>=20
> Sorry, please ignore this.
>=20

Hmm? Why is the fix not needed?

 Tomi



--6GQRfutIxAIrmFxj3kQcgcNvS9GHSNvdn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS+1pQAAoJEPo9qoy8lh71M3gP/3BH8tBAVEHisA2E2dSLpIdv
mxnF2Wkr2QRTXZbJtSJ6jAGGmq962oqHasrF9V5oUmjHF16M2cNmvzH3Pheu4gah
ZLmZKrOWS6aoScWuWUW/yor3KWTgWu9PWW1+wdHJ3s92yiLKbM5X+OoU9UnKAUh3
41PsfyO9rCklhuzo6v3r88u2MG2tJImpMFtMomRbKsoXsgKbMbvgEh0msfiCaaGV
Qll61UQhE2VKbYOK8gapwyelzUedU7WNA1avrJHbUfPzwW/nSWhRalXTJmdQVgIB
I95LDPh9UUbzzi2JU+zhTtDsvMU+WbU5Bg/qOOcwC5NkT7JGFAr7FtWpFfFqV/ex
122tmqMgKYd2Fk+Fa+JKou7a6R3gFPzCG7W9EzThz2LEuPJF/IfszO6LQKhw5hBV
J9diYwk+f1S/f8LDdPLcnVl+SKGdA6GZvzU1PY5wskU86cAN5U4OkSWFDAAszJdU
X0VQvsxB3w14kkXVuFt6zFK67E7L6ONx9uKe/VJZ6aCwqsR0XuD+ovcJYAd6aoFI
fHfpvbWmndJq893RzUiGYgwNamO3SMIJZ5zpcw7GE1ycLbGvR5yKCjPDJE8855Au
WaU9vYJmqcVDiA78nFRI6vD263Lwk95HQmzfH1pJPa+EEiXKjEXoJ42umpRJvSYA
sWiTm4PtX+Yy/YUES/Ou
=eez7
-----END PGP SIGNATURE-----

--6GQRfutIxAIrmFxj3kQcgcNvS9GHSNvdn--
