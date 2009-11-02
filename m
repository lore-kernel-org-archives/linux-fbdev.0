From: Ondrej Zajicek <santiago@crfreenet.org>
Subject: Re: [PATCH] Add VirtIO Frame Buffer Support
Date: Mon, 2 Nov 2009 23:32:50 +0100
Message-ID: <20091102223249.GC22301@localhost>
References: <1257199759-2941-1-git-send-email-agraf@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5684835793160817040=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <santiago@crfreenet.org>) id 1N56Of-0001xl-VB
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 02 Nov 2009 23:33:13 +0000
Received: from smtp1.kolej.mff.cuni.cz ([78.128.192.10])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N56OZ-0001wB-Bg
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 02 Nov 2009 23:33:13 +0000
In-Reply-To: <1257199759-2941-1-git-send-email-agraf@suse.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Alexander Graf <agraf@suse.de>
Cc: linux-fbdev-devel@lists.sourceforge.net


--===============5684835793160817040==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vOmOzSkFvhd7u8Ms"
Content-Disposition: inline


--vOmOzSkFvhd7u8Ms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2009 at 11:09:19PM +0100, Alexander Graf wrote:
> When we want to create a full VirtIO based machine, we're still missing
> graphics output. Fortunately, Linux provides us with most of the framewor=
ks
> to render text and everything, we only need to implement a transport.
>=20
> So this is a frame buffer backend written for VirtIO. Using this and my
> patch to qemu, you can use paravirtualized graphics.

Just a note: it might be useful to allow paravirtualized graphics to
handle text mode. In that case, it can be done in fbdev layer using
tileblit operations.

--=20
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@crfreenet.org)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

--vOmOzSkFvhd7u8Ms
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrvXhEACgkQw1GB2RHercNV1gCcD8j01t5Yy6h9vJPwNsKA7yuk
rOYAnA5+Vlht1uFJRRx/E95mZ6Au0hzO
=/2lR
-----END PGP SIGNATURE-----

--vOmOzSkFvhd7u8Ms--


--===============5684835793160817040==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
--===============5684835793160817040==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============5684835793160817040==--
