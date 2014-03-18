From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 18 Mar 2014 06:33:55 +0000
Subject: Re: [PATCH 6/9] Doc/DT: Add DT binding documentation for MIPI DSI CM Panel
Message-Id: <5327E8D3.5010907@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="aTlV2D2po9mTkpS714eEiAlWlbPXu4XuO"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
 <1393590016-9361-7-git-send-email-tomi.valkeinen@ti.com>
 <4670830.fkS1noPxcd@avalon>
In-Reply-To: <4670830.fkS1noPxcd@avalon>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Tomasz Figa <tomasz.figa@gmail.com>, dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, Rob Clark <robdclark@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

--aTlV2D2po9mTkpS714eEiAlWlbPXu4XuO
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 17/03/14 16:22, Laurent Pinchart wrote:

>> +Example
>> +-------
>> +
>> +lcd0: display {
>> +	compatible =3D "tpo,taal", "panel-dsi-cm";
>> +	label =3D "lcd0";
>> +
>> +	gpios =3D <&gpio4 6 GPIO_ACTIVE_HIGH>;	/* 102, reset */
>=20
> If the panel uses a TE GPIO but no reset GPIO, do you plan to express t=
his=20
> with a "hole" for the reset GPIO ? e.g. something like
>=20
> 	gpios =3D <0>, <&gpio4 6 GPIO_ACTIVE_HIGH>;

Yes.

> Wouldn't it be better to split the gpios property into "reset-gpios" an=
d "te-
> gpios" ?

Yes, I can change it. I don't have a strong preference.

I've gotten similar comments for other bindings also, so I guess the
preferred way is to use named "-gpios" properties for everything except
the case where you really have multiple gpios with the same purpose?

The gpio binding documentation doesn't give much guidance on this.

 Tomi



--aTlV2D2po9mTkpS714eEiAlWlbPXu4XuO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTJ+jTAAoJEPo9qoy8lh714mkP/Rz4sZKoJ56Wxt2bFMR/arkt
snypct4nSm444/zeo08sRQd4ftbWHBOwyuiTcmTY9bf4zWUvHsSVHw3K+TsiL0rT
zHvO07skSZUCTHsuvPU0ngRJVKKSAZNv00Ii6vualS1afba+wn/fDsJofMo5WOxS
SkDiL9rfWkRFse3pFLjKNU8K36bjpcan5HEQkLxArDPgJ66LsUcQRebF76SSVuMH
kwZ7NInbTZiCNflpO5eh9+Pz55dk3KxWT4BrheIg1YgRIt4+npjP2hDcwewjTcRX
jT6dXoXjxckQgQSSfo/eJ0gtOcEkU9vmcDIvQtylK8AhjGvV9GxynV4kLK40KFHS
z5wVaQQUZ/woVLSLpZ/uPaaKs83yqPM4GkE+IwmarM7KVKnO/Cx8fyGtJFACZZXC
bKqJuzT6KveIyTxg203oGVgo3sVen6jy2An7n/CF2J3pcjlr/9mRaLXbWp1hjoTr
JTB8EWiJsJLVhYXXDiqVbsQmMa45junt3sxGvNqwZd7ghwVdvPh6WS0lFPuZMzz4
E9iHOKpZd5dFlxliRUsFQyM7j3g5RFEevsAAC1olUrTEBFrqFKRqzvPf/yvbgNlU
6WhwxUvub2nG4uDcmQqpCV99FeLoGnK/0c46LTQyK743ohfQvFmf1RggQK8JXbTg
H7CB+3R0Vi+TToASGw27
=/McC
-----END PGP SIGNATURE-----

--aTlV2D2po9mTkpS714eEiAlWlbPXu4XuO--
