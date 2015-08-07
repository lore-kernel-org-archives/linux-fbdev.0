From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 07 Aug 2015 10:49:12 +0000
Subject: Re: [PATCH 2/2] OMAPDSS: of-dss: omap_dss_find_output_by_port_node() keep port refcount
Message-Id: <55C48D28.8080905@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="pLoMLUf70oBXxS2A73XWGIVm3t0PKpurR"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1f1f0438904af54bcaadd6e1796dad06e7001172.1438885638.git.jsarha@ti.com>
In-Reply-To: <1f1f0438904af54bcaadd6e1796dad06e7001172.1438885638.git.jsarha@ti.com>
To: linux-fbdev@vger.kernel.org

--pLoMLUf70oBXxS2A73XWGIVm3t0PKpurR
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 06/08/15 21:41, Jyri Sarha wrote:
> The only user of dss_of_port_get_parent_device() function is
> omap_dss_find_output_by_port_node() and it assumes the refcount of the
> port parameter is not decremented by the call.
>=20

The subject of the patch should contain "dss-of", not "of-dss". Although
for both patches I think it's fine to use plain "OMAPDSS: " prefix. The
subject should also say "fix" or such.

The description above is kind of "detached". A patch description should
generally describe something in the lines of what the current behavior
is, what the problem is, and what the patch does. And the desc should be
independent of the subject.

This particular case is rather simple, and it's clear that
dss_of_port_get_parent_device() is not supposed to decrease the refcount
of the "port" parameter (as that kind of behavior is normally a special
case). And so it should be enough to say what the issue seen is and that
you fix the function to not decrement the parameter's refcount.

 Tomi


--pLoMLUf70oBXxS2A73XWGIVm3t0PKpurR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVxI0oAAoJEPo9qoy8lh710DIP/0Jl14KF15QNFhcUJiDqWVwU
k4msGGto3Tivy0bfFeEkkCvkm5W7TJq6t+Ae8hYHA8SlMwu0Bn+JkbBKjklavPYf
kXpysVPLOmZp87m9BbJiT4gXPXiT81KL1WZbX++K+lHzX/bsqBVx9gcS725fgK01
PLYfkbh278bMakMA10A1IIVNo9uu488qAQuLbLSUFp6zSqWBksmh5eZMSRshhtHs
/XKOXBb3Ea/qciJd3r8FoCIRGLywD2XD6o2NyNrRXJS4FKOqwveQCVqbkSlowwT4
cCI0KpOGKTWytRFmsnDceNDFf9yxvtu+0eUysAkza9HGYdSQbe1ThkRV13eGfk3I
gMDDvhYzZzJp6aMzlCZ4NSDR8vn0WT7tf2bb1BfQe41gkG3W7WCmLrHdpCKPhYxd
+9DUyOjhsdPUlCgMWIIE2uEq35x0NcZWuWWujL2gw7/yBA+xdNrkADqi+/Q6tzVv
SKaR5HnImE2NpfN+1II17TU1wxF3MDi8wTdsp+uyCkgiZW+/xVnIqB4f142KF26f
7hEAYYUwxl95J2TVSeE8fUPkY6nEFgKciZt1Qwk1qWH4OatwxtBEKu7cnlqO7luP
Fhxm3Tk2mvV6YhJgb84cx/s/uHcyd8tZifSvgr+nRBhCfsMOKJACiU6vSK9GPzgK
iyp+WaeowaH3EhqF9/cF
=ozE5
-----END PGP SIGNATURE-----

--pLoMLUf70oBXxS2A73XWGIVm3t0PKpurR--
