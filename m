From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Subject: [BUG] at drivers/char/vt.c:3332
	do_blank_screen() on resume
Date: Thu, 15 Feb 2007 12:58:45 +0200
Message-ID: <200702151258.45648.caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr,
	linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0101565849=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HHeKL-000584-Kp for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 Feb 2007 02:59:01 -0800
Received: from ns2.uludag.org.tr ([193.140.100.220] helo=uludag.org.tr)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HHeKJ-0006Fw-Od
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 Feb 2007 02:59:01 -0800
Received: from zangetsu.local (unknown [85.108.252.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 73E1F54EA5A7
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 15 Feb 2007 12:58:27 +0200 (EET)
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

--===============0101565849==
Content-Type: multipart/signed; boundary="nextPart2052061.s2DXXQOHsq";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2052061.s2DXXQOHsq
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi;

With 2.6.20, resuming from disk sometimes cannot returns on vt7 where X run=
s=20
but everything seems working, so just changing to vt1 and returning to vt7=
=20
solves the problem. But dmesg shows some BUG() output like [1] whenever thi=
s=20
problem occurs

I'm using 20070207 snapshot of suspend, s2disk is used to suspend2disk,=20
machine is a Sony Vaio FS-215B which is in the whitelist and works well wit=
h=20
2.6.16/17/18 (all have fbsplash and vesafb-tng patches [from gentoo]=20
applied).

According to Pavel Machek, this is the true list to report the problem and =
his=20
explanations about problem can be found at [2].=20

[1] http://cekirdek.pardus.org.tr/~caglar/dmesg.2.6.20
[2] http://lkml.org/lkml/2007/2/15/91

Cheers
=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart2052061.s2DXXQOHsq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iD8DBQBF1Dzly7E6i0LKo6YRAp9DAJ9ERTYqdPH1g/Ux50SH3D59xsIG5wCfdUpd
B03GnXksldj5ZW45n6nhjVA=
=BF26
-----END PGP SIGNATURE-----

--nextPart2052061.s2DXXQOHsq--


--===============0101565849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0101565849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0101565849==--
