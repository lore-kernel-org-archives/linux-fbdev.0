From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Thu, 13 Nov 2014 10:45:20 +0000
Subject: Re: [PATCH v2 1/4] dt-bindings: simplefb: Specify node location and handoff related properties
Message-Id: <20141113104520.GG20972@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="S5HS5MvDw4DmbRmb"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415868610-13297-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1415868610-13297-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org


--S5HS5MvDw4DmbRmb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2014 at 09:50:07AM +0100, Hans de Goede wrote:
> Since simplefb nodes do not relate directly to hw typically they have been
> placed in the root of the devicetree. As the represent runtime information
> having them as sub-nodes of /chosen is more logical, specify this.
>=20
> Also specify when to set the chosen stdout-path property to a simplefb no=
de.
>=20
> For reliable handover to a hardware specific driver, that driver needs to
> know which simplefb to unregister when taking over, specify how the hw dr=
iver
> can find the matching simplefb node.
>=20
> Last add some advice on how to fill and use simplefb nodes from a firmware
> pov.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--S5HS5MvDw4DmbRmb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZIvAAAoJEBx+YmzsjxAgAswQAKTKad6EYIpFwIe06o7tOisF
zrq4r7vcSxyp5LRB/qHUIU2kQQGaL4C3hMI+jItEPmqttaFdmt4a7pquGuRtmq/y
X+t0fpEL8gfdhL3xj14GVLZAqzA0xaEO1X8h0kqEw3kCP2QfyP3n0t33yELBmX3m
9dE5nUJqgwKoQSxub/TpBWkDblLGZ/0S+dNfr6vbV0PXIr0j0UyD+6JPFODCo9Fb
41NAChpygoWwWnk6WhFCFm0kgdISZexhtqFUp1wtph4LKMMVvS6/E5/s6lYGa8Hv
alKsVJijmZelqWn10MDlGjskeik82WHSnJ6Mlu59gqxnf0Q8PtzVqFfEavCrwMyV
LvzwoxsvCXCq7WwR/sWKSj5WuA/O1N7+cXDTczOv4aNtId8Z9kPfRlj6V1yDIl9f
4cNHBv3Je9woVshyvOs38fGVmq+NmGPD0chxEAqCc/hDjG8YSAqSaXAMP9PbPoba
jAJniVV4BuSsWMmaIEESn3KF6BgiNTM9a+NXz05+t/ArTXLAUhWlJ5loqYc2sGNZ
JVvS1GGdJ+MYOb48XngXSQUOqtHnYYcWCCt+xhUjSrEff8Dt3NLSw8CDq5gR9QbV
Gugq892Jm9G8ttas3LCnshhrTIklo8ObCnYu8rHHEb1sM3Irp87GxQzAphCHNS4H
1jqDXfTZkl07Ae+eV2xY
=7MD5
-----END PGP SIGNATURE-----

--S5HS5MvDw4DmbRmb--
