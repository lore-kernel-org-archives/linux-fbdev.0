From: Ondrej Zajicek <santiago@crfreenet.org>
Subject: Re: [Qemu-devel] Re: [PATCH] Add VirtIO
	Frame	Buffer Support
Date: Tue, 3 Nov 2009 16:29:11 +0100
Message-ID: <20091103152911.GA8266@localhost>
References: <1257199759-2941-1-git-send-email-agraf@suse.de>
	<4AEFCBED.50804@redhat.com>
	<DB868FAB-60AA-4D3A-82AE-A3DAF1AF83B2@suse.de>
	<4AEFCCBA.9050408@redhat.com>
	<8BA1853F-11C9-44B1-9FDB-1DFDAED40E1B@suse.de>
	<4AEFCEDA.4030308@redhat.com>
	<87F51670-CB3F-431C-87B4-A8746F996C6F@suse.de>
	<20091103112543.GA24834@snarc.org> <4AEFFA0A.4040105@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3304959478863018594=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <santiago@crfreenet.org>) id 1N5LJ2-0005JR-Dy
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Nov 2009 15:28:24 +0000
Received: from smtp1.kolej.mff.cuni.cz ([78.128.192.10])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N5LIw-0004W1-0z
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Nov 2009 15:28:24 +0000
In-Reply-To: <4AEFFA0A.4040105@redhat.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Avi Kivity <avi@redhat.com>
Cc: Vincent Hanquez <tab@snarc.org>, linux-fbdev-devel@lists.sourceforge.net, kvm@vger.kernel.org, qemu-devel@nongnu.org


--===============3304959478863018594==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2009 at 11:38:18AM +0200, Avi Kivity wrote:
> On 11/03/2009 01:25 PM, Vincent Hanquez wrote:
> > not sure if i'm missing the point here, but couldn't it be hypothetical=
ly
> > extended to stuff 3d (or video&  more 2d accel ?) commands too ? I can't
> > imagine the cirrus or stdvga driver be able to do that ever ;)
> >   =20
>=20
> cirrus has pretty good 2d acceleration.  3D is a mega-project though.

Cirrus has no blending/compositing hardware support.
Paravirtualized graphics can easily support full XRender-style
2D acceleration.

--=20
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@crfreenet.org)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrwTEcACgkQw1GB2RHercMCjACfSHIv0uPJ/UNNqz2bwRXgmwuK
D6IAn1GeAdI/wUhtr8j7YDXahRoigV7t
=I3yW
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--


--===============3304959478863018594==
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
--===============3304959478863018594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============3304959478863018594==--
