From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 14 Aug 2017 08:43:41 +0000
Subject: Re: [PATCH 3/3] mfd: twl: move header file out of I2C realm
Message-Id: <20170814084340.65morabelapfegph@ninjato>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="lv6drd3t7p4u6slo"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-4-wsa@the-dreams.de>
 <20170706064453.GH16144@ulmo.fritz.box>
 <20170706070352.xdecvsnremwqed72@dell>
 <20170813133700.tv4ka7anvbzcplr7@ninjato>
 <20170814064247.qvggx4ito4vgjqvs@dell>
In-Reply-To: <20170814064247.qvggx4ito4vgjqvs@dell>
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.>


--lv6drd3t7p4u6slo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Given the triviality of the change for non-MFD subsystems, can we apply
> > this for 4.14?
>=20
> I can't apply anything without Acks for *all* of the subsystems above.

Well, there are cases when you can. Those should be exceptions and well
justified, of course.

> My suggestion would be to collect the Acks you've received up until
> this point and identify which SS's are still lacking in change log
> section of a RESEND.

I agree, though, that I can try a second round to get the acks.


--lv6drd3t7p4u6slo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmRYrkACgkQFA3kzBSg
KbZSwQ//SXeJiriQ1JXWeiiNv7W8RZlZDMhcZP2Y8iTfn2czEvOrh2tQ5RRPqzm5
tlAk7TjAmnnH+rRlRNNgJRtIoiDc9fDr3VPP6/5IXlKgq2P/ghEUHLei/Efgfae+
FByJTP7rbAtDZBfSsKVIhrCs8ut7pok4JrSIIKlAFbvz5jHe/acUchycFkd2IazJ
Xisflk0KWbWNpyFN/W+zlovipFi/DTI+ELNjRGENwtjnznFKTZRdTxGTYOg4pN9t
8MlaKBYwcobZ3hj6YO2gs0DZjdN8nftSk6Gi/JYoPhNhA1dpQ6tND/Z5VvJtvJxS
21E0ywdIMT7ELa5kDBA1MgL/TZZO4jG7/RdQtVOjOlB9GBmtrsrhRn9ETZmlT7kj
lh+D+gGkXigqldLUTKT7kJ3kLUjAhyfj75vAqJv+NMrgc9hALFDJUAhYk3LJsyUX
wHNt/+nRLhaHrLWcsY0spd35XAm9HAMxnofVqsyI9Tb98K+5nHh0D5ta3VlW5xrJ
HXTmYjoObJbP64EMx56As6FF5sjuGZ4MqI209FOiw1+6Ri0XMHmOxThMyBIRbBZk
HN1XZgoQ4yH3GpROpWEE278X7HrTiX2sujJ/8DfP6juca5tY7lUxf01w1ar40FMY
uWpd7+w0pyLmgqtS0S38XFy0+1l4JY2ybyfUbmx3xnDGLZd4gdE=
=TZvd
-----END PGP SIGNATURE-----

--lv6drd3t7p4u6slo--
