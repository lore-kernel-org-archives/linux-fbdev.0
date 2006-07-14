From: Ondrej Zajicek <santiago@mail.cz>
Subject: struct fb_ops functions and sleeping
Date: Fri, 14 Jul 2006 22:47:49 +0200
Message-ID: <20060714204749.GA27737@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1552765926=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G1Ua4-0004tT-D0 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Jul 2006 13:48:12 -0700
Received: from gateway.crfreenet.org
	([82.113.54.238] helo=mail.crfreenet.org ident=postfix)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G1Ua2-0003f2-07
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Jul 2006 13:48:12 -0700
Received: from localhost.localdomain (feanor.newtown.chrudimsko.czf
	[192.168.3.10])
	by mail.crfreenet.org (Postfix) with ESMTP id 50BFC8EB98
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 14 Jul 2006 22:48:01 +0200 (CEST)
Received: from santiago by localhost.localdomain with local (Exim 4.50)
	id 1G1UZi-0007WB-6M for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Jul 2006 22:47:50 +0200
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
To: linux-fbdev-devel@lists.sourceforge.net


--===============1552765926==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello

I would like to ask whether there are any rules about context in which
functions from struct fb_ops are called, particularly whether they can
sleep and which functions may be called only between some fb_open
and fb_release (for example from fbcon).

I tried to get working two graphics cards using VGA arbiter patch
(http://www.ussg.iu.edu/hypermail/linux/kernel/0503.1/0054.html)
After some hacking it worked, but without proper locking.

--=20
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@mail.cz, jabber: santiago@njs.ne=
tlab.cz)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iEYEARECAAYFAkS4AvUACgkQw1GB2RHercN4aQCfTAn/8VLStXaaVb44zINtSoIc
UBkAn2HQk/SDh3Bx7xZzr5sTBxzEVmMn
=iCwy
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--


--===============1552765926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--===============1552765926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1552765926==--
