From: Marcelo Ramos <mramos@montevideo.com.uy>
Subject: Re: pm2fb fixes
Date: Wed, 21 Apr 2004 01:51:18 -0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040421015118.2caa6e99@zerocool>
References: <XFMail.20040421004644.jim.hague@acm.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__21_Apr_2004_01_51_18_-0300_AOs2af=h0CF_tYXS"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BG9m4-0005wG-2A
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Apr 2004 21:55:52 -0700
Received: from r200-40-228-146.adinet.com.uy ([200.40.228.146] helo=mx2.montevideo.com.uy)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BG9m3-0004Ve-BY
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Apr 2004 21:55:51 -0700
In-Reply-To: <XFMail.20040421004644.jim.hague@acm.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net

--Signature=_Wed__21_Apr_2004_01_51_18_-0300_AOs2af=h0CF_tYXS
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

El (On) Wed, 21 Apr 2004 00:46:44 +0100 (BST)
Jim Hague <jim.hague@acm.org> escribi=F3 (wrote):

> The conversion of pm2fb to using framebuffer_alloc() introduced a null po=
inter
> dereference bug.
>=20
> This patch fixes this bug, and a silly problem in pm2fb_blank(). There's =
also
> some minor tidying.
>=20
> The patch is against 2.6.6-rc1.

I applied the patch and now the kernel oops is gone. How can I change the
resolution? If I don't specify the mode then i get 640x480-60 but if i use
video=3Dpm2fb:mode:1024x768 (or any other resolution) I get 640x400-70. am I
passing the driver the argument with a wrong format?

TIA

--=20
 _____________________________________________________________
                                        _____  ____________
  Marcelo Ramos                        |     \/      __    |
  Fedora Core 1 | Linux 2.6.5          |            |_/    /
  Socio UYLUG Nro 125                  |                   \
  Linux registered user #118109        |____|\/|____|\______\

--Signature=_Wed__21_Apr_2004_01_51_18_-0300_AOs2af=h0CF_tYXS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAhf3MKHiVwzS5rpkRAjmmAJ9eDZerw4onncJXY4+4KTvzYvDU+gCeLCjo
Orklr5Qh/DvkGv8DLTJVecU=
=32vf
-----END PGP SIGNATURE-----

--Signature=_Wed__21_Apr_2004_01_51_18_-0300_AOs2af=h0CF_tYXS--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
