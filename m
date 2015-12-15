From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 15 Dec 2015 14:03:28 +0000
Subject: Re: [PATCH 03/23] OMAPDSS: tpd12s015: remove platform data support
Message-Id: <56701DB0.3020605@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="4g2SPUN8RaAUxV6ckbHgJfdJwdx3pw6hx"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449676791-26304-4-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1449676791-26304-4-git-send-email-tomi.valkeinen@ti.com>
To: linux-fbdev@vger.kernel.org

--4g2SPUN8RaAUxV6ckbHgJfdJwdx3pw6hx
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 13/12/15 22:07, Laurent Pinchart wrote:

>>  static int tpd_probe_of(struct platform_device *pdev)
>>  {
>> @@ -282,11 +257,7 @@ static int tpd_probe(struct platform_device *pdev=
)
>>
>>  	platform_set_drvdata(pdev, ddata);
>>
>> -	if (dev_get_platdata(&pdev->dev)) {
>> -		r =3D tpd_probe_pdata(pdev);
>> -		if (r)
>> -			return r;
>> -	} else if (pdev->dev.of_node) {
>> +	if (pdev->dev.of_node) {
>>  		r =3D tpd_probe_of(pdev);
>>  		if (r)
>>  			return r;
>=20
> How about moving the else case not shown here to the beginning of the f=
unction=20
> with
>=20
> 	if (!pdev->dev.of_node)
> 		return -ENODEV;
>=20
> and lowering the indentation level here with just
>=20
> 	r =3D tpd_probe_of(pdev);
> 	if (r)
> 		return r;
>=20
> Apart from that the patch looks good to me.

True, it can be cleaned up. I'll do that in a separate patch, so that
this one stays simple. I can also move the contents of tpd_probe_of()
into tpd_probe(), as there's no point in having a separate function for o=
f.

 Tomi


--4g2SPUN8RaAUxV6ckbHgJfdJwdx3pw6hx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWcB2xAAoJEPo9qoy8lh71GdYP/iI8NyODlrATpzypliDv2TqE
63Tjv93d9RPpxkTrl3amBqU1MBiT+ddQyQdJw9O+WFmvL8NI9kvDf2puy0WMWTiK
R5E2eek18NByS8EZIinh9zapa8TEuZSeBlCflnfDB0nvdMi8+h9HOvi1VzoZ0BZ5
x6AXBzL/Eh8jJzH4+LBY+YmqZsO+FwiZF/2pRdJkyz/0jzMKTbqiKyz9TP/HmLFw
r1NFpVmCersuRNmuEMMnBaIvGsQULxqTsDYVsAWZGoCq+oTX0KUbYTKwTIg2ojaX
HFn1x0OVJRyvLt8WbYntsnfQmjAR99cwcMIxX57kILL4ju0ldTIMt54Ez4wbbLBk
bw7TcVXvoMeJmeWrRJn6KSFILE/qUPCvy5Zxz4a3Jp1i5i3qFQu9B49kFMsxNWOg
8sdNMGFNsJAlOcIHmChc7WS87F0JMXDjm8HiZ4IBjJSlIp5HkDHf1bQFEeQCMk+z
kuPojMeEQBfZcsQotiGtcQHcjubtPab0HE3omNVG3yuoZsOWdAK82ylooW+0JM5H
3aVVRstWZkCMeCKRaRCpei1Oh+pyOMM4IW2NSg2GfmjSbOtIZrjP/IqowWu2N5Y8
mNUtH+CIL43NyWCJhRrzNcG06aJDAk4/WnV2wZCT/i0Xxrk/KYP7KGFXe/gWfa+S
jcnp21+U7ZkHZAHyMt0b
=0OvM
-----END PGP SIGNATURE-----

--4g2SPUN8RaAUxV6ckbHgJfdJwdx3pw6hx--
