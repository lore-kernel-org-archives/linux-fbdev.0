From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 01 Jul 2014 10:22:51 +0000
Subject: Re: [PATCH 2/2] video: clps711x: Fix sparse warnings
Message-Id: <53B28BFB.3040203@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="S6ctBT6D8UEokacRheQHiVXrWX793W5Dp"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1403937246-14506-2-git-send-email-shc_work@mail.ru>
In-Reply-To: <1403937246-14506-2-git-send-email-shc_work@mail.ru>
To: linux-fbdev@vger.kernel.org

--S6ctBT6D8UEokacRheQHiVXrWX793W5Dp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/07/14 09:23, Alexander Shiyan wrote:
> Tue, 1 Jul 2014 09:14:02 +0300 =D0=BE=D1=82 Tomi Valkeinen <tomi.valkei=
nen@ti.com>:
>> On 28/06/14 09:34, Alexander Shiyan wrote:
>>> This patch fixes below warnings:
>>> CHECK   drivers/video/fbdev/clps711x-fb.c
>>>   drivers/video/fbdev/clps711x-fb.c:247:24: warning: incorrect type i=
n argument 1 (different address spaces)
>>>   drivers/video/fbdev/clps711x-fb.c:247:24:    expected void const *p=
tr
>>>   drivers/video/fbdev/clps711x-fb.c:247:24:    got char [noderef] <as=
n:2>*screen_base
>>>   drivers/video/fbdev/clps711x-fb.c:248:35: warning: incorrect type i=
n argument 1 (different address spaces)
>>>   drivers/video/fbdev/clps711x-fb.c:248:35:    expected void const *p=
tr
>>>   drivers/video/fbdev/clps711x-fb.c:248:35:    got char [noderef] <as=
n:2>*screen_base
> ...
>>>  	info->screen_base =3D devm_ioremap_resource(dev, res);
>>> -	if (IS_ERR(info->screen_base)) {
>>> -		ret =3D PTR_ERR(info->screen_base);
>>> +	if (IS_ERR((__force void *)info->screen_base)) {
>>> +		ret =3D PTR_ERR((__force void *)info->screen_base);
>>
>> I don't see any other user of devm_ioremap_resource() having that kind=

>> of casts. Why are they needed here?
>=20
> Not needed, type cast was done only to remove sparse warnings.

Right, but I think either sparse is wrong here, or the PTR_ERR/IS_ERR
are wrong. You shouldn't do typecasts like that to hide those warnings.

The memset warning is correct, because you shouldn't use memset to
__iomem memory.

 Tomi



--S6ctBT6D8UEokacRheQHiVXrWX793W5Dp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTsov7AAoJEPo9qoy8lh71nKgP/0MPLXm1fcBFI7DUBy9nQMwJ
v7RpXEH+iMC/OwBAAAJ7t8O3XtT/VYfat2yEIHLW0mfmlG/7cnSXgabMnc9BdbUF
4khz3l2xhU6Iibkxn/LZApvb8h8yy3k7OKKy7GwDOSsodhPmXNzcV2lqz1HYXLTR
10wdH3zuJ+Z/OzaAcmKm7YNEv573I4h89mM3TvrJAMMQPnBeEzAZJuQ9CSwD6Feu
CjO94ckR1SSBcrRdr2vwIyO36K1C8RLghIumQHbs/cnCnHqjpayZg3FBJr5J1Cqg
4oWcTewLMESqy4rBgsgc24NaLkSTac7VZnUjDkoUOCNPbm2fLzqYumbNg7bh3LvL
WxCBMxGxVkla5YjNJ8GZ0acWRllDK8akhVpeECPANTVyRFWjhLcLgWqzIxoLFpzW
lkpeeDE0VNQtjV+xaJWBfsiqKWJfy8A8OTxD+KyyG9jE//lgkg62c6IdTVcOha7N
1+HDl5N7xZBDqISGojyciCq8bNaVwXzrQIjeEtun9uHypC2NZD3Tc79cpz/6T+tI
Mv60Uk8yv6AgO/xvPUNXOPmhLiEG0U8MspfS+A9rlEN5UmGBloo0OoeNyL9KzyIj
Hb117z/2scS4cQNdQomcYxL+1VHtAQ8LqlLE9TeNLQeJkUXnPqWg9ayO4Pe8Xg0+
QhYnOYQx3k9JKevFfGF7
=jQab
-----END PGP SIGNATURE-----

--S6ctBT6D8UEokacRheQHiVXrWX793W5Dp--
