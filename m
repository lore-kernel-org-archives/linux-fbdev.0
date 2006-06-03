From: Christian Trefzer <ctrefzer@gmx.de>
Subject: [PATCH] neofb: fix unblank logic interfering
	with lid toggled backlight
Date: Sat, 3 Jun 2006 15:52:58 +0200
Message-ID: <20060603135258.GB16012@zeus.uziel.local>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1404760250=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FmWYk-0000LU-OT for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 03 Jun 2006 06:52:59 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FmWYj-0002Iq-Vt
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 03 Jun 2006 06:52:58 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>


--===============1404760250==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This is a fix for the most annoying problem that remained with neofb:

After "setterm -powersave powerdown" the console blanker will disable
the backlight after the given timeout expires. If this happens after the
lid has been shut, we read "LCD off" from the register and store that in
the driver. Once the lid is opened, the backlight turns on, but any key
press that would awaken the blanked console will switch the backlight
off again.

The workaround so far was to use the "display config toggle" Fn key
combo - once if no external display is attached, otherwise as often as
required to restore the desired display setup.

The following patch fixes the issue at least for the LCD-only case, with
no external monitor attached. Other display setup permutations are
pending further testing, but so far I can guarantee at least no negative
change in behaviour, if any at all.


Signed-off-by: Christian Trefzer <ctrefzer@gmx.de>
---

diff --git a/drivers/video/neofb.c b/drivers/video/neofb.c
index 24b12f7..1a06229 100644
--- a/drivers/video/neofb.c
+++ b/drivers/video/neofb.c
@@ -1333,17 +1333,22 @@ static int neofb_blank(int blank_mode, s
 	 *  run "setterm -powersave powerdown" to take advantage
 	 */
 	struct neofb_par *par =3D info->par;
-	int seqflags, lcdflags, dpmsflags, reg;
+	int seqflags, lcdflags, dpmsflags, reg, tmpdisp;
=20
-
-	/*
-	 * Reload the value stored in the register, if sensible. It might have
-	 * been changed via FN keystroke.
+	/*=20
+	 * Read back the register bits related to display configuration. They mig=
ht
+	 * have been changed underneath the driver via Fn key stroke.
+	 */
+	neoUnlock();
+	tmpdisp =3D vga_rgfx(NULL, 0x20) & 0x03;
+	neoLock(&par->state);
+=09
+	/* In case we blank the screen, we want to store the possibly new
+	 * configuration in the driver. During un-blank, we re-apply this setting,
+	 * since the LCD bit will be cleared in order to switch off the backlight.
 	 */
 	if (par->PanelDispCntlRegRead) {
-		neoUnlock();
-		par->PanelDispCntlReg1 =3D vga_rgfx(NULL, 0x20) & 0x03;
-		neoLock(&par->state);
+		par->PanelDispCntlReg1 =3D tmpdisp;
 	}
 	par->PanelDispCntlRegRead =3D !blank_mode;
=20
@@ -1378,12 +1383,21 @@ #endif
 		break;
 	case FB_BLANK_NORMAL:		/* just blank screen (backlight stays on) */
 		seqflags =3D VGA_SR01_SCREEN_OFF;	/* Disable sequencer */
-		lcdflags =3D par->PanelDispCntlReg1 & 0x02; /* LCD normal */
+		/*
+		 * During a blank operation with the LID shut, we might store "LCD off"
+		 * by mistake. Due to timing issues, the BIOS may switch the lights
+		 * back on, and we turn it back off once we "unblank".
+		 *
+		 * So here is an attempt to implement ">=3D" - if we are in the process
+		 * of unblanking, and the LCD bit is unset in the driver but set in the
+		 * register, we must keep it.
+		 */
+		lcdflags =3D ((par->PanelDispCntlReg1 | tmpdisp) & 0x02); /* LCD normal =
*/
 		dpmsflags =3D 0x00;	/* no hsync/vsync suppression */
 		break;
 	case FB_BLANK_UNBLANK:		/* unblank */
 		seqflags =3D 0;			/* Enable sequencer */
-		lcdflags =3D par->PanelDispCntlReg1 & 0x02; /* LCD normal */
+		lcdflags =3D ((par->PanelDispCntlReg1 | tmpdisp) & 0x02); /* LCD normal =
*/
 		dpmsflags =3D 0x00;	/* no hsync/vsync suppression */
 #ifdef CONFIG_TOSHIBA
 		/* Do we still need this ? */

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQIVAwUBRIGUOl2m8MprmeOlAQIa9g//T/kPB7/Y87y0BFyMQvYwM1neh55ZC9Uj
2ERJeUbiU0uabNXq/9M3FE25v3OcjvciBDZvMk5/2nfoKoUdFMtbXIR8Rvps93te
ffDZfkwF37IXHfpx1I0bI+2yJBeiYSlBzhu8XAO12V6cumaeigUwU0ClP/VLNTYD
MsqV4YxrddVHOeNam1NtzrwlTRggoEv24wKsVNSesBuqYCvtXdADHHgL94SGEGwU
UFeCmpFaGD14NLBBL/Lvyxislyo3W4HAqh1DBGzY4jmCtHQSPUvXoGs/vl/bwKpt
ml4cWrTwo8y+2og2qkFXAC6ICmRFQeIxCgBo6Hy2/lllWEGl88Fc1/pTcuAzY/H9
eP5pbo6o3ntrvAUztwOCTRUpVbvuR/X4ZX7tRsHJMSxVXvpbGie6a3HSi2i7UChS
7qqHf1Y4Eiu+zIgjWgpKBDhVfXNr+lcKhGjwo62TsaiU6Ksyvf6Jte/JwXXNku5E
dw8Atf4TqLq8HyAIaQnS9bOw6RcUiIBgM+baVBBUTkoirSOvnNtV7YOa1pDRK0yV
O5I9erPkjUV42anC0dXWQXvbO4zN1YPN0QbHlfNZs1pK54lbb/XzUHbW/0NkPXAe
Laxeo7+1PW9MCS9QDwrSf6Qy4V6ijTqfw0swUbcmhPGecF6kAeqQZzTGAjUNEwD8
biejUwW3PGw=
=oRGx
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--



--===============1404760250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1404760250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1404760250==--
