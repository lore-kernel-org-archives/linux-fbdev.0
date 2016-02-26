From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 26 Feb 2016 11:15:55 +0000
Subject: Re: [PATCH 0/7] PMAG-AA frame buffer driver rework
Message-Id: <56D033EB.7010506@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9gwIag0MJ8rRs23O8McvFxIKNhf90wowf"
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LFD.2.20.1602220110330.7431@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.20.1602220110330.7431@eddie.linux-mips.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--9gwIag0MJ8rRs23O8McvFxIKNhf90wowf
Content-Type: multipart/mixed; boundary="C8qRAUQkEexOBKDbvObTje6kCHDVWgHdo"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: "Maciej W. Rozycki" <macro@linux-mips.org>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <56D033EB.7010506@ti.com>
Subject: Re: [PATCH 0/7] PMAG-AA frame buffer driver rework
References: <alpine.LFD.2.20.1602220110330.7431@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.20.1602220110330.7431@eddie.linux-mips.org>

--C8qRAUQkEexOBKDbvObTje6kCHDVWgHdo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22/02/16 03:54, Maciej W. Rozycki wrote:
> Hi,
>=20
>  This is an update to the PMAG-AA frame buffer driver to adapt it to ou=
r=20
> current APIs, which I promised a while ago (too much of a while, which =
I=20
> apologise for).

Interesting hardware. I like the names of these things. "Monolithic CMOS
64 x 64 Pixel Cursor Generator", "TURBOchannel Color Frame Buffer".

Also interesting to see the git history of a file going almost directly
to the initial git commit.

Thanks, queued for 4.6.

 Tomi


--C8qRAUQkEexOBKDbvObTje6kCHDVWgHdo--

--9gwIag0MJ8rRs23O8McvFxIKNhf90wowf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW0DPsAAoJEPo9qoy8lh71r/EQAJgA5dhgU8o+j0yd8sOJuOfc
T8+D/BlIzGrDPuxA8tucEfvIdD58Q0YK4432tAb/17Ras1rtfmsjPV4w8gaK1n4w
PwRspC6jZSad7faxsn4Q9XbnduorY95qYS4v5ASMguugCRQW+SenCut/5pi/H8jL
W6Bdv3EWCUbADclloJTW/jnGQGR8XgyiXb4ceREfeQ3fnQDUGVAHQVUcvwNqfT+6
pNDSVirnDCnPJAM41kzzTHF8+yl1aUvFft6v2QNWxUAC2RyydkVJgTsQZhij/hqD
fvu4Ltk2NJj16ZfLpf8zxjbzebQLQZS0SbPfyUpgjV+2Wzo/VUKldrkapv3Lk12a
YIa4Z+40lHTTWr2wCWjD8rsdIAIbhr0IFQi3avZFyedZBUeJZZEKkVwY5DSUtJTr
tpWy0PKn8nNwYq+OZ/enSxJVx2+Z3tTT6lt55lqOl6xr9IkBljmNh/XrUKs+uEY1
LaNKpeN5az4j09zktMZMz/6MCGv8HhTLlELA0Zm+oxaNFB3eF+mCi4XTRS1TE7bt
4+EAguDbCTqAx2KCiwKaovkAA9XkpARJnGL75y12oMxWrG4ZrfUger2Mu0cDX6vs
ZxVeuBSNxro5tB60JqbMvmuCRE1UosRzsvGrjrLX6JiS/CFjTSjgUZu1eXUP5DmZ
3Xsaa3XcvAAKM1g5q/J2
=1o8c
-----END PGP SIGNATURE-----

--9gwIag0MJ8rRs23O8McvFxIKNhf90wowf--
