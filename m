From: Mike Frysinger <vapier@gentoo.org>
Subject: [simple patch] touchup virtual frame buffer
	docs for modules
Date: Wed, 19 Jul 2006 23:04:38 -0400
Message-ID: <200607192304.39235.vapier@gentoo.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_HLvvEW7/WNv3OQv"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G3OqA-0004mU-Jk for Linux-fbdev-devel@lists.sourceforge.net;
	Wed, 19 Jul 2006 20:04:42 -0700
Received: from smtp.gentoo.org ([140.211.166.183])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G3OqA-0006Z2-7U
	for Linux-fbdev-devel@lists.sourceforge.net;
	Wed, 19 Jul 2006 20:04:42 -0700
Received: from home.wh0rd.org (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTP id 7DAA764B41
	for <Linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 20 Jul 2006 03:04:41 +0000 (UTC)
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
To: Linux-fbdev-devel@lists.sourceforge.net

--Boundary-00=_HLvvEW7/WNv3OQv
Content-Type: multipart/signed; boundary="nextPart3810473.hQM1jtfTi3";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3810473.hQM1jtfTi3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

the Kconfig help text doesnt mention that in order to load the vfb module, =
you=20
have to pass in the parameter vfb_enable=3D1

patch attached to document this and hopefully save someone else some time :)
=2Dmike

--nextPart3810473.hQM1jtfTi3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iQIVAwUARL7yxkFjO5/oN/WBAQIfFw//RKGGXz102QLtpS1Gadj7Y6ZHoyucBSHS
xfFi16G32ssWl+xKLCSxEpkXIM0sla4RCLtxQDt6yZ0GztwSZpiFm+jH7u/TBBd7
8MFObULqj5vnqtldnwJ+fgBFSqX13Y0mWi7B62pKdOVZj6rlF6/4s5iGQmZrVr3n
q2FqBFOXTAlTDeWGCBeOqSSHqfVVZlQaWqVppCuaPRFaNHGCI1MH/zpn1TzxxAAl
grtxqwTWsh0GzBD7PfoJJaaetliiKmnTGJYWjAqa3s/Q/1Kvsva5uM0WYazCB0mG
pEKFmZWmpgtb4of5V4yEjHJFLk45q+XOP2CxkTcMc0XsdghZyJrHY5CC2/ZIiE5j
8l4odz58LWhmqmuIRd1PmThASxSpwgdc2rlVDvZ3v99VCxuYbkvRptQ4Em27QLVx
XMrDpXTdX+14WeK8eJNgyOaPgRHTmvXG1lCstjiBA9k4JvjgoySFoWriNuIGV89A
OR/tdsq/Vb/lxYXKGVW3nZYZqr5IDOipGggPC052fgyN+Q/v4ZfsFD0yYjFmwsCe
l2LDXe3tYCt7n9TCJQPG04HJ0pyF4ZLE22PwzZKAL1wA3nj43obKh7rCR0rdcDzQ
7h8iZV4s0OtcVrmwLtPjTqDWAFqq1hMHrytSQvJ5ZwzBVDv2sSHJt2sXRjx35MnT
BLmwQ05q0bo=
=/T52
-----END PGP SIGNATURE-----

--nextPart3810473.hQM1jtfTi3--

--Boundary-00=_HLvvEW7/WNv3OQv
Content-Type: text/x-diff; charset="us-ascii";
	name="vfb-module-kconfig-docs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="vfb-module-kconfig-docs.patch"

Document required module options in Kconfig for loading the vfb module.

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 6533b0f..6a68a43 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1609,7 +1609,8 @@ config FB_VIRTUAL
 	  kernel option `video=vfb:'.
 
 	  To compile this driver as a module, choose M here: the
-	  module will be called vfb.
+	  module will be called vfb. In order to load it, you must use
+	  the vfb_enable=1 option.
 
 	  If unsure, say N.
 if VT

--Boundary-00=_HLvvEW7/WNv3OQv
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_HLvvEW7/WNv3OQv
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--Boundary-00=_HLvvEW7/WNv3OQv--
