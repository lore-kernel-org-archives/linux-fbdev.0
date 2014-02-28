From: Sebastian Reichel <sre@ring0.de>
Date: Fri, 28 Feb 2014 16:25:05 +0000
Subject: Re: [PATCH 3/9] Doc/DT: Add DT binding documentation for DVI Connector
Message-Id: <20140228162504.GB29034@earth.universe>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="aM3YZ0Iwxop3KEKx"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
 <1393590016-9361-4-git-send-email-tomi.valkeinen@ti.com>
 <20140228155937.GQ21483@n2100.arm.linux.org.uk>
 <5310B567.7040605@ti.com>
In-Reply-To: <5310B567.7040605-l0cyMroinI0@public.gmane.org>
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2014 at 06:12:23PM +0200, Tomi Valkeinen wrote:
> On 28/02/14 17:59, Russell King - ARM Linux wrote:
>=20
> >> +dvi0: connector@0 {
> >> +	compatible =3D "dvi-connector";
> >> +	label =3D "dvi";
> >> +
> >> +	i2c-bus =3D <&i2c3>;
> >> +
> >> +	dvi_connector_in: endpoint {
> >> +		remote-endpoint =3D <&tfp410_out>;
> >> +	};
> >> +};
> >=20
> > This looks far too simplistic.  There are different classes of DVI
> > connector - there is:
> >=20
> > DVI A - analogue only
> > DVI D - digital only (single and dual link)
> > DVI I - both (single and dual digital link)
> >=20
> > DRM at least makes a distinction between these three classes, and this
> > disctinction is part of the user API.  How would a display system know
> > which kind of DVI connector is wired up on the board from this DT
> > description?
>=20
> Yes, I think that's a valid change. But do we also need to specify
> single/dual link, in addition to the three types?
>=20
> I guess the compatible string is the easiest way for differentation, at
> least for the three main types, i.e. "dvi-d-connector" etc.
>=20
> "dvi-d-1l-connector" and "dvi-d-2l-connector" for the single/dual link?
> That looks a bit funny.

maybe like this:

Required Properties:
 - compatible: should contain one of the following:
  * "dvi-d-connector"
  * "dvi-a-connector"
  * "dvi-i-connector"

Optional Properties:
 - dual-link: Should be set for dual-link capable connectors

-- Sebastian

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTELhgAAoJENju1/PIO/qafx0P/3NAZQdcRgXllzJSYwYIR30l
uhLBvQBploihzHthjMVWip9H2Kji3CfpOFN6Yl4C7Lbqvn+J3iza6Dgl4QFqZM21
tZnRZbhM0/IQ0rum2s8aRLpRleBhFAOJYXKGPE0EQ5EtPY7b8viQtmKlo1YuTK/M
oRYEnpeBSGDw7PChXfZJ8VOtNx7lqO7wao3U4tTLcEVa8ukLt0FnD8I4Av4uBaHE
qyX7K6aHmkIjWqhUgHPKUGTXxGhzbijIyjqTguJgfwsknYYjiSpzJs+hT6Z7sVuK
dm09ktJY29M4y4rsiRHJUEYTnaY+basnHMuykUodFf9TqSNCEkSIyN8YPcu2uwXn
l3ARZimLxl5ZmabzIU4u4grB3GHMcWDBt+rnB6wVaoPliJi61tolwCINqQ1ShKY5
BaL0nNq/IjJtBYEnLO2t3NfhfYElozOsE63sKUpfHzUB/9+cDLwwQ7pcxQ8PlSz3
Ct6JB20ZdGUTzobPkcgXEypTXstrdA3LrpEACCvJnsuGmexbPqzkMZPukeiahITK
p1mdX9dhLj/H4V9xqEJow7wocWrLdtHI7MVt9XiRVKkyKKYbWApMzbcJDCDjK4qo
rP+DtBo7Ew+RRfR5bMcfYWjb7TLTUP3XLoh3WQe2Y3vzCD5lPyTU6QR15wKszgPE
bC4sa7zDTOz3FfEOuMl6
=lZun
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
