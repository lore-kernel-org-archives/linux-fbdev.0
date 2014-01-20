From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 20 Jan 2014 15:30:21 +0000
Subject: Re: [PATCH 13/15] fbdev: sh-mobile-lcdcfb: Enable driver compilation with COMPILE_TEST
Message-Id: <5189278.VEETF0BgjA@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart13766517.2z3GftTjSq"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <22423852.GiH1NBjiii@avalon> <52DD06CB.8050606@ti.com>
In-Reply-To: <52DD06CB.8050606@ti.com>
To: linux-arm-kernel@lists.infradead.org


--nextPart13766517.2z3GftTjSq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Tomi,

On Monday 20 January 2014 13:21:47 Tomi Valkeinen wrote:
> On 2014-01-19 23:01, Laurent Pinchart wrote:
> > Hi Tomi,
> > 
> > The lcdc driver can be compiled without meram support. This is handled by
> > conditional compilation in include/video/sh_mobile_meram.h that defines
> > the
> > meram functions as stubs when meram support isn't selected.
> > 
> > The problem comes from the combination of FB_SH_MOBILE_MERAM=m and
> > FB_SH_MOBILE_LCDC=y. The former makes the meram function non-stubs, while
> > the later makes the LCDC driver fail to link, as meram support is then
> > compiled as a module.
> > 
> > How do you usually handle this ?
> 
> I guess the easiest option is to make FB_SH_MOBILE_MERAM a bool, instead
> of tristate.

That's easy, but it would prevent meram support from being compiled as a 
module when lcdc support is compiled as a module as well.

-- 
Regards,

Laurent Pinchart

--nextPart13766517.2z3GftTjSq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJS3UETAAoJEIkPb2GL7hl1N0cIAK3CuBV2Skvj6Gv52A6C+Xmn
um31AZBSSbmGlp6FP1D6WcWjCtMRJfUQJWim81wxe8RnprmdHqvtkJsFCzhBmN2o
/t0FKilzX+IUQUzipvA/2hwFIqL2TtCsAS+ENmOLWI5ysFlnWwNEw1HBlGSzAmQK
FLhG4V+BkfZWLbXD/9d9oov+SNXvKFeP1ZkfyDvejVkHwIt5uxeFZdG9KEz4+BYg
5/0RuptQXNbh6ZzSbcF16wan4migfshAtdnruR6GQjYlEU+tNcwz6EsvVIUWNxk2
WlZuIGhKua2W/QBZFIY991czwhX9ZlF62jExY59K1LGtTnDMzW2Q2f8m/8tzmjY=
=+ZPH
-----END PGP SIGNATURE-----

--nextPart13766517.2z3GftTjSq--

