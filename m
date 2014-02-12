From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 12 Feb 2014 11:42:30 +0000
Subject: Re: [PATCH 1/1] video: exynos: Fix S6E8AX0 LCD driver build error
Message-Id: <52FB5E26.8000709@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="AtsCfamSEGnelNqCNnsq4sfUeiMjHDHp7"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1392198583-1828-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1392198583-1828-1-git-send-email-sachin.kamat@linaro.org>
To: linux-fbdev@vger.kernel.org

--AtsCfamSEGnelNqCNnsq4sfUeiMjHDHp7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/02/14 13:41, Sachin Kamat wrote:
> On 12 February 2014 16:56, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote=
:
>> On 12/02/14 11:55, Sachin Kamat wrote:
>>> On 12 February 2014 15:19, Sachin Kamat <sachin.kamat@linaro.org> wro=
te:
>>>> Enable S6E8AX0 LCD driver only if LCD_CLASS_DEVICE is a built-in dri=
ver.
>>>> Else we get the following errors due to missing symbols:
>>>> drivers/built-in.o: In function `s6e8ax0_probe':
>>>> :(.text+0x51aec): undefined reference to `lcd_device_register'
>>>> :(.text+0x51c44): undefined reference to `lcd_device_unregister'
>>>>
>>>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>>>> ---
>>>>  drivers/video/exynos/Kconfig |    3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/video/exynos/Kconfig b/drivers/video/exynos/Kco=
nfig
>>>> index 976594d578a9..eb6f2b059821 100644
>>>> --- a/drivers/video/exynos/Kconfig
>>>> +++ b/drivers/video/exynos/Kconfig
>>>> @@ -22,7 +22,8 @@ config EXYNOS_MIPI_DSI
>>>>
>>>>  config EXYNOS_LCD_S6E8AX0
>>>>         bool "S6E8AX0 MIPI AMOLED LCD Driver"
>>>> -       depends on (EXYNOS_MIPI_DSI && BACKLIGHT_CLASS_DEVICE && LCD=
_CLASS_DEVICE)
>>>> +       depends on EXYNOS_MIPI_DSI && BACKLIGHT_CLASS_DEVICE
>>>> +       depends on (LCD_CLASS_DEVICE =3D y)
>>>>         default n
>>>>         help
>>>>           If you have an S6E8AX0 MIPI AMOLED LCD Panel, say Y to ena=
ble its
>>>> --
>>>> 1.7.9.5
>>>>
>>>
>>> Sorry, please ignore this.
>>>
>>
>> Hmm? Why is the fix not needed?
>=20
> You said you have already applied this for 3.14-fixes. I accidentally
> sent it again.

Ah ok. I thought the patch itself can be ignored (removed from my branch)=
=2E

 Tomi



--AtsCfamSEGnelNqCNnsq4sfUeiMjHDHp7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS+14mAAoJEPo9qoy8lh71EtIP/3rkIbowI6T70l0gJmJQzt1H
Hxb5enJAqk6BcKDvTzYr3NRvbFV/6jUsvCXGfNtrJnIBkUlURAy4ADIJHYAOh3B5
p3BU3qM6a2HVGOT8mwbyGRKBL0pR9z/zjOcFHwREZdDOyervVvqLb1g987yWsOa8
eZfmhIVn2qdLqlIWnE7q85T3xwGM7cP+05+UGDGwxjWQdR5ERRJAXZtddxJPiMsW
bnJN/RiW0RILi2eccPV6Dbq2eP+l65TZEXqBJ+k8AIfLpZHbP2MT3MJfAWnkMVMu
vaZUkleotnLoG4LcPGpZ4pDs14HCE5SGVUGkVTHJGXfUB5s55HWjOxXNupUlZK01
Cs4RlgyNQ0JvLEAXJt9kad4B7FdQ84fsM0kvL48VYnasPdEYt5j8f+PEF1YGy7nm
Z3jn0sGJV1bXcVb+G4Ka3bJn/yf8N+aePLEjFt1UNGY/umXmhKlIfJJlMFNCugBJ
akUTYpN+f5oa+k4NgFAaoe2Bq9IxNrRGOFK9MS3fpqHaAdCcXQHG36S5FIOllpqw
H4TyMehn1DvOcVCWLaqymTRhuV/nqnDLqfeD3PNYLp7XPoPh9VKXqFTKhrP+RBrj
Mttb06Hck0xFRdXVs/7YMaECNXcZdzERyau3tkRiCVKelSNC0LqAqDhdiJlU5pdm
SZwFHgN1OT2lLfSpgjmp
=YPGq
-----END PGP SIGNATURE-----

--AtsCfamSEGnelNqCNnsq4sfUeiMjHDHp7--
