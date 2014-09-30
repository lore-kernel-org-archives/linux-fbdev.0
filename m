From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 30 Sep 2014 11:40:47 +0000
Subject: Re: [PATCH 1/2] video/fbdev: Always built-in video= cmdline parsing
Message-Id: <542A96BF.7080303@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="FLXT3PtAa0IOEf04pup66FHTUOn65M1ns"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407312512-6533-1-git-send-email-daniel.vetter@ffwll.ch>
 <1407329562-10832-1-git-send-email-daniel.vetter@ffwll.ch>
In-Reply-To: <1407329562-10832-1-git-send-email-daniel.vetter@ffwll.ch>
To: Daniel Vetter <daniel.vetter@ffwll.ch>, DRI Development <dri-devel@lists.freedesktop.org>
Cc: Plagniol-Villard <plagnioj@jcrosoft.com>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev@vger.kernel.org

--FLXT3PtAa0IOEf04pup66FHTUOn65M1ns
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 06/08/14 15:52, Daniel Vetter wrote:
> In drm/i915 we want to get at the video=3D cmdline modes even when we
> don't have fbdev support enabled, so that users can always override
> the kernel's initial mode selection.
>=20
> But that gives us a direct depency upon the parsing code in the fbdev
> subsystem. Since it's so little code just extract these 2 functions
> and always build them in.
>=20
> Whiel at it fix the checkpatch fail in this code.
>=20
> v2: Also move fb_mode_option. Spotted by the kbuild.
>=20
> v3: Review from Geert:
> - Keep the old copyright notice from fb_mem.c, although I have no
> idea what exactly applies.
> - Only compile this when needed.
>=20
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>=20
> --
>=20
> I prefer if we can merge this through drm-next since we'll use it
> there in follow-up patches.
> -Daniel
> ---
>  drivers/video/fbdev/Kconfig           |   4 ++
>  drivers/video/fbdev/core/Makefile     |   1 +
>  drivers/video/fbdev/core/fb_cmdline.c | 110 ++++++++++++++++++++++++++=
++++++++
>  drivers/video/fbdev/core/fbmem.c      |  92 --------------------------=
--
>  drivers/video/fbdev/core/modedb.c     |   3 -
>  5 files changed, 115 insertions(+), 95 deletions(-)
>  create mode 100644 drivers/video/fbdev/core/fb_cmdline.c

Sorry for late response.

Looks fine for me, and I'm fine merging it via drm-next.

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi



--FLXT3PtAa0IOEf04pup66FHTUOn65M1ns
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUKpa/AAoJEPo9qoy8lh71He0P/31yfZe15u4KlFhqOsxpvevt
9WMLudfj6xDq1CnKy7/cQU7yEHrSQJImieUoziiqSccWZUafdJlB1cejLlgFwTef
UUDilu3uMgVz7CnSaz0di28NpHIyKYomB73zjNLVVeR4XASlaQvhnmGtGXNLIBAt
v27IlITMYzY8IYl9pcABdHSqkucro8BpvtGCcfs0HVsP5nRajzjNkvoteLedxz4f
M79EAIv1qCGg+B5NMkQieuIRRbSZKlV20axrp7ng0kBP7/zN8BOFZrN4UW8JaJ/j
eB2GPL1vnhv4UkTviGCx6E9ywqh3nCgpVum49rf/EKaxiLcw85kYXPiqIMfk+IkP
Fcm+qTPcsvNFRh7YiqaAQK/Jylc1VwDTQwG2dnOvrkxT8kWSEtaPHaBhlKCQrK0k
G5/PFmQCzFH7joFtbO/rUcPZKh7mMJ36JVSRWkXn8BFzsMN9OyWgoBdJKDKPq0qg
c9gaUh1mt/sRopuGli/7RPdBET00j76TfScOHq+SL2d7R2Nywad4FqiHdQrPG+RP
bDlpDg1/07OQrq0iv1MHtzrYdPT3uHfISMmQRXC9L908PyVxkiNTnsuoSVFLgQwB
262Dd9mOoDSDL5rRgIWIydmbspQC/ZE0+5KJmVcq54swfazgZM/QkZJYD7k4NokO
LbhIDhmKZ+t2cdihB+YE
=/KeK
-----END PGP SIGNATURE-----

--FLXT3PtAa0IOEf04pup66FHTUOn65M1ns--
