From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 01 Aug 2013 05:44:00 +0000
Subject: Re: [PATCH v2 10/24] video: da8xx-fb: fb_set_par support
Message-Id: <51F9F5A0.6080300@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="HE4UIVhhBbgvt3oOolIQW1vcupclW6U5H"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1375208791-15781-11-git-send-email-detheridge@ti.com>
In-Reply-To: <1375208791-15781-11-git-send-email-detheridge@ti.com>
To: linux-fbdev@vger.kernel.org

--HE4UIVhhBbgvt3oOolIQW1vcupclW6U5H
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 31/07/13 21:56, Etheridge, Darren wrote:
>>>
>>> +static int da8xxfb_set_par(struct fb_info *info) {
>>> +	struct da8xx_fb_par *par =3D info->par;
>>> +	int ret;
>>> +	bool raster =3D da8xx_fb_is_raster_enabled();
>>> +
>>> +	if (raster)
>>> +		lcd_disable_raster(true);
>>> +	else
>>> +		lcd_disable_raster(false);
>>
>> This looks odd. If raster is enabled, you disable it. And if raster is=
 disabled,
>> you disable it.
>=20
> I corrected this one in patch 0011 - I agree this code is very confusin=
g.

In patch 11 you add the enum. I wasn't referring to that. My point was
that even if raster is already disabled,
lcd_disable_raster(dont-wait-for-framedone) is called.

 Tomi



--HE4UIVhhBbgvt3oOolIQW1vcupclW6U5H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJR+fWgAAoJEPo9qoy8lh71MfkP/0h3HdesLUMmP+9GZzO716Ma
jvcgUL0M/yGXj2Gne85xQxQIC1606qITVElQJAtWo67ZnkdbMV2L+xCBmXPZKpLi
04dZorM8ZpVJy88vUqz2a1Hn16DS0ThQqM4HvVLyEjktEdUTGX9f+HjwoZ9lPpxm
o99i/FcnRL2Bd5L/VFhSPpgmSpLUxGZ/WIkWdKteLl1yioBQ3++UKj6RT9QP0Ib3
PwWdyDpPevvhyMf9RBhlzp+V85L5akaRgB+TMYk0kTB52ItC9bxHlC4uZ9eThhiQ
4qQsWNVgkPcEgBxPoY5aopv9M0QUByj2Xwd2bvXwUlwBmvCZjKXD1UTqXSdSX98I
euGNIue61Osp+Li6M1vjMILXT4cdJpNRkFUGODMB+uHtlvlzsLwypCDUJzxm3dPE
BT9FIUeyiGr6V2LHeqgZuMynPYnpvZ1GNbYMd76KVt0m2L7KHSSjx8WGN5D5wjuZ
1JWjNJVZNWVYZYLGuZhWWoAWa4B2FHspu78FnutvwsjjHqpVGlc6S/DNxeAwWHb2
uaxdTsXcqSp3UWDtieOcWnQGw0IxUN/cBhBBV8L6pza6e4ysxceF1qwY0mXuIPLM
uxVFEAAMdOcKXLeLzu0Qr0Zk7JZs99Yhy5U12SGTvjDFRUn2gNsgO4qwhhNJ0uy3
OeVCl8gXmUOBX9/10I/T
=R3nV
-----END PGP SIGNATURE-----

--HE4UIVhhBbgvt3oOolIQW1vcupclW6U5H--
