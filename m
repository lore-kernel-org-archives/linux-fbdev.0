From: jhf@rivenstone.net (Joseph Fannin)
Subject: Re: [Linux-fbdev-devel] fbdev broken in current bk for PPC
Date: Sun, 12 Sep 2004 21:52:59 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040913015259.GA2784@samarkand.rivenstone.net>
References: <1094783022.2667.106.camel@gaston> <200409110504.09812.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S264903AbUIMBxQ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200409110504.09812.adaplas@hotpop.com>
List-Id: <fbdev-devel.lists.sourceforge.net
To: adaplas@pol.net
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 11, 2004 at 05:04:09AM +0800, Antonino A. Daplas wrote:

> Hi Ben,
>=20
> How about this patch?  This brings back the old way of setting up the
> drivers, supports:
>=20
> video=3Dxxxfb:off
> video=3Dofonly
>=20
> Your patch that brings offb to the very last of the Makefile is needed.

    Applying these two patches to 2.6.9-rc1-mm4 makes the framebuffer
console on my Powermac work again.  This box has an ATI RAGE chip on
the motherboard I don't often use, so being able to do video=3Datyfb:off
lets me keep the driver around -- thanks!

--=20
Joseph Fannin
jhf@rivenstone.net

"Bull in pure form is rare; there is usually some contamination by data."
    -- William Graves Perry Jr.

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBRP17Wv4KsgKfSVgRAiBvAJ9PZsqswnU2qZcSswuFTCtP34xVdgCbBDy7
R3KHXHIXTVgwLj6JgcRtWzI=
=vn3H
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
