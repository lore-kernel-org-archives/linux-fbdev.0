From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH][fbcon] Don't repaint the cursor when it is disabled.
Date: Sun, 17 Jul 2005 14:00:05 +0200
Message-ID: <20050717120005.GA28169@spock.one.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261257AbVGQMAK@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Currently even when the cursor is disabled (`setterm -cursor off`), it
is still repainted as a black rectangle the size of a single char. This
can be seen, for example, by chvt'ing to a free tty, disabling the
cursor and doing `dd if=3D/dev/urandom of=3D/dev/fb0`.

The patch changes this behaviour by avoiding painting anything when the
cursor is disabled.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
---

diff -Nupr linux-2.6.12-orig/drivers/video/console/fbcon.c linux-2.6.12/dri=
vers/video/console/fbcon.c
--- linux-2.6.12-orig/drivers/video/console/fbcon.c	2005-06-17 21:48:29.000=
000000 +0200
+++ linux-2.6.12/drivers/video/console/fbcon.c	2005-07-17 13:32:00.00000000=
0 +0200
@@ -276,7 +276,8 @@ static void fb_flashcursor(void *private
=20
 	if (!vc || !CON_IS_VISIBLE(vc) ||
 	    fbcon_is_inactive(vc, info) ||
- 	    registered_fb[con2fb_map[vc->vc_num]] !=3D info)
+ 	    registered_fb[con2fb_map[vc->vc_num]] !=3D info ||
+	    vc_cons[ops->currcon].d->vc_deccm !=3D 1)
 		return;
 	acquire_console_sem();
 	p =3D &fb_display[vc->vc_num];


--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC2khFaQ0HSaOUe+YRAruhAJ45jKOtHsB1GMP31AB28PAxBZzeBQCfcEfP
6g+FwKpgeA6ziEdBCA7Ecac=
=tjlD
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
