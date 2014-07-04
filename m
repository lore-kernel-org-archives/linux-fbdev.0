From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 04 Jul 2014 08:06:31 +0000
Subject: Re: [PATCH 2/2] video: clps711x: Fix sparse warnings
Message-Id: <53B66087.1040500@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="u5IGDM0HOXpn67Dr9xwiIRO7bMBD9QCoN"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1403937246-14506-2-git-send-email-shc_work@mail.ru>
In-Reply-To: <1403937246-14506-2-git-send-email-shc_work@mail.ru>
To: linux-fbdev@vger.kernel.org

--u5IGDM0HOXpn67Dr9xwiIRO7bMBD9QCoN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 01/07/14 13:31, Alexander Shiyan wrote:
> Tue, 1 Jul 2014 13:22:51 +0300 =D0=BE=D1=82 Tomi Valkeinen <tomi.valkei=
nen@ti.com>:
>> On 01/07/14 09:23, Alexander Shiyan wrote:
>>> Tue, 1 Jul 2014 09:14:02 +0300 =D0=BE=D1=82 Tomi Valkeinen <tomi.valk=
einen@ti.com>:
>>>> On 28/06/14 09:34, Alexander Shiyan wrote:
>>>>> This patch fixes below warnings:
>>>>> CHECK   drivers/video/fbdev/clps711x-fb.c
>>>>>   drivers/video/fbdev/clps711x-fb.c:247:24: warning: incorrect type=
 in argument 1 (different address spaces)
>>>>>   drivers/video/fbdev/clps711x-fb.c:247:24:    expected void const =
*ptr
>>>>>   drivers/video/fbdev/clps711x-fb.c:247:24:    got char [noderef] <=
asn:2>*screen_base
>>>>>   drivers/video/fbdev/clps711x-fb.c:248:35: warning: incorrect type=
 in argument 1 (different address spaces)
>>>>>   drivers/video/fbdev/clps711x-fb.c:248:35:    expected void const =
*ptr
>>>>>   drivers/video/fbdev/clps711x-fb.c:248:35:    got char [noderef] <=
asn:2>*screen_base
>>> ...
>>>>>  	info->screen_base =3D devm_ioremap_resource(dev, res);
>>>>> -	if (IS_ERR(info->screen_base)) {
>>>>> -		ret =3D PTR_ERR(info->screen_base);
>>>>> +	if (IS_ERR((__force void *)info->screen_base)) {
>>>>> +		ret =3D PTR_ERR((__force void *)info->screen_base);
>>>>
>>>> I don't see any other user of devm_ioremap_resource() having that ki=
nd
>>>> of casts. Why are they needed here?
>>>
>>> Not needed, type cast was done only to remove sparse warnings.
>>
>> Right, but I think either sparse is wrong here, or the PTR_ERR/IS_ERR
>> are wrong. You shouldn't do typecasts like that to hide those warnings=
=2E
>=20
> Well, I'll remove these changes and send a second version of the patch.=


I applied these two patches, and removed the type casts from the second o=
ne.

 Tomi



--u5IGDM0HOXpn67Dr9xwiIRO7bMBD9QCoN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTtmCHAAoJEPo9qoy8lh71FKIQAKRAMIYaoElDK/9GTQUb19lU
WMosINjmyBvtM2I/+1ILHbSaZJUHHHT/J1uQklMQS2XoFmw+mLr9j5yV6+PNDdNL
R1K8BeB8wdIFkr2M1nAbIfVxA+EaGoUzQtnMDicvPTz4gRBRCQtqTVD4hc80tXVv
uB37G6D2u31bBjdMRemgVRWurd6UkeKtSo4uTlzw7DYE7PfPGsBf9MMiK3Jd51By
0YyhYRjG/71YbCCAjYIw1rrxLaL74wqZU2NGUkSWnxoMBy4PfyqPChOhMK0VRt5i
b0/Cm0J1C8iCrFxR1zf+sR7UNflmjZf2ItkPVA/3/IYUmMG8pXwgLKUSKzjYafAC
vDyfZdjlXeSs7CpC491judCdWO+9eyUq/etmfsim4xKBClKUTgETSYpwvvDLn6C6
jZ81mfooF9RnGNy8LyLdTfk8djLOuVmmNlhxRaKDwoDv5zjLSUEoGflLOMNcyTLE
aLidvzzeDdRmPFSv6VnpPzkYAm+9PukJIMmHLka4nsSsiJrHzfqxAp7s0j59VzfJ
msRWCTWq2fAVsFjFXUykHCYb1qnbTTIIAUWi49Mis1dU4DBKNhVWxKaybOH3UG9t
kpt0znUDHVzUsdoKkXAA6Qx6sQQ8IPM+0ktT6kCiWkSYZYfXPDUandCVv/rJ1+1q
DbdONJb5kJ2bJ/Yg+QM4
=qFdK
-----END PGP SIGNATURE-----

--u5IGDM0HOXpn67Dr9xwiIRO7bMBD9QCoN--
