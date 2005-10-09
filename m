From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH] fbdev: fix the fb_find_nearest_mode() function
Date: Sun, 9 Oct 2005 11:29:49 +0200
Message-ID: <20051009092949.GA9610@spock.one.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOXVC-0001FW-9U
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 09 Oct 2005 02:29:54 -0700
Received: from ipp23-131.piekary.net ([80.48.23.131])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EOXVB-000082-4Y
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 09 Oct 2005 02:29:53 -0700
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Currently the fb_find_nearest_mode() function finds a mode with
screen resolution closest to that described by the 'var' argument
and with some arbitrary refresh rate (eg. in the following sequence
of refresh rates: 70 60 53 85 75, 53 is selected).

This patch fixes the function so that it looks for the closest mode as=20
far as both resolution and refresh rate are concerned. The function's
first argument is changed to fb_videomode so that the refresh rate can
be specified by the caller, as fb_var_screeninfo doesn't have any fields
that could directly hold this data.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
---

diff -Nurp fbdev-orig/drivers/video/console/fbcon.c fbdev/drivers/video/con=
sole/fbcon.c
--- fbdev-orig/drivers/video/console/fbcon.c	2005-10-08 23:14:29.000000000 =
+0200
+++ fbdev/drivers/video/console/fbcon.c	2005-10-09 01:03:22.000000000 +0200
@@ -2758,7 +2758,7 @@ static void fbcon_new_modelist(struct fb
 			continue;
 		vc =3D vc_cons[i].d;
 		display_to_var(&var, &fb_display[i]);
-		mode =3D fb_find_nearest_mode(&var, &info->modelist);
+		mode =3D fb_find_nearest_mode(fb_display[i].mode, &info->modelist);
 		fb_videomode_to_var(&var, mode);
=20
 		if (vc)
diff -Nurp fbdev-orig/drivers/video/modedb.c fbdev/drivers/video/modedb.c
--- fbdev-orig/drivers/video/modedb.c	2005-10-08 23:14:29.000000000 +0200
+++ fbdev/drivers/video/modedb.c	2005-10-09 01:25:16.000000000 +0200
@@ -663,6 +663,7 @@ void fb_var_to_videomode(struct fb_video
 {
 	u32 pixclock, hfreq, htotal, vtotal;
=20
+	mode->refresh =3D 0;
 	mode->name =3D NULL;
 	mode->xres =3D var->xres;
 	mode->yres =3D var->yres;
@@ -785,39 +786,39 @@ struct fb_videomode *fb_find_best_mode(s
 }
=20
 /**
- * fb_find_nearest_mode - find mode closest video mode
+ * fb_find_nearest_mode - find closest videomode
  *
- * @var: pointer to struct fb_var_screeninfo
+ * @mode: pointer to struct fb_videomode
  * @head: pointer to modelist
  *
  * Finds best matching videomode, smaller or greater in dimension.
  * If more than 1 videomode is found, will return the videomode with
- * the closest refresh rate
+ * the closest refresh rate.
  */
-struct fb_videomode *fb_find_nearest_mode(struct fb_var_screeninfo *var,
+struct fb_videomode *fb_find_nearest_mode(struct fb_videomode *mode,
 					  struct list_head *head)
 {
 	struct list_head *pos;
 	struct fb_modelist *modelist;
-	struct fb_videomode *mode, *best =3D NULL;
+	struct fb_videomode *cmode, *best =3D NULL;
 	u32 diff =3D -1, diff_refresh =3D -1;
=20
 	list_for_each(pos, head) {
 		u32 d;
=20
 		modelist =3D list_entry(pos, struct fb_modelist, list);
-		mode =3D &modelist->mode;
+		cmode =3D &modelist->mode;
=20
-		d =3D abs(mode->xres - var->xres) +
-			abs(mode->yres - var->yres);
+		d =3D abs(cmode->xres - mode->xres) +
+			abs(cmode->yres - mode->yres);
 		if (diff > d) {
 			diff =3D d;
-			best =3D mode;
+			best =3D cmode;
 		} else if (diff =3D=3D d) {
-			d =3D abs(mode->refresh - best->refresh);
+			d =3D abs(cmode->refresh - mode->refresh);
 			if (diff_refresh > d) {
 				diff_refresh =3D d;
-				best =3D mode;
+				best =3D cmode;
 			}
 		}
 	}
diff -Nurp fbdev-orig/include/linux/fb.h fbdev/include/linux/fb.h
--- fbdev-orig/include/linux/fb.h	2005-10-08 23:14:40.000000000 +0200
+++ fbdev/include/linux/fb.h	2005-10-09 01:03:17.000000000 +0200
@@ -898,7 +898,7 @@ extern struct fb_videomode *fb_match_mod
 					  struct list_head *head);
 extern struct fb_videomode *fb_find_best_mode(struct fb_var_screeninfo *va=
r,
 					      struct list_head *head);
-extern struct fb_videomode *fb_find_nearest_mode(struct fb_var_screeninfo =
*var,
+extern struct fb_videomode *fb_find_nearest_mode(struct fb_videomode *mode,
 						 struct list_head *head);
 extern void fb_destroy_modelist(struct list_head *head);
 extern void fb_videomode_to_modelist(struct fb_videomode *modedb, int num,


--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDSOMNaQ0HSaOUe+YRAt0AAJ4r7b5+uL8lb5WaJsrZG55KRHqITQCgkcdj
x86qV0m1cjenLewOatF9ljw=
=KlyV
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
