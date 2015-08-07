From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 07 Aug 2015 10:38:23 +0000
Subject: Re: [PATCH 1/2] OMAPDSS: dss-of: Fix node refcount leak in omapdss_of_get_next_port()
Message-Id: <55C48A9F.2080505@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="oPsRF1kXvUX0Fq5TNeGxB5ABbt1KUALEG"
List-Id: <linux-fbdev.vger.kernel.org>
References: <2641bae47b15795f2a697e69c72ad1b7424d2178.1438885638.git.jsarha@ti.com>
In-Reply-To: <2641bae47b15795f2a697e69c72ad1b7424d2178.1438885638.git.jsarha@ti.com>
To: linux-fbdev@vger.kernel.org

--oPsRF1kXvUX0Fq5TNeGxB5ABbt1KUALEG
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 06/08/15 21:41, Jyri Sarha wrote:
> Signed-off-by: Jyri Sarha <jsarha@ti.com>

Please always fill in the patch description. In simplest cases it may be
the same as in the subject.

> ---
>  drivers/video/fbdev/omap2/dss/dss-of.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/video/fbdev/omap2/dss/dss-of.c b/drivers/video/fbd=
ev/omap2/dss/dss-of.c
> index 928ee63..ab6ef16 100644
> --- a/drivers/video/fbdev/omap2/dss/dss-of.c
> +++ b/drivers/video/fbdev/omap2/dss/dss-of.c
> @@ -60,6 +60,7 @@ omapdss_of_get_next_port(const struct device_node *pa=
rent,
>  			}
>  			prev =3D port;
>  		} while (of_node_cmp(port->name, "port") !=3D 0);
> +		of_node_put(ports);

I think a blank line is needed above of_node_put().

 Tomi


--oPsRF1kXvUX0Fq5TNeGxB5ABbt1KUALEG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVxIqfAAoJEPo9qoy8lh71UVcP/2uAgLcxx04d/+2FomWcJ47G
8Enz17SbahQD51uxpn0fe3KZrurDiRJpYTcw08Syom9FK9lB3Aew8j81SQKfIwOD
VvdgOelDsXEH19FVo7XnoHw4MsRfAGcxrIJExpchh8uib2hD0mDTAEwEn3sXtRNe
cJry484HyYcXBQq+T2e5vsO1w5y3BYxjx0v/Q1Tln9paaUvc/V1rQv5tYBBivrhj
uFd23g1d0q+21WCACYDW70P9iEZV2Qviztg6rLCrgvAtv5pFM9xJIT+2gMxj97Qe
c/XR4k8vgWwxcDX751pMyWMSedm3ug9Lgw5GqK6egJj8WoVoD+F2UtABwOlLCSV5
RL9qtdd1l5fdxuSOqeDkmlEMGplV1BPm/UwsSJYKO1rOV8cTcT9A3jmHulniiD5o
purqlx6tVDURMrrfn6xfiWHb9g3dKWrEHB5Zk118RPekTQ0znsoH8Ti1uHE1tYO1
9a8b/vtjrC8VGnzLAqxz0krqgDyma6MLrP5ZLua9HG21bJF/ULe98xO8fG8NBiI2
Dngj371gE9qvLEW1rVsRdAqn4VQ4iaHcg2ceDNLOH+Macte2AJfEm+zRT82lZqqa
ud0j6wkPIcPT+9STCeUmODAb2a7rvKCOJDfUx6f+twfPTwRgZQUmFnlPH+BZ2Dgi
HKOH7+OQCmVPY8IN1ByA
=UB8w
-----END PGP SIGNATURE-----

--oPsRF1kXvUX0Fq5TNeGxB5ABbt1KUALEG--
