From: Florian Lohoff <flo@rfc822.org>
Subject: Radeonfb v/hsync polarity defaults
Date: Sun, 8 Feb 2004 21:07:47 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040208200747.GA1359@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ApvDq-00065y-Ic
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 08 Feb 2004 12:08:06 -0800
Received: from noose.gt.owl.de ([62.52.19.4])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1ApvDp-0007jy-Tf
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 08 Feb 2004 12:08:06 -0800
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: ajoshi@kernel.crashing.org
Cc: linux-fbdev-devel@lists.sourceforge.net


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
i was just trying 2.6.2 on my Vaio C1MHP. It uses a RadeonM6 with a
1280x600 panel size. As on 2.4 it hs the same default problem of wrong
set v/hsync polarity. The radeonfb makes exactly the opposite
assumptions about default polarity as XFree does. I debugged this when
having the exact same problem on 2.4. I cooked the following patch
against a 2.4 version. This wrong polarity causes the display to shift
up by about 4-6 pixels which causes the top line to be unreadable while
at the bottom we have 4-6 unused rows.

I would like to see this fixed on 2.6 too so i am sending this again.
The patch does not apply to 2.6 as too much has changed but you get the
point.

--- radeonfb.c.orig	Wed Apr 30 19:22:55 2003
+++ radeonfb.c	Wed Apr 30 19:31:46 2003
@@ -1353,12 +1353,11 @@
 	var->hsync_len =3D rinfo->hSync_width;
 	var->vsync_len =3D rinfo->vSync_width;
 	var->sync =3D 0;
-	if (rinfo->synct =3D=3D 3) {
-		if (rinfo->hAct_high)
-			var->sync |=3D FB_SYNC_HOR_HIGH_ACT;
-		if (rinfo->vAct_high)
-			var->sync |=3D FB_SYNC_VERT_HIGH_ACT;
-	}
+
+	if (rinfo->hAct_high)
+		var->sync |=3D FB_SYNC_HOR_HIGH_ACT;
+	if (rinfo->vAct_high)
+		var->sync |=3D FB_SYNC_VERT_HIGH_ACT;
=20
 	var->vmode =3D 0;
 	if (rinfo->interlaced)
@@ -1404,6 +1403,11 @@
 			rinfo->vOver_plus =3D (readw(tmp0+28) & 0x7ff) - readw(tmp0+26);
 			rinfo->vSync_width =3D (readw(tmp0+28) & 0xf800) >> 11;
 			rinfo->clock =3D readw(tmp0+9);
+
+			/* We don't know that the H/V sync active level should be
+			   make the same assumptions as XFree does - High Active */
+			rinfo->vAct_high=3D1;
+			rinfo->hAct_high=3D1;
=20
 			rinfo->got_dfpinfo =3D 1;
 			return 1;

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAJpcTUaz2rXW+gJcRAjPxAKDWDaG+93l4JGwWuFLdsMJBKpC1SACgymbb
nPbOMJH5S77DvBUCOhh6eR8=
=9Gcy
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
