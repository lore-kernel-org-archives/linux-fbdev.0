From: Ondrej Zajicek <santiago@crfreenet.org>
Subject: Re: open and close semanthics
Date: Fri, 28 Aug 2009 14:22:56 +0200
Message-ID: <20090828122254.GB9848@localhost>
References: <4A946A59.20307@manoweb.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8943010850475281727=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <santiago@crfreenet.org>) id 1Mh3Xo-0008Dl-CJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Aug 2009 15:39:16 +0000
Received: from gateway.crfreenet.org ([81.92.146.254] helo=mail.crfreenet.org)
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mh0Vf-0005s6-Ug
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Aug 2009 12:24:57 +0000
In-Reply-To: <4A946A59.20307@manoweb.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Alessio Sangalli <alesan@manoweb.com>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>


--===============8943010850475281727==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2009 at 03:48:57PM -0700, Alessio Sangalli wrote:
> Hi, can somebody give me an authoritative answer:
> what is the semanthics associated to the "open" and "release" (close) cal=
ls?
>=20
> More specifically, "open" and "release" can/must/must not change any=20
> setting (resolution etc)?

Many drivers for non-embedded (VGA compatible) cards assume that they
should not touch hardware if their device is not open. So they configure
device during the first open and restore original state during the
last close. The framebuffer console counts as one user, and therefore
keeps the device configured.

--=20
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@crfreenet.org)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqXzB4ACgkQw1GB2RHercNGQwCfTYXmHeTkY/MTOqaTKxa3CPGE
1sMAni8B8DRVDzw0XZRsM1u6pKICwoYP
=xQRz
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--


--===============8943010850475281727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============8943010850475281727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============8943010850475281727==--
