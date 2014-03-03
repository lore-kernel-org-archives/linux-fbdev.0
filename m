From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 03 Mar 2014 06:42:35 +0000
Subject: Re: [PATCH 3/9] Doc/DT: Add DT binding documentation for DVI Connector
Message-Id: <5314245B.803@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="LiE0K17Efemajrmpfcx1JEowqX9AjGLVP"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
 <1393590016-9361-4-git-send-email-tomi.valkeinen@ti.com>
 <20140228155937.GQ21483@n2100.arm.linux.org.uk> <5310B567.7040605@ti.com>
 <20140228162327.GT21483@n2100.arm.linux.org.uk>
In-Reply-To: <20140228162327.GT21483@n2100.arm.linux.org.uk>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Tomasz Figa <tomasz.figa@gmail.com>, dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, Rob Clark <robdclark@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

--LiE0K17Efemajrmpfcx1JEowqX9AjGLVP
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 28/02/14 18:23, Russell King - ARM Linux wrote:

>> I guess the compatible string is the easiest way for differentation, a=
t
>> least for the three main types, i.e. "dvi-d-connector" etc.
>>
>> "dvi-d-1l-connector" and "dvi-d-2l-connector" for the single/dual link=
?
>> That looks a bit funny.
>=20
> I think that starts getting a tad messy:
>=20
> 	dvi-a-connector
> 	dvi-d-1l-connector
> 	dvi-d-2l-connector
> 	dvi-i-1l-connector
> 	dvi-i-2l-connector

Yes, it's messy. Pondering this over the weekend, I think it makes sense
to have just one compatible string, as all those connectors are still
the same DVI connector, just different variations of the same.

> That's rather a lot of compatible strings.  Another possibility is:
>=20
> 	compatible =3D "dvi-connector";
> 	analog;
> 	digital;
> 	single-link;
> 	dual-link;
>=20
> I'm debating whether "-signalling" should be on the 2nd and 3rd (or...
> -signaling depending on how you prefer to spell that word.)  At least
> one of "analog" and/or "digital" must be specified, and if "digital"
> is specified, then exactly one of "single-link" or "dual-link" should
> be specified.
>=20
> So, this would mean we end up with:
>=20
> 	compatible =3D "dvi-connector";
> 	analog;
> 	digital;
> 	dual-link;
>=20
> for a DVI-I dual-link connector.

Another option would be:

num-links =3D 2;

But I like your suggestion more. We could also optimize it, "digital" is
extra as both "single-link" and "dual-link" mean also digital. But... I
don't see much point in optimizing that way. So I agree with your
suggestion as is.

 Tomi



--LiE0K17Efemajrmpfcx1JEowqX9AjGLVP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTFCRbAAoJEPo9qoy8lh71DnUP/1tWOVUVwjeQyjNGbRim9v3W
ARDV1sg+OV4xIrdeTkynILBK5DA3XopiwQKB/D6ODY28ZdNy9qu44b1EdKLj53D/
J6o2TD5BZdGcZ1XHGWHzWZHwPGAsJ9NYvTNsbJbJEG+WPRIW+yiQWySZ3y/3QQ+o
U14NdkRoGDQdSVfBKXBOYvATAivOKUd7w1qhKhtvr+GU0/IwbCSJDhmScGOW4MM2
IBRkD+xVHoBwjDMyn/GwwYKxxFrBWkhsblUIGWs3ufBw2AxrssbsMuM9iK5RyPvz
TcHyonDAVZKJd1OVp+bY8KGPhLl1Ri9enpvzqJFhQZKeVlL1G0opmtmL6YSIko1K
XufgiyuhaBfdb1n4zL/bbchb1dpWP23FJ4hH3pO7x21Cf78l+/Bi8/meTAIVKIab
AlohZyMGgl8I9VwA+P0MXa+lN+5SSem/6wVq16Cb5vgveFc9w70jrnGS/PhEawT6
Ojn7MlLEHaCEtt+JS5g1AIrBNpJRpXyu55qEknT26H0cZDWKpvQpUXEp7ZiFcoic
B5IePoklCUpJI1wkS21793DtDk75zpvQjfq033PTdgWEFRyFfN8jJ5oP31SesgD8
WEU4+ZwzE1cdkHiCZZBYgsYbYxjPVuaN0zOidZ3GvxrYfUVYITy+mIoxVxAUOf61
3kbiVCNRxQygV0nxdsSF
=DJAr
-----END PGP SIGNATURE-----

--LiE0K17Efemajrmpfcx1JEowqX9AjGLVP--
