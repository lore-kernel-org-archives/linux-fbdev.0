From: Stuffed Crust <pizza@shaftnet.org>
Subject: radeonfb: Add ATOM BIOS parsing v6a (rebased)
Date: Thu, 9 Nov 2006 00:25:24 -0500
Message-ID: <20061109052524.GA25031@shaftnet.org>
References: <20060905153713.GA22789@shaftnet.org>
	<20060906220027.GA30385@shaftnet.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0682019998=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gi4BT-00037S-BK for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 08 Nov 2006 23:18:47 -0800
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Gi4BQ-0003Jw-Q6
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 08 Nov 2006 23:18:47 -0800
Received: from rrcs-24-73-230-86.se.biz.rr.com ([24.73.230.86]
	helo=shaft.shaftnet.org)
	by externalmx-1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1Gi33n-0002cl-IR
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 08 Nov 2006 22:06:50 -0800
Received: from shaft.shaftnet.org (localhost [127.0.0.1])
	by shaft.shaftnet.org (8.13.1/8.13.1) with ESMTP id kA95PP1i025401
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 9 Nov 2006 00:25:25 -0500
Received: (from pizza@localhost)
	by shaft.shaftnet.org (8.13.1/8.13.1/Submit) id kA95POLp025400
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 9 Nov 2006 00:25:24 -0500
In-Reply-To: <20060906220027.GA30385@shaftnet.org>
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


--===============0682019998==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

For those of you who are still tracking this, I've rebased my ATOM BIOS=20
patch against 2.6.19-rc5: =20

   http://www.shaftnet.org/users/pizza/radeonfb-atom-2.6.18-v6a.diff
   http://www.shaftnet.org/users/pizza/radeonfb-atom-2.6.19-v6a.diff

There are no (intentional) functional changes between the two, although =20
2.6.19 re-did the edid probing to use generic calls, so it may behave=20
differently.

Feedback welcome, especially if you were having problems with radeonfb=20
mis-detecting your monitor(s).

See also:

   http://bugzilla.kernel.org/show_bug.cgi?id=3D6215
=20
Ciao,

 - Solomon
--=20
Solomon Peachy        		       pizza at shaftnet dot org	=20
Melbourne, FL                          ^^ (mail/jabber/gtalk) ^^
Quidquid latine dictum sit, altum viditur.          ICQ: 1318344


--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFFUrvEPuLgii2759ARAtnOAJ9EnGgTNVZJUPYfFVwDMla4OFEe9ACg8qgF
lO2S6ZeiKYcqgpC56kJ1BxY=
=oZ+K
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--


--===============0682019998==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0682019998==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0682019998==--
