Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1431D63C0
	for <linux-fbdev@vger.kernel.org>; Sun,  2 Feb 2025 20:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738528434; cv=none; b=KL0U4OmTiCodr1k5EYnJ9T+7MCpBrutl9xIrzo4zAfPqUvJBa6ze5f8B+TaeNiqno6DK6QARbBT736R1Nyy2AgHQ10DhiOB7F7CzOxAdgUWsCI1zHUBA1zydh7K6Q+iW1MHvZDUQcE65Pte6KNPhT+uyu4r9K/KuZivZ6oya13M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738528434; c=relaxed/simple;
	bh=3xkGnCA+2W4MwrMR7tEIbmk15Iva2nvIfdOtXcPOFEQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=tKiC6lA1KM2k2LXyWK/2KAW1Rbcsl0zyh0yG43fxZy5wR4KxJQQUnOeTErLWPWH9+4YwUgW20ddYUOp5O7N3ZjvztuwgZ7feOpyE4N6Vvz1csAhKPhMBZcTRZ5S9pDVgvhMqTqvkfIBhpzOCRdfBwIboKVJC4UXXmDzYUrPcRlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: from [192.168.0.59] (unknown [89.134.12.53])
	by c64.rulez.org (Postfix) with ESMTPSA id 224BF100F6
	for <linux-fbdev@vger.kernel.org>; Sun,  2 Feb 2025 21:33:47 +0100 (CET)
Message-ID: <0abefa4d-be0c-4e2b-1c8d-e3e448151389@c64.rulez.org>
Date: Sun, 2 Feb 2025 21:33:46 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-GB
To: linux-fbdev@vger.kernel.org
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
Subject: [PATCH] Use correct erase colour for clearing in fbcon
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------alzpjBkbfUD5Q4uwr6R8Ijas"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------alzpjBkbfUD5Q4uwr6R8Ijas
Content-Type: multipart/mixed; boundary="------------eP0WBqVytWQYTk9GNM9ZauRI";
 protected-headers="v1"
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org
Message-ID: <0abefa4d-be0c-4e2b-1c8d-e3e448151389@c64.rulez.org>
Subject: [PATCH] Use correct erase colour for clearing in fbcon

--------------eP0WBqVytWQYTk9GNM9ZauRI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The erase colour calculation for fbcon clearing should use get_color inst=
ead
of attr_col_ec, like everything else. The latter is similar but is not co=
rrect.
For example it's missing the depth dependent remapping and doesn't care a=
bout
blanking.

The problem can be reproduced by setting up the background colour to grey=

(vt.color=3D0x70) and having an fbcon console set to 2bpp (4 shades of gr=
ay).
Now the background attribute should be 1 (dark gray) on the console.

If the screen is scrolled when pressing enter in a shell prompt at the bo=
ttom
line then the new line is cleared using colour 7 instead of 1. That's not=

something fillrect likes (at 2bbp it expect 0-3) so the result is interes=
ting.

This patch switches to get_color with vc_video_erase_char to determine th=
e
erase colour from attr_col_ec. That makes the latter function redundant a=
s
no other users were left.

Use correct erase colour for clearing in fbcon

Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
---
 drivers/video/fbdev/core/bitblit.c   |  5 ++--
 drivers/video/fbdev/core/fbcon.c     | 10 +++++---
 drivers/video/fbdev/core/fbcon.h     | 38 +---------------------------
 drivers/video/fbdev/core/fbcon_ccw.c |  5 ++--
 drivers/video/fbdev/core/fbcon_cw.c  |  5 ++--
 drivers/video/fbdev/core/fbcon_ud.c  |  5 ++--
 drivers/video/fbdev/core/tileblit.c  |  8 +++---
 7 files changed, 18 insertions(+), 58 deletions(-)

diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/cor=
e/bitblit.c
index 3ff1b2a86..f9475c14f 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -59,12 +59,11 @@ static void bit_bmove(struct vc_data *vc, struct fb_i=
nfo *info, int sy,
 }
