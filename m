From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 18 Mar 2014 12:43:05 +0000
Subject: Re: [PATCH 6/9] Doc/DT: Add DT binding documentation for MIPI DSI CM Panel
Message-Id: <3793066.CEaE5qMjRq@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart3999461.FK4J4kLf1C"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
 <4670830.fkS1noPxcd@avalon> <5327E8D3.5010907@ti.com>
In-Reply-To: <5327E8D3.5010907@ti.com>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, dri-devel@lists.freedesktop.org, Andrzej Hajda <a.hajda@samsung.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>


--nextPart3999461.FK4J4kLf1C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi Tomi,

On Tuesday 18 March 2014 08:33:55 Tomi Valkeinen wrote:
> On 17/03/14 16:22, Laurent Pinchart wrote:
> >> +Example
> >> +-------
> >> +
> >> +lcd0: display {
> >> +=09compatible =3D "tpo,taal", "panel-dsi-cm";
> >> +=09label =3D "lcd0";
> >> +
> >> +=09gpios =3D <&gpio4 6 GPIO_ACTIVE_HIGH>;=09/* 102, reset */
> >=20
> > If the panel uses a TE GPIO but no reset GPIO, do you plan to expre=
ss this
> > with a "hole" for the reset GPIO ? e.g. something like
> >=20
> > =09gpios =3D <0>, <&gpio4 6 GPIO_ACTIVE_HIGH>;
>=20
> Yes.
>=20
> > Wouldn't it be better to split the gpios property into "reset-gpios=
" and
> > "te- gpios" ?
>=20
> Yes, I can change it. I don't have a strong preference.
>=20
> I've gotten similar comments for other bindings also, so I guess the
> preferred way is to use named "-gpios" properties for everything exce=
pt
> the case where you really have multiple gpios with the same purpose?

That's my understanding, yes.

> The gpio binding documentation doesn't give much guidance on this.

=2D-=20
Regards,

Laurent Pinchart

--nextPart3999461.FK4J4kLf1C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTKD9ZAAoJEIkPb2GL7hl1TjkH/2Kb7C78gRRuNUFQude2TXRI
cO+TV41Ern3vnapcqpQm08SHf7tD4bfF73ANrgcTA0s/GO6irUrLtWTKyqC6IB4E
6xo6jFXMdZGNMbfhG3ZqmMRjg9axobDYX3EnHGUO2hxHcM4wOBRJwxSwr5M5t/qZ
uEvpqgvM+jVAkfxDRJpJ4wDLEEGWWnfCteE2ASvyvKenYVys7HZdql/UtxOUl2za
Tz1vi4NB5xRghUL/Vd0ZzCbgC8IYVEsOQa46skTGdFUQw0zRM8nxbYh3mUzj7mOC
bqz3EO3PO0XNawf9k+Jg2auIm5tL/XHJogBzMPF6y8C7TfRNIh1fKMdj8pyRVvY=
=P+Dj
-----END PGP SIGNATURE-----

--nextPart3999461.FK4J4kLf1C--

