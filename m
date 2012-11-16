From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 16 Nov 2012 09:28:18 +0000
Subject: Re: [RFC] fbdev: arm has __raw I/O accessors, use them in fb.h
Message-Id: <50A60732.3050602@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enig2D5C6EE95D75CCB5A3CA0060"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353057364-21214-1-git-send-email-archit@ti.com>
In-Reply-To: <1353057364-21214-1-git-send-email-archit@ti.com>
To: linux-arm-kernel@lists.infradead.org

--------------enig2D5C6EE95D75CCB5A3CA0060
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-16 11:16, Archit Taneja wrote:
> This removes the sparse warnings on arm platforms:
>=20
> warning: cast removes address space of expression
>=20
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  include/linux/fb.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index c7a9571..7fce1e1 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -548,7 +548,7 @@ static inline struct apertures_struct *alloc_apertu=
res(unsigned int max_num) {
>  #define fb_memcpy_fromfb sbus_memcpy_fromio
>  #define fb_memcpy_tofb sbus_memcpy_toio
> =20
> -#elif defined(__i386__) || defined(__alpha__) || defined(__x86_64__) |=
| defined(__hppa__) || defined(__sh__) || defined(__powerpc__) || defined=
(__avr32__) || defined(__bfin__)
> +#elif defined(__i386__) || defined(__alpha__) || defined(__x86_64__) |=
| defined(__hppa__) || defined(__sh__) || defined(__powerpc__) || defined=
(__avr32__) || defined(__bfin__) || defined(__arm__)
> =20
>  #define fb_readb __raw_readb
>  #define fb_readw __raw_readw

Looks good and works for me:

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi



--------------enig2D5C6EE95D75CCB5A3CA0060
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQpgcyAAoJEPo9qoy8lh71h04P/jV9c68OY+dfdzG76Z8qJwxd
fcFvvpNMMadNXiHphcNku7sYGqWIY8cJ2HToAVdHIVRFxfkuTcps7bhqQs25ySAb
DRA/KuIbdKn1xKWf6NnrsZ4YTHxllZRyCRC+C2leagZ+eQV1dWSaGOnu7CpI1UPH
h84qCIe9E30iZBpoFUYzZy7m88wpPYHsK+gIqJzJAFZvWY4t9bqjeSzKlELeX+qG
9VrGgCayY5DzdgpDQf3cAK1RFEO/jkEKJfflSNbqBBMjwG0HAMHe0oR5JMj1SNQN
0gcpVnJTuVAsOLBBnfiLZ3nUk/ukfI2W7NoGeRT00Fyg2AOeY1649vQcawYIJs2L
1IjCkjLua9T8YZ+mriXZeZXO4kBOkPysf6sktP0dCez7bicSOMUvGxSzdKVJwErp
BrizvwLEmDe+xvbwK2slv/RPWfQGNOpHP0EMS8XgTmPaIGHAPNGd5y1OgQ55H7r8
J6lnpLrZlGp5/YQLfuoopCJfr+OzkJdtb30zLWyUWXqaie9ZTeZpldNXtVDj3mFc
RNhGkNtwV8eLVHzQPDxBedqXfoD+0/P/JqSjnfv9xS3B1z+BwBvJCLua7GMZUPmp
BDoL3y2htM7JQCVCJcEv3s7+UmkHSyC9Tw+Rq2Hfo640cgZVT+4s71e6cAoPf/4a
sZTGpTZg2iwiYFfNcWFH
=Ngdx
-----END PGP SIGNATURE-----

--------------enig2D5C6EE95D75CCB5A3CA0060--