=20
 static void bit_clear(struct vc_data *vc, struct fb_info *info, int sy,
-		      int sx, int height, int width)
+		      int sx, int height, int width, int fg, int bg)
 {
-	int bgshift =3D (vc->vc_hi_font_mask) ? 13 : 12;
 	struct fb_fillrect region;
=20
-	region.color =3D attr_bgcol_ec(bgshift, vc, info);
+	region.color =3D bg;
 	region.dx =3D sx * vc->vc_font.width;
 	region.dy =3D sy * vc->vc_font.height;
 	region.width =3D width * vc->vc_font.width;
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c
index e8b4e8c11..07d127110 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1258,7 +1258,7 @@ static void __fbcon_clear(struct vc_data *vc, unsig=
ned int sy, unsigned int sx,
 {
 	struct fb_info *info =3D fbcon_info_from_console(vc->vc_num);
 	struct fbcon_ops *ops =3D info->fbcon_par;
-
+	int fg, bg;
 	struct fbcon_display *p =3D &fb_display[vc->vc_num];
 	u_int y_break;
=20
@@ -1279,16 +1279,18 @@ static void __fbcon_clear(struct vc_data *vc, uns=
igned int sy, unsigned int sx,
 		fbcon_clear_margins(vc, 0);
 	}
=20
+	fg =3D get_color(vc, info, vc->vc_video_erase_char, 1);
+	bg =3D get_color(vc, info, vc->vc_video_erase_char, 0);
 	/* Split blits that cross physical y_wrap boundary */
=20
 	y_break =3D p->vrows - p->yscroll;
 	if (sy < y_break && sy + height - 1 >=3D y_break) {
 		u_int b =3D y_break - sy;
-		ops->clear(vc, info, real_y(p, sy), sx, b, width);
+		ops->clear(vc, info, real_y(p, sy), sx, b, width, fg, bg);
 		ops->clear(vc, info, real_y(p, sy + b), sx, height - b,
-				 width);
+				 width, fg, bg);
 	} else
-		ops->clear(vc, info, real_y(p, sy), sx, height, width);
+		ops->clear(vc, info, real_y(p, sy), sx, height, width, fg, bg);
 }
=20
 static void fbcon_clear(struct vc_data *vc, unsigned int sy, unsigned in=
t sx,
diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/=
fbcon.h
index df70ea5ec..4d97e6d8a 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -55,7 +55,7 @@ struct fbcon_ops {
 	void (*bmove)(struct vc_data *vc, struct fb_info *info, int sy,
 		      int sx, int dy, int dx, int height, int width);
 	void (*clear)(struct vc_data *vc, struct fb_info *info, int sy,
-		      int sx, int height, int width);
+		      int sx, int height, int width, int fb, int bg);
 	void (*putcs)(struct vc_data *vc, struct fb_info *info,
 		      const unsigned short *s, int count, int yy, int xx,
 		      int fg, int bg);
@@ -116,42 +116,6 @@ static inline int mono_col(const struct fb_info *inf=
o)
 	return (~(0xfff << max_len)) & 0xff;
 }
=20
-static inline int attr_col_ec(int shift, struct vc_data *vc,
-			      struct fb_info *info, int is_fg)
-{
-	int is_mono01;
-	int col;
-	int fg;
-	int bg;
-
-	if (!vc)
-		return 0;
-
-	if (vc->vc_can_do_color)
-		return is_fg ? attr_fgcol(shift,vc->vc_video_erase_char)
-			: attr_bgcol(shift,vc->vc_video_erase_char);
-
-	if (!info)
-		return 0;
-
-	col =3D mono_col(info);
-	is_mono01 =3D info->fix.visual =3D=3D FB_VISUAL_MONO01;
-
-	if (attr_reverse(vc->vc_video_erase_char)) {
-		fg =3D is_mono01 ? col : 0;
-		bg =3D is_mono01 ? 0 : col;
-	}
-	else {
-		fg =3D is_mono01 ? 0 : col;
-		bg =3D is_mono01 ? col : 0;
-	}
-
-	return is_fg ? fg : bg;
-}
-
-#define attr_bgcol_ec(bgshift, vc, info) attr_col_ec(bgshift, vc, info, =
0)
-#define attr_fgcol_ec(fgshift, vc, info) attr_col_ec(fgshift, vc, info, =
1)
-
     /*
      *  Scroll Method
      */
diff --git a/drivers/video/fbdev/core/fbcon_ccw.c b/drivers/video/fbdev/c=
ore/fbcon_ccw.c
index f9b794ff7..89ef4ba7e 100644
--- a/drivers/video/fbdev/core/fbcon_ccw.c
+++ b/drivers/video/fbdev/core/fbcon_ccw.c
@@ -78,14 +78,13 @@ static void ccw_bmove(struct vc_data *vc, struct fb_i=
nfo *info, int sy,
 }
