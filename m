From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 07 May 2014 16:02:40 +0000
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree support
Message-Id: <536A5920.1020908@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MB3F0saapg1aMl86Q2fNJxgwV2mp2KnAh"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-4-git-send-email-tony@atomide.com>
 <5369EAE7.3030705@ti.com> <20140507150343.GA9502@atomide.com>
In-Reply-To: <20140507150343.GA9502@atomide.com>
To: linux-arm-kernel@lists.infradead.org

--MB3F0saapg1aMl86Q2fNJxgwV2mp2KnAh
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/05/14 18:03, Tony Lindgren wrote:

>>> +	lcd0: display {
>>> +		compatible =3D "sharp,ls037v7dw01";
>>> +		power-supply =3D <&lcd_3v3>;
>>> +		reset-gpios =3D <&gpio5 27 GPIO_ACTIVE_HIGH>;	/* gpio155, lcd RESB=
 */
>>> +		enable-gpios =3D <&gpio5 26 GPIO_ACTIVE_HIGH	/* gpio154, lcd MO */=

>>> +				&gpio1 2 GPIO_ACTIVE_HIGH	/* gpio2, lcd LR */
>>> +				&gpio1 3 GPIO_ACTIVE_HIGH	/* gpio3, lcd UD */
>>> +				&gpio5 24 GPIO_ACTIVE_HIGH>;	/* gpio152, lcd INI */
>>
>> Why are most of the gpios in 'enable-gpios'? MO, LR and UD don't reall=
y
>> have anything to do with enabling the panel. Why not just have one
>> 'gpios' array with all the gpios, as they are quite a mixed bunch?
>=20
> Yeah that's what I had initially, but reading simple-panel.txt noticed
> there are some standardized GPIOs for reset and enable.

I'm not sure if it's worth to try to make it compatible with
simple-panel. simple-panel bindings do not work with omapdss anyway, and
simple-panel doesn't have the support for input ports/endpoints.

Can the panel be used with only one gpio (I guess that would be INI or
RESB)? If not, simple-panel doesn't work.

> How about we set up one reset-gpios, one enable-gpios and an array of
> three unlabelled GPIOs?
>=20
> Or if we want to add something generic, we could add new mode-gpios
> property that other panels might be able to use too?
>=20
> BTW, I'm also personally fine with all five gpios showing in a single
> gpios property, I'm not too exited about naming anything in DT..

I don't have a strong opinion here. I don't have much experience with
DT, especially with making bindings compatible with other ones.

I'd just forget the simple-panel, and have single gpio array.

 Tomi



--MB3F0saapg1aMl86Q2fNJxgwV2mp2KnAh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTalkhAAoJEPo9qoy8lh71yuoQAJFJE52MYlem81uE1m9G6Vyc
pkzRUMtjnrHXAeDSvfxW4PbFFHZ3PpgXtC4PXCEGMb4iGf/H7u9M3ke+GPGc80wO
wMVVPT5hYLfYvMRkvh7nQRVTC5mJuM1d2Q9/E0SCx2gJsA4iuazM4EniYYcCqUcC
E808VJqQ9vuQ7WhUngioOb6wcXO+/A0N2ldrOaR2pziTgqgfIZo9WuOtulElnAEN
RPn2t+Ws4UydjJNtSPR6hhDiYFgGp6dqqFn6/e9jDKpRRIarBD/07lANmtRPWmzv
XaSFlqqkbM22J7ReqUoLj2/IPIDOb4/tx+TYj7M7wLjj8atxukasZCyZ+x9ACdj/
5qnwgVeEnVgk4/GVqsYBBKLpG1uMmhLz5gZDm8/Q+tpCQl/lWoBZ2/hEV3Sct5u8
464ULhqe2rWyLZ6O9Ax8YHO4+ZDVajwqd/zsas63mR6MuVytbBxrR8CCnRlXlBE/
D6+/6avSP6Zxjlv6PHf4+o1oHJ5KLVQViLF7wYuWd1zx76S3QwpFPoxR/vNwO0Sl
TvKpMK47Ku8nkoIXu85gDiyvAv9AlEPHmBHTsv/1vUFGpq9I7GKt17qHBeK2DLZ9
n/zEOAiVJVzgMp0ggkpEAhKoAt35ERWWRmN01hNxUC8xhrKuTpGGM0t4dPLjmAg9
zj0AyhPSPl3uZeWMei11
=m1/F
-----END PGP SIGNATURE-----

--MB3F0saapg1aMl86Q2fNJxgwV2mp2KnAh--
