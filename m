From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 26 Nov 2013 14:58:20 +0000
Subject: Re: [PATCH -v2] fbdev: sh_mobile_meram: Fix defined but not used compiler warnings
Message-Id: <1510041.WqZSiK0jXs@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart2907014.2EEeaJxgLB"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1383728247-19294-1-git-send-email-geert@linux-m68k.org>
 <5204468.CmggZzW3kO@avalon> <5294B3B9.3090104@ti.com>
In-Reply-To: <5294B3B9.3090104@ti.com>
To: linux-arm-kernel@lists.infradead.org


--nextPart2907014.2EEeaJxgLB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Tomi,

On Tuesday 26 November 2013 16:44:09 Tomi Valkeinen wrote:
> On 2013-11-06 13:57, Laurent Pinchart wrote:
> > On Wednesday 06 November 2013 09:57:27 Geert Uytterhoeven wrote:
> >> If both CONFIG_PM_SLEEP and CONFIG_PM_RUNTIME are not set:
> >>=20
> >> drivers/video/sh_mobile_meram.c:573: warning: =E2=80=98sh_mobile_m=
eram_suspend=E2=80=99
> >> defined but not used drivers/video/sh_mobile_meram.c:597: warning:=

> >> =E2=80=98sh_mobile_meram_resume=E2=80=99 defined but not used
> >>=20
> >> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >=20
> > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >=20
> > and applied to my tree.
>=20
> What does that mean? Are you collecting sh_mobile video patches?
>=20
> Or to rephrase, shall I apply this to fbdev fixes tree?

I was planning to send you a pull request for that, but if you can pick=
 it up=20
that's even easier, thanks.

--=20
Regards,

Laurent Pinchart

--nextPart2907014.2EEeaJxgLB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSlLcRAAoJEIkPb2GL7hl1yqYIAIcYh/iNMs9nHvUd13lmnIio
NU8TdHocRih+uR4qB3lOf20Qb1O55x7UGGGHJqzpiFqNxz5GSRGTbQjh9r+V8C0I
/OfVCP93MLaOxTOYP8PxYwOyp3tsAHkJ1myplVhsB0idvudL0BgMFLURB1hgxMYz
2xhRbTq0Jx194xDQJlVwprOFmbsAlizi+D4ts9WeqMQ0NDu/6oxYKx3RpNw91luF
vXuV8A8B5E4ToEOzrS31yOrruXqX/y3pMVSeoqKydGswtFImJnVCaHkymGlWoz2r
FTgJe4uiz1df+pdA+nyGdKOjB7itsa6UTYv+WKWY0jLbpMe5TqgMQZhpaF++O54=
=UWRP
-----END PGP SIGNATURE-----

--nextPart2907014.2EEeaJxgLB--

