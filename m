From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Fix spurious error return in FBIO_RADEON_SET_MIRROR (fwd)
Date: Wed, 26 Jan 2005 10:04:13 +0100 (MET)
Message-ID: <Pine.GSO.4.61.0501261003420.6807@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-1106730253=:6807"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtmQX-0000WY-C3
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Jan 2005 04:37:41 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CtmQU-0003ur-6x
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Jan 2005 04:37:41 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Antonino Daplas <adaplas@hotpop.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Andreas Schwab <schwab@suse.de>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-851401618-1106730253=:6807
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by witte.sonytel.be id j0Q94EGU004134

---------- Forwarded message ----------
Date: Wed, 26 Jan 2005 02:05:43 +0100
From: Andreas Schwab <schwab@suse.de>
To: linuxppc-dev@ozlabs.org
Subject: Fix spurious error return in FBIO_RADEON_SET_MIRROR

FBIO_RADEON_SET_MIRROR always returns with -EINVAL even if successful due
to an inappropriate fall-through.

Signed-off-by: Andreas Schwab <schwab@suse.de>

--- linux-2.6.10/drivers/video/aty/radeon_base.c.~1~	2004-12-29 20:17:12.=
000000000 +0100
+++ linux-2.6.10/drivers/video/aty/radeon_base.c	2005-01-26 01:48:17.0000=
00000 +0100
@@ -911,7 +911,7 @@ static int radeonfb_ioctl (struct inode=20
=20
 			OUTREG(CRTC_EXT_CNTL, tmp);
=20
-			break;
+			return 0;
 		case FBIO_RADEON_GET_MIRROR:
 			if (!rinfo->is_mobility)
 				return -EINVAL;

Andreas.

--=20
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstra=DFe 5, 90409 N=FCrnberg, Germany
Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
---559023410-851401618-1106730253=:6807--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
