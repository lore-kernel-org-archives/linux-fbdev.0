From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 29 Dec 2014 08:13:12 +0000
Subject: Re: [GIT PULL] fbdev fixes for 3.19
Message-Id: <54A10D18.1060308@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="t2mwM2X2VItUwrbIGIJGmu0UWEJKOquhI"
List-Id: <linux-fbdev.vger.kernel.org>
References: <54899F0E.4090309@ti.com> <20141220210125.GB16705@amd> <20141220212027.GC16705@amd> <20141220215718.GA25101@amd> <20141223111250.GA30284@amd>
In-Reply-To: <20141223111250.GA30284@amd>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Mark Brown <broonie@kernel.org>

--t2mwM2X2VItUwrbIGIJGmu0UWEJKOquhI
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 23/12/14 13:12, Pavel Machek wrote:

>>> I test-merged 3315764efceaccfb02c7d4c99ef8eed6716cd861, and boom,
>>> video is gone.
>>
>> I reverted
>> 4b4123f0c7b02f7cf1a3189f967f079197578c3a..9051909e451a0368c95ccf74562a=
db53fd2719f8
>> in 3.19, and voila, video is back.
>=20
> Tomi?
>=20
> Your merge causes regression on my hardware. I'd expect some
> communication from you. If you don't have time right now, can we
> revert the merge until its fixed?

I've posted a fix on the "n900 regressions" thread.

 Tomi



--t2mwM2X2VItUwrbIGIJGmu0UWEJKOquhI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUoQ0YAAoJEPo9qoy8lh71LUIP/0jxnBS0cRYNsQ8+WLhUdQ8r
ny2loQU60fSR8WTh+NPFbiyax33O4HnBFV1a0qw9QsoQMULCiUam4duexXCk3h5m
68b6z4H/7iDmDnMDOSOfosmnGIiaW/PO+oN8gikLyMPeNFouOw5aMu+UtbuRVgbV
xZlV2dcteSbv7rAtw2tE75cngVgvqkfrMonIiiMLbJqwrCgK7zhO47ZkiWA3bZFi
VG9zqZtVhl8ofAe3zE6BiyyiSaetvrsSM1Riiui8ITHVKBwsiPfaPgb1c68STdPo
s2iNIUI7d7KBt4dh/lapS9yHWLcLfC8+tGon3RojxsUYeZLb3IIhMYg8RpQ+w3Om
79+As9kJQWK8gWjJ8UGaT++qZ/bcCf9PDtXcXtVxAYADdSYDK56X6P2djrTA/R+a
5aZryNRM/hMqNKmwrEggm4kTKxNqlX5bK2W8rFXvAJUcyH0jWjciuB4raA3HVeEC
hLLppthEcv4DhG1QVH8t7juO0qnfjdMz+0K72jmaUAaOCRV2lViLoYU8ZwqrTu4+
eePNbt13j91876bm9M/VKOGsjskMdsOXQH6c31zU0xYzuHTwsfAu/SH5uKPnJPzO
Yhh7gaWBj7Zs5vIOPhjD/Z6UH+7BR29l4IE+qkyLt0+4LhxNV/aBW3uSfYVlYHzx
hlCbmkvpKhJDctzTn8Av
=N6PP
-----END PGP SIGNATURE-----

--t2mwM2X2VItUwrbIGIJGmu0UWEJKOquhI--
