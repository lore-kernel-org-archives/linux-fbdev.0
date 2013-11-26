From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 26 Nov 2013 15:00:31 +0000
Subject: Re: [PATCH -v2] fbdev: sh_mobile_meram: Fix defined but not used compiler warnings
Message-Id: <5294B78F.3010903@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="uQHhBUuOkU0hBrOdoQwoRB0WclOWEUA28"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1383728247-19294-1-git-send-email-geert@linux-m68k.org>
 <5204468.CmggZzW3kO@avalon> <5294B3B9.3090104@ti.com>
 <1510041.WqZSiK0jXs@avalon>
In-Reply-To: <1510041.WqZSiK0jXs@avalon>
To: linux-arm-kernel@lists.infradead.org

--uQHhBUuOkU0hBrOdoQwoRB0WclOWEUA28
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2013-11-26 16:58, Laurent Pinchart wrote:
> Hi Tomi,
>=20
> On Tuesday 26 November 2013 16:44:09 Tomi Valkeinen wrote:
>> On 2013-11-06 13:57, Laurent Pinchart wrote:
>>> On Wednesday 06 November 2013 09:57:27 Geert Uytterhoeven wrote:
>>>> If both CONFIG_PM_SLEEP and CONFIG_PM_RUNTIME are not set:
>>>>
>>>> drivers/video/sh_mobile_meram.c:573: warning: =E2=80=98sh_mobile_mer=
am_suspend=E2=80=99
>>>> defined but not used drivers/video/sh_mobile_meram.c:597: warning:
>>>> =E2=80=98sh_mobile_meram_resume=E2=80=99 defined but not used
>>>>
>>>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>>
>>> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>>
>>> and applied to my tree.
>>
>> What does that mean? Are you collecting sh_mobile video patches?
>>
>> Or to rephrase, shall I apply this to fbdev fixes tree?
>=20
> I was planning to send you a pull request for that, but if you can pick=
 it up=20
> that's even easier, thanks.

Ok. Applied, then, to fbdev =3D).

 Tomi



--uQHhBUuOkU0hBrOdoQwoRB0WclOWEUA28
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSlLePAAoJEPo9qoy8lh71iCYP/3WKjqSnxJsE1CMjUGJHrWld
WxXDU30JV21SGNWr5oe7KNbJRI60JpSRAiSb0J+uCGo/iuB5YH8IJ5B5z59nLIPe
TgPzZgr7D/8NPcSZP3nfBO2V/yVTCRHQjL87biLoKokxetJyywCvUy+O7vi3Tqtg
9VD8g6GzOoZ2u5Gb4uc4JuQ8Xj2rvu0XVp7gQ16P8Dfu/CTVAkay/AbqCCSt6T8w
HiZ2cO+3MVptyGu6DNz8w4GzFjfQvezmNZxR56mEABv1EOwiauDpvYgm1MtEv6fA
2uojfChy6Oq9lnuk3o7AbgrzAkpiWpSISO8VnS9cHRwhc39jq+Avxq4WOOw3c3Ta
/8jkRMf65060kquVb5dt6XzdICldKi+9px12nGEP18/YHXeFEJv3Wn4gzxMfH8kj
m5D5NsY3nHJRSWsEX6gebOH5BBrGRsoMK8k4+IhTsf0DRd1pMCnS5YfcsYX+HBUv
SFNJJUmdF+sU1MVa+Y4X71TIukuoRoFbiXPaULBuMnqzeSSuGPxcfxzL59wbO7Nx
WRnof+tU20wo8Y0fLN+HpgsAKEiXwglNBE4bW5/PmmbQ6GJ/2rsqFUAqK/BHC/MP
LHQiWOD1KvVPYV1ka2tbZzoWuVfcgtir4F0qE2BFJnDyXNpmQuxafJJ/fvYP82tb
dKd2NnamF61AKB+lXvh2
=7zX7
-----END PGP SIGNATURE-----

--uQHhBUuOkU0hBrOdoQwoRB0WclOWEUA28--
