From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 13 Jan 2015 12:55:46 +0000
Subject: Re: [PATCH resend] console/dummy: Move screen size selection from CPP to Kconfig
Message-Id: <54B515D2.3050303@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="R486RKaKwCbvHdB40ngKKcregjOWIFRJV"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1421093822-26761-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1421093822-26761-1-git-send-email-geert@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--R486RKaKwCbvHdB40ngKKcregjOWIFRJV
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 12/01/15 22:17, Geert Uytterhoeven wrote:
> PA-RISC already handled the dummy console screen size selection in
> Kconfig, so generalize this to other platforms.
>=20
> ARM keeps on using screen_info, which is filled in by
> platform-specific code, or from ATAGS.

Thanks, queued for 3.20.

 Tomi



--R486RKaKwCbvHdB40ngKKcregjOWIFRJV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtRXSAAoJEPo9qoy8lh71jZIP/2Nhn5kO4Tk1hr5EJjdw0aJS
+T8GAP/meAcaE58VEUmv6TcZ8WbPU7r4RZRK+NT5eaNw6fa2QFq8+RR2rhHpvlru
LBzzGi5/i+r/5KRmMj9/AlbCWz6W5ANc+fgBLvfPadhOBIcTo1FzvN8iVs/8cXel
dhXgMTRDaMYu2bb7BFiinO5dfPbm4FNML+WfxypokmfANzfdLI+gMWO3N98+mGib
LHrEMX58KyiZoLzIapEz0FoWesz81sjEbqfqEToYvclL/mKEB+/u8jHhJNv9Uizn
mIUBLzigvkYLxOdc+HFuOI/u59+0UfmmU6kUbvYLqml5YxSZ0kq4p1Dkvp5W6rfU
0hym+dcULxPnzZSW35UohEWpzUd9mhpAn2DoodzQclTmRBhpQiQikXebKGFiGLJA
ivXQ6Bre55xrB/s5ySvYTiTzHua7JlmAr6iu1XrP4PWulof/cG5MletOFGB5GTdR
uDxGs11R6K8FaXABElLeCcvnp+NZX4gFgdwSu+C3tww9cAXHjNUER1lI4SGuDiFo
+ceWwE5uPywjo3eaYJ9deFLYp3hgX1G17Pt1CAJY63S7/1iVyEy8+vaXwts/neO+
789ZugX1BYug2Gx4wLfp6poUkDfn6clZQXTfEcsAmvFO9v3p279879iPNTkomzl2
sqFHOTmg+MzRYsj0H79V
=sevE
-----END PGP SIGNATURE-----

--R486RKaKwCbvHdB40ngKKcregjOWIFRJV--
