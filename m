From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 11 Mar 2014 06:43:18 +0000
Subject: Re: [PATCH 3/9] Doc/DT: Add DT binding documentation for DVI Connector
Message-Id: <531EB086.8040404@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="mTHRbUBsIG2Ra7bvfcHTKn5En2CvWexqB"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>	
 <1393590016-9361-4-git-send-email-tomi.valkeinen@ti.com>	
 <20140228155937.GQ21483@n2100.arm.linux.org.uk>
 <1393604717.3802.61.camel@paszta.hi.pengutronix.de>
In-Reply-To: <1393604717.3802.61.camel@paszta.hi.pengutronix.de>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Tomasz Figa <tomasz.figa@gmail.com>, dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, Rob Clark <robdclark@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

--mTHRbUBsIG2Ra7bvfcHTKn5En2CvWexqB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 28/02/14 18:25, Philipp Zabel wrote:

> dvi-connector {
> 	compatible =3D "dvi-connector";
> 	ddc-i2c-bus =3D <&i2c3>;
>=20
> 	port {
> 		dvi_d_in: endpoint@0 {
> 			remote-endpoint =3D <&sii902x_out>;
> 		};
> 		dvi_a_in: endpoint@1 {
> 			remote-endpoint =3D <&tve_out>;
> 		};
> 	};
> };
>=20
> It should be possible to let the connector know that those two endpoint=
s
> are connected to a TMDS source and to a VGA source, respectively.

I have not worked with boards that would have the analog part, so just
wondering about the above.

The above would mean that either digital or analog is in use, but not
both. Was that the intention? From the connector's perspective, the
analog and digital pins are separate, and I think they can be used at
the same time. That kind of sounds like the analog and digital pins
should be represented as separate ports.

 Tomi



--mTHRbUBsIG2Ra7bvfcHTKn5En2CvWexqB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTHrCGAAoJEPo9qoy8lh71sbcP/id8eVwyYhfKbpC8nnMfgzfQ
UskPVnG7Tp6cSBewDmz/befBqCKGnTC51lOr941WmWhdXZk9ZeON+nAEo2XyF+kG
emIq2aYb5NtAKFIKHS/F9omT8KmiVBE/jRWAoWN0fGx2iJJUz7YN7h5DoeGVROv4
O4zeCY0ci8LpmsL5qFk07/LsNoHTtUqWi7KTPqeeK8VmtkmVeKIgsVQAR+a8e834
5IDhfeQ1O6FNi52+c3bcubZBp/+pEPgRiPc0es1/NacreXfd/7QO3mXpQuu0ImhL
xWT7r09xZz+ktuBhmEx6olsNYD4C3UskO4qOdOqCFqG/7AYos35+HFM7iZJIwvzG
F8zp1EaqpqumFHdL1jwp2ld4x80NKVlZDJrumUsyYIqginFS/a615A2SLy0JwQyl
reriEPxOHaIr5+BzGCabZK3/5CivRk+S+cEJjY6SXhkMgG3fxp2qi/Hla7MZ69fh
1pvQw19yHJMcc5TrxJ5B6x7h7b/RtRRao1N1Yf8qc3gyZShAyV8z496F6uT0SPnV
+Zg3/jP1/IOL59aLG2FLo8Ae62aR8nPIjtvGTf/9zlsrqtC/coz9rW8TEEmd9mh2
vJYotHCliY87neaEXlNLUcbwUL4ZrFp08skPEBAivxqbso0nLyBrBuWznY+pbnOX
exRC1vycJllPWMFzHpdg
=q41a
-----END PGP SIGNATURE-----

--mTHRbUBsIG2Ra7bvfcHTKn5En2CvWexqB--