=20
 static void ccw_clear(struct vc_data *vc, struct fb_info *info, int sy,
-		     int sx, int height, int width)
+		     int sx, int height, int width, int fg, int bg)
 {
 	struct fbcon_ops *ops =3D info->fbcon_par;
 	struct fb_fillrect region;
-	int bgshift =3D (vc->vc_hi_font_mask) ? 13 : 12;
 	u32 vyres =3D GETVYRES(ops->p, info);
=20
-	region.color =3D attr_bgcol_ec(bgshift,vc,info);
+	region.color =3D bg;
 	region.dx =3D sy * vc->vc_font.height;
 	region.dy =3D vyres - ((sx + width) * vc->vc_font.width);
 	region.height =3D width * vc->vc_font.width;
diff --git a/drivers/video/fbdev/core/fbcon_cw.c b/drivers/video/fbdev/co=
re/fbcon_cw.c
index 903f6fc17..b9dac7940 100644
--- a/drivers/video/fbdev/core/fbcon_cw.c
+++ b/drivers/video/fbdev/core/fbcon_cw.c
@@ -63,14 +63,13 @@ static void cw_bmove(struct vc_data *vc, struct fb_in=
fo *info, int sy,
 }
=20
 static void cw_clear(struct vc_data *vc, struct fb_info *info, int sy,
-		     int sx, int height, int width)
+		     int sx, int height, int width, int fg, int bg)
 {
 	struct fbcon_ops *ops =3D info->fbcon_par;
 	struct fb_fillrect region;
-	int bgshift =3D (vc->vc_hi_font_mask) ? 13 : 12;
 	u32 vxres =3D GETVXRES(ops->p, info);
=20
-	region.color =3D attr_bgcol_ec(bgshift,vc,info);
+	region.color =3D bg;
 	region.dx =3D vxres - ((sy + height) * vc->vc_font.height);
 	region.dy =3D sx *  vc->vc_font.width;
 	region.height =3D width * vc->vc_font.width;
diff --git a/drivers/video/fbdev/core/fbcon_ud.c b/drivers/video/fbdev/co=
re/fbcon_ud.c
index 594331936..0af7913a2 100644
--- a/drivers/video/fbdev/core/fbcon_ud.c
+++ b/drivers/video/fbdev/core/fbcon_ud.c
@@ -64,15 +64,14 @@ static void ud_bmove(struct vc_data *vc, struct fb_in=
fo *info, int sy,
 }
=20
 static void ud_clear(struct vc_data *vc, struct fb_info *info, int sy,
-		     int sx, int height, int width)
+		     int sx, int height, int width, int fg, int bg)
 {
 	struct fbcon_ops *ops =3D info->fbcon_par;
 	struct fb_fillrect region;
-	int bgshift =3D (vc->vc_hi_font_mask) ? 13 : 12;
 	u32 vyres =3D GETVYRES(ops->p, info);
 	u32 vxres =3D GETVXRES(ops->p, info);
=20
-	region.color =3D attr_bgcol_ec(bgshift,vc,info);
+	region.color =3D bg;
 	region.dy =3D vyres - ((sy + height) * vc->vc_font.height);
 	region.dx =3D vxres - ((sx + width) *  vc->vc_font.width);
 	region.width =3D width * vc->vc_font.width;
diff --git a/drivers/video/fbdev/core/tileblit.c b/drivers/video/fbdev/co=
re/tileblit.c
index eff7ec4da..45b0828fa 100644
--- a/drivers/video/fbdev/core/tileblit.c
+++ b/drivers/video/fbdev/core/tileblit.c
@@ -32,16 +32,14 @@ static void tile_bmove(struct vc_data *vc, struct fb_=
info *info, int sy,
 }
=20
 static void tile_clear(struct vc_data *vc, struct fb_info *info, int sy,=

-		       int sx, int height, int width)
+		       int sx, int height, int width, int fg, int bg)
 {
 	struct fb_tilerect rect;
-	int bgshift =3D (vc->vc_hi_font_mask) ? 13 : 12;
-	int fgshift =3D (vc->vc_hi_font_mask) ? 9 : 8;
=20
 	rect.index =3D vc->vc_video_erase_char &
 		((vc->vc_hi_font_mask) ? 0x1ff : 0xff);
-	rect.fg =3D attr_fgcol_ec(fgshift, vc, info);
-	rect.bg =3D attr_bgcol_ec(bgshift, vc, info);
+	rect.fg =3D fg;
+	rect.bg =3D bg;
 	rect.sx =3D sx;
 	rect.sy =3D sy;
 	rect.width =3D width;
--=20
2.30.2


--=20
						    -soci-

--------------eP0WBqVytWQYTk9GNM9ZauRI--

--------------alzpjBkbfUD5Q4uwr6R8Ijas
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEE8WlaH4v4aHNT2Bn0WOeEu4KftGsFAmef1qoFAwAAAAAACgkQWOeEu4KftGuP
9Af+L5YmtdDybRfgDE7u3K/YzNtRtX7BmUNbWJYO2Kagci9AmAGf1P4nxkVljkKEciRSc+YrFsVU
sl4pAv0CHDNYURexV9sgIR4kJtTldX8T+AUzioR3+A6eVkWb+W8iSZ0l/lVa1uxCiPIwezuyF2ZU
fvMmtnElmMYXtlL7Xqli444uei/L+7a6cHucYY+9wrmuaiKfDdMToGB0QmDNmhNPhYdhvRKLNiY/
eI8Uycuvkn1oBukhhrlzAWt45ROW6WfW5uKj8QcMtKD8xjIU7tT6MP9A6eOR3OmKQVnYjZzQJ/7z
n9d418QENLWTp9QIeNdl9iUy5mJWAje+Ods9PzIVEQ==
=uc7U
-----END PGP SIGNATURE-----

--------------alzpjBkbfUD5Q4uwr6R8Ijas--
