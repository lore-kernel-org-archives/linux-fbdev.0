From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 10 Aug 2015 09:23:21 +0000
Subject: Re: [PATCH v2 0/2] OMAPDSS: Fix of-node refcount issues
Message-Id: <55C86D89.4090806@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="mwtFIl0SFUmRcUTs1MEPWmj2rnxvH0J1v"
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1438945255.git.jsarha@ti.com>
In-Reply-To: <cover.1438945255.git.jsarha@ti.com>
To: linux-fbdev@vger.kernel.org

--mwtFIl0SFUmRcUTs1MEPWmj2rnxvH0J1v
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 07/08/15 14:04, Jyri Sarha wrote:
> Changes since the first version:
> - Fix commit descriptions and subject according to Tomi's comments
>=20
> I found couple of refcounting issues related to OMAP DSS of-node
> handling. Second patch should fix the "ERROR: Bad of_node_put() on
> /encoder@0/ports/port@1" -problem.
>=20
> In the long run it would make sense start using of_graph_*() functions
> in OMAP DSS too. However the semantics of of_graph_*() functions are
> quite different from omapdss_of_*() counterparts. So it better to just
> fix these bugs first.
>=20
> Jyri Sarha (2):
>   OMAPDSS: Fix node refcount leak in omapdss_of_get_next_port()
>   OMAPDSS: Fix omap_dss_find_output_by_port_node() port refcount
>     decrement
>=20
>  drivers/video/fbdev/omap2/dss/dss-of.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks, I've picked these up for 4.2 fixes.

 Tomi


--mwtFIl0SFUmRcUTs1MEPWmj2rnxvH0J1v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVyG2KAAoJEPo9qoy8lh71CqEP/RsX9DDKzzmkc0AkQOUuUvA1
OjmHneVCFVx95PMcxEylMto6SJu5rnk39GfrmipiM4Gr0OTJapt/eO/PcaOmxIu7
ZRlKYWFmyDsgvWDjAT9KPVyzN4OClk6wGxL1ffOd7ag8TXd+vdHJMcl5/uC5v7N5
yR36hRLD0pMp/nyXvoFhAGH+jE1enUnYNSb48kx6i4nPLyvURxMYexh8eD2A74Zl
u2YgsZEat5mB9jRCW91OQMccQ44LnVtf/i42On2sehJVGGCSc/jzTLeEacn1Khjq
rAHkAVwswfmvjzOopb2cSm4Xpus721qh/tL8BhpN4ZP7S4IBKou9XDhG4Ck9LWXu
pTaYwpvClR1hz2L6fW2bgByTs9YIMUZbFuKmAAgbcXhMwIqCHpqftI1Js/1zWYFv
i2RBIWxVyLfKtZak8yg6ZYVlH4eHWiavMEXb0y24HTlouhX5l7TwSTX9bquTYhFk
63ie68j9F7stC9D5qeqmH4SaAvX1I2pmpQONo+q01GKQ9Lxe7C7AOXoAiCYcB+ll
Doeg18EE5pwNlXj/vWijKxWrztf1qWiv7zG/9sDyaH1vtRApgrZVRrkxPGZXa0Ti
028/yg1KDXgAx54a0BByoNngECV+P5eGm9SnrTECW2jfyCoGXdjEfg3OdECv8fzX
/P0o8HjLQPxpnH07BEDW
=feKa
-----END PGP SIGNATURE-----

--mwtFIl0SFUmRcUTs1MEPWmj2rnxvH0J1v--
