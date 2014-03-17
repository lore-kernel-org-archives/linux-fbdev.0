From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 17 Mar 2014 11:23:39 +0000
Subject: Re: [PATCH v2] RFC: framebuffer: provide generic get_fb_unmapped_area
Message-Id: <5326DB3B.1080409@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="OPMSqnEKGWtWFuXEuuqTBPeHukltGlo15"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1391447684-22556-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1391447684-22556-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-fbdev@vger.kernel.org

--OPMSqnEKGWtWFuXEuuqTBPeHukltGlo15
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 03/02/14 19:14, Uwe Kleine-K=C3=B6nig wrote:
> This patch makes mmapping the simple-framebuffer device work on a no-MM=
U
> ARM target. The code is mostly taken from
> arch/blackfin/kernel/sys_bfin.c.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> note this is only tested on this no-MMU machine and I don't know enough=

> about framebuffers and mm to decide if this patch is sane. Also I'm
> a bit unsure about the size check, I just believed Geert that
> PAGE_ALIGN(info->fix.smem_len) is the right value to check against.

I don't know enough about mm to say much here, and the text above make
me feel a bit uneasy. I'd be happy if this would get a few
acks/reviewed-bys/tested-bys...

So what does this patch actually do? If I read things correctly,
currently .get_unmapped_area is null, except for sparc and blackfin. But
userspace's mmap() calls that, right? Is there a default implementation
somewhere? Why is that different for no-MMU case?

 Tomi



--OPMSqnEKGWtWFuXEuuqTBPeHukltGlo15
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTJts7AAoJEPo9qoy8lh71LWEP/RNFlRNTaQdBXqvZG/xPTez/
QHph4Wquc0kY4VSuCUF8ldLfhGuDPsR+fVeceH/a2Gk4V3dppnp//yYWuqhNff/u
MbViuq1D3W1RDtHksfQTZPJ9mfBoNWqB0QiXxlunCbOVUEBbo8b559bhStiqxa1z
Bc1ReZVM+t68KQR1Mfs1zDoj0/+taxu2g6OhcSDwSJs3vIT+rWM4nROKN8+eYjrF
XcvLfVT8Gi+fn2gI5zbUhnx2ccFapaGbArZPyavZUqLo8nOjV6I7UPNePrH6CKxK
Ta+K4P/5x4iU7c2i/rITgcuaGXzP/Ng5TtFjL3OSw5xZ6jEpbYh/IhTABIJWQPP9
qX6oDPw2Fxej11XFzjya+rrtPYeeqH1wJPu2SaVlDN8xMeJvdW/WX19gakBFMhAF
bqjqbyF5bEwuFrM64Q/XqAz/EknLqKUIIl0wVowvoCwZrm5ygIcfKvH3c5nN3uva
SO72bxtXuDkDk7Ecth7n2p2FxH3vE7/V4Z8a9Oir0RDQ/4V8rY/57IzqwzdUbO1P
3PZ6FDxc91q8DutpyHg6XFVhLfyu3YQZAjR+L0sqVDaehw1Zk1OIdEAV/3G4lGPP
z4zoA2lVMvYErTpYXCQ9GrnV99pIwpJbWCrbqdfdaZqMl5ZYgIPTeruDPJT+0bLe
qnF1Xca8NLVYqDtAYXqY
=mbJ4
-----END PGP SIGNATURE-----

--OPMSqnEKGWtWFuXEuuqTBPeHukltGlo15--
