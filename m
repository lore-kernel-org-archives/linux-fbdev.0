From: Ondrej Zajicek <santiago@crfreenet.org>
Subject: Re: [PATCH 27/41] fbdev: Advertise limitation
	of drawing engine
Date: Wed, 25 Apr 2007 23:23:27 +0200
Message-ID: <20070425212327.GA7956@localhost.localdomain>
References: <462EFBB4.1080900@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1399946326=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hgoxf-0001jz-Js for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 14:23:39 -0700
Received: from smtp1.kolej.mff.cuni.cz ([195.113.24.4])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hgoxe-0007V5-0S
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 14:23:39 -0700
In-Reply-To: <462EFBB4.1080900@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


--===============1399946326==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2007 at 02:56:52PM +0800, Antonino A. Daplas wrote:
> A few drivers are not capable of blitting rectangles of any dimension.
> vga16fb can only blit 8-pixel wide rectangles, while s3fb (in tileblitting
> mode) can only blit 8x16 rectangles.

I have two new drivers which use tileblit. Where i can get diff of your
tree (not splitted to fifty parts and mixed with mail) to be able to
update that drivers to new interfaces? Or should i send it in current
form (againts 2.6.21-rc7)?

--=20
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@mail.cz, jabber: santiago@njs.ne=
tlab.cz)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iEYEARECAAYFAkYvxs8ACgkQw1GB2RHercOSmgCcC/R//9CxoMwO6XHYieIaJuB9
icEAn15bPiibQjbS8+cpBTQBrrTF11ZN
=j5LK
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--


--===============1399946326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1399946326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1399946326==--
