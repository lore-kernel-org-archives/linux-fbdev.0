From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 20 Jan 2014 11:21:47 +0000
Subject: Re: [PATCH 13/15] fbdev: sh-mobile-lcdcfb: Enable driver compilation with COMPILE_TEST
Message-Id: <52DD06CB.8050606@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="StNpavP0Rwj5439tA1NDhpBbNj2xLeAUk"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <52CD0CBB.3070801@ti.com> <52D8F14A.7030100@ti.com>
 <22423852.GiH1NBjiii@avalon>
In-Reply-To: <22423852.GiH1NBjiii@avalon>
To: linux-arm-kernel@lists.infradead.org

--StNpavP0Rwj5439tA1NDhpBbNj2xLeAUk
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2014-01-19 23:01, Laurent Pinchart wrote:
> Hi Tomi,

> The lcdc driver can be compiled without meram support. This is handled =
by=20
> conditional compilation in include/video/sh_mobile_meram.h that defines=
 the=20
> meram functions as stubs when meram support isn't selected.
>=20
> The problem comes from the combination of FB_SH_MOBILE_MERAM=3Dm and=20
> FB_SH_MOBILE_LCDC=3Dy. The former makes the meram function non-stubs, w=
hile the=20
> later makes the LCDC driver fail to link, as meram support is then comp=
iled as=20
> a module.
>=20
> How do you usually handle this ?

I guess the easiest option is to make FB_SH_MOBILE_MERAM a bool, instead
of tristate.

 Tomi



--StNpavP0Rwj5439tA1NDhpBbNj2xLeAUk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS3QbLAAoJEPo9qoy8lh713VkP/RbIJ5AooeQ6lOZDRZO9sWub
XfjH6K2auApkr3k1/d7LCND/hp6KR58r4S8+3O9zvs3j8TtuSQ+zp9Et1/Ey6TlY
wemoS1rSHE+T+wu38rCUlFVPjR1lOqKF5d4oIvjCozVzyjrzzp+ph3pUo0yOJdv6
VuQoPJLPBH/fUAtpoUBRr0kNVMI3l06mEU37Y8ZsjZ2i0UXa3IcMqWSGlWYwhJbB
PPeW5mEarHoNL6TVz6JjoNQSGzE3cITCVNZ0q7e/0/K+3lbP08n1qxCRLy5ATSDn
/MWsVK1ZVYLkleohohijSjstJK3VOfwmXRE3shN8LZnTCRKAqPqb+LpcExzB6/h4
k/3bhJjBkJOuO3asgA3S6/aaHz3b7CrbMG3ytaJciCzDzdabW4G4vsZ5f9/nPY9T
NNuMdxxgroWCIJ6uWLtSMO2nAr4ylpyURdAT64kPwYM7Zk47JbRtMlHHLYj0rREs
/z0oeMmX+zN/NniS5L3xH7DtBozzj01hRY+NGHs4oOBV+Hmrx/aD1JhxPjRvJtOJ
LVLLrHDqqXXM+c0Lic+gQde/23LcOnhe6EiQbWBoVCab8ddCBkFljBsGz0uDvdDH
nGm1jUw1uEe+T7HjZSnmG0A8C8qxyZLbwBTKw1CgKBY1hX7uffA8z/hRRAi9bRfn
Ff2DuHuwKaAoI0uxuzKU
=Scoq
-----END PGP SIGNATURE-----

--StNpavP0Rwj5439tA1NDhpBbNj2xLeAUk--
